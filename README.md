# Overview

This project provides a framework for modelling and simulating year-to-year performance changes for an athlete competing in a heptathlon. By leveraging historical performance data, the project uses regression modelling and residual analysis to predict future outcomes and assess the impact of strategic focus on a specific event (referred to as disciplines).

My R script with notes can be found here:
[Heptathlon_Model_R_Script.R](Heptathlon_Model_R_Script.R)

# Data
The data used in this analysis consists of historical data from previous heptathlon performances. Each athlete that appears in the dataset is alongside their 'pre' and 'post' scores in each of the 7 disciplines in the heptathlon. The 'pre' score is the scores of the first instance where the athlete was recorded, and the 'post' scores are their scores from the next large scale heptathlon competition they competed in, typically a year later. A 'diff' column shows the difference in points from the 'pre' and 'post' scores in each discipline and of their total score. Athletes could appear multiple times in this database without being duplicates if their scores came from different competitions and dates. 

An athlete was chosen at random for this project to be used for this predictive modelling. This was Hanna Kasyanova and her performance from the 2008 Beijing Olympics where she placed 13th. Her data was removed from the dataset before analysis as to not create any bias.

# Key Features

### **Performance Modelling:**

- **Linear Regression:** Builds discipline-specific regression models to predict performance changes based on previous scores.
- **Quintile Division:** Divides predicted values into quintiles to capture variability and classify residuals for each discipline.

- **Model Storage:** Stores model parameters (correlation, intercept, slope) and residuals for later use in simulations.

### **Simulation Framework:**

- **Monte Carlo Simulations:** Conducts 100,000 simulations to predict potential performance outcomes for each discipline and the overall score.

- **Residual Integration:** Adds randomised residuals from the corresponding quintile to each simulation, ensuring realistic performance variability.

- **Distribution Analysis:** Visualises the distribution of simulated total scores using histograms to identify trends and possible outcomes.

### **Emphasis Strategy Evaluation:**

- **Targeted Disciplines:** Simulates scenarios where one discipline is emphasised by doubling the chance of selecting higher residuals.

- **Score Comparison:** Calculates average total scores for each emphasis strategy to identify the optimal focus area for maximising total points.

# Objective
The primary objective of this project is to create a data-driven framework for analysing and predicting athletic performance in heptathlon events. By modelling year-to-year performance changes using linear regression, the project identifies how previous scores influence future outcomes while incorporating realistic variability through residual analysis. The use of Monte Carlo simulations enables the estimation of a wide range of potential results, offering valuable insights into the likelihood of various performance scenarios. Additionally, the framework evaluates the impact of strategic emphasis on specific disciplines by simulating scenarios where the athlete’s performance in one area is optimised. This approach allows for a deeper understanding of how targeted focus can affect overall scores. Ultimately, the project provides coaches, analysts, and athletes with actionable insights to optimise training strategies, improve decision-making, and maximise total scores in competition.
 
# Methodology
The methodology employed in this project combines statistical modelling with simulation techniques to predict future athletic performance and assess the impact of focusing on specific disciplines. The approach is divided into two main stages: performance modelling and simulation.

### **Performance Modelling:**
 The first step in the methodology involves building linear regression models for each of the seven disciplines. These models predict the year-to-year change in performance (referred to as the DIFF values) based on the previous year’s score (PRE). Linear regression is chosen for its simplicity and effectiveness in modelling continuous relationships. For each discipline, the regression model is fitted using the historical data, and the resulting coefficients, intercept and slope, are stored for future use.

In addition to the regression model, residual analysis is performed. The residuals represent the difference between the observed and predicted performance values, capturing the random variability in the data. These residuals are crucial for generating realistic simulations and are sorted into quintiles to reflect the range of possible deviations in performance.

### **Simulation Framework:**
 The second stage involves Monte Carlo simulations, where 100,000 simulations are run to model potential future outcomes for the athlete. For each simulation, the athlete’s predicted performance change for each discipline is calculated using the regression formula (intercept + slope × previous performance). A random residual is then added to the predicted change, which is selected from one of the five quintiles based on the predicted change’s value. One discipline is randomly chosen to be 'emphasised' during training, this discipline will be given two random residuals instead, and the higher of the two residuals is chosen for this discipline. This approach ensures that the simulated performances reflect realistic variability, and 'emphasised' disciplines are more likely to have better improvement in scores, similar to what might be observed in real-world competition.

Once all disciplines have been simulated, the total score is calculated by summing the individual scores across all seven disciplines. The simulations are repeated many times, allowing for the creation of a distribution of potential total scores. This distribution is visualised through histograms, which help to identify the range of outcomes and the likelihood of different performance levels.

# Insights

The results of the simulations offer valuable insights into the athlete’s potential performance, as well as the impact of emphasising specific disciplines. The simulations produce a range of possible total scores, providing a better understanding of performance variability and the likelihood of exceeding certain thresholds.

### Discipline regression
![regression line of 800m]()