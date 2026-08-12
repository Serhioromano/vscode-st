(*
 * MAIN — Example program using FB_Blink
 *
 * Demonstrates how to instantiate and call the blink function block
 * with physical I/O binding.
 *
 * Wiring:
 *   X0 — Enable switch (NO contact)
 *   Y0 — Blink output (lamp / indicator)
 *
 * Compatible: FX3U, FX3G, FX3S, FX5U (GX Works 2)
 *)

(* Call FB_Blink instance:
 *   fbBlink — declared as VAR in MAIN.csv
 *   DI_Enable — declared as VAR_GLOBAL in IO.csv (bound to X0)
 *   DO_Lamp  — declared as VAR_GLOBAL in IO.csv (bound to Y0)
 *)
fbBlink(
    xEnable  := DI_Enable,
    tOnTime  := T#500MS,
    tOffTime := T#500MS,
    xOut     := DO_Lamp
);
