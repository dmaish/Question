//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;
import {SystemTypes} from "./SystemTypes.sol";
import "hardhat/console.sol";

contract OccupiedPosition {

  function bishopOccupiedPos(
      SystemTypes.Position memory _bishopPosition, 
      SystemTypes.Position memory _suggestedPos
    ) public pure returns (SystemTypes.Position memory) {

        SystemTypes.Position memory newBishopPosition;

        int xMove = int(_suggestedPos.X) - int(_bishopPosition.X);
        int yMove = int(_suggestedPos.Y) - int(_bishopPosition.Y);

        if (xMove > 0 && yMove > 0){
          int newX = int(_suggestedPos.X) + 1;
          int newY = int(_suggestedPos.Y) + 1;
          newBishopPosition = SystemTypes.Position(uint(newX), uint(newY));

        } else if (xMove > 0 && yMove < 0) {
          int newX = int(_suggestedPos.X) + 1;
          int newY = int(_suggestedPos.Y) - 1;
          newBishopPosition = SystemTypes.Position(uint(newX), uint(newY));

        } else if (xMove < 0 && yMove > 0) {
          int newX = int(_suggestedPos.X) - 1;
          int newY = int(_suggestedPos.Y) + 1;
          newBishopPosition = SystemTypes.Position(uint(newX), uint(newY));

        } else if (xMove < 0 && yMove < 0) {
          int newX = int(_suggestedPos.X) - 1;
          int newY = int(_suggestedPos.Y) - 1;
          newBishopPosition = SystemTypes.Position(uint(newX), uint(newY));

        }
        
        return newBishopPosition;
    }  

    function queenOccupiedPos(
      SystemTypes.Position memory _queenPosition, 
      SystemTypes.Position memory _suggestedPos
    )
    public pure returns (SystemTypes.Position memory) {

      SystemTypes.Position memory newQueenPosition;

      int xMove = int(_suggestedPos.X) - int(_queenPosition.X);
      int yMove = int(_suggestedPos.Y) - int(_queenPosition.Y);

      if ( xMove == 0 && yMove != 0 ) { //vertical movements
          if (yMove > 0) {
            int newY = int(_suggestedPos.Y) + 1;
            newQueenPosition = SystemTypes.Position(_suggestedPos.X, uint(newY));
          } else {
            int newY = int(_suggestedPos.Y) - 1;
            newQueenPosition = SystemTypes.Position(_suggestedPos.X, uint(newY));
          }

      } else if ( xMove != 0 && yMove == 0 ) { //horizontal movements  
          if (xMove > 0) {
            int newX = int(_suggestedPos.X) + 1;
            newQueenPosition = SystemTypes.Position(uint(newX) ,_suggestedPos.Y);
          } else {
            int newX = int(_suggestedPos.X) - 1;
            newQueenPosition = SystemTypes.Position(uint(newX) ,_suggestedPos.Y);
          }
      } else if (xMove > 0 && yMove > 0){ //diagonal movements ⍒
        int newX = int(_suggestedPos.X) + 1;
        int newY = int(_suggestedPos.Y) + 1;
        newQueenPosition = SystemTypes.Position(uint(newX), uint(newY));

      } else if (xMove > 0 && yMove < 0) {
        int newX = int(_suggestedPos.X) + 1;
        int newY = int(_suggestedPos.Y) - 1;
        newQueenPosition = SystemTypes.Position(uint(newX), uint(newY));

      } else if (xMove < 0 && yMove > 0) {
        int newX = int(_suggestedPos.X) - 1;
        int newY = int(_suggestedPos.Y) + 1;
        newQueenPosition = SystemTypes.Position(uint(newX), uint(newY));

      } else if (xMove < 0 && yMove < 0) {
        int newX = int(_suggestedPos.X) - 1;
        int newY = int(_suggestedPos.Y) - 1;
        newQueenPosition = SystemTypes.Position(uint(newX), uint(newY));

      }

      return newQueenPosition;
    }

    function knightOccupiedPos(
      SystemTypes.Position memory _knightPosition, 
      SystemTypes.Position memory _suggestedPos
    )
    public pure returns (SystemTypes.Position memory) {
      // the assumption of the knight jump, is that the Y part of the movement is done last. Thus if the suggested
      // position is occupied, the length of the Y movement will be lengthened by 1 [either downward/upwards].

      SystemTypes.Position memory newKightPosition;
      int yMove = int(_suggestedPos.Y) - int(_knightPosition.Y);
      

      if (yMove > 0) {
        int newY = int(_suggestedPos.Y) + 1;
        newKightPosition = SystemTypes.Position(_suggestedPos.X, uint(newY));

      } else if (yMove < 0) {
        int newY = int(_suggestedPos.Y) - 1;
        newKightPosition = SystemTypes.Position(_suggestedPos.X, uint(newY));

      }

      return newKightPosition;

    }

}