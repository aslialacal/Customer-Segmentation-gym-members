
# Load required packages
library(dplyr)
library(ggplot2)
library(readr)
library(tidyr)


# Load and Explore the Data
df <- read.csv("C:\\Users\\aslia\\OneDrive\\Desktop\\Marketing Analytics\\gym_members_exercise_tracking.csv")

# View basic structure
str(df)
glimpse(df)

# See first few rows
head(df)

# Summary statistics
summary(df)

#check missing values
colSums(is.na(df))

# Count unique values in categorical columns
df %>%
  summarise(
    Gender = n_distinct(Gender),
    Workout_Type = n_distinct(Workout_Type),
    Experience_Level = n_distinct(Experience_Level))

# I would like to use some categorical columns in clustering so I will encode them

# Encode Gender
df$Gender <- ifelse(df$Gender == "Female", 1, 0 )

# One-hot encode Workout type and merge back into original dataset 
# First, create dummy variables like Workout_TypeCardio, Workout_TypeYoga etc

workout_dummies <- model.matrix(~ Workout_Type - 1, data = df)

# Combine these dummies with the original dataset 

df <- cbind(df, workout_dummies)


#check if everything is done
glimpse(df)

#K-means uses Euclidean distance, so variables with large scales (like calories or heart rate)
#will dominate the clustering unless all variables are on the same scale. So we need to normalize the data

# Normalize all numeric columns in the dataset with excluding Workout_Type column

df_scaled <- as.data.frame(scale(df %>% select(-Workout_Type)))


#check summary
summary(df_scaled) #We scaled all numeric features (i.e., every column now) to have: Mean = 0 Standard Deviation = 1
                   # since everything is numeric and meaningful, we scaled all.


# Determine the optimal number of clusters
# A: Elbow Method

# Create a vector to store WSS values
wss <- numeric()

# Compute WSS for k = 1 to 10

for (k in 1:10) {kmeans <- kmeans(df_scaled, centers = k, nstart= 25)
wss[k] <- kmeans$tot.withinss}

# Plot WSS - k

elbow_plot <- qplot(1:10, wss, geom= "line") + 
  geom_point() + labs(title = "Elbow method for K" , 
                      x="Number of clusters (k)", 
                      y="Total within-cluster sum of squares") +
  theme_minimal()

print(elbow_plot)

# B: Silhouette Method

library(cluster)

# Computing silhouette widths for k= 2 to 10

avg_sil <- numeric()


for (k in 2:10)
{
  km_res <- kmeans(df_scaled, centers=k, nstart=25)
  sil <-silhouette(km_res$cluster, dist(df_scaled))
  avg_sil[k] <- mean(sil[,3])
}
 
# Plot Silhouette score

sil_plot <- qplot(2:10, avg_sil[2:10], geom="line")+
  geom_point()+
  labs(title="Silhouette Method for Optimal K",
       x= "Number of Clusters",
       y="Average Silhouette score")+
  theme_minimal()
  
  print(sil_plot)

  
  
# I have chosen k=6 because in Elbow method k=2 was the highest WSS 
#but it would be so broad and oversimplified thats why I evaluated the Silhouette method,
#and I also saw k=2 highest WSS but I checked the second highest WSS and it was k=6
# and it would be more distinct marketting segments so I went for it.
  
  
  
# K-means with k = 6
  
set.seed(123)    #for preducibility
kmeans_result <- kmeans(df_scaled, center = 6, nstart=25)

# Add the cluster labels to your original dataset

df$Cluster <- as.factor(kmeans_result$cluster)

# Check updated dataset
head(df)

# Check Cluster balance 
table(df$Cluster)

# Check Cluster centers (z-scores number of standard deviations from the mean)
kmeans_result$centers


# Generate profiles of clusters

cluster_profiles <- df %>%
  group_by(Cluster) %>%
  summarise(
    Count = n(),
    Avg_Age = round(mean(Age),1),
    Gender_Ratio = round(mean(Gender),2),
    Avg_BMI = round(mean(BMI),1),
    Avg_Calories = round(mean(Calories_Burned), 1),
    Avg_Session_Duration = round(mean(Session_Duration..hours.), 2),
    Avg_Workout_Frequency = round(mean(Workout_Frequency..days.week.), 2),
    Avg_Experience = round(mean(Experience_Level), 1),
    Avg_Water_Intake = round(mean(Water_Intake..liters.),2),
    Avg_Fat_Percent = round(mean(Fat_Percentage), 1),
    Top_Workout_Type = names(sort(table(Workout_Type), decreasing = TRUE))[1]
  )

# VISUALIZE THE SEGMENTS


#  Scatter Plot of Gender and Workout Type

ggplot(df, aes(x = Gender, y = Workout_Type, color = Cluster)) +
  geom_point(alpha = 0.6, size = 3) +
  labs(title = "Clusters by ") +
  theme_minimal()

#  Scatter Plot of Gender and Workout Type

ggplot(df, aes(x = Workout_Type, y =  Workout_Frequency..days.week., color = Cluster)) +
  geom_point(alpha = 0.6, size = 3) +
  labs(title = "Clusters by ") +
  theme_minimal()

# Boxplots by Cluster

#Workout_Frequency Boxplot

ggplot(df, aes(x = Cluster, y = Workout_Frequency..days.week. , fill = Cluster)) +
  geom_boxplot() +
  labs(title = "Workout Frequency by Cluster") +
  theme_minimal()

#Fat Percentage Boxplot

ggplot(df, aes(x = Cluster, y = Fat_Percentage, fill = Cluster)) +
  geom_boxplot() +
  labs(title = "Workout Frequency by Cluster") +
  theme_minimal()

#Water Intake Boxplot
ggplot(df, aes(x = Cluster, y =  Water_Intake..liters., fill = Cluster)) +
  geom_boxplot() +
  labs(title = "Workout Frequency by Cluster") +
  theme_minimal()

#BMI boxplot

ggplot(df, aes(x = Cluster, y = BMI, fill = Cluster)) +
  geom_boxplot() +
  labs(title = "Workout Frequency by Cluster") +
  theme_minimal()

#Barplot of Cluster Averages (Faceted by Feature)

install.packages("reshape2")
library(reshape2)
  
# Melt for ggplot
df_plot <- melt(cluster_profiles, id.vars = "Cluster")

ggplot(df_plot, aes(x = as.factor(Cluster), y = value, fill = as.factor(Cluster))) +
  geom_col(position = "dodge") +
  facet_wrap(~ variable, scales = "free_y") +
  labs(x = "Cluster", y = "Average Value", fill = "Cluster",
       title = "Cluster Profiles by Feature") +
  theme_minimal()

