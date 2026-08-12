(* ═══════════════════════════════════════════════════════════════
   INIT — First Scan Initialization
   Runs once on M8002 (first scan after RUN).
   ═══════════════════════════════════════════════════════════════ *)

IF M8002 THEN
    g_bFirstPulseReady := FALSE;
    g_diElapsedTime := K0;
    g_diTotalPulses := K0;
    g_rFlowRate := E0.0;
    g_rFlowFiltered := E0.0;

    (* Defaults — override from HMI *)
    (* g_rLPP := E10.0; *)
    (* g_rSmoothing := E0.3; *)
END_IF;
