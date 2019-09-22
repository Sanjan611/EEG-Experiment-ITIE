function ThankYouScreen(window)
    % THANKYOUSCREEN displays a black screen with white text, 'Thank You!'
    %
    % THANKYOUSCREEN(window) takes in the argument 'window', a window 
    % pointer output by PsychImaging('OpenWindow')
    
    Screen('TextSize', window, 300); 
    Screen('FillRect', window, 0);
    DrawFormattedText(window, 'THANK YOU!', 'center', 'center', 1);
    Screen('Flip', window);
end