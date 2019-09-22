function WelcomeScreen(window)
    % WELCOMESCREEN displays a black screen with white text, 'WELCOME'
    %
    % WELCOMESCREEN(window) takes in the argument 'window', a window 
    % pointer output by PsychImaging('OpenWindow')
    
    Screen('TextSize', window, 300);
    DrawFormattedText(window, 'WELCOME', 'center', 'center', 1);
    Screen('Flip', window);
end