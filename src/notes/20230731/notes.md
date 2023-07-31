
# Delay

- Seeing ~2ns to cross the entire delay lines, too short...

![](rise.png)

![](fall.png)


- With the parasitic extraction this increases to ~3.5ns 

- The simulation take x10 longer to run with parasitics extraction

![](parasitics_rise.png)

![](parasitics_fall.png)

- Increasing the number of inverters to 8 per stage still does 
  reach the rising edge of the next clock

- The names for the resync also gets squashed so might need more
  keep = true

![](8_inv_per_stage.png)


