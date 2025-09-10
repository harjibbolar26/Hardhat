import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

export default buildModule("TokenSwapContractModule", (m) => {
  const tokenSwap = m.contract("TokenSwap", [
    "0xEACFf13E3a2CB585B5A7E4D0c3E733E09A4f3587",
    "0x8A0DFe52F9df810aBDd40493C97a4587B0913eF1",
    2,
    3,
  ]);

  //   const tokenSwap = m.contract("TokenSwap", [tokenA, tokenB, 2, 5]);

  return { tokenSwap };
});
