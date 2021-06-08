# APCSFinalProject

**Group Name:** Gotta Match 'Em All

**Group Members:** Austin Ngan, Jason Zhou

**Project Description:**

We are trying to create a Pokemon Shuffle “clone”, mainly focusing on its matching elements and interactions with Pokemon types. The basis of the project should have its match elements and “damage” components, as well as a turn limit for each level. The user will be able to choose from either levels to progress through the game, or a free play mode where they simply match until they want to stop. In the levels, the player will have a set amount of moves they can do and have to reach a certain score in order to beat the level.

**Prototype:** https://docs.google.com/document/d/1n__b3dagQLo8h0CAY-NgloRj4c0hSL9zSHTDt-R-eH8/edit?usp=sharing

## Development Log:
### May 25:
Jason: Worked on board class to add variables, added a way to display the board with score and moves remaining. Also started on moving elements of the array with a swap method.  

Austin: Finished creating boss and Pokemon classes with their respective constructors and get methods, as well as added the check combos methods for the board class.  

### May 26:
Jason: Worked on scanning board for valid combos and started on the process of removing combos.

Austin: Tried to create a way to use the Pokemon class in board, rather than using int arrays.

### May 27:
Jason: Finished manipulating the board through mouse input, so being able to drag and drop tiles.

Austin: Fully implemented the use of the Pokemon class in the board class, as well as prevented full combos from spawning when the board is initially generated.

### May 28:
Jason: Finished implementation of detecting and removing combos from board and the board will continue to match combos and award points until there are no combos left.

Austin: Started implementing a start, win, and game over screen.

### May 29:
Jason: Created screens for start and choosing a mode. Also implemented a boss health bar.

Austin: Finished the calculations based off of type effectiveness, weaknesses multiply the calculated score from the combo by 0.5, 2 if it is effective.

### May 30:
Jason: Added win screen and started developing a party picker screen to choose which Pokemon you take into board.

Austin: <strike> Created a branch that attempts to use pngs for their respective Pokemon, rather than the colored tiles used in the previous demo. Apparently multiple  PImages in Processing makes displaying very slow, might just try to display drawn images. </strike> Was just a mistake constantly loading PImage every single iteration in a nested loop. Also, the boss is generated with a random element.

### May 31:
Jason: Fixed the party picker screen after the ArrayList storing the party was wiped every frame. Completed the party picker where you can add and remove, added descriptors for gamemode on hover.

Austin: Party picker screen now uses pngs to display the base 4 Pokemon, planning on adding more Pokemon to the party picker screen later and having the board generate based off the Pokemon picked.

### June 1:
Jason: <strike> Attempted to implement a display function and constructor that only takes in a pokemon name in Pokemon.</strike> Program works fine up until you click the "confirm" button, rolled back changes (should have branched), tinkered with graphics.

Austin: Added a getPImage method for the Pokemon that uses the Pokemon's name and attempted to convert the display method in board to use the party Pokemon array so that there is more freedom to display different Pokemon.

### June 2:
Jason: Implemented a Pokemon display function for party setup (board took a performance hit because all objects were initializing their own PImage) and a time trial mode.

Austin: Added another Pokemon class constructor to add both types and the Pokemon's name when being initialized in generator during the party picker screen.

### June 3:
Jason: Fixed issues around more individual pokemon in party picker screen and displaying on the board. Also modified the buttons to be larger and more colorful.

Austin: Added multiple images in data that will be displayed as the boss. The image is displayed based off the type it is generated with.

### June 4:
Jason: Started working on boss manipulation of the board, freezing Pokemon so they can't be moved and must be part of a combo to remove the frozen block.

### June 5:
Jason: Started working on rock disruptor, implemented not being able to swap with a rock, need to figure out how to keep it from being removed.

Austin: Started on the level select screen, started implementing clickable levels in the screen.

### June 6:
Jason: Finished implementation of rock disruptor, rock is only able to be removed when it is adjacent to a combo.

Austin: 

### June 7:
Jason: Added implementation of block disruptor, which is similar to rock but it only goes away after you make a certain amount of moves.

Austin: Tried implementing the actual level selection with mouseClicked, but there are issues with what happens after the mouse is clicked.

## UML Diagram Updates:
**May 29:** https://drive.google.com/file/d/1xNGIy_zpkd7C0Rtd6X70NHZmNEkU4-X-/view?usp=sharing  
**May 24:** https://drive.google.com/file/d/1ELlNXD1teTN4-YNPTtRZDYKZbeG_eWeP/view?usp=sharing
