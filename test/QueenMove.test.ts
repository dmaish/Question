/* eslint-disable eqeqeq */
import { ethers } from "hardhat";
import { assert, expect } from "chai";
// eslint-disable-next-line node/no-extraneous-import
import { Contract } from "@ethersproject/contracts";

describe("QueenMove", function () {
  let queenMove: Contract;
  before(async function () {
    const QueenMove = await ethers.getContractFactory("QueenMove");
    queenMove = await QueenMove.deploy();
  });

  describe("MoveFromInsideBoard", () => {
    it("Move queen from inside board { X: 4, Y: 4 }", async () => {
      const pos = { X: 4, Y: 4 };
      const moves = await queenMove.queenValidMoves(pos);
      assert.equal(moves.length, 27);

      // assert for possible vertical moves
      const verticalMoves = moves.filter((move) => move.X == pos.X);
      assert.equal(verticalMoves.length, 7);

      // assert for possible horizontal moves
      const horizontalMoves = moves.filter((move) => move.Y == pos.Y);
      assert.equal(horizontalMoves.length, 7);

      moves.forEach((move) => {
        if (move.X != pos.X && move.Y != pos.Y) {
          const diff = Math.abs(move.X - pos.Y);
          if (diff == 1) {
            assert.equal(1, Math.abs(move.Y - pos.Y));
          } else if (diff == 2) {
            assert.equal(2, Math.abs(move.Y - pos.Y));
          } else if (diff == 3) {
            assert.equal(3, Math.abs(move.Y - pos.Y));
          } else if (diff == 4) {
            assert.equal(4, Math.abs(move.Y - pos.Y));
          } else {
            expect.fail();
          }
        }
      });
    });
  });

  describe("MoveFromCorner", () => {
    it("Move queen from corner of board { X: 1, Y: 1 }", async function () {
      const pos = { X: 1, Y: 1 };
      const moves = await queenMove.queenValidMoves(pos);
      const possibles = [
        { X: 1, Y: 2 },
        { X: 1, Y: 3 },
        { X: 2, Y: 2 },
        { X: 3, Y: 3 },
        { X: 2, Y: 1 },
        { X: 3, Y: 1 },
      ];
      moves.forEach((move) => {
        assert.isNotNull(possibles.find((m) => m.X == move.X && m.Y == move.Y));
      });
    });
  });
});
