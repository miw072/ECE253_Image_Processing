% We are training using the training samples
%
clear;
close all;

% adding libsvm path
addpath(genpath('.\libsvm-3.11'));
cellsize=8;
nbins=8;

% set number of training and testing images
num_tr_pos = 50; % number of positive training samples
num_te_pos = 100; % number of positive testing samples
num_tr_neg = 50; % number of negative training samples
num_te_neg = 100; % number of negative testing samples

%% Training phase
% loop to get the set number of training images

features_pos=[];
for i=1:num_tr_pos
    fname = ['.\positives\' num2str(i) '.png'];
    
    % read image name
    im = imread(fname);
    
    % resize image
    im_r = imresize(im,[64 64]);
    
    
    [featureVector, hogVisualization] = extractHOGFeatures(im_r);
    
    features_pos=[features_pos;featureVector(:)'];
    
end

% loop to get negative features

features_neg=[];
for i=1:num_tr_neg
    fname = ['.\negatives\' num2str(i) '.png'];
    
    % read image name
    im = imread(fname);
    
    % resize image
    im_r = imresize(im,[64 64]);
    
    [featureVector, hogVisualization] = extractHOGFeatures(im_r);
    
    features_neg=[features_neg;featureVector(:)'];
    
end

all_features = [features_pos;features_neg];
labels = [ones(num_tr_pos,1);-1*ones(num_tr_neg,1)];

%% SVM Classifier training

[dF, sF, cF] = scale_fts(double(all_features),0,1); %change this for testing
modelF = svmtrain(labels, dF, '-t 0 -c 1 -b 1'); %1 is common, 25 also

%% Testing phase
% loop to get the set number of testing images

% -- Generate HOG features
features_pos_test=[];
for i=num_tr_pos+1:num_tr_pos+num_te_pos
    fname = ['.\positives\' num2str(i) '.png'];
    
    % read image name
    im = imread(fname);
    
    % resize image
    im_r = imresize(im,[64 64]);
    
    [featureVector, hogVisualization] = extractHOGFeatures(im_r);
    features_pos_test=[features_pos_test;featureVector(:)'];
    
end

% loop to get negative features

features_neg_test=[];
for i=num_tr_neg+1:num_tr_neg+num_te_neg
    fname = ['.\negatives\' num2str(i) '.png'];
    
    % read image name
    im = imread(fname);
    
    % resize image
    im_r = imresize(im,[64 64]);
    [featureVector, hogVisualization] = extractHOGFeatures(im_r);
    
    features_neg_test=[features_neg_test;featureVector(:)'];
    
end


all_features_test = double([features_pos_test;features_neg_test]);
labels_test = [ones(num_te_pos,1);-1*ones(num_te_neg,1)];


%% Prediction

d_te_scaled = all_features_test.*repmat(sF,size(all_features_test,1),1)+repmat(cF,size(all_features_test,1),1);
[class_result,acc_instance,scores_result] = svmpredict(labels_test, d_te_scaled, modelF,'-b 1');



