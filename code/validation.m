 function [Sensitivity, Specitivity, Accuracy]= validation(manual,image)

image_ = image;
manual_ = manual;

%% inja true positive va true negative ro hesab mikonim
sumindex = image_ + manual_;
TP = length(find(sumindex == 2));
TN = length(find(sumindex == 0));
%% inja false positive va false negative ro hesab mikonim
substractindex = image_ - manual_;
FP = length(find(substractindex == -1));
FN = length(find(substractindex == 1));

%% score haii ke shoma az ma khaste boodid :
Accuracy = (TP+TN)/(FN+FP+TP+TN);
Sensitivity = TP/(TP+FN);
Specitivity = TN/(TN+FP);
%% score haii ke dar darse hoosh mohasebati tadris shode :
Precision = TP/(TP+FP);
Recall = TP / (TP + FN);
%% score haye ezafii ke az ghabl kar karde boodam :
Fmeasure = 2*TP/(2*TP+FP+FN);
MCC = (TP*TN-FP*FN)/sqrt((TP+FP)*(TP+FN)*(TN+FP)*(TN+FN));
Dice = 2*TP/(2*TP+FP+FN);
Jaccard = Dice/(2-Dice);
