clear all; clear all; close all;
pathImport = 'C:\KinectData\Experiment1\Annotation';

datatrain = [];
datatest = [];
truthtrain = [];
truthtest = [];
ClassNum = 3;

class = 1;
temp =[];
temp = dlmread([pathImport '\EshedLeftSidePrinter2Driver.txt'],' ');

datatrain = [datatrain;temp];
[m,n] = size(temp);
x = -ones(1,ClassNum);
x(1,class) = 1;
truthtrain= [truthtrain;repmat(x,m,1)];

class = 2;
temp =[];
temp = dlmread([pathImport '\EshedRightSidePrinter2Passenger.txt'],' ');

datatrain = [datatrain;temp];
[m,n] = size(temp);
x = -ones(1,ClassNum);
x(1,class) = 1;
truthtrain= [truthtrain;repmat(x,m,1)];


class = 3;
temp =[];
temp = dlmread([pathImport '\EshedLeftSidePrinter2NoOne.txt'],' ');

datatrain = [datatrain;temp];
[m,n] = size(temp);
x = -ones(1,ClassNum);
x(1,class) = 1;
truthtrain= [truthtrain;repmat(x,m,1)];

%%
%Random sample selection
%I want a function that randomly selects training samples from a training
%set, turn this into a cross validation thing somehow
PERCENT =0.2;

indecies = randi([1, length(datatrain)], round(PERCENT*length(datatrain)),1);
indecies = unique(indecies);
while(length(indecies) ~= round(PERCENT*length(datatrain)))
more = randi([1, length(datatrain)], round(PERCENT*length(datatrain))-length(indecies),1);
indecies = [indecies;more];
indecies = unique(indecies);
end

[rows cols] = size(datatrain);
datatest = zeros(length(indecies),cols);
truthtest = zeros(length(indecies),ClassNum);
datatest(indecies,:) = datatrain(indecies,:);
truthtest(indecies,:) = truthtrain(indecies,:);
datatrain(indecies,:)=[];
truthtrain(indecies,:)=[];

datatest(all(datatest==0,2),:)=[];
truthtest(all(truthtest==0,2),:) = [];

%%
%shuffle datasets
PERCENT =0.2;
j=1;
step = floor(PERCENT*length(datatrain));
step = step;
total = floor(length(datatrain)/step);
accuracy = zeros(1:total,1);

all = [datatrain truthtrain];
allshuff = randswap(all);
shufftrain = allshuff(:,1:81);
shufftruthtrain = allshuff(:,82:end);


for i=1:total
    dtest =[];
    dtrain = [];
    dtest = shufftrain((i-1)*step+1:i*step,:);
    dtrain = shufftrain([1:(i-1)*step,i*step+1:end],:);  
    dtruthtest = shufftruthtrain((i-1)*step+1:i*step,:);
    dtruthtrain = shufftruthtrain([1:(i-1)*step,i*step+1:end],:);  
    
    [m,n] = size(dtruthtrain);
labelstrain = zeros(m,1);
for k= 1:m
    idxt = find(dtruthtrain(k,:) == 1);
    labelstrain(k,1) = idxt;
end

[m,n] = size(dtruthtest);
labelstest = zeros(m,1);

for k= 1:m
    idxt = find(dtruthtest(k,:) == 1);
    labelstest(k,1) = idxt;
end
    
    
    svm_type = 0; % linear SVM
kernel_type = 0; %linear %
%PLAY AROUND WITH THIS! ALSO DO SCALING!
%type svmtrain for info
gamma = 1/81; % 'width' of the Gaussian basis function
cost = 15; % C parameter in loss function
epsilon = 0.1; % epsilon parameter in loss function

options = ['-s ', num2str(svm_type),...
' -t ', num2str(kernel_type),...
' -g ', num2str(gamma),...
' -c ', num2str(cost),...
' -p ', num2str(epsilon)];

%model = svmtrain(labelstrain, dtrain(:,17:end),options);
%yp = svmpredict(labelstest, dtest(:,17:end), model);
%98
model = svmtrain(labelstrain, dtrain(:,1:81),options);
yp = svmpredict(labelstest, dtest(:,1:81), model);
ypCon = [];
%From column vector of 1-12 to -1 and 1
for t=1:length(yp)
    x = -ones(1,ClassNum);
    x(1,yp(t)) = 1;
    ypCon = [ypCon;repmat(x,1,1)]; 
end

accuracy(i,j) = 100 - confusion(dtruthtest',ypCon') * 100;
% if(accuracy(i,1)<88)
%     plotconfusion(dtruthtest',ypCon')
% end
%compute mean accuracy over gestures

end


mean(accuracy);
%yes = (gestureCorrect)./(gestureTotal);

%%

[m,n] = size(truthtrain);
labelstrain = zeros(m,1);
for i= 1:m
    idxt = find(truthtrain(i,:) == 1);
    labelstrain(i,1) = idxt;
end

[m,n] = size(truthtest);
labelstest = zeros(m,1);

for i= 1:m
    idxt = find(truthtest(i,:) == 1);
    labelstest(i,1) = idxt;
end

%%
%NEED TO DO SCALING ON MY OWN HERE
%svm_scale('-l',-1,'-u',1,'-s','svmguide1');
%svm_type = 3; % epsilon SVM
svm_type = 0; % linear SVM
kernel_type = 0; %linear %
%PLAY AROUND WITH THIS! ALSO DO SCALING!
%type svmtrain for info
gamma = 1/66; % 'width' of the Gaussian basis function
cost = 5; % C parameter in loss function
epsilon = 0.1; % epsilon parameter in loss function

options = ['-s ', num2str(svm_type),...
' -t ', num2str(kernel_type),...
' -g ', num2str(gamma),...
' -c ', num2str(cost),...
' -p ', num2str(epsilon)];
model = svmtrain(labelstrain, datatrain(:,1:end),options);
%yp = svmpredict(labelstrain, datatrain(:,17:end), model);
yp = svmpredict(labelstest, datatest(:,1:end), model);


% model = svmtrain(labelstest, datatrain,options);
% yp = svmpredict(labelstest, datatrain, model);

%%

ypCon = [];
%From column vector of 1-12 to -1 and 1
for i=1:length(yp)
    x = -ones(1,ClassNum);
    x(1,yp(i)) = 1;
    ypCon = [ypCon;repmat(x,1,1)];
end
plotconfusion(truthtest',ypCon')
set(gcf, 'Position', [20 10 800 500])
%      saveas(gcf,'.\results\knnk=1linearfeatures17to97alldata.png');

%% FEATURE PLOT
figure(2)
i=17;
%plot((1:10),datatrain(1:10,i),'.')


%a = datatrain(2,32:97);
a = (abs(datatrain(gestureRange(9,1):gestureRange(9,1),32:97)));
%b = triu(ones(6),1); 
b = triu(ones(12),1); 
b(~~b)=a;
b=b+b';
[m n] = size(b);
b(1:m+1:end) = 1;
figure(2)


configuration = {'ElS', 'ElE' ,'ElW' ,'ERS' ,'ERE', 'ERW' , 'AlS', 'AlE',...
    'AlW', 'ARS' ,'ARE', 'ARW'
    };
imagesc(b)
set(gca,'XTick',1:12)

xtickstring = configuration;

%set(gca,'XTickLabel','\theta')

set(gca,'YTick',1:12)
set(gca,'YTickLabel',configuration)
set(gca,'YDir','normal')
colorbar('EastOutside')
%colormap(flipud(gray))



%%
%GestureStart and end indecies
[p1,p2] = size(datatrain);
gestureRange = zeros(length(gestures),2);
gestureRange(1,1)=1;
gestureRange(length(gestures),2)=p1;
count = 1;
for i=1:p1-1
    if(labelstrain(i) ~= labelstrain(i+1))
        gestureRange(count,2)=i;
        gestureRange(count+1,1)=i+1;
        count = count+1;
    end
end

