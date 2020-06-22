function lamda2 = prinCur(Image)

%% hamoontor ke dar function e asli tozih dadam
%% dar in ghesmat matrix e hessian ro tashkil midim
%% dar vaghe az tasvir moshtagh e marhale dovom migirim :
[gx, gy] = gradient(double(Image));
[gxx, gxy] = gradient(gx);
[gxy, gyy] = gradient(gy);

%% baraye in kar, do ta array 
%% be size e khode tasvir dar nazar migirim :
[row,col] = size(Image);
lamdaplus = zeros(row,col);
lamdaminus = zeros(row,col);

%% dar inja eigen value haye matrix e hessian ro hesab mikonim
for r = 1:row
    for c = 1:col
            [lamdaplus(r,c),lamdaminus(r,c)] = lamdafind(gxx(r,c),gyy(r,c),gxy(r,c));
    end
end

lamda2 = lamdaplus;

end