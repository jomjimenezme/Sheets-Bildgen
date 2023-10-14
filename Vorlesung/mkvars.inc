# Variable - Programme
LTXFILT := ltxfilt
##LTXFILT := cat
BTXFILT := btxfilt
##BTXFILT := cat
TWL2TEX := twl2tex
LST2TEX := lst2tex
LST2SRC := lst2src
LST2XXXC := -lang=c
UNCOLMAKE := uncolourmake
CPP := cpp-11
MAKEDEP := $(CPP) -MM
CC := gcc-11
CCFLAGS := -std=c18 -Wpedantic -Wall -Wextra -Winit-self -Wlogical-op \
	-Wunreachable-code -Wno-unused-function  -Wshadow -Wformat-overflow=2
EDITOR := emacs -i -geometry 80x42

# Variable - Dateien
MAIN := BildGen

STY := halecture.cls collistings.sty halecture.xdy halecbib.sty \
	commands.tex localcommands.tex mycolours.tex \

TWL := $(MAIN).twl \
	cha_einfuehrung.twl \
	cha_hardware-interaktion.twl \
	cha_scan-conversion.twl \
	cha_koordinatentransformationen.twl \
	cha_clipping.twl \
	cha_sichtbarkeit.twl \
	cha_faerbung.twl \
	cha_objekte.twl \
	cha_kurven-flaechen.twl \
	cha_faerbung2.twl \
	leer.twl \

BIB := \
	Books.bib \
	Books2.bib \

PNG := \
	Bilder/yagir/titel-cornell-pt-heller.png \
	person_nopic.png \
	Bilder/glai/flat-sphere-wireframe-noculling.png \
	Bilder/glai/flat-sphere-wireframe-culling.png \
	Bilder/uebung/painters.png \
	Bilder/uebung/silhouetten.png \
	Bilder/glai/flat-sphere-ambient.png \
	Bilder/glai/flat-sphere-diffuse.png \
	Bilder/glai/flat-sphere-specular.png \
	Bilder/glai/depthcue.png \
	Bilder/glai/warn-exp0-angle21.png \
	Bilder/glai/warn-exp12-angle90.png \
	Bilder/glai/flat2.png \
	Bilder/glai/shadowmap.png \
	Bilder/glai/tex-marble.png \
	Bilder/glai/normal-tex.png \
	Bilder/blumen/blumen03.png \
	person_Bezier.png \
	bezierpatch.png \
	beziernetz.png \
	rotk_kugel.png \
	rotk_rand1.png \
	rotk_rand2.png \
	Bilder/uebung/rt-vorl-d1.png \
	Bilder/uebung/rt-vorl-d2.png \
	Bilder/uebung/rt-vorl-d3.png \
	Bilder/uebung/rt-vorl-d4.png \
	Bilder/uebung/rt-vorl-d5.png \
	Bilder/uebung/rt-vorl-d6.png \
	person_CohenM.png \
	Bilder/yagir/cornell-radiosity.png \
	Bilder/wikimedia/radiosity-comparison.png \
	Bilder/radios/sceneSortMod-h500-00001.png \
	Bilder/radios/sceneSortMod-h500-00015.png \
	Bilder/radios/sceneSortMod-h500-00050.png \
	Bilder/radios/sceneSortMod-h500-00400.png \
	Bilder/radios/sceneSortMod-h500-00600.png \
	Bilder/radios/sceneSortMod-h500-03000.png \
	Bilder/radios/sceneSortMod-h500-25000.png \
	Bilder/radios/sceneSortMod-h500-80000.png \
	person_Cook.png \
	Bilder/yagir/cornell-distrt-pointlight.png \
	Bilder/yagir/cornell-distrt-arealight.png \
	Bilder/yagir/cornell-distrt-pointlight-depthoffield.png \
	Bilder/yagir/cornell-distrt-arealight-depthoffield.png \
	Bilder/yagir/cornell-pt.png \
	Bilder/yagir/diffuse.png \
	Bilder/yagir/phong1.png \
	Bilder/yagir/phong2.png \
	Bilder/yagir/phong3.png \
	Bilder/yagir/phong4.png \
	Bilder/yagir/phong5.png \
	Bilder/yagir/phong6.png \
	Bilder/yagir/diffuse-and-mirror.png \
	Bilder/yagir/blue-glass.png \
	Bilder/yagir/plastic-bunny.png \
	Bilder/yagir/art-glass-cuboids.png \
	Bilder/yagir/cornell-pt-uniform-100spp.png \
	Bilder/yagir/cornell-pt-impsampcostheta-100spp.png \
	Bilder/yagir/cornell-microfacet-uniform-64spp.png \
	Bilder/yagir/cornell-microfacet-impsamp-64spp.png \
	Bilder/yagir/cornell-pt-uniform-10spp.png \
	Bilder/yagir/cornell-pt-directlighting-10spp.png \
	Bilder/yagir/cornell-pt-directlighting-100spp.png \
	Bilder/yagir/mis-dl-light-64spp.png \
	Bilder/yagir/mis-dl-brdf-64spp.png \
	Bilder/yagir/mis-dl-light-and-brdf-200spp.png \
	person_Guibas.png \
	Bilder/web/bunny-bidipt-caustics.png \
	Bilder/wikimedia/glass-bidipt-caustics.png \
	Bilder/web/mlt-vs-bidipt-magnified.png \
	Bilder/wikimedia/glass-molecule-photonmapping.png \
	Bilder/wikimedia/glass-en2000-photonmapping.png \

GIF :=

JPG := \
	person_Braun.jpg \
	person_Cohen.jpg \
	person_Sutherland.jpg \
	person_Barsky.jpg \
	person_Lambert.jpg \
	person_Phong.jpg \
	person_Mach.jpg \
	person_Gouraud.jpg \
	person_Hermite.jpg \
	person_Bernstein.jpg \
	person_deCasteljau.jpg \
	person_Horner.jpg \
	person_Whitted.jpg \
	person_Goral.jpg \
	person_Torrance.jpg \
	person_Greenberg.jpg \
	person_Battaile.jpg \
	person_Chen.jpg \
	person_Kajiya.jpg \
	person_Porter.jpg \
	person_Carpenter.jpg \
	person_Veach.jpg \
	person_Lafortune.jpg \
	person_Willems.jpg \
	person_Jensen.jpg \

TIF :=

EPS := BUW_Logo.eps AI_Logo.eps \

PDF :=

TFIG := \

PFIG := \

TINKSVG := \
	fig_fragestellung.svg \
	fig_hardwareKathodenstrahlroehre.svg \
	fig_hardwareVectorDisplay.svg \
	fig_hardwarePlotterFlach.svg \
	fig_hardwarePlotterTrommel.svg \
	fig_hardwareRasterbildschirm.svg \
	fig_hardwareRasterInterlaced.svg \
	fig_hardwareRasterDisplay.svg \
	fig_hardwareRasterDelta.svg \
	fig_hardwareFarbRasterDisplay.svg \
	fig_hardwareFarbtabelle.svg \
	fig_hardwareDisplayFarbtabelle.svg \
	fig_hardwareLCD.svg \
	fig_hardwareLCDDurchsichtig.svg \
	fig_hardwareLCDUndurchsichtig.svg \
	fig_hardwarePlasma.svg \
	fig_hardwareDrucker.svg \
	fig_hardwareDruckerNadel.svg \
	fig_hardwareDruckerTintenstrahl.svg \
	fig_hardwareDruckerLaser.svg \
	fig_hardwareTastaturMaus.svg \
	fig_hardwareRegler.svg \
	fig_hardwareMausMechanisch.svg \
	fig_hardwareMausOptisch.svg \
	fig_hardwareTouchscreen.svg \
	fig_interaktionSamplingModell.svg \
	fig_interaktionSamplingTemperatur.svg \
	fig_interaktionEventModell.svg \
	fig_interaktionEchoCursor.svg \
	fig_interaktionEchoBand.svg \
	fig_interaktionEchoUmriss.svg \
	fig_interaktionEchoVerschieben.svg \
	fig_interaktionCursorform.svg \
	fig_interaktionWarten.svg \
	fig_scanconversion.svg \
	fig_scanPaintersOhneDoppelpufferung.svg \
	fig_scanDoppelpufferung.svg \
	fig_scanFensteroberflaeche.svg \
	fig_scanStreckePrinzip.svg \
	fig_scanStreckeIncrement1.svg \
	fig_scanStreckeIncrement2.svg \
	fig_scanStreckeHardware.svg \
	fig_scanKreisNOAchtel.svg \
	fig_scanKreisIncrement.svg \
	fig_scanPolygonzug.svg \
	fig_scanPolygone.svg \
	fig_scanPolygonGrundalgorithmus.svg \
	fig_scanPolygonSonderfaelle.svg \
	fig_scanPolygonInkrementell1.svg \
	fig_scanPolygonInkrementell2.svg \
	fig_scanPolygonInkrementell3.svg \
	fig_scanPolygonInkrementellAlgo1.svg \
	fig_scanPolygonInkrementellAlgo2.svg \
	fig_scanPolygonFloodFill1.svg \
	fig_scanPolygonFloodFill3.svg \
	fig_scanBreiteStrecke2.svg \
	fig_scanBreiteStrecke3.svg \
	fig_scanBreiteStrecke4.svg \
	fig_scanStreckeMuster2.svg \
	fig_scanStreckeMuster3.svg \
	fig_scanRaumStattFarbe3.svg \
	fig_scanRaumStattFarbe4.svg \
	fig_scanText1.svg \
	fig_scanText3.svg \
	fig_koordUeberblick.svg \
	fig_koordNormGeraetAbbildung.svg \
	fig_koordNormGeraetFaktor.svg \
	fig_koordProjektion1.svg \
	fig_koordProjektion4.svg \
	fig_koordStandardParallel.svg \
	fig_koordStandardPerspektiv.svg \
	fig_koordStrahlensatz.svg \
	fig_koordAllgemein1.svg \
	fig_koordAllgemein2.svg \
	fig_koordAllgemeinSichtbar.svg \
	fig_koordProjektiv.svg \
	fig_koordRollerSpeiche.svg \
	fig_clipPixel.svg \
	fig_clipAnalytisch2D.svg \
	fig_clipStreckenNaiv.svg \
	fig_clipCohenSituation.svg \
	fig_clipCohenCode.svg \
	fig_clipCohenBsp1.svg \
	fig_clipCohenBsp2.svg \
	fig_clipCohenBsp3.svg \
	fig_clipCyrus.svg \
	fig_clipCyrusBsp.svg \
	fig_clipPolygonSutherland.svg \
	fig_clipPolygonSutherlandFall1.svg \
	fig_clipPolygonSutherlandFall2.svg \
	fig_clipPolygonSutherlandFall3.svg \
	fig_clipPolygonSutherlandFall4.svg \
	fig_clipHardwareKonventionell.svg \
	fig_clipHardwarePipeline.svg \
	fig_clipHardwarePipelineProblem.svg \
	fig_clip3DBsp.svg \
	fig_clip3DParallel.svg \
	fig_clip3DPerspektivisch.svg \
	fig_clip3DFuerStoerend.svg \
	fig_clip3DFuerEntfernt.svg \
	fig_clip3DFuerVorne.svg \
	fig_clip3DFuerSchichten.svg \
	fig_clip3DNormalisiertParallel.svg \
	fig_clip3DNormalisiertPerspektiv.svg \
	fig_clip3DRealisierung.svg \
	fig_sichtPixel.svg \
	fig_sichtKonvex1.svg \
	fig_sichtKonvex2.svg \
	fig_sichtKonvex3.svg \
	fig_sichtKonvex4.svg \
	fig_sichtKonvex5.svg \
	fig_sichtZellenBsp.svg \
	fig_sichtZBufferSituation.svg \
	fig_sichtZBufferHardware.svg \
	fig_sichtPolygoneSituation.svg \
	fig_sichtPolygoneIntervalle.svg \
	fig_sichtPolygoneVerschmelzen.svg \
	fig_sichtPolygoneBaum.svg \
	fig_sichtPolyederCulling.svg \
	fig_sichtPolyederUmlaufsinn.svg \
	fig_sichtPolyederNormale.svg \
	fig_sichtPolyederKontur.svg \
	fig_sichtPolyederKonturkanten.svg \
	fig_sichtPolyederKonturproblem.svg \
	fig_sichtPaintersKorrekt.svg \
	fig_sichtPaintersInkorrekt.svg \
	fig_sichtPaintersEbene1.svg \
	fig_sichtPaintersEbene2.svg \
	fig_sichtPaintersGitter.svg \
	fig_sichtSilhouette1.svg \
	fig_sichtSilhouette2.svg \
	fig_sichtSilhouetteFall1.svg \
	fig_sichtSilhouetteFall2.svg \
	fig_sichtSilhouetteFall3.svg \
	fig_sichtSilhouetteFall4.svg \
	fig_farbeModellKontinuierlich.svg \
	fig_farbeModellSampling.svg \
	fig_farbeModellSamplingProblem.svg \
	fig_farbeModellFaltungGleich.svg \
	fig_farbeModellFaltungUngleich.svg \
	ink_farbeRezeptoren.svg \
	fig_farbeModellRGBWuerfel.svg \
	fig_farbeModellHSVSaettigung.svg \
	fig_farbeModellHSVKegel.svg \
	fig_farbeModellHLSKegel.svg \
	fig_farbeEffekteAmbient.svg \
	fig_farbeEffekteDiffus2.svg \
	fig_farbeEffekteDiffus3.svg \
	fig_farbeEffekteWinkelabhaengig1.svg \
	fig_farbeEffekteWinkelabhaengig2.svg \
	fig_farbeDepthCueing.svg \
	fig_farbeWarnSpiegel.svg \
	fig_farbeWarnKegel.svg \
	fig_farbeWarnKlappe.svg \
	fig_farbeStrategieKrumm1.svg \
	fig_farbeStrategieKrumm2.svg \
	fig_farbeStrategieBouknightMach1.svg \
	fig_farbeStrategieBouknightMach2.svg \
	fig_farbeStrategieBouknightMach3.svg \
	fig_farbeGouraud1.svg \
	fig_farbeGouraudHighlight1.svg \
	fig_farbeGouraudNormale1.svg \
	fig_farbeSchattenSituation.svg \
	fig_farbeZPufferProblem1.svg \
	fig_farbeZPufferProblem2.svg \
	fig_farbeTexturFlat1.svg \
	fig_farbeTexturFlat2.svg \
	fig_farbeTexturBump1.svg \
	fig_farbeTexturBump2.svg \
	fig_farbeTexturVolume.svg \
	fig_farbeTransparenzSituation.svg \
	fig_farbeTransparenzMaske.svg \
	fig_farbeTransparenzMolekuel.svg \
	fig_objekteFlaechenbasiertWuerfel.svg \
	fig_objekteFlaechenbasiertLoecher.svg \
	fig_objekteFlaechenbasiertInnenAussen.svg \
	fig_objekteVolumenErgebnisse.svg \
	fig_objekteVolumenSweep.svg \
	fig_objekteVolumenZellraster.svg \
	fig_objekteVolumenOctree2.svg \
	fig_objekteVolumenVerschieben.svg \
	fig_objekteFraktalGebirge.svg \
	fig_objekteFraktalBerg1.svg \
	fig_objekteFraktalSkala.svg \
	fig_objekteGrammatikZweig.svg \
	fig_objekteProzeduralFeuer.svg \
	fig_farbeRaytracingBrechungsgesetz.svg \
	fig_farbeRaytracingWhitted.svg \
	fig_farbeRaytracingRichtungen.svg \
	fig_farbeRaytracingProblemDiffus.svg \
	fig_farbeRaytracingZellen.svg \
	fig_farbeRaytracingOctree.svg \
	fig_farbeRaytracingOctreeBaum.svg \
	fig_farbeRaytracingMedian.svg \
	fig_farbeRaytracingMedianBaum.svg \
	fig_farbeRaytracingLichtpuffer.svg \
	fig_farbeRaytracingAdaptiv1.svg \
	fig_farbeRaytracingAdaptiv2.svg \
	fig_farbeRadiosityFarbverschiebung.svg \
	fig_farbeRadiosityColourBleeding.svg \
	fig_farbeRadiosityVollkommenDiffus.svg \
	fig_farbeRadiosityRaumwinkel1.svg \
	fig_farbeRadiosityRaumwinkel2.svg \
	fig_farbeRadiosityEnergie.svg \
	fig_farbeRadiosityKonkav.svg \
	fig_farbeRadiosityInterpolation.svg \
	fig_farbeRadiosityFormfaktor.svg \
	fig_farbeRadiosityFormGeometrisch.svg \
	fig_farbeRadiosityFormZellen1.svg \
	fig_farbeRadiosityFormZellen2.svg \
	fig_farbeRadiosityFormZellen3.svg \
	fig_farbeRadiosityFormZellen4.svg \
	fig_farbeRadiosityFormZellen5.svg \
	fig_farbeRadiosityLichtquellen.svg \
	fig_farbeRadiosityGatherShoot.svg \
	fig_farbeRadiositySchattengrenze.svg \
	fig_farbeRadiosityAblauf.svg \
	fig_renderFluxIrradianceRadiance.svg \
	fig_renderDistributedRayPath.svg \
	fig_renderBRDF1.svg \
	fig_renderBRDF2.svg \
	fig_renderBTDF.svg \
	fig_renderBSDF.svg \
	fig_renderCombBRDF.svg \
	fig_renderMIS.svg \
	fig_renderBidiPT.svg \

PINKSVG := \
	fig_titelFragestellung.svg \
	fig_titelStreckePrinzip.svg \
	fig_titelPaintersOhneDoppelpufferung.svg \
	fig_hardwarePlotterHauptrichtungen.svg \
	fig_hardwarePlotterApproximation.svg \
	fig_hardwareRasterNoninterlaced.svg \
	fig_hardwareRasterInline.svg \
	fig_scanPolygonPrinzip.svg \
	fig_scanPolygonFloodFill2.svg \
	fig_scanBreiteStrecke1.svg \
	fig_scanStreckeMuster1.svg \
	fig_scanRaumStattFarbe1.svg \
	fig_scanRaumStattFarbe2.svg \
	fig_scanRaumStattFarbe5.svg \
	fig_scanRaumStattFarbe6.svg \
	fig_scanRaumStattFarbe7.svg \
	fig_scanFarbeStattRaum.svg \
	fig_scanText2.svg \
	logo_OpenGL.svg \
	logo_Vulkan.svg \
	fig_koordProjektion2.svg \
	fig_koordProjektion3.svg \
	fig_koordRollerRoller.svg \
	fig_koordRollerLenker.svg \
	fig_koordRollerRad.svg \
	fig_clipStreckenMehrfach.svg \
	fig_clipStreckenEinPunkt.svg \
	fig_clipPolygonBsp.svg \
	fig_clipPolygonSutherlandProblem1.svg \
	fig_clipPolygonSutherlandProblem2.svg \
	fig_sichtWireframe.svg \
	fig_sichtRemoved.svg \
	fig_sichtZellenScan.svg \
	fig_sichtZellenBb.svg \
	fig_sichtZellenGutartig.svg \
	fig_sichtZellenBoesartig.svg \
	fig_sichtPolygoneAufwand.svg \
	fig_sichtPaintersUnmoeglich.svg \
	fig_farbeEffekteDiffus1.svg \
	fig_farbeStrategieKonstant1.svg \
	fig_farbeStrategieBouknightMach4.svg \
	fig_farbeGouraudHighlight2.svg \
	fig_farbeGouraudNormale2.svg \
	fig_farbePhongNormalen.svg \
	fig_objekteFlaechenbasiertDurchdringung.svg \
	fig_objekteFlaechenbasiertBohren.svg \
	fig_objekteVolumenSweepOps.svg \
	fig_objekteVolumenOctree1.svg \
	fig_objekteFraktalBerg2.svg \
	fig_objekteFraktalBerg3.svg \
	fig_objekteFraktalBerg4.svg \

GP := \
	gp_kurveZusammengesetzt.gp \
	gp_kurveHermiteBasisPolynome.gp \
	gp_kurveBezierBeispiele.gp \
	gp_kurveBernsteinPolynome.gp \
	gp_kurveBezierStueckweise.gp \
	gp_kurveBSpline.gp \
	gp_kurveBSplineBasisPolynome.gp \
	gp_kurveBSplinePunkteMehrfach.gp \
	gp_kurveBezierUnterteilung.gp \

LY :=

SRCDIR := Quellen

OTHERSRCREL := \
	Tretroller/roller.c \

SUBMAKESDIRREL := \
	Tretroller \

# Variable - Notebook
NOTEBOOKPATH := /home/holger/Bildgenerierung/Vorlesung

# Variable - Pfade zu Bibliotheken etc.
