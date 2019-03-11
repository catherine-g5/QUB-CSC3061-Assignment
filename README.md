# CSC3061 - Group Project

## Project Sections
### Section 1 - Training the Automatic System
- *32 Marks*
- Two Main Components 
	- A feature descriptor
		- Describe an image region with a high-dimensional descriptor
		- Options:
			1. Full Image (Prac 5 & 6)
			2. Dimensionality reduction techniques (Prac 7)
			3. Gabor Features
	- A learning method
		- Learn to classify an image region as a person or not.
		- Options
			1. SVM
			2. Nearest neighbour
			3. K-NN
- Folder images contains crops to be used for training.
- Justify your choice and the parameter values.
	
### Section 2 - Testing the Classification System
- *21 Marks*
- In order to justify previous choices, we need to divide dataset (both positive and negative examples) in 2 subsets: training and testing
	- Training samples and their labels for learning choose the best techniques, strategies and parameters for each block using the testing
	- Options:
		1. Given test and training files  face_train.cdataset and face_test.cdataset
		2. Half/half
		3. Cross validation
- Evaluate the performance of your final choice(s)
	- Options:
		1. Recognition Rate
		2. TP, FP, TN, FN (Prac 7)
		3. Precision, recall, specificity, sensitivity, etc… (Prac 7)

### Section 3 - Detection Implementation
- *37 Marks*
- Apply your classification/verification system to implement a pedestrian detector
- Two important components
	- A sliding window detector.  (Based on Prac 6)
		- Crop the image at every location and use the classifier to tell if that image region  contains a face. By scanning every location on the full image, it will detect all instances of faces in that image. 
		- In order to detect faces at multiple sizes, our sliding window detector should run at multiple scales (will  require resizing image)
	- Non-maxima suppression. (Prac 6)
		- Overlapping detections are a common problem. NMS removes overlapping detection to improve performance.  It keeps best detections in each region by selecting the strongest responses.
- Run your detector on the 4 files imX.jpg, and evaluate its performance
	- Calculate the performance of our detector (TP, FP, TN, FN, etc…)
	- Generate output images with bounding boxes
	- Reflect and explain the results that you have obtained
		- Why and when it fails?
