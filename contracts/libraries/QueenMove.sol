//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;
import {SystemTypes} from "./SystemTypes.sol";

contract QueenMove {

    SystemTypes.Diff[] private queenMoves;

    constructor() {
        generateQueenMoves();
    }

    function generateQueenMoves() private {
        int stepsToBoardLength = 7; 

        for (int i=1; i <= stepsToBoardLength; i++) {
            queenMoves.push(SystemTypes.Diff(i, i)); // right upper diagonal
            queenMoves.push(SystemTypes.Diff(i, -i)); // right lower diagonal
            queenMoves.push(SystemTypes.Diff(-i, i)); // left upper diagonal
            queenMoves.push(SystemTypes.Diff(-i, -i)); // left lower diagonal
            
            queenMoves.push(SystemTypes.Diff(i + 1, 0)); // horizontally right
            queenMoves.push(SystemTypes.Diff(i - 1, 0)); // horizontally left
            queenMoves.push(SystemTypes.Diff(0, i + 1)); // vertically up
            queenMoves.push(SystemTypes.Diff(0, i - 1)); // vertically down
        }
    }

    function queenValidMoves(SystemTypes.Position memory _position) public view returns (SystemTypes.Position[] memory) {

        uint count = 0;
        for (uint i=0; i< queenMoves.length; i++) {
            int newX = int(_position.X) + queenMoves[i].X;
            int newY = int(_position.Y) + queenMoves[i].Y;
            if (newX > 8 || newX < 1 || newY > 8 || newY < 1 || 
            newX == int(_position.X) && newY == int(_position.Y)){
                continue;
            }
            count++; 
        }

        SystemTypes.Position[] memory results = new SystemTypes.Position[](count);
        uint index = 0;
        for (uint i=0; i < queenMoves.length; i++){
            int newX = int(_position.X) + queenMoves[i].X;
            int newY = int(_position.Y) + queenMoves[i].Y;
            if (newX > 8 || newX < 1 || newY > 8 || newY < 1 || 
            newX == int(_position.X) && newY == int(_position.Y)){
                continue;
            }
           results[index] = SystemTypes.Position(uint(newX), uint(newY));
           index++;
        }

        return results;
    }
}