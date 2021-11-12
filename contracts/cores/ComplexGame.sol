//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;
import "../interfaces/IGame.sol";
import "../libraries/KnightMove.sol";
import "../libraries/BishopMove.sol";
import "../libraries/QueenMove.sol";
import {SystemTypes} from "../libraries/SystemTypes.sol";
import "../libraries/OccupiedPosition.sol";
import "../libraries/Randomizer.sol"; 
import "hardhat/console.sol";

contract ComplexGame is IGame {

    SystemTypes.Position private knightPosition;
    SystemTypes.Position private bishopPosition;
    SystemTypes.Position private queenPosition;

    enum Pieces {
        KNIGHT, 
        BISHOP, 
        QUEEN
    }

    function play(uint256 _moves) override external { 
        KnightMove knight = new KnightMove();
        BishopMove bishop = new BishopMove();
        QueenMove queen = new QueenMove();
        OccupiedPosition occupiedPosition = new OccupiedPosition();

        for (uint i = 0; i < _moves; i++) {
            uint totalPieces = uint256(Pieces.QUEEN) + 1;
            uint randomNumber = Randomizer.random(i) % totalPieces;
            SystemTypes.Position[] memory possibles;
            SystemTypes.Position memory suggestedPos;

            if (randomNumber == uint256(Pieces.KNIGHT)) {
                possibles = knight.validMovesFor(knightPosition);
                uint r = Randomizer.random(possibles.length) % possibles.length; 
                suggestedPos = possibles[r];

                // if the suggested position is occupied
                if (
                    bishopPosition.X == suggestedPos.X && bishopPosition.Y == suggestedPos.Y  ||
                    queenPosition.X == suggestedPos.X && queenPosition.Y == suggestedPos.Y 
                ) {
                    knightPosition = occupiedPosition.knightOccupiedPos(knightPosition, suggestedPos);
                } else {
                    knightPosition = suggestedPos; 
                }
                
                console.log("%d: Knight Position is (%d,%d)", i, knightPosition.X, knightPosition.Y); 

            } 
            else if (randomNumber == uint256(Pieces.BISHOP)) {
                possibles = bishop.bishopValidMoves(bishopPosition);
                uint r = Randomizer.random(possibles.length) % possibles.length; 
                suggestedPos = possibles[r];

                // if the suggested position is occupied
                if (
                    knightPosition.X == suggestedPos.X && knightPosition.Y == suggestedPos.Y ||
                    queenPosition.X == suggestedPos.X && queenPosition.Y == suggestedPos.Y 
                ) {
                    bishopPosition = occupiedPosition.bishopOccupiedPos(bishopPosition, suggestedPos);
                } else {
                    bishopPosition = suggestedPos; 
                }
                console.log("%d: Bishop Position is (%d,%d)", i, bishopPosition.X, bishopPosition.Y); 

            } else if (randomNumber == uint256(Pieces.QUEEN)) {
                possibles = queen.queenValidMoves(queenPosition);
                uint r = Randomizer.random(possibles.length) % possibles.length; 
                suggestedPos = possibles[r];

                if (
                    knightPosition.X == suggestedPos.X && knightPosition.Y == suggestedPos.Y ||
                    bishopPosition.X == suggestedPos.X && bishopPosition.Y == suggestedPos.Y 
                ){
                    queenPosition = occupiedPosition.bishopOccupiedPos(queenPosition, suggestedPos);
                } else {
                    queenPosition = suggestedPos;  
                }
                
                console.log("%d: Queen Position is (%d,%d)", i, queenPosition.X, queenPosition.Y); 

            } else {
                continue;
            }
        }

    }
    
    function setup() override external {
        // setup the initial position of each of the pieces
        // should each of the pieces be placed randomly? [should this be randomized ?]
          knightPosition = SystemTypes.Position(2,2);
          bishopPosition = SystemTypes.Position(5,5);
          queenPosition = SystemTypes.Position(7,7);

    }
} 