
                                    SGV SMART CONTRACT SECURITY AUDIT




Two most common attacks:
    -- Reentrancy (an attacker calls a function that interacts with another contract, immediately calls a same function again before the first function call completes)
    -- Oracle Manipulation (A means for smart contracts to access data from the world outside the blockchain)


                            <!-- FIRST ATTACK  -->
1) There are total 2 functions. 
    a) transfer funds to user
    b) transfer funds from pool to pool

We added checks in these two functions that only admins can call these function, (the 3 pool admins)


                            <!-- SECOND ATTACK  -->
We are not taking anything outside of the smart contract, so we don't need to worry about that





<!-- https://dev.to/yakult/tutorial-write-upgradeable-smart-contract-proxy-contract-with-openzeppelin-1916 -->