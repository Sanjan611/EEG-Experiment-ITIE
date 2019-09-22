%% Level 1: Easy
% 5 images, 30 s = 3 min
% findFries
% findCrocodile
% findCandle
% findbread

easy_imageFile = ["findFries.png", "findCrocodile.png", "findCandle.png"];
easy_itemFile = ["fries.png", "crocodile2.png", "Candle.png"];
easy_itemName = ["fries", "crocodile", "candle"];

for i = 1:length(easy_itemName)
    
    findThisItem(window, screenPixels, easy_itemName(i), easy_itemFile(i), "Images/ItemToFind");
    KbStrokeWait;
    
    showImageOnScreen(window, [char("Images") filesep char(easy_imageFile(i))], screenPixels, 1);
    KbStrokeWait;
    
end

%% Level 2: Medium
% 5 images, 1 min = 5 min
% findStethoscope
% find8

med_imageFile = ["find8_2.jpg", "findStethoscope.jpg"];
med_itemFile = ["8.jpg", "stethoscope2.jpg"];
med_itemName = ["Number 8", "Stethoscope"];

for i = 1:length(med_itemName)
    
    findThisItem(window, screenPixels, med_itemName(i), med_itemFile(i), "Images/ItemToFind");
    KbStrokeWait;
    
    showImageOnScreen(window, [char("Images") filesep char(med_imageFile(i))], screenPixels, 1);
    KbStrokeWait;
    
end

%% Level 3: Hard
% Use Where's Waldo images for this
% 3 images, 2 min = 6 min
% whereswaldo1
% whereswaldo2
% whereswaldo3

hard_imageFile = ["whereswaldo1.jpg", "whereswaldo2.jpg", "whereswaldo3.jpg"];
hard_itemFile = ["waldo1.jpg", "waldo2.jpg", "waldo3.jpg"];
hard_itemName = ["Waldo", "Waldo", "Waldo"];

for i = 1:length(hard_itemName)
    
    findThisItem(window, screenPixels, hard_itemName(i), hard_itemFile(i), "Images/ItemToFind");
    KbStrokeWait;
    
    showImageOnScreen(window, [char("Images") filesep char(hard_imageFile(i))], screenPixels, 1);
    KbStrokeWait;
    
end

%% Picture of WALDO
showImageOnScreen(window, 'Images/waldo1.jpg', screenPixels, 0);
KbStrokeWait;

showImageOnScreen(window, 'Images/waldo2.png', screenPixels, 0);
KbStrokeWait;

%% Where's Waldo?
showImageOnScreen(window, 'Images/whereswaldo1.jpg', screenPixels, 1);
KbStrokeWait;

showImageOnScreen(window, 'Images/whereswaldo2.jpg', screenPixels, 1);
KbStrokeWait;