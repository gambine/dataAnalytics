table(training$Genre)
table(training$Platform)
data <- sample(2,nrow(training),replace = TRUE, prob = c(0.67,0.33))
test1 <- training[data == 1,]
test2 <- training[data == 2,]
nrow(test1)
nrow(test2)
library(e1071)
library(rminer)
e1071model <- naiveBayes(Genre~.,data = test1)
e1071model
type <- c("Action")
new_data <- data.frame(type = "Action")
predict(e1071model, new_data, type = "raw")