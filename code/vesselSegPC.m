function [segImage] = vesselSegPC(inputImage, mask)

%% vaghti bedoon e erosion algorithm ro ejra mikonim
%% mibinim ke yek meghdar az mohit e khareji e mask
%% toye tasvir mimoone ama ba estefade az erosion in 
%% pixel haye nakhaste ro ham az mask hazf mikonim

se = strel('diamond',20);
erodedmask = im2uint8(imerode(mask,se));
%%figure;
%%imshow(erodedmask);
%%title('Generation of image mask');

%Apply gaussian filter to the image where s=1.45
%% dar in marhale, yek filter e gaussian roye tasvir emal mikonim
%% ta noise haye tasvir ro kamtar konim :
filter = fspecial('gaussian', [3,3] ,1.45);
inputImage = inputImage(:,:,2);
img3 = imfilter(inputImage, filter);

%img3 = imgaussfilt(inputImage(:,:,2) ,1.45);     %sigma st. deviation (s)
%%figure;
%%imshow(img3);
%%title('After Gaussian Filter');

%% in ghesmat, lambda va principal curvature ro peida mikonim :
%% baraye in kar hessian matrix image ro hesab mikonim :
%% baraye hessian matrix :
%% agar image ro g dar nazar bgirim,
%% maghadir e matrix e hessian ebaratand az :
%% g xx , g xy, g yx, g yy;
lambda = prinCur(img3);
maxprincv = im2uint8(lambda/max(lambda(:)));
%% hala mask ro dar principal curvature be dast oomade
%% zarb mikonim ta enhena haye asli e aks namayan shavad :

maxprincvmsk = maxprincv.*(erodedmask/255);
%%figure;
%%imshow(maxprincvmsk);
%%title('Finding lamda - principal curvature');

%% histogram e tasvir e be dast amade :
original_hist = imhist(maxprincvmsk);
figure;
imhist(maxprincvmsk);
title('original image histogram');
%% hala in image ke be dast avordim, contrast
%% ghabele tavajohi nadare, bana bar in
%% histogramesh ro enhance mikonim ta contrast e behtari ro
%% dar tasvir moshahede konim :
%%newprI = adapthisteq(maxprincvmsk,'numTiles', [8 8], 'nBins', 128);
newprI = imadjust(maxprincvmsk);

seconde_thresh = graythresh(newprI);
vessels = im2bw(newprI,seconde_thresh);
figure;
imshow(vessels);
title('Contrast enhancement.');
%% histogram e tasvir baad az enhancement :
%% hamantor ke moshahede mishavad, tamam e pixel ha bein e
%% 0 va 1 pakhsh mishavand :
enhanced_hist = imhist(vessels);
figure;
imhist(vessels);
title('enhanced image histogram');

%% dar natije enhancement yek seri pixel
%% be shekl e noise segment mishe ke ba estefade az BWAREAOPEN
%% in noise haro hazf mikonim :
vessels = bwareaopen(vessels, 200);
segImage = vessels;
figure;
imshow(segImage);
title('Filtering out small segments');