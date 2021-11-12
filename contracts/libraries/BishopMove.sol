//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;
import {SystemTypes} from "./SystemTypes.sol";

contract BishopMove {

    SystemTypes.Diff[] private bishopMoves;

    constructor() {
        generateBishopMoves();
    }

    function generateBishopMoves() private {
        int stepsToBoardLength = 7; //assuming piece is at pos (1,1),(8, 1), (8, 8), (1, 8)

        for (int i=1; i <= stepsToBoardLength; i++) {
            bishopMoves.push(SystemTypes.Diff(i, i)); // right upper diagonal
            bishopMoves.push(SystemTypes.Diff(i, -i)); // right lower diagonal
            bishopMoves.push(SystemTypes.Diff(-i, i)); // left upper diagonal
            bishopMoves.push(SystemTypes.Diff(-i, -i)); // left lower diagonal
        }
    }

    function bishopValidMoves(SystemTypes.Position memory _position) public view returns (SystemTypes.Position[] memory) {
        // Is the fixed results array worth it for creating extra logic to figure out valid positions ? 
        // Is there a chance for any edge-case to this logic ?

        uint count = 0;
        for (uint i=0; i< bishopMoves.length; i++) {
            int newX = int(_position.X) + bishopMoves[i].X;
            int newY = int(_position.Y) + bishopMoves[i].Y;
            if (newX > 8 || newX < 1 || newY > 8 || newY < 1){
                continue;
            }
            count++; 
        }

        SystemTypes.Position[] memory results = new SystemTypes.Position[](count);

        // the following is repeated in all pieces' movement libraries. Make it reusable ?
        uint index = 0;
        for (uint i=0; i < bishopMoves.length; i++){
            int newX = int(_position.X) + bishopMoves[i].X;
            int newY = int(_position.Y) + bishopMoves[i].Y;
            if (newX > 8 || newX < 1 || newY > 8 || newY < 1){
                continue;
            }
           results[index] = SystemTypes.Position(uint(newX), uint(newY));
           index++;
        }

        return results;
    }
}