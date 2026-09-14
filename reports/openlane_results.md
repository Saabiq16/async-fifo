# OpenLane ASIC Implementation Results

## Design Information

| Parameter | Value |
|---|---|
| Design | Asynchronous FIFO |
| Technology | SKY130A |
| Standard Cell Library | `sky130_fd_sc_hd` |
| OpenLane Version | 1.0.2 |
| Flow | RTL-to-GDSII |
| Synthesis Strategy | AREA 0 |
| Clock Period | 10 ns |
| Target Frequency | 100 MHz |
| Core Utilization Target | 40% |
| Heuristic Diode Insertion | Enabled |

---

## Physical Design Results

| Parameter | Value |
|---|---:|
| Synthesized Cells | 702 |
| Total Physical Cells | 20,299 |
| Core Area | 20,299.47 µm² |
| Die Area | 0.025597 mm² |
| Placement Utilization | 42.27% |
| Diode Cells | 168 |
| Decap Cells | 963 |
| Welltap Cells | 168 |
| Fill Cells | 156 |
| Wire Length | 20,003 |
| Vias | 5,485 |

---

## Timing Results

Final post-route STA at the nominal corner:

| Parameter | Result |
|---|---:|
| Clock Period | 10 ns |
| Target Frequency | 100 MHz |
| Setup TNS | 0 ns |
| Worst Setup Slack | +7.73 ns |
| Worst Hold Slack | +0.35 ns |
| Setup Violations | 0 |
| Hold Violations | 0 |

OpenLane also reported no max slew, max fanout, or max capacitance violations at the typical corner.

---

## Power Results

Final post-route power estimation at the typical corner:

| Power Component | Value |
|---|---:|
| Internal Power | 1.85 mW |
| Switching Power | 0.957 mW |
| Leakage Power | 5.32 nW |
| **Total Power** | **2.80 mW** |

### Power Distribution

- Internal power: **65.9%**
- Switching power: **34.1%**
- Leakage power: approximately **0%**

---

## Physical Verification

| Verification | Result |
|---|---:|
| Detailed Routing DRC | 0 violations |
| Magic DRC | 0 violations |
| LVS | PASS |
| LVS Errors | 0 |
| Antenna Net Violations | 0 |
| Antenna Pin Violations | 0 |
| KLayout ↔ Magic XOR Differences | 0 |
| Max Slew Violations | 0 |
| Max Fanout Violations | 0 |
| Max Capacitance Violations | 0 |

---

## Signoff Summary

The asynchronous FIFO successfully completed the OpenLane RTL-to-GDSII flow using the SKY130A PDK and `sky130_fd_sc_hd` standard-cell library.

The implementation completed:

- RTL synthesis
- Floorplanning
- Global and detailed placement
- Clock Tree Synthesis (CTS)
- Heuristic antenna diode insertion
- Global routing
- Detailed routing
- Parasitic extraction
- Multi-corner static timing analysis
- Power estimation
- Magic DRC
- LVS
- Antenna verification
- KLayout/Magic XOR verification
- Final GDS generation

The final flow completed successfully with no setup or hold violations, zero DRC violations, zero LVS errors, and zero antenna violations.

---

## Final GDS

The final GDSII layout was generated as:

`results/fifo.gds`

The GDS can be viewed using KLayout.