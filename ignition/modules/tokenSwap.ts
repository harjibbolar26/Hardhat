import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

export default buildModule("TokenSwapModule", (m) => {
  const tokenA = m.contract("TokenA");
  const tokenB = m.contract("TokenB");

  const tokenSwap = m.contract("TokenSwap", [tokenA, tokenB, 2, 5]);

  return { tokenA, tokenB, tokenSwap };
});
