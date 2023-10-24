/*
 * bbox.c
 *
 *  Created on: 24.11.2016
 *      Author: Martin Galgon
 * 
 * Version 24.11.2016
 */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#define MIN(X,Y) (((X)<(Y))?(X):(Y))
#define MAX(X,Y) (((X)>(Y))?(X):(Y))
#define UPDATE(X,D) \
	bbmax[(D)] = MAX(bbmax[(D)], (X)[(D)]); \
	bbmin[(D)] = MIN(bbmin[(D)], (X)[(D)]);


int main(int argc, char** argv)
{
	if(argc < 2) return 1;
	if(argc > 2) return 1;

	FILE* file = fopen(argv[1], "r");
	if(file == NULL){
		printf("File not found: %s\n", argv[1]);
		return;
	}else{
		printf("Input model: %s\n", argv[1]);
	}

	char line[1024];
	float cop[3];
	float vrp[3];
	int i;

	fgets(line, sizeof(line), file);
	sscanf(line, "%f %f %f", &(cop[0]), &(cop[1]), &(cop[2]));

	fgets(line, sizeof(line), file);
	sscanf(line, "%f %f %f", &(vrp[0]), &(vrp[1]), &(vrp[2]));

	int anz = 0;
	fgets(line, sizeof(line), file);
	sscanf(line, "%d", &anz);

	printf("%d faces\n", anz);

	float bbmin[3] = { INFINITY,  INFINITY,  INFINITY};
	float bbmax[3] = {-INFINITY, -INFINITY, -INFINITY};

	for(i = 0; i < anz; i++){
		float d1[3];
		float d2[3];
		float d3[3];
		int r, g, b;

		fgets(line, sizeof(line), file);
		sscanf(line, "%f %f %f %f %f %f %f %f %f %d %d %d", 
			&(d1[0]), &(d1[1]), &(d1[2]),
			&(d2[0]), &(d2[1]), &(d2[2]),
			&(d3[0]), &(d3[1]), &(d3[2]),
			&r, &g, &b
		);

		UPDATE(d1,0)
		UPDATE(d1,1)
		UPDATE(d1,2)
		UPDATE(d2,0)
		UPDATE(d2,1)
		UPDATE(d2,2)
		UPDATE(d3,0)
		UPDATE(d3,1)
		UPDATE(d3,2)
	}

	printf("BB: [%lf, %lf]x[%lf, %lf]x[%lf, %lf]\n", bbmin[0], bbmax[0], bbmin[1], bbmax[1], bbmin[2], bbmax[2]);
	printf("Center: (%lf %lf %lf)\n", (bbmin[0] + bbmax[0]) * 0.5,
	                                    (bbmin[1] + bbmax[1]) * 0.5,
	                                    (bbmin[2] + bbmax[2]) * 0.5);

	float dx = vrp[0] - cop[0];
	float dy = vrp[1] - cop[1];
	float dz = vrp[2] - cop[2];
	
	if(dy == 0){
		printf("No y=0 intersect\n");
	}else{
		float t = -cop[1] / dy;
		float x = dx * t + cop[0];
		float z = dz * t + cop[2];
		printf("Intersect y=0: (%lf %lf %lf)\n", x, 0.0, z);
	}

	if(dz == 0){
		printf("No z=0 intersect\n");
	}else{
		float t = -cop[2] / dz;
		float x = dx * t + cop[0];
		float y = dy * t + cop[1];
		printf("Intersect z=0: (%lf %lf %lf)\n", x, y, 0.0);
	}

	if(dx == 0){
		printf("No x=0 intersect\n");
	}else{
		float t = -cop[0] / dx;
		float y = dy * t + cop[1];
		float z = dz * t + cop[2];
		printf("Intersect x=0: (%lf %lf %lf)\n", 0.0, y, z);
	}

	printf("Delta: %lf\n", sqrtf(dx * dx + dy * dy + dz * dz));
	
	return 0;
}
