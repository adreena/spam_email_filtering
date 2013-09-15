spam_email_filtering
====================
Background
--

The dataset passes a pre-processing step before applying any classification method, so that each message can be represented as a vector of words. 

Since Python is a powerful language in terms of working with strings, this stage is developed in Python2. The following
steps involve in creating bag of words:

  - tokenization, which extracts the words in the email body
  - lemmatization, reducing words to their root forms (e.g., ‘‘extracting” to
‘‘extract”)
  - stop-word removal, eliminating some words that often occur in many emails (e.g. "to", ''a'', ''fo'')

The result is stored as a dictionary to be used as feature-vector for representing each email in the dataset. For this purpose, we consider one set only for spams and the other
one dedicated only to legitimate emails. For each set, we make a dictionary and eliminate
the high frequent words (of legitimate-dictionary) from spam-dictionary.

Machine learning methods
---
Learning methods used in this project are Support Vector Machine (SVM), Naïve-Bayesian (NB), Decision Tree (DT), Random Forest (RF), and some combination techniques like Majority-of-Voting, Maximum-Probability, Average-of-Probabilities and
Product-of-Probabilities. In this study we try to evaluate the performance of a classifier which uses Dempster-Shafer Theory of Evidence (DSTE) for spam filtering.

The idea of using DSTE comes from the paper of Al-Ani et al. which exploits degree of beliefs from different classifiers to predict the final label. This method is claimed to be a
new technique for combining multiple classifiers based on DSTE.

Hypotheses:
---
  - Manipulating training set for reducing training errors and its impacts on test errors.
  - Combining SVM, Naïve-Bayesian and RF classifiers for reducing test-error using degree
of uncertainty.
  - Supervised methods will perform better than unsupervised methods.


Conclusion
---
Eliminating data points with sparse-feature from the training dataset and replacing them by some new generated data points may decrease training-error. But it does not necessarily
improve the performance of the learner because no valuable information will be added to the training dataset.

Combining beliefs and uncertainties by using DSTE is a good approach for making a final prediction for a data point. It reduces the overall error. For proving this idea, more
experiments should be done with different basis-classifiers and datasets.

Unsupervised methods are not good approaches for spam filtering. Because the structure of spam and legitimate emails are very close to each other and it is hard for a classifier to
predict a label for new data points. So by providing a labeled training set for the classifier, discrimination of emails would be more accurate (supervised methods).

We also tried to classify image emails by using OCR applications to take the texts out of an image. Unfortunately the available public corpuses include only image parts of
emails not the texts. For instance in some of the emails there are only a few words like “CLICK HERE”. Obviously this small feature vector is not qualified to train the classifiers.
A possible solution for this problem can be merging some texts to these images, in order to make a better feature vector.
