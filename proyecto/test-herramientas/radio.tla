------------------------------ MODULE radio ------------------------------

EXTENDS Naturals, Sequences

CONSTANTS T

ASSUME T = 88..108

VARIABLES state, freq, action

(*-- State Types --*)
Radio == "RADIO"
Freq(i) == <<"FREQ", i>>
Scan(i) == <<"SCAN", i>>

Init ==
    /\ state = Radio
    /\ freq \in T

Next ==
    \/ /\ state = Radio
       /\ action = "on"
       /\ state' = Freq(108)
       /\ freq' = 108

    \/ /\ \E i \in T: state = Freq(i)
       /\ action = "off"
       /\ state' = Radio
       /\ freq' = freq

    \/ /\ \E i \in T: state = Freq(i)
       /\ action = "reset"
       /\ state' = Freq(108)
       /\ freq' = 108

    \/ /\ \E i \in T: state = Freq(i)
       /\ action = "scan"
       /\ state' = Scan(108)
       /\ freq' = freq

    \/ /\ \E i \in T: state = Scan(i)
       /\ action = "notfound"
       /\ i > 88
       /\ state' = Scan(i - 1)
       /\ freq' = freq

    \/ /\ \E i \in T: state = Scan(i)
       /\ action = "notfound"
       /\ i = 88
       /\ state' = Freq(108)
       /\ freq' = 108

    \/ /\ \E i \in T: state = Scan(i)
       /\ action = "found"
       /\ state' = Freq(i)
       /\ freq' = i

    \/ /\ \E i \in T: state = Scan(i)
       /\ action = "off"
       /\ state' = Radio
       /\ freq' = freq

vars == <<state, freq>>

Spec == Init /\ [][Next]_vars

=============================================================================

=============================================================================
\* Modification History
\* Last modified Sun Apr 13 18:15:30 ART 2025 by ignacioramirez
\* Created Sun Apr 13 17:59:48 ART 2025 by ignacioramirez
