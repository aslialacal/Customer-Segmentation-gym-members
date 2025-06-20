# Fitness App Clustering Analysis

This project clusters users of a fitness tracking app based on behavioral and demographic features to create personalized marketing strategies.



## Dataset
The dataset includes anonymized user data from a fitness tracking app:
- Demographics (Age, Gender)
- Fitness behavior (Workout Type, Frequency, Session Duration)
- Physiological stats (Calories Burned, BMI, Fat %, Avg BPM)
- Lifestyle metrics (Water Intake, Experience Level)


## Techniques Used
- Data preprocessing (dummy variables, normalization)
- KMeans clustering
- Cluster profiling and interpretation
- Visualization

## Key Features Used for Clustering
Age
Gender
BMI
Calories_Burned
Session_Duration..hours.
Workout_Frequency..days.week.
Experience_Level 
Water_Intake..liters.   
Fat_Percentage
Workout_Type


## Outputs
- Cluster summary table
- Cluster-specific visualizations
- Marketing strategy recommendations

## Files
- "Customer Segmentation_Gym Members.R": main analysis code
- "cluster_summary.csv": table of cluster
- "Visuals/": plots for cluster interpretation

## Cluster Profiles + Marketing Strategies

Cluster 1 – Low Intensity Yogis
•	🧘 Top Workout: Yoga
•	🔥 Avg Calories: 790.8
•	💪 Experience: 3.07 
•	💧 Water Intake: 2.41
•	🧍 Gender Ratio: 0.55 (almost balanced)
•	🧠 Strategy:
→ Promote mindfulness, flexibility, and wellness programs.
→ Offer relaxation-oriented bundles such as yoga mats, teas, recovery tools).
→ Engage via stress-reduction workshops.
________________________________________
Cluster 2 – High-Calorie Power Yogis
•	🧘 Top Workout: Yoga
•	🔥 Highest Avg Calories: 1265.2
•	🔁 Fat %: 14.8 (low, visible abs)
•	🔁 Highest Frequency: 4.53 sessions
•	🧍 Gender Ratio: 0.47 (almost balanced)
•	🧠 Strategy:
→ Market intense yoga fusion programs.
→ Offer loyalty rewards for consistency.
→ Upsell nutritional coaching since fat is low 
________________________________________
Cluster 3 – HIIT Lovers with High Fat 
•	⚡ Top Workout: HIIT
•	🔥 Calories: 813.2
•	🧠 Fat %: 28.4 (high)
•	🧍 Gender Ratio: 0.68 ( Predominantly Female)
•	🧠 Strategy:
→ Focus on fat loss and transformation challenges.
→ Promote metabolic conditioning, tracking tools like wearable and HIIT-specific plans.
→ Emphasize before/after journeys, possibly with coach check-ins.
________________________________________
Cluster 4 – Light Cardio Lovers
•	🏃 Top Workout: Cardio
•	🕓 Lowest duration + frequency (1.10 & 2.97)
•	🔥 Calories: 783.2 
•	🧠 High fat % (28.6)
•	🧠 Strategy:
→ Focus on motivational campaigns like "start your journey"
→ Send push reminders, create group challenges
→ Offer goal-setting plans with small wins
________________________________________
Cluster 5 – Strength Seekers
•	🏋️ Top Workout: Strength
•	🧍 Gender Ratio: 0.58 ( mostlky Female)
•	💪 Frequency: 3.11
•	🔥 Calories: 826.9
•	🧠 Strategy:
→ Promote progressive overload programs
→ Partner with equipment or supplement brands
→ Offer strength milestones
________________________________________
Cluster 6 – High BMI
•	🏋️ Top Workout: Cardio
•	⚖️ Highest BMI: 34.2
•	🧍 Gender Ratio: 0 (only male)
•	🧠 Strategy:
→ This may represent obese male clients, needing inclusive outreach
→ Position accessible cardio programs, gentle onboarding, and personal coaching
→ Send push reminders, create group challenges


## Gender Ratio	Interpretation
0.0	All male
0.5	Equal male and female
1.0	All female
> 0.5	More female
< 0.5	More male


## Requirements

tidyverse
cluster
factoextra
scales
reshape2



