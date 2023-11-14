const Web3 = require("web3");
const { abi, evm } = require("./BowlingGame.json"); // Replace with the actual ABI and Bytecode

const web3 = new Web3("YOUR_WEB3_PROVIDER_URL");
const account = web3.eth.accounts.privateKeyToAccount("YOUR_PRIVATE_KEY");

const contract = new web3.eth.Contract(abi);

// Deploy the contract
async function deployContract() {
  const deploy = contract.deploy({
    data: evm.bytecode.object,
  });

  const gas = await deploy.estimateGas();

  const newContractInstance = await deploy.send({
    from: account.address,
    gas,
  });

  console.log("Contract deployed at:", newContractInstance.options.address);
}

deployContract();
