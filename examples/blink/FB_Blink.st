(*
 * FB_Blink — Blink / Flash Function Block
 *
 * Alternates output ON/OFF using two TON timers.
 * - tOnTime: duration output stays ON
 * - tOffTime: duration output stays OFF
 * - Output starts ON when enabled (rising edge of xEnable)
 *
 * Compatible: FX3U, FX3G, FX3S, FX5U (GX Works 2)
 *)

(* Rising edge detection on enable — start with ON phase *)
IF MEP(xEnable) THEN
    xOut := TRUE;
END_IF;

(* On-timer: runs while output is ON and enabled *)
tonOn(IN := xOut AND xEnable, PT := tOnTime);
IF tonOn.Q THEN
    xOut := FALSE;  (* ON time expired, switch to OFF *)
END_IF;

(* Off-timer: runs while output is OFF and enabled *)
tonOff(IN := NOT xOut AND xEnable, PT := tOffTime);
IF tonOff.Q THEN
    xOut := TRUE;   (* OFF time expired, switch to ON *)
END_IF;

(* When disabled, reset output immediately *)
IF NOT xEnable THEN
    xOut := FALSE;
END_IF;
