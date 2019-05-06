# <font color=Chocolate size=6>Stress Testing the Nox-DAG Network</font>

## Introduction
Nox-DAG Network is a quick and scalable public blockchain based on DAG technology.

We will broadcast a large quantity of transactions from an virtual private server (VPS) to see how many transactions per second (TPS) the Nox-DAG network could handle.

## Prepare test
+ Greater than or equal to three full nodes, VPS (CPU:4-core, RAM:8GB, DISK:40GB)
+ One of the full nodes connected with the wallet, for broadcasting transactions
+ GPU miner (greater than or equal to GTX1060), for packing transactions to blocks
+ Create 100 accounts (send transactions from these accounts)
+ Deposit with 100HLC in each account

## Specifications of this test
+ 100 accounts(addresses) is created with the wallet
+ The miner mining 10,000HLC (200 blocks) for a address from the wallet
+ The wallet deposited with 100HLC each account
+ Send transactions with the wallet (100 transactions per account, each sending 1hlc)
+ PoW for the 10,000 transactions were generated on a miner

## Test case

#### 20 Accounts, 500 Transactions Test
In this test, a total of 500 transactions were sent between 20 accounts.

Write the test results as follows:

+ Number of Transactions: 500
+ Broadcast Length: XX Seconds
+ Average Broadcast TPS: XX
+ Peak TPS (1S Average): XX TPS

#### 100 Account, 5000 Transaction Test
In this test, a total of 5000 transactions were sent between 100 accounts.

Write the test results as follows:

+ Number of Transactions: 5000
+ Broadcast Length: XX Seconds
+ Average Broadcast TPS: XX TPS
+ Peak TPS (1S Average): XX TPS

