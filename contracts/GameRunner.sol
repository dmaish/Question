//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;
import "./cores/SimpleGame.sol";
import "./cores/ComplexGame.sol";

contract GameRunner {
    function runSimple() external {
      SimpleGame game = new SimpleGame(); 
      game.setup();
      game.play(10);
    }
        
    function runComplex(uint _moves) external {

      ComplexGame game = new ComplexGame(); 
      game.setup();
      game.play(_moves);
    
    }
}
 