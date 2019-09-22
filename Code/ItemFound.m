function ItemFound(window)
    
    Screen('TextSize', window, 200); 
    Screen('FillRect', window, 1);
    DrawFormattedText(window, 'Item Found!', 'center', 'center', 0);
    Screen('Flip', window);
    
end