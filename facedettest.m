close all;
clear all;
clc;
flag = 0;

%Detect objects using Viola-Jones Algorithm

%To detect Face
FDetect = vision.CascadeObjectDetector;    



I = imread('12.jpg');
imshow(I);
hold on
title('Input Image');
hold off;

BB = step(FDetect,I);
if(isempty(BB))
    msgbox("No Face Detected",'Conclusion');
else
    figure,
    imshow(I); hold on
    for i = 1:size(BB,1)
        rectangle('Position',BB(i,:),'LineWidth',5,'LineStyle','-','EdgeColor','r');
    end
    title('Face Detection');
    hold off;
 EyeDetect = vision.CascadeObjectDetector('EyePairBig');
 BB=step(EyeDetect,I);



figure,imshow(I);
rectangle('Position',BB,'LineWidth',4,'LineStyle','-','EdgeColor','b');
title('Eyes Detection');
Eyes=imcrop(I,BB);
figure,imshow(Eyes);

    NoseDetect = vision.CascadeObjectDetector('Nose','MergeThreshold',16);
    BB=step(NoseDetect,I);
    flag = isempty(BB)

    figure,
    imshow(I); hold on
    for i = 1:size(BB,1)
        rectangle('Position',BB(i,:),'LineWidth',4,'LineStyle','-','EdgeColor','b');
    end
    title('Nose Detection');
    hold off;

    %To detect Mouth
    MouthDetect = vision.CascadeObjectDetector('Mouth','MergeThreshold',16);

    BB=step(MouthDetect,I);
    flag = flag | isempty(BB)

    figure,
    imshow(I); hold on
    for i = 1:size(BB,1)
        rectangle('Position',BB(i,:),'LineWidth',4,'LineStyle','-','EdgeColor','r');
    end
    title('Mouth Detection');
    hold off;

    if(flag == 1)
        msgbox("Wearing Mask Properly,THANK YOU",'Conclusion');
    else
        msgbox("No mask,Please Wear Mask",'Conclusion');
    end
end

