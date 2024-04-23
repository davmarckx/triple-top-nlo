OUTDIR=$1
PATCH="--- ${OUTDIR}/SubProcesses/P0_gb_tttxwm/matrix_4.f	2023-02-21 19:58:46.000000001 +0100
+++ ${OUTDIR}/SubProcesses/P0_gb_tttxwm/matrix_4.f	2023-02-21 19:58:46.000000001 +0100
@@ -486,7 +486,8 @@
       CALL FFV1_0(W(1,7),W(1,16),W(1,9),GC_11,AMP(4))
 C     Amplitude(s) for diagram number 5
       CALL FFV1_0(W(1,12),W(1,14),W(1,9),GC_11,AMP(5))
-      CALL FFV2_2(W(1,7),W(1,6),GC_124,DCMPLX(CMASS_MDL_MT),W(1,16))
+      CALL FFV2_2(W(1,7),W(1,6),1.0D-05*GC_124,DCMPLX(173.3,-0.6836),
+     $   W(1,16))
 C     Amplitude(s) for diagram number 6
       CALL FFV1_0(W(1,16),W(1,4),W(1,15),GC_11,AMP(6))
 C     Amplitude(s) for diagram number 7
--- ${OUTDIR}/SubProcesses/P0_gb_tttxwm/matrix_6.f	2023-02-21 19:58:46.000000001 +0100
+++ ${OUTDIR}/SubProcesses/P0_gb_tttxwm/matrix_6.f	2023-02-21 19:58:46.000000001 +0100
@@ -558,7 +558,8 @@
       CALL FFV1_0(W(1,7),W(1,16),W(1,9),GC_11,AMP(4))
 C     Amplitude(s) for diagram number 5
       CALL FFV1_0(W(1,12),W(1,14),W(1,9),GC_11,AMP(5))
-      CALL FFV2_2(W(1,7),W(1,6),GC_124,DCMPLX(CMASS_MDL_MT),W(1,16))
+      CALL FFV2_2(W(1,7),W(1,6),1.0D-05*GC_124,DCMPLX(173.3,-0.6836),
+     $   W(1,16))
 C     Amplitude(s) for diagram number 6
       CALL FFV1_0(W(1,16),W(1,4),W(1,15),GC_11,AMP(6))
 C     Amplitude(s) for diagram number 7
--- ${OUTDIR}/SubProcesses/P0_bg_tttxwm/matrix_2.f	2023-02-21 19:58:46.000000001 +0100
+++ ${OUTDIR}/SubProcesses/P0_bg_tttxwm/matrix_2.f	2023-02-21 19:58:46.000000001 +0100
@@ -558,7 +558,8 @@
       CALL FFV1_0(W(1,7),W(1,16),W(1,9),GC_11,AMP(4))
 C     Amplitude(s) for diagram number 5
       CALL FFV1_0(W(1,12),W(1,14),W(1,9),GC_11,AMP(5))
-      CALL FFV2_2(W(1,7),W(1,6),GC_124,DCMPLX(CMASS_MDL_MT),W(1,16))
+      CALL FFV2_2(W(1,7),W(1,6),1.0D-05*GC_124,DCMPLX(173.3,-0.6836),
+     $   W(1,16))
 C     Amplitude(s) for diagram number 6
       CALL FFV1_0(W(1,16),W(1,4),W(1,15),GC_11,AMP(6))
 C     Amplitude(s) for diagram number 7
--- ${OUTDIR}/SubProcesses/P0_bg_tttxwm/matrix_5.f	2023-02-21 19:58:46.000000001 +0100
+++ ${OUTDIR}/SubProcesses/P0_bg_tttxwm/matrix_5.f	2023-02-21 19:58:46.000000001 +0100
@@ -486,7 +486,8 @@
       CALL FFV1_0(W(1,7),W(1,16),W(1,9),GC_11,AMP(4))
 C     Amplitude(s) for diagram number 5
       CALL FFV1_0(W(1,12),W(1,14),W(1,9),GC_11,AMP(5))
-      CALL FFV2_2(W(1,7),W(1,6),GC_124,DCMPLX(CMASS_MDL_MT),W(1,16))
+      CALL FFV2_2(W(1,7),W(1,6),1.0D-05*GC_124,DCMPLX(173.3,-0.6836),
+     $   W(1,16))
 C     Amplitude(s) for diagram number 6
       CALL FFV1_0(W(1,16),W(1,4),W(1,15),GC_11,AMP(6))
 C     Amplitude(s) for diagram number 7"
