/*
 * in2obj.c
 *
 *  Created on: 17.11.2012
 *      Author: Martin Galgon
 *
 * Version 24.11.2016
 */

#include <stdio.h>
#include <stdlib.h>

// #define OLD_IN_FORMAT

//======================================================================
int glai_find_float(float* vec, int vec_p, float v[3])
{
	int index = -1;
	int p = 0;
	while(p < vec_p){
		if(vec[p] == v[0] && vec[p+1] == v[1] && vec[p+2] == v[2]){
			index = p;
			break;
		}
		p += 3;
	}
	return index;
}
//======================================================================
int glai_find_int(int* vec, int vec_p, int v[3])
{
	int index = -1;
	int p = 0;
	while(p < vec_p){
		if(vec[p] == v[0] && vec[p+1] == v[1] && vec[p+2] == v[2]){
			index = p;
			break;
		}
		p += 3;
	}
	return index;
}
//======================================================================
typedef struct{
	float cop[3];
	float tgt[3];
#ifdef OLD_IN_FORMAT
	int u[2];
	int v[2];
	int c[2];
#endif
	int n;
	float* vbuf; // size n*3*3
	int* fbuf;   // size n*3
	int* cbuf;   // size n*3
	int* ctrans; // size n
	int nv;
	int nf;
	int nc;
} ModelIN;
//======================================================================
#ifdef OLD_IN_FORMAT
#define MODELIN_INITIALIZER { {0,0,0}, {0,0,0}, {0,0}, {0,0}, {0,0}, 0, NULL, NULL, NULL, NULL, 0, 0, 0 }
#else
#define MODELIN_INITIALIZER { {0,0,0}, {0,0,0}, 0, NULL, NULL, NULL, NULL, 0, 0, 0 }
#endif
//======================================================================
void free_IN(ModelIN in)
{
	free(in.vbuf);
	free(in.fbuf);
	free(in.cbuf);
	free(in.ctrans);
}
//======================================================================
ModelIN glaiReadIN(const char* name, int flip)
{
	int i;

	FILE* file = fopen(name, "r");
	if(file == NULL){
		printf("File not found: %s\n", name);
		return;
	}else{
		printf("Input model: %s\n", name);
	}

	char line[1024];

	ModelIN in = MODELIN_INITIALIZER;

	fgets(line, sizeof(line), file);
	sscanf(line, "%f %f %f", &(in.cop[0]), &(in.cop[1]), &(in.cop[2]));

	fgets(line, sizeof(line), file);
	sscanf(line, "%f %f %f", &(in.tgt[0]), &(in.tgt[1]), &(in.tgt[2]));

#ifdef OLD_IN_FORMAT
	fgets(line, sizeof(line), file);
	sscanf(line, "%d %d", &(in.u[0]), &(in.u[1]));

	fgets(line, sizeof(line), file);
	sscanf(line, "%d %d", &(in.v[0]), &(in.v[1]));

	fgets(line, sizeof(line), file);
	sscanf(line, "%d %d", &(in.c[0]), &(in.c[1]));
#endif

	int anz = 0;
	fgets(line, sizeof(line), file);
	sscanf(line, "%d", &anz);

	printf("%d faces\n", anz);

	// Allocate some buffers.
	in.vbuf = (float*)malloc(anz * 3 * 3 * sizeof(float));
	in.fbuf = (int*)malloc(anz * 3 * sizeof(int));
	in.cbuf = (int*)malloc(anz * 3 * sizeof(int));
	in.ctrans = (int*)malloc(anz * sizeof(int));

	int vbuf_p = 0;
	int fbuf_p = 0;
	int cbuf_p = 0;

	int v = 0;
	int c = 0;

	for(i = 0; i < anz; i++){
		float d1[3];
		float d2[3];
		float d3[3];
		float normal[3];
		int r, g, b;

		fgets(line, sizeof(line), file);
		sscanf(line, "%f %f %f %f %f %f %f %f %f %d %d %d",
			&(d1[0]), &(d1[1]), &(d1[2]),
			&(d2[0]), &(d2[1]), &(d2[2]),
			&(d3[0]), &(d3[1]), &(d3[2]),
			&r, &g, &b
		);

		// Find vertex indices
		int f1 = glai_find_float(in.vbuf, vbuf_p, d1);
		int f2 = glai_find_float(in.vbuf, vbuf_p, d2);
		int f3 = glai_find_float(in.vbuf, vbuf_p, d3);

		// Select new vertex indices, store vertex.
		if(f1 == -1){
			f1 = v++;
			in.vbuf[vbuf_p]   = d1[0];
			in.vbuf[vbuf_p+1] = d1[1];
			in.vbuf[vbuf_p+2] = d1[2];
			vbuf_p += 3;
		}else f1 /= 3;

		if(f2 == -1){
			f2 = v++;
			in.vbuf[vbuf_p]   = d2[0];
			in.vbuf[vbuf_p+1] = d2[1];
			in.vbuf[vbuf_p+2] = d2[2];
			vbuf_p += 3;
		}else f2 /= 3;

		if(f3 == -1){
			f3 = v++;
			in.vbuf[vbuf_p]   = d3[0];
			in.vbuf[vbuf_p+1] = d3[1];
			in.vbuf[vbuf_p+2] = d3[2];
			vbuf_p += 3;
		}else f3 /= 3;

		// Find color
		int col[3];
		col[0] = r; col[1] = g; col[2] = b;
		int c1 = glai_find_int(in.cbuf, cbuf_p, col);

		// Store color
		if(c1 == -1){
			c1 = c++;
			in.cbuf[cbuf_p]   = col[0];
			in.cbuf[cbuf_p+1] = col[1];
			in.cbuf[cbuf_p+2] = col[2];
			cbuf_p += 3;
		}else c1 /= 3;

		// Link face to color
		in.ctrans[i] = c1;

		// Define face via indices.
		in.fbuf[fbuf_p] = f1;
		if(flip){
			in.fbuf[fbuf_p+1] = f3;
			in.fbuf[fbuf_p+2] = f2;
		}else{
			in.fbuf[fbuf_p+1] = f2;
			in.fbuf[fbuf_p+2] = f3;
		}
		fbuf_p += 3;

// 		printf("Read [%f, %f, %f] [%f %f %f] [%f %f %f]\n", d1[0], d1[1], d1[2], d2[0], d2[1], d2[2], d3[0], d3[1], d3[2]);
// 		fflush(0);
// 		printf("Color: %d %d %d\n", r, g, b);
// 		fflush(0);
// 		glaiCalculateNormal(d1, d2, d3, normal);
// 		glColor3ub(r, g, b);
// 		glNormal3fv(normal);
// 		printf("Normal: %f %f %f\n", normal[0], normal[1], normal[2]);
// 		fflush(0);
// 		glVertex3fv(d1);
// 		glVertex3fv(d2);
// 		glVertex3fv(d3);
	}

	fclose(file);

	printf("faces:     %d\n", anz);
	printf("vertices:  %d\n", v);
	printf("processed: %d\n", i);
	printf("colors:    %d\n", c);

	in.nv = v;
	in.nf = anz;
	in.nc = c;

	return in;
}
//======================================================================
void write_to_OBJ(const char* objname, const char* mtlname, ModelIN in)
{
	int i, j;

	// Write OBJ
	FILE* file = fopen(objname, "w");
	if(file == NULL){
		printf("Could not open file \"%s\" for writing.\n", objname);
		return;
	}

	fprintf(file, "mtllib %s\n", mtlname);

	// Write vertices
	for(i = 0; i < in.nv; i++){
		fprintf(file, "v %f %f %f\n", in.vbuf[i*3], in.vbuf[i*3+1], in.vbuf[i*3+2]);
	}

	// Write faces by colors
	for(i = 0; i < in.nc; i++){
		// write color identifier
		fprintf(file, "usemtl color%d\n", i);
		// For each unique color search faces with this color
		for(j = 0; j < in.nf; j++){
			if(in.ctrans[j] == i){
				fprintf(file, "f %d %d %d\n", in.fbuf[j*3] + 1, in.fbuf[j*3+1] + 1, in.fbuf[j*3+2] + 1);
			}
		}
	}

	fclose(file);

	// Write material Library
	file = fopen(mtlname, "w");
	if(file == NULL){
		printf("Could not open file \"%s\" for writing.\n", mtlname);
		return;
	}

	for(i = 0; i < in.nc; i++){
		// write color identifier
		fprintf(file, "newmtl color%d\n", i);
		fprintf(file, "Ka %f %f %f\n", in.cbuf[i*3]/255.0f, in.cbuf[i*3+1]/255.0f, in.cbuf[i*3+2]/255.0f);
		fprintf(file, "Kd %f %f %f\n", in.cbuf[i*3]/255.0f, in.cbuf[i*3+1]/255.0f, in.cbuf[i*3+2]/255.0f);
		fprintf(file, "Ks %f %f %f\n", 0.0f, 0.0f, 0.0f);
		// For each unique color search faces with this color
	}

	fclose(file);
}
//======================================================================
void write_to_IN(const char* inname, ModelIN in)
{
	int i;

	FILE* file = fopen(inname, "w");
	if(file == NULL){
		printf("Could not open file \"%s\" for writing.\n", inname);
		return;
	}

	fprintf(file, "%f %f %f # COP\n", in.cop[0], in.cop[1], in.cop[2]);
	fprintf(file, "%f %f %f # TGT\n", in.tgt[0], in.tgt[1], in.tgt[2]);
#ifdef OLD_IN_FORMAT
	fprintf(file, "%d %d # umin, umax\n", in.u[0], in.u[1]);
	fprintf(file, "%d %d # vmin, vmax\n", in.v[0], in.v[1]);
	fprintf(file, "%d %d # B, F\n", in.c[0], in.c[1]);
#endif
	fprintf(file, "%d # Anzahl Dreiecke\n", in.nf);

	for(i = 0; i < in.nf; i++){
		int v1 = in.fbuf[i*3];
		int v2 = in.fbuf[i*3+1];
		int v3 = in.fbuf[i*3+2];

		fprintf(file, "%.6f %.6f %.6f %.6f %.6f %.6f %.6f %.6f %.6f %d %d %d\n",
			in.vbuf[3*v1], in.vbuf[3*v1+1], in.vbuf[3*v1+2],
			in.vbuf[3*v2], in.vbuf[3*v2+1], in.vbuf[3*v2+2],
			in.vbuf[3*v3], in.vbuf[3*v3+1], in.vbuf[3*v3+2],
			in.cbuf[3*in.ctrans[i]], in.cbuf[3*in.ctrans[i]+1], in.cbuf[3*in.ctrans[i]+2]
		);
	}
}
//======================================================================
int main(int argc, char** argv)
{
	if(argc < 2) return 1;
	if(argc > 3) return 1;

	ModelIN in;

	if(argc == 3)
		in = glaiReadIN(argv[1], 1);
	else
		in = glaiReadIN(argv[1], 0);

	write_to_OBJ("model.obj", "model.mtl", in);
	write_to_IN("test.in", in);
	free_IN(in);

	return 0;
}
