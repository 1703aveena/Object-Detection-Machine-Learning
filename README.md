# SVM-for-object-detection
SVM for object detection
###  Description: 
Train an SVM and use it for detecting human upper bodies in TV series The Big Bang Theory images. To detect human upper bodies in images, we need a classifier that can distinguish between upper-body image patches from non-upper-body patches. To train such a classifier, we can use SVMs. The training data is typically a set of images with bounding boxes of the upper bodies. Positive training examples are image patches extracted at the annotated locations. A negative training example can be any image patch that does not significantly overlap with the annotated upper bodies. Thus there are potentially many more negative training examples than positive training examples. Due to memory limitation, it will not be possible to use all negative training examples at the same time. In this question, you will implement hard-negative mining to find hardest negative examples and iteratively train an SVM.

### Data 

Training images are provided in the subdirectory trainIms. The annotated locations of the upper bodies are given in trainAnno.mat. This file contains a cell structure ubAnno; ubAnno{i} is the annotated locations of the upper bodies in the ith image. ubAnno{i} is 4×k matrix, where each column corresponds2 to an upper body. The rows encode the left, top, right, bottom coordinates of the upper bodies (the origin of the image coordinate is at the top left corner).
Images for validation and test are given in valIms, testIms respectively. 


### Implementation

#### Library

External library
Raw image intensity values are not robust features for classification. In this question, we will use Histogram of Oriented Gradient (HOG) as image features. HOG uses the gradient information instead of intensities, and this is more robust to changes in color and illumination conditions. See [1] for more information about
HOG, but it is not required for this assignment.
To use HOG, you will need to install an VL FEAT: http://www.vlfeat.org. This is an excellent cross-platform library for computer vision and machine learning. However, in this homework, you are only allowed to use the HOG calculation and visualization function vl hog. In fact, you should not call vl hog directly. Use the supplied helper functions instead; they will call vl hog.
