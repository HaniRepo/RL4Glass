# RL4Glass
# Simulation of the Heating Transfer Using MATLAB Simulink
This repository addresses the Simulink model of the simulation of heat transfer between the gob and the mold as provided by the Glassform project.

## Versions Overview
The project is developed in multiple stages, starting with a base schema and evolving to incorporate more detailed modeling and cooling phases. Key milestones include:

- Initial versions focused on setting up the model structure, interpolating key parameters, and calculating the gob and mold temperatures during different phases (settle, counter).
- Later versions introduced active and passive cooling, allowing the simulation of temperature evolution across multiple cycles.
- Simulink was primarily used, but a code-based environment was also developed for standalone simulations.

The most recent versions handle cooling integration and dynamic transitions between phases to mimic real-world processes. These versions also added the capability to simulate temperature variation across different cooling and settle times.

## Validation Versions
The current validation implementations are listed below with a brief description.

| Validation Version | Description                                                                                                      |
| ------------------ | --------------------------------------------------------------------------------------------------------------- |
| Validation V1       | Setup to validate 13150 experiments tracking the temperature of the mold and gob during each cycle              |
| Validation V2       | User-defined validation for running different IDs across custom cycles                                          |
| Validation V3       | Validation with dynamic coefficient calculation based on user input for gob initial temperature and other settings |
| Validation V4       | Stability check of mold temperature over 5000 cycles with two scenarios (constant settle or cooling values)      |
| Validation V5       | Dynamic stability check  and validation of the cases for consecutive cycles(Setup II)|
| Validation V6       | Chacking the behaviour after stability by increasing and decreasing T_mold, T_gob and  T_air|
| Validation V7       | Adding the reinforcement Learning controllr to handle the distortion|

> The validation versions are designed to test the robustness and accuracy of the heat transfer model by running simulations with varying parameters. Each version introduces different test scenarios for checking mold and gob temperature behavior.

### Data Dependency
To calculate the interpolation and coefficient values required for simulations, we use pre-calculated matrices and dynamic calculations in later versions.

## Detailed Descriptions of Validation Versions

### Validation Version 1
**Description:**  
In this version, the validation setup involves 13150 experiments to check the mold and gob temperature values in each cycle.

**Data dependency:**
- `allCoeffs`: This .mat file contains the pre-calculated coefficients for 75 different cases, stored as (a1_1, a1_2, a1_3, a1_4, … kc_1, kc_2, kc_3, kc_4). Each row represents one case, and these coefficients are used in the calculation for each cycle.

**Experiment:**  
The experiment runs across 75 cases, each with 18 cycles, resulting in 13150 records. It tracks the initial and final temperatures of the mold and gob for each cycle.

**Result:**  
The results of the mold and gob final temperatures, along with the calculated error, are outputted as text and CSV files.

### Validation Version 2
**Description:**  
In this setup, the user can specify different IDs for a desired number of cycles. Based on the provided ID, the corresponding coefficients are used, and the simulation runs. The user can input one or multiple IDs to compare the temperature changes over various cycles. An example using three IDs for 2000 runs is provided, and a PDF with plots of the current example is included.

### Validation Version 3
**Description:**  
In this version, the user can run different scenarios based on various initial gob temperatures and control settings. Unlike previous versions, this one does not require pre-calculated coefficients in a lookup table. Instead, the coefficients are calculated dynamically based on control inputs (`temperatureGob_init`, `t_settle`, `t_cooling`) and passed to the simulation function. Users can specify the number of cycles and settings to compare short and long runs, and the corresponding evolution of mold and gob temperature is plotted.

**Data dependency:**
- `coefficients.csv`: Contains the coefficients calculated for different cases and control settings.

### Validation Version 4
**Description:**  
In this version, as requested in the meeting, the stability of the mold temperature is checked over 5000 cycles. Two settings are used:
1. The settle time is kept constant, while the cooling value changes across 5 different values. The mold temperature for each setting is plotted.
2. The cooling value is kept constant, while the settle time changes across 5 different values. The mold temperature is plotted for comparison.

A PDF with the code and the resulting figures is provided as a demo.

**Data dependency:**  
- `coefficients_exa.csv`: This file stores the coefficients and control settings for the different cases.

### Validation Version 5
**Description:**  
In this version, as requested in the meeting, we added setup II validation script, where each case has been executed for consecutive cycle, and the final value is checked with the GF's simulations.

- `validationSecondSetup.mlx`: This file runs the 75 simulation and store the simulation traces and  plots in the 'ValidFolder' directory. 

- `checkResult.mlx`: After finishing the simulation, you can run this file to store the final temperature values in order to summries the results.

- `comparison.mlx`: This script is extended version of the 'validation version 4', that you can check the effects of different mold capacity in the stability test.

### Validation Version 6
**Description:**  
In this version, we switched to python. Therefore, the simulink file has been convereted to C code and used as an input to mimic the simulation set up. Then we used stability test to find the stable point of the simulation. Reaching to that point, we added distortion to different parameter to see the behaviour of the system and anlyze the related control parameters.

### Validation Version 7
**Description:**  
After having system stabilized,in this version, we increase/decrease the initial temperature of the gob to mimic changing different gob at the real process. Then, the reinforcement learning controller is activated to change the time of contact and time of cooling to adjust the system with new setting.


**Data dependency:**  
- `coefficients.csv`: Contains the coefficients calculated for different cases and control settings.
- `shortexperiment.csv`: Contains the different 75 cases setting including the final values of the last cycle .

A PDF with the code and the resulting figures is provided as a demo. Also the folder of results and compariosn with real data has been added.

