(* ═══════════════════════════════════════════════════════════════
   Flow Rate Calculation — Time-Between-Pulses Method
   ───────────────────────────────────────────────────────────
   Principle: instead of counting pulses per fixed time window,
   measure the time between consecutive pulses using D8010.
   D8010 = current scan time in 0.1ms units.

   Formula: Flow [L/min] = LPP * 600,000 / dTime [0.1ms]

   I/O:
     X0   — Water meter pulse input (rising edge)
     D8010 — Scan time 0.1ms (accumulated each cycle)
   ═══════════════════════════════════════════════════════════════ *)

(* ── Accumulate scan time every cycle ── *)
(* D8010 is WORD (scan time 0.1ms); WORD_TO_DINT widens to DINT *)
g_diElapsedTime := g_diElapsedTime + WORD_TO_DINT(D8010);

(* ── Rising edge of water meter pulse ── *)
IF MEP(X0) THEN
    (* Increment total pulse counter (totalizer) *)
    g_diTotalPulses := g_diTotalPulses + K1;

    IF g_bFirstPulseReady THEN
        (* Normal operation: compute flow from time since last pulse *)
        IF g_diElapsedTime > K100 THEN
            (* Guard: require at least 10ms between pulses
               to avoid division by near-zero on fast pulses *)
            g_rFlowRate := (g_rLPP * E600000.0) / DINT_TO_REAL(g_diElapsedTime);

            (* Exponential smoothing filter *)
            (* Blends raw value with previous filtered value:
               α% from new raw, (1-α)% from old filtered *)
            g_rFlowFiltered := (g_rSmoothing * g_rFlowRate) +
                ((E1.0 - g_rSmoothing) * g_rFlowFiltered);
        END_IF;
    ELSE
        (* First pulse after startup: arm the system,
           no flow computed yet (need two points for a delta) *)
        g_bFirstPulseReady := TRUE;
    END_IF;

    (* Reset accumulator for the next pulse interval *)
    g_diElapsedTime := K0;
END_IF;

(* ── Timeout: no pulse for 3 seconds → flow decays to 0 ── *)
(* Accumulator keeps running — next pulse produces a correct
   low-flow reading, and the one after restores accurate rate. *)
IF g_diElapsedTime > K30000 THEN
    g_rFlowRate := E0.0;
    (* Feed zero through the filter for smooth decay *)
    g_rFlowFiltered := (g_rSmoothing * E0.0) +
        ((E1.0 - g_rSmoothing) * g_rFlowFiltered);
END_IF;

(* ── Reset totalizer (set g_xCounterReset TRUE to clear) ── *)
IF g_xCounterReset THEN
    g_diTotalPulses := K0;
END_IF;
