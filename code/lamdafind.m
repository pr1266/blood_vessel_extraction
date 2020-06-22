function [lamdaplus,lamdaminus]=lamdafind(gxx1,gyy1,gxy1)

H = [gxx1 gxy1 ; gxy1 gyy1];

%% inja eigen value haro hesab mikonim:
lamda = eig(H);

%% inja meghdar e max o min e lamda ro be dast miarim :
if lamda(1)>lamda(2)
    lamdaplus = lamda(1);
    lamdaminus = lamda(2);
else if lamda(1)<lamda(2)
    lamdaplus = lamda(2);
    lamdaminus = lamda(1);  
    else
        lamdaplus = lamda(1);
        lamdaminus = lamda(2);
    end
end
end