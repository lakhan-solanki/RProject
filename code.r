%% read in image
i=imread('toy_candy.jpg');
imshow(i);

%% convert to grayscale image
igray=rgb2gray(i);
imshow(igray);

%% Problems illumination doesn't allow for any easy segmentation
level=0.66953;
ithresh=im2bw(igray,level);
imshowpair(i,ithresh,'montage');

File - 02
%% read in image
i=imread('toy_candy.jpg');
imshow(i);
%% RGB Color space
rmat=i(:,:,1);
gmat=i(:,:,2);
bmat=i(:,:,3);
figure;
subplot(2,2,1), imshow(rmat);
title('red plane');
subplot(2,2,2), imshow(gmat);
title('green plane');
subplot(2,2,3), imshow(bmat);
title('blue plane');
subplot(2,2,4), imshow(i);
title('original image');

File - 03
%% Read in image
i=imread('toy_candy.jpg');
imshow(i);
%% Solution: Thresholding the image on
% im=double(img)/255;
im=i;
rmat=im(:,:,1);
gmat=im(:,:,2);
bmat=im(:,:,3);
figure;
subplot(2,2,1), imshow(rmat);
title('red plane');
subplot(2,2,2), imshow(gmat);
title('green plane');
subplot(2,2,3), imshow(bmat);
title('blue plane');
subplot(2,2,4), imshow(i);
title('original image');

%%
levelr=0.66953;
levelg=0.6;
levelb=0.48;
i1=im2bw(rmat,levelr);
i2=im2bw(gmat,levelg);
i3=im2bw(bmat,levelb);
isum=(i1&i2&i3);
% plot the data
subplot(2,2,1), imshow(i1)
title('red plane');
subplot(2,2,2), imshow(i2);
title('green plane');
subplot(2,2,3), imshow(i3);
title('blue plane');
subplot(2,2,4), imshow(isum);
title('sum of all the planes');

%% complement image and fill in holes
icomp=imcomplement(isum);
ifilled=imfill(icomp,'holes');
figure,imshow(ifilled);

%%
se=strel('disk',9);
iopenned=imopen(ifilled,se);
% figure,imshowpair(iopenned,i);
imshow(iopenned);

%% extract features
iregion=regionprops(iopenned,'centroid');
[labeled,numObjects]=bwlabel(iopenned,4);
stats=regionprops(labeled,'Eccentricity','Area','BoundingBox');
areas=[stats.Area];
eccentricities=[stats.Eccentricity];

%% use feature analysis to count skittles obejects
idxOfSkittles=find(eccentricities);
statsDefects=stats(idxOfSkittles);
figure,imshow(i);
hold on;
for idx = 1:length(idxOfSkittles)
h=rectangle('Position',statsDefects(idx).BoundingBox);
set(h,'EdgeColor',[.75 0 0]);
hold on;
end
if idx>10
title(['there are ',num2str(numObjects),'obejects in the image']);
end
hold off;