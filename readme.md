# Tic Tac Toe Game - Shall We Play a Game?

Welcome to the Tic Tac Toe game – an interactive two-player experience designed for iPhone! This app brings the classic game to life with gesture-driven interactions, animations, and a polished user interface.


## Project Overview

### Project Setup
- The app is limited to iPhone-only and portrait orientation.

### Initial User Interface

- #### Game Board Grid View
  - Created a `GridView` subclass of `UIView` to draw the visual game board grid using `UIBezierPath`.

- #### Square Grid Views
  - Added nine transparent `UIView` instances above the `GridView` to represent each square.
  - Created an IBOutlet collection to keep track of these views.

- #### X's and O's
  - Utilized `UILabels` for X and O game pieces.
  - Added a `UIPanGestureRecognizer` to allow users to drag their game pieces.

- #### Instructions View
  - Created an `InfoView` subclass of `UIView` with a label and a button.
  - Presented the `InfoView` to provide game instructions.

### Game Play

- #### Start of a Turn
  - Designated X as the first player to start.
  - Animated the current player's piece to draw attention, enabling user interaction afterward.

- #### During a Turn
  - Implemented `UIPanGestureRecognizer` to allow users to move their game pieces.
  - Used CGRect's `intersect()` method to determine if the piece is overlapping a square view.
  - Implemented a feature that snaps the piece into place if released on an unoccupied square; otherwise, it animated back to the starting position.

- #### End of a Turn
  - Displays a new piece for the next player, set its alpha property to 0.5, and disable user interaction.
  - Checks for a win or tie at the end of each turn.
  - Used `CABasicAnimation` to animate a line being drawn across the winning pieces.

#### Declare a Winner or Tie
  - Presents `InfoView` to indicate the winner or a tie, animating it on/off the screen.

#### Clear the Board
  - Fades out the pieces in anticipation of another game, automatically starting a new game.

### Grid Model
  - Created a `Grid` class to track square occupancy and determine game outcomes.
  - Allows the view controller to interact with the grid for various game-related functions.

## Attributions

- Tic Tac Toe Icon: [Flaticon](https://www.flaticon.com/free-icon/tic-tac-toe_1021366)
- Line across Grid: [Stack Overflow](https://stackoverflow.com/questions/26662415/draw-a-line-with-uibezierpath)
- Drawing the Grid: [Stack Overflow](https://stackoverflow.com/questions/52841082/how-to-override-drawrect-function-in-uiview-swift)
- Gesture Recognizer and Pan Gesture: [CocoaCasts](https://cocoacasts.com/swift-fundamentals-working-with-pan-gesture-recognizers-in-swift)

## Additional Information

- This project was developed using Xcode and Swift.
- For issues or questions, contact [(Jas) Jaswitha](mailto:jaswithareddyguntaka@gmail.com).


Note: Challenges may exist, such as the InfoView's disappearance issue.

Enjoy playing Tic Tac Toe with your friends on a single device! 🎮👥
