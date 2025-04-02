# Install required packages (only need to run once)
install.packages(c("readr", "readxl", "ggplot2", "cluster", "janitor"))

# Load necessary libraries
library(readr)
library(readxl)
library(ggplot2)
library(cluster)
library(janitor)

# Load dataset
Project_data_01 <- read_excel("Project_data_01.xlsx")
colnames(Project_data_01) <- c("Store_ID", "Store_Area", "Items_Available", "Daily_Customer_Count", 
                               "Store_Sales", "Sales_per_Customer", "Revenue_Category", 
                               "Customer_Density", "Sales_per_Item", "Store_Size_Category", 
                               "Estimated_Profit")

# 1. Descriptive Statistics
summary(Project_data_01$Store_Sales)
summary(Project_data_01$Estimated_Profit)

# 2. Data Visualization
# Average Store Sales by Revenue Category
ggplot(Project_data_01, aes(x = Revenue_Category, y = Store_Sales)) +
  stat_summary(fun = mean, geom = "bar", fill = "skyblue") +
  labs(title = "Average Store Sales by Revenue Category")

# Scatter Plot: Store Area vs. Store Sales
ggplot(Project_data_01, aes(x = Store_Area, y = Store_Sales)) +
  geom_point(color = "blue", alpha = 0.6) +
  labs(title = "Store Area vs Store Sales", x = "Store Area", y = "Store Sales")

# 3. Correlation Analysis
cor(Project_data_01$Store_Area, Project_data_01$Store_Sales)

# 4. Customer Behavior Analysis
# Density of Daily Customer Count by Revenue Category
ggplot(Project_data_01, aes(x = Daily_Customer_Count, fill = Revenue_Category)) +
  geom_density(alpha = 0.5) +
  labs(title = "Customer Count Distribution by Revenue Category")

# Average Sales per Customer by Store Size
aggregate(Sales_per_Customer ~ Store_Size_Category, data = Project_data_01, mean)

# 5. Regression Analysis
model <- lm(Store_Sales ~ Store_Area + Items_Available + Daily_Customer_Count, data = Project_data_01)
summary(model)

# 6. Clustering Analysis
clustering_data <- scale(Project_data_01[, c("Store_Area", "Daily_Customer_Count", "Store_Sales")])
summary(clustering_data)

# K-Means Clustering with 3 clusters
kmeans_result <- kmeans(clustering_data, centers = 3, nstart = 25)
Project_data_01$Cluster <- as.factor(kmeans_result$cluster)
summary(kmeans_result)

# Cluster Distribution
table(Project_data_01$Cluster)

# Visualizing Clusters
ggplot(Project_data_01, aes(x = Store_Area, y = Store_Sales, color = Cluster)) +
  geom_point() +
  labs(title = "Store Clusters", x = "Store Area", y = "Store Sales")

# 7. Hypothesis Testing (ANOVA)
anova_result <- aov(Store_Sales ~ Cluster, data = Project_data_01)
summary(anova_result)

# 8. Feature Engineering
Project_data_01$Profit_Margin <- Project_data_01$Estimated_Profit / Project_data_01$Store_Sales
summary(Project_data_01$Profit_Margin)

# 9. Handling Missing and Zero Values
sum(is.na(Project_data_01$Store_Sales))  # Count missing values
Project_data_01$Store_Sales[is.na(Project_data_01$Store_Sales)] <- mean(Project_data_01$Store_Sales, na.rm = TRUE)


# 10. Hierarchical Clustering
hclust_result <- hclust(dist(clustering_data), method = "ward.D2")
plot(hclust_result, main = "Hierarchical Clustering", xlab = "", sub = "")

# 11. Summary of Clusters
aggregate(cbind(Store_Area, Store_Sales, Estimated_Profit) ~ Cluster, data = Project_data_01, mean)








