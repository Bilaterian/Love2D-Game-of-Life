# Love2D Game of Life
 My recreation of Conway's Game of Life made in Love 2D

 Features I want to add: 
 - Save to JPG -> saved to png instead
 - painting the canvas -> done
 - switching cell states on canvas -> done
    --pick between turning on cells and turning off cells
 - switch between painting and switching cells -> done
 - select colors from a palette -> done
 - possible improvements: change brush size? -> done
 - custom filenames, if empty saved as default ->done
 - window opens up for filename and saved notification window -> done
 - better indicators when something is pressed -> done
 - custom cursors?
 - sound effects would be cool
 - current font sucks, change it so it looks cool
 - need better design overall
 - refactor so that lua files that just need colors don't need a reference to brushButtons
 - consider creating an abstract class since there are plenty of duplicate functions between buttons

 user desired changes by samuel loveys:
-brush toggle
-palette toggle
-installer -> get github to do this
-change saving to user directory -> done
-change functionality of draw button to also draw in the desired colour -> done
-custom icon and app name -> done
-bug where clicking save still draws to screen first -> hacky but done
-new bug where clicking save/close still draws to screen -> finally fixed