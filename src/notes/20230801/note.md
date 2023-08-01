# Delay

- Seeing ~3ns to cross the entire delay lines when switching to sky130_fd_sc_hd__dlygate4sd3_1

- Guess the larger region of poly in the design increases the capactiance and therefore the delay 

![](single_stage_no_para_sky130_fd_sc_hd__dlygate4sd3_1_rise.png)

![](single_stage_no_para_sky130_fd_sc_hd__dlygate4sd3_1_fall.png)

- This delay increases to ~5.5ns when across the entire line when parasitics are included

![](single_stage_with_para_sky130_fd_sc_hd__dlygate4sd3_1_rise.png)

![](single_stage_with_para_sky130_fd_sc_hd__dlygate4sd3_1_fall.png)


- 32x1 inv: Utilisation 37.72%
- 32x8 inv: Utilisation 43.35%
- 32x1 delay gate: Utilisation 39.96%

- Looks like 3 sky130_fd_sc_hd__inv for 1 sky130_fd_sc_hd__dlygate4sd3
- Delay per cell of ~170ps sky130_fd_sc_hd__dlygate4sd3
- Delay per cell of ~100ps sky130_fd_sc_hd__inv


![](sky130_fd_sc_hd__dlygate4sd3_vs_sky130_fd_sc_hd__inv.png)




