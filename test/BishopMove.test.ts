/* eslint-disable eqeqeq */
import { ethers } from "hardhat";
import { assert, expect } from "chai";
// eslint-disable-next-line node/no-extraneous-import
import { Contract } from "@ethersproject/contracts";

describe("BishopMove", function () {
  let bishopMove: Contract;
  before(async function () {
    const BishopMove = await ethers.getContractFactory("BishopMove");
    bishopMove = await BishopMove.deploy();
  });

  describe("MoveFromInsideBoard", () => {
    it("Move bishop from inside board { X: 4, Y: 4 }", async () => {
      const pos = { X: 4, Y: 4 };
      const moves = await bishopMove.bishopValidMoves(pos);
      assert.equal(moves.length, 13);
      moves.forEach((move) => {
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
      });
    });
  });

  describe("MoveFromCorner", () => {
    it("Move bishop from corner of board { X: 1, Y: 1 }", async function () {
      const pos = { X: 1, Y: 1 };
      const moves = await bishopMove.bishopValidMoves(pos);
      assert.equal(moves.length, 7);
      const possibles = [
        { X: 2, Y: 2 },
        { X: 3, Y: 3 },
        { X: 4, Y: 4 },
        { X: 5, Y: 5 },
        { X: 6, Y: 6 },
      ];
      moves.forEach((move) => {
        assert.isNotNull(possibles.find((m) => m.X == move.X && m.Y == move.Y));
      });
    });
  });
});
