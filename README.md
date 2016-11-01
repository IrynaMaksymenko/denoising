# denoising
This is study project that addresses the problem of documents demoising inspired by competition posted on kaggle (see https://www.kaggle.com/c/denoising-dirty-documents). 

Given as input some scanned typed document the target is to remove background noise and make text as readable as possible.

Two different approaches are used for comparison:
- clusterisation
- neural network

Code is written in Matlab. The structure is as folllowing:
- /data contains input (train) and output (predicted) images
- /nn example of simple neural network that can be used to solve the problem
- /nn_stack is an attempt to join several NNs to improve results
- clustering (several variants) examples of how clustering can solve the problem
- poster.pptx contains short presentation of this project
