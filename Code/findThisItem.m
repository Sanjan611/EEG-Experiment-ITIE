function findThisItem(window, screenPixels, itemName, imgName, imgPath, shouldResize)
    % FINDTHISITEM displays the item to the subject needs to search for
    %
    % Input Parameters
    % ----------------
    % window : window pointer as returned by PsychImaging('OpenWindow')
    %
    % screenPixels : a 1x2 matrix that contains the screen width and screen
    % height as its first and second element respectively
    %
    % itemName : text containing the name of the item
    %
    % imgName : char array containing the filename 


    screenXpixels = screenPixels(1);
    screenYpixels = screenPixels(2);

    Screen('FillRect', window, 1);
    
    Screen('TextSize', window, 100); 
    DrawFormattedText(window, ['Find this item: ', char(itemName)], 'center', 0.2*screenYpixels, 0);
    
    Screen('TextSize', window, 70);
    DrawFormattedText(window, 'Press ENTER when you are ready to search!', 'center', 0.9*screenYpixels, 0);
    
    imgLocation = [char(imgPath), filesep, char(imgName)];
 
    I = imread(imgLocation);
    imageTexture = Screen('MakeTexture', window, I);
    
    if shouldResize=="1"
        Screen('DrawTexture', window, imageTexture, [], [480+30 540-200 1440+30 1080-200], 0);
    else
        Screen('DrawTexture', window, imageTexture, [], [], 0);
    end
    
    Screen('Flip', window);
    
end