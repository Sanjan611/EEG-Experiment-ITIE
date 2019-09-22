function Experiment(enobio_mac)
    % EXPERIMENT  Run the experiment 
    %
    %   EXPERIMENT(ENOBIO_MAC) runs the experiment with LSL connections made to
    %   the given MAC address
    %

    % Close all current screens and variables
    sca;
    close all; 
    %clearvars;

    % Set up PTB
    PsychDefaultSetup(2);

    Screen('Preference', 'SkipSyncTests', 1);

    % Set up the LSL layer to send markers
    lib = lsl_loadlib();

    info = lsl_streaminfo(lib, 'Presentation', 'Markers', 1, 0, 'cf_int32', enobio_mac);
    outlet = lsl_outlet(info);

    % To send a marker, the code is
    % outlet.push_sample(marker)

    %% SCREEN STUFF

    % Get the screens, and the screen to use
    screens = Screen('Screens');
    screenNumber = max(screens);
    disp(screens);
    disp(screenNumber);
    screenNumber = 2;

    black = BlackIndex(screenNumber);
    white = WhiteIndex(screenNumber);

    [window, windowRect] = PsychImaging('OpenWindow', screenNumber, black);

    [screenXpixels, screenYpixels] = Screen('WindowSize', window);
    screenPixels = [screenXpixels screenYpixels];

    [xCenter, yCenter] = RectCenter(windowRect);

    nominalFrameRate = Screen('NominalFrameRate', window);

    %% WELCOME SCREEN 

    WelcomeScreen(window);
    outlet.push_sample(1);
    WaitSecs(3);

    %% Instruction Screen
    Instructions(window);
    outlet.push_sample(2);
    KbStrokeWait;

    %% Images and text matrix

    % stimuli contains - name of item to find, item file name, bigger image
    % file name
    stimuli = [ "fries", "fries.png", "findFries.png", "0";
        "crocodile", "crocodile.png", "FindCrocodile.png", "0";
        "candle", "Candle.png", "findCandle.png", "0";
        "Number 8", "8.jpg", "find8.jpg", "0";
        "Stethoscope", "stethoscope2.jpg", "findStethoscope.jpg", "0";
        "Waldo", "waldo1.jpg", "whereswaldo1.jpg", "0";
        "Waldo", "waldo2.jpg", "whereswaldo2.jpg", "0"; 
        "Lollipop", "lollipop.jpg", "findLollipop.jpg", "0";
        "Letter Z", "Z.jpg", "findZ.jpg", "0";
        "Number 5", "5.jpg", "find5.jpg", "0";
        "Number 6", "6.jpg", "find6.jpg", "0";
        "Number 8", "8_2.jpg", "find8_2.jpg", "0"];

    %% STIMULUS PRESENTATION - in a random order

    num_stimuli = length(stimuli);

    rng('default');
    order = randperm(num_stimuli);

    for i = 1:num_stimuli
        ind = order(i);

        % STEP 1: Show the item to find
        findThisItem(window, screenPixels, stimuli(ind,1), stimuli(ind,2), "../Data/Images/Item", stimuli(ind, 4));
        outlet.push_sample(3);
        KbStrokeWait;

        % STEP 2: Show the image 
        showImageOnScreen(window, [char("../Data/Images/Image") filesep char(stimuli(ind,3))], screenPixels, 1);
        outlet.push_sample(4);

        KbStrokeWait;
        ItemFound(window);
        % This key stroke implies the subject has found the target item in the
        % image
        outlet.push_sample(5);
        WaitSecs(3);

        % Relax for 10s after half the stimuli are presented
        if(i==floor(num_stimuli/2))
            outlet.push_sample(6);
            RelaxTimer(30, window, nominalFrameRate, [screenXpixels screenYpixels]);
        end

    end

    %% THANK YOU

    ThankYouScreen(window);
    outlet.push_sample(9);
    KbStrokeWait;

    %% Close the on-screen
    sca;
end