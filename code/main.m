%% mahal e data set ro moshkhas mikonim :
%% man tooye system e khodam absolute path estefade karfam
%% shoma mitoonin baraye test az relative path estefade konid :
dataset_path = 'C:\Users\pr1266\Desktop\soal_dovom_cv\DRIVE\Test\images\';
groundtruth_path = 'C:\Users\pr1266\Desktop\soal_dovom_cv\DRIVE\Test\1st_manual\';
mask_path = 'C:\Users\pr1266\Desktop\soal_dovom_cv\DRIVE\Test\mask\';
%% directory path haro mikhoonim : 
dataset_dir = dir(dataset_path);
groundtruth_dir = dir(groundtruth_path);
mask_dir = dir(mask_path); 

%% yek array ijad mikonim jahat e 
%% zakhire sazi score haye matloob :
%% Accuracy, Sensitivity, Specitivity
%% size inja 20 * 3 darmiad :
scores = zeros(numel(dataset_dir) - 2, 3);

%% algorithm ro baraye hame aks ha ejra mikonim :
 
for index = 3:numel(dataset_dir)
    
    inputImage = imread([dataset_path dataset_dir(index).name]);
    goundTruth = imread([groundtruth_path groundtruth_dir(index).name]);
    goundTruth = im2bw(goundTruth);
    mask = imread([mask_path mask_dir(index).name]);
    figure;
    imshow(inputImage);
    title('Raw inputed image');

    figure;
    imshow(goundTruth);
    title('Ground Truth');

    segImage = vesselSegPC(inputImage, mask); 

    figure;
    imshow(segImage);
    title('Processed data');
    [Sensitivity, Specitivity, Accuracy] = validation(goundTruth,segImage);
    
    %% zakhire sazi score ha :
    scores(index - 2, 1) = Sensitivity;
    scores(index - 2, 2) = Specitivity;
    scores(index - 2, 3) = Accuracy;
    
    %% zakhire sazi segmented image :
    path = 'C:\Users\pr1266\Desktop\soal_dovom_cv\DRIVE\segmented_images\';
    image_name = int2str(index - 2);
    image_path = strcat(path, image_name);
    image_path = strcat(image_path, '.gif');
    imwrite(segImage, image_path);
end

%% inja score ro be soorat e csv zakhire mikonim :
xlswrite('C:\Users\pr1266\Desktop\soal_dovom_cv\DRIVE\scores.xlsx', scores);