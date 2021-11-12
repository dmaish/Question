/* eslint-disable eqeqeq */
import { ethers } from "hardhat";
import { assert, expect } from "chai";
// eslint-disable-next-line node/no-extraneous-import
import { Contract } from "@ethersproject/contracts";

describe("Occupied positions", () => {
  let occupied: Contract;
  before(async () => {
    const OccupiedPos = await ethers.getContractFactory("OccupiedPosition");
    occupied = await OccupiedPos.deploy();
  });

  describe("Bishop occupied positions", () => {
    it("occupied bishop position { X: 1, Y: 1 }", async () => {
      const pos = { X: 1, Y: 1 };
      const suggestedPosition = { X: 6, Y: 6 }; // this position is supposedly occupied by another piece
      const jumpToPosition = { X: 7, Y: 7 };

      const newPos = await occupied.bishopOccupiedPos(pos, suggestedPosition);
      assert.equal(jumpToPosition.X, newPos.X);
      assert.equal(jumpToPosition.Y, newPos.Y);
    });

    it("occupied bishop position { X: 8, Y: 8 }", async () => {
      const pos = { X: 8, Y: 8 };
      const suggestedPosition = { X: 5, Y: 5 }; // this position is supposedly occupied by another piece
      const jumpToPosition = { X: 4, Y: 4 };

      const newPos = await occupied.bishopOccupiedPos(pos, suggestedPosition);
      assert.equal(jumpToPosition.X, newPos.X);
      assert.equal(jumpToPosition.Y, newPos.Y);
    });

    it("occupied bishop position { X: 4, Y: 4 }", async () => {
      const pos = { X: 4, Y: 4 };
      const suggestedPosition = { X: 5, Y: 5 }; // this position is supposedly occupied by another piece
      const jumpToPosition = { X: 6, Y: 6 };

      const newPos = await occupied.bishopOccupiedPos(pos, suggestedPosition);
      assert.equal(jumpToPosition.X, newPos.X);
      assert.equal(jumpToPosition.Y, newPos.Y);
    });
  });

  describe("Queen occupied postions", () => {
    it("horizontal right queen occupied", async () => {
      const pos = { X: 4, Y: 4 };
      const suggestedPosition = { X: 6, Y: 4 };
      const jumpToPosition = { X: 7, Y: 4 };

      const newPos = await occupied.queenOccupiedPos(pos, suggestedPosition);
      assert.equal(jumpToPosition.X, newPos.X);
      assert.equal(jumpToPosition.Y, newPos.Y);
    });
    it("horizontal left queen occupied", async () => {
      const pos = { X: 4, Y: 4 };
      const suggestedPosition = { X: 2, Y: 4 };
      const jumpToPosition = { X: 1, Y: 4 };

      const newPos = await occupied.queenOccupiedPos(pos, suggestedPosition);
      assert.equal(jumpToPosition.X, newPos.X);
      assert.equal(jumpToPosition.Y, newPos.Y);
    });
    it("vertical up queen occupied", async () => {
      const pos = { X: 4, Y: 4 };
      const suggestedPosition = { X: 4, Y: 6 };
      const jumpToPosition = { X: 4, Y: 7 };

      const newPos = await occupied.queenOccupiedPos(pos, suggestedPosition);
      assert.equal(jumpToPosition.X, newPos.X);
      assert.equal(jumpToPosition.Y, newPos.Y);
    });
    it("vertical down queen occupied", async () => {
      const pos = { X: 4, Y: 4 };
      const suggestedPosition = { X: 4, Y: 2 };
      const jumpToPosition = { X: 4, Y: 1 };

      const newPos = await occupied.queenOccupiedPos(pos, suggestedPosition);
      assert.equal(jumpToPosition.X, newPos.X);
      assert.equal(jumpToPosition.Y, newPos.Y);
    });
    it("diagonal up right queen occupied", async () => {
      const pos = { X: 4, Y: 4 };
      const suggestedPosition = { X: 7, Y: 7 };
      const jumpToPosition = { X: 8, Y: 8 };

      const newPos = await occupied.queenOccupiedPos(pos, suggestedPosition);
      assert.equal(jumpToPosition.X, newPos.X);
      assert.equal(jumpToPosition.Y, newPos.Y);
    });
    it("diagonal left down queen occupied", async () => {
      const pos = { X: 4, Y: 4 };
      const suggestedPosition = { X: 2, Y: 2 };
      const jumpToPosition = { X: 1, Y: 1 };

      const newPos = await occupied.queenOccupiedPos(pos, suggestedPosition);
      assert.equal(jumpToPosition.X, newPos.X);
      assert.equal(jumpToPosition.Y, newPos.Y);
    });
  });

  describe("Knight occupied positions", () => {
    it("occupied knight position { X: 4, Y: 4 }", async () => {
      const pos = { X: 4, Y: 4 };
      const suggestedPosition = { X: 6, Y: 3 };
      const jumpToPosition = { X: 6, Y: 2 };

      const newPos = await occupied.knightOccupiedPos(pos, suggestedPosition);
      assert.equal(jumpToPosition.X, newPos.X);
      assert.equal(jumpToPosition.Y, newPos.Y);
    });

    it("occupied knight position { X: 8, Y: 8 }", async () => {
      const pos = { X: 8, Y: 8 };
      const suggestedPosition = { X: 7, Y: 6 };
      const jumpToPosition = { X: 7, Y: 5 };

      const newPos = await occupied.knightOccupiedPos(pos, suggestedPosition);
      assert.equal(jumpToPosition.X, newPos.X);
      assert.equal(jumpToPosition.Y, newPos.Y);
    });
  });
});
