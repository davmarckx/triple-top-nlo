PATCH="--- ${OUTDIR}/SubProcesses/P0_dbx_ttxtxu/matrix_2.f     2023-02-21 19:03:36.000000001 +0100
+++ ${OUTDIR}/SubProcesses/P0_dbx_ttxtxu/matrix_2.f     2023-02-21 19:03:36.000000001 +0100
@@ -475,7 +475,7 @@
       CALL FFV1_2(W(1,7),W(1,9),GC_11,DCMPLX(ZERO),W(1,12))
 C     Amplitude(s) for diagram number 2
       CALL FFV2_0(W(1,12),W(1,6),W(1,10),GC_124,AMP(2))
-      CALL FFV2P0_3(W(1,7),W(1,6),GC_124,DCMPLX(CMASS_MDL_MW),W(1,10))
+      CALL FFV2P0_3(W(1,7),W(1,6),1.0D-05*GC_124,DCMPLX(CMASS_MDL_MW),W(1,10))
       CALL FFV1_1(W(1,8),W(1,9),GC_11,DCMPLX(ZERO),W(1,13))
 C     Amplitude(s) for diagram number 3
       CALL FFV2_0(W(1,5),W(1,13),W(1,10),GC_124,AMP(3))
--- ${OUTDIR}/SubProcesses/P0_uxbx_ttxtxdx/matrix_2.f   2023-02-21 19:03:37.000000001 +0100
+++ ${OUTDIR}/SubProcesses/P0_uxbx_ttxtxdx/matrix_2.f   2023-02-21 19:03:37.000000001 +0100
@@ -475,7 +475,7 @@
       CALL FFV1_2(W(1,7),W(1,9),GC_11,DCMPLX(ZERO),W(1,12))
 C     Amplitude(s) for diagram number 2
       CALL FFV2_0(W(1,12),W(1,6),W(1,10),GC_124,AMP(2))
-      CALL FFV2P0_3(W(1,7),W(1,6),GC_124,DCMPLX(CMASS_MDL_MW),W(1,10))
+      CALL FFV2P0_3(W(1,7),W(1,6),1.0D-05*GC_124,DCMPLX(CMASS_MDL_MW),W(1,10))
       CALL FFV1_1(W(1,8),W(1,9),GC_11,DCMPLX(ZERO),W(1,13))
 C     Amplitude(s) for diagram number 3
       CALL FFV2_0(W(1,5),W(1,13),W(1,10),GC_124,AMP(3))
--- ${OUTDIR}/SubProcesses/P0_bxd_ttxtxu/matrix_3.f     2023-02-21 19:03:37.000000001 +0100
+++ ${OUTDIR}/SubProcesses/P0_bxd_ttxtxu/matrix_3.f     2023-02-21 19:03:37.000000001 +0100
@@ -475,7 +475,7 @@
       CALL FFV1_2(W(1,7),W(1,9),GC_11,DCMPLX(ZERO),W(1,12))
 C     Amplitude(s) for diagram number 2
       CALL FFV2_0(W(1,12),W(1,6),W(1,10),GC_124,AMP(2))
-      CALL FFV2P0_3(W(1,7),W(1,6),GC_124,DCMPLX(CMASS_MDL_MW),W(1,10))
+      CALL FFV2P0_3(W(1,7),W(1,6),1.0D-05*GC_124,DCMPLX(CMASS_MDL_MW),W(1,10))
       CALL FFV1_1(W(1,8),W(1,9),GC_11,DCMPLX(ZERO),W(1,13))
 C     Amplitude(s) for diagram number 3
       CALL FFV2_0(W(1,5),W(1,13),W(1,10),GC_124,AMP(3))
--- ${OUTDIR}/SubProcesses/P0_bxux_ttxtxdx/matrix_3.f   2023-02-21 19:03:37.000000001 +0100
+++ ${OUTDIR}/SubProcesses/P0_bxux_ttxtxdx/matrix_3.f   2023-02-21 19:03:37.000000001 +0100
@@ -475,7 +475,7 @@
       CALL FFV1_2(W(1,7),W(1,9),GC_11,DCMPLX(ZERO),W(1,12))
 C     Amplitude(s) for diagram number 2
       CALL FFV2_0(W(1,12),W(1,6),W(1,10),GC_124,AMP(2))
-      CALL FFV2P0_3(W(1,7),W(1,6),GC_124,DCMPLX(CMASS_MDL_MW),W(1,10))
+      CALL FFV2P0_3(W(1,7),W(1,6),1.0D-05*GC_124,DCMPLX(CMASS_MDL_MW),W(1,10))
       CALL FFV1_1(W(1,8),W(1,9),GC_11,DCMPLX(ZERO),W(1,13))
 C     Amplitude(s) for diagram number 3
       CALL FFV2_0(W(1,5),W(1,13),W(1,10),GC_124,AMP(3))"