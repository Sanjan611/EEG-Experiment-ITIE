function showImageOnScreen(window, imgLoc, screenPixels, shouldResize)
    
    screenXpixels = screenPixels(1);
    screenYpixels = screenPixels(2);
    
    I = imread(imgLoc);
 
    % Get the size of the image
    [s1, s2, s3] = size(I);

    % Check if image fits on screen or not
    %{
    if s1 > screenYpixels || s2 > screenYpixels
        disp('Image is too big to fit on the screen, so resizing down');
        %sca;
        %return;
        %I = imresize(I, [1920 1080]);
        I = I(1:1080, 1:1920, :);
        [s1, s2, s3] = size(I);
        shouldResize = 0;
    end
    %}
    shouldResize = 1;
    
    if shouldResize == 1
        % RESIZING IMAGE TO GET MAX SIZE FOR THAT SCREEN
        % getting aspect ratios (width/height)
        aspectRatioImage = s2/s1;
        aspectRatioScreen = screenXpixels/screenYpixels;

        if aspectRatioImage >= aspectRatioScreen
            imageWidth = screenXpixels;
            imageHeight = screenXpixels/(aspectRatioImage);
        else
            imageHeight = screenYpixels;
            imageWidth = screenYpixels*(aspectRatioImage);
        end

        I = imresize(I, [imageHeight imageWidth]);
    end


    % Make the image into a texture
    Screen('FillRect', window, 1);
    imageTexture = Screen('MakeTexture', window, I);

    Screen('DrawTexture', window, imageTexture, [], [], 0);

    Screen('Flip', window);
end