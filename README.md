# Overview
This is a project which I completed during university, while first learning R and statistical analysis.
It looked to provide a framework for modelling and simulating year-to-year performance changes for an athlete competing in a heptathlon. By leveraging historical performance data, the project uses regression modelling and residual analysis to predict future outcomes and assess the impact of strategic focus on a specific event (referred to as disciplines).

In this document I will be looking back at the project to show its insights, limitations, and areas for improvement, with the future goal of recreating this project utilising these improvements to upgrade my work and its findings. 

My R script with notes can be found here:
[Heptathlon_Model_R_Script.R](Heptathlon_Model_R_Script.R)

Upon writing this script I also wrote a 10 page report on the findings and their significance which can be read here:
[Heptathlon_Project_Report.md](Heptathlon_Project_Report.md)

# Data
The data used in this analysis consists of historical data from previous heptathlon performances. Each athlete that appears in the dataset is alongside their 'pre' and 'post' scores in each of the 7 disciplines in the heptathlon. The 'pre' score is the scores of the first instance where the athlete was recorded, and the 'post' scores are their scores from the next large scale heptathlon competition they competed in, typically a year later. A 'diff' column shows the difference in points from the 'pre' and 'post' scores in each discipline and of their total score. Athletes could appear multiple times in this database without being duplicates if their scores came from different competitions and dates. 

An athlete was chosen at random for this project to be used for this predictive modelling. This was Hanna Kasyanova and her performance from the 2008 Beijing Olympics where she placed 13th. Her data was removed from the dataset before analysis as to not create any bias.

Hanna Kasyanova's PRE scores were:
| Event        | Score |
|--------------|-------|
| 100m Hurdles | 1047  |
| High Jump    | 978   |
| Shot Put     | 739   |
| 200m         | 947   |
| Long Jump    | 975   |
| Javelin      | 589   |
| 800m         | 890   |

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
---
![regression line of 800m](Images/800m_example_reg)

The first visualisation created in this script shows the regression line for the 7 different disciplines. Rather than showing all 7 (they all have very similar regression lines) The 800m event graph is being shown. As with the other disciplines, this shows a clear negative regression. This is to be expected, with the nature of elite competition in sport, the better you are the harder it is to improve. Those athletes that had worse PRE scores had an easier time improving upon themselves and therefore had a better DIFF score, with the opposite being true for those who had the higher PRE scores. 

### Simulation point spread frequency
---
![histogram of the simulation points for Hanna Kasyanova](Images/sim_points_spread_hist)

The histogram displays the distribution of the total simulated scores for the athlete, based on 100,000 simulations. The frequency of scores are normally distributed, with a peak around 6100, indicating that the most likely total score for the athlete is centred around this value. The spread of scores ranges from approximately 5900 to 6400, reflecting variability introduced by residuals from year-to-year performance changes. This variability is influenced by both the predicted changes and the random noise modelled within each discipline.

The relatively symmetric shape of the histogram suggests that the simulation assumptions, particularly the residuals and quintile-based structure, are well-calibrated and do not introduce significant bias. The width of the distribution provides an estimate of the uncertainty in the athlete's projected performance, highlighting how their total score could vary depending on discipline-specific outcomes. 

### Discipline emphasis average
---
![Plot showing the average total points per discipline emphasis](Images/athlete_emph_score)

### **Score Table**

| Index | Event        | Avg Score   |
|-------|--------------|---------|
| 1     | 100m Hurdles | 6134.7  |
| 2     | High Jump    | 6124.9  |
| 3     | Shot Put     | 6128.6  |
| 4     | 200m         | 6142.1  |
| 5     | Long Jump    | 6164.9  |
| 6     | Javelin      | 6151.2  |
| 7     | 800m         | 6155.5  |
| 8     | No Emphasis  | 6125.3

This graph illustrates how emphasising different disciplines in training affects the athlete's average total score over 100,000 simulations. Each point represents the mean score when focusing on a specific discipline (indexed 1 to 7), while index 8 represents the scenario with no emphasis on any particular discipline.

From the graph, it is evident that certain disciplines yield higher average scores when emphasised in training, with indexes 5, 6, and 7 showing the greatest improvements in total performance. Conversely, disciplines indexed 1, 2, and 3 result in lower scores when emphasised, suggesting that focusing on these areas might not provide as much benefit.

As expected, the score for index 8 is lower than the best-performing disciplines, but interestingly is slightly higher than the weakest discipline, indicating that a balanced approach without specific focus may result in a moderate improvement. These insights can guide training decisions by prioritising disciplines that offer the most substantial impact on overall performance while considering the diminishing returns of focusing on less influential areas.

# Challenges With This Project
While the project provides valuable insights, there are several limitations to be aware of:

- **Assumptions in Regression Models:** The linear regression models assume a constant relationship between previous performance and future performance. In reality, this relationship may be more complex and subject to other factors (e.g., training, injuries, mental state).

- **Limited Data:** The project relies on a single dataset, which may not capture all variables influencing an athlete’s performance. Factors such as external conditions (e.g., weather) or psychological factors are not considered in the model.

- **Independence of Residuals:** The residuals are assumed to be independent for each discipline. However, in real-world situations, there may be correlations between disciplines that could affect performance.

- **Simplified Approach to Emphasis:** The emphasis strategy only doubles the likelihood of higher residuals in a chosen discipline. This approach is a simplification and may not fully represent the effects of different training methods or real-life variability.


# Future Work
When I recreate this project, there are several areas that I would like to change or improve upon in order to increase the accuracy and usefulness of the project.

- **Advanced Modelling Techniques:** Exploring machine learning models or more complex statistical techniques could improve the accuracy of performance predictions and residual estimations.

- **Improved Dataset:** The dataset that was used in this project was simple and only held the bare minimum of data needed. Improving upon this dataset to include more variables such as time from last event, age or funding for training would improve the accuracy and insights form this project. However the limitation for this would be the struggle of finding all this data.

- **Broader Athlete Base:** The model could be applied to a wider range of athletes to test its applicability across different skill levels and disciplines. This would provide insights into how the model generalises beyond the current dataset.

- **Dynamic Weighting of Disciplines:** Instead of assigning a fixed emphasis to one discipline at a time, explore dynamic weighting schemes that distribute emphasis across multiple disciplines simultaneously. This would reflect more realistic training scenarios and allow for optimisation of training strategies.

- **Optimisation Algorithms for Emphasis Allocation:** Implement optimisation techniques (e.g., genetic algorithms, gradient descent, or reinforcement learning) to automatically determine the best emphasis strategy for maximising an athlete’s overall score. This could eliminate the need to manually test each discipline.

- **Interaction Between Disciplines:** Account for potential interactions between disciplines, as improvement in one may influence performance in others (e.g., increased emphasis on Javelin might also benefit Shot Put). Incorporating these dependencies could refine the simulation results.

Utilising some or all of these ideas would greatly improve the quality of my work for the next project on this idea, however I'm sure they will all have their own intricacies and limitations to deal with. Either way, I am looking forward to recreating this project and see what I can improve upon.

# Conclusion
Overall for my first time using R and attempting predictive modelling I am proud of the insights I was able to create during this Project. It provided a powerful tool for predicting athletic performance and evaluating the impact of focusing on specific disciplines. By combining regression modelling with Monte Carlo simulations, the project offered actionable insights into an athlete's potential future performance, helping coaches and analysts make data-driven decisions. The ability to simulate different emphasis strategies allows for the identification of training priorities that can maximise overall performance. While the model is based on certain assumptions and has limitations, it provides a solid foundation for further exploration and refinement in sports analytics. I am excited about the future re-creation of this project to see how much I can improve.