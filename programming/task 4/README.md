# Programming Tasks

# Task 3
1. In order to collect mutual fund data, APIs such as yahoo finance API can be adopted.

2. Most existing APIs online required monthly subscription and so programming cannot be performed. Integration of the data can be done using json library if Python language is adopted. First merge the JSON files obtained from the APIs in one new file then use json.dump to format the file as JSON.

3. Data validation should be performed at least once a month or when new API is applied as such APIs might be invalid. 


# Task 4
1. Data pre-processing technique applied in this task:
- acquire the dataset: "train.csv" is the train dataset in this task
- import essential python libraries: tensorflow, pandas, numpy
- identify and drop the missing values: since the size of the dataset is relatively small and so it is hard to normalise the data correctly
- extract the features and the target: the 'label' column is the desired output while the remaining columns are the input of the machine learning model

2. Keras was adopted in this task due to the ease of deloyment and handful built-in options for the model optimisation and the activation layers for Neural Network

3. The desired model was expected to be a multi-class classifier. Hence, the loss function was categorical crossentropy where it allowed 4 label classes. The optimiser was SGD that allowed maunal input of the learning rate and so the model could have higher precision with loss reduced.

4. One of the possible ways to deal with the small size of the dataset is to include more data if number of label classes remains unchanged. This can prevent the potential issue of overfitting and might enhance the precision.

5. To deal with the imbalanced dataset, re-label might be a solution. The possible outcomes of the model could be reduced to 2 classes such that the dataset can be more balanced and the precision can be enhanced.

6. Due to the insufficient of the training data and imbalanced dataset, the evaluation result of the model was poor with an accuracy of 0.3396 only. Different loss functions, optimisers was applied yet no luck. One of the possible approaches to achieve higher precision is to adopt a generalisation rule such as standardise the data values. 

