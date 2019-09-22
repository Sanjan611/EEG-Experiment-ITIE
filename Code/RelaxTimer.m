function RelaxTimer(startTime, window, nominalFrameRate, screenPixels)
    presSecs = sort(repmat(0:startTime, 1, nominalFrameRate), 'descend');
    
    screenXpixels = screenPixels(1);
    screenYpixels = screenPixels(2);


    Screen('TextSize', window, 200);
    Screen('FillRect', window, 0);
    for i = 1:length(presSecs) 

        Screen('TextSize', window, 100);
        DrawFormattedText(window, ['Relax for ' int2str(startTime) ' seconds ... '], 'center', 0.4*screenYpixels, 1);

        if presSecs(i)==0 
            text = 'Starting now!';
            DrawFormattedText(window, text, 'center', 0.6*screenYpixels, 1);
        else
            numberString = num2str(presSecs(i));
            DrawFormattedText(window, numberString, 'center', 0.6*screenYpixels, 1);
        end
        Screen('Flip', window);
    end

end