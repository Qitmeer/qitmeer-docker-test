# <font color=Chocolate size=6>Stress Testing Report</font>

## Test Environment

#### Full Node
Each node is an AWS EC2 instance or aliyun VPS, total five full nodes.

Hardware Configurations of the node, which receiving the test transactions:
1. AWS instance type: c5d.xlarge
2. vCPU: 4
3. Memory: 7.45 GB
4. Disk: 25 GB

Software Configurations:
1. Operation System: Ubuntu, 16.04 LTS, Canonical
2. Golang Version: go1.12.7.  linux-amd64

Full node Configurations:
1. Memory Pool size: 1000 tx
2. Block Size: 4 MB
3. Block Reward: 25 token
4. Block Time: 2 minute

#### Test Client
Hardware Configurations:
1. CPU: Intel(R) Core(TM) i7-8700K CPU@3.70GHz
2. Memory: 16 GB
3. Disk: Kingston SSD 256 GB
4. Network Bandwidth: 300 Mbps

Software Configurations:
1. Operation System: Windows 10
2. Jave Version: jdk-10.0.2
3. Stress Testing Software: Apache JMeter 5.1.1

#### Miner
1. CPU: Intel(R) Core(TM) i7-8700K CPU@3.70GHz
2. Memory: 16 GB
3. GPU: GeForce GTX 1060 5GB
4. Disk: Kingston SSD 256 GB

## Build Qitmeer-DAG Network
How to quickly run the Qitmeer-DAG Network, see [here.](https://github.com/HalalChain/qitmeer-docker-test/blob/master/README.md)

## Run miner
How to quickly run a miner, see [here.](https://github.com/HalalChain/qitmeer-docker-test/blob/master/miner_and%20mining_pool_manual.md)

## Test Step
- Configure the test environment
- Create accounts(addresses and private keys)
- Run Qitmeer-DAG nodes
- Configurate miner<br>
Configure the address of the sending transaction account to the mining address:<br> 
```asciidoc
./hlc-miner -s 47.93.20.102:1236 -u admin -P 123 --symbol HLC --notls -i 24 -W 256 --mineraddress TmN4SADy42FKmN8ARKieX9iHh9icptdgYNn --testnet
```
The following parameters can be modified depending on your situation:
    
    s :full node IP and port
    mineraddress: miner account address
    u : full node rpc username
    P : full node rpc password
- Mining to the send transaction account: 120 blocks, 3000 HLC
- Create 30,000 signed RAW transactions through scripts and export them to CSV files

[Create sign raw transaction hash script](https://github.com/HalalChain/qitmeer-docker-test/blob/master/stress_testing_batch_create_transactions_script.md)
- Configure the test client(JMeter), Key configuration parameters:

      Number of Threads (users): 500
      Ramp-Up Period (in seconds): 10
      Loop Count: 20
![JMeter parameters](./images/sendRawTransaction.jpg)
LoopController.loops=20, It is the number of transactions sent on behalf of a thread.
ThreadGroup.num_threads=500, It is the number of threads opened.
The product of the two is the number of transactions sent this time.
- JMeter loads CSV files and sends RAW transactions to the test network 
by calling the sendRawTransaction RPC of the miner's full node. JMeter configures 500 threads to send them, 
recording the start time of sending transactions.
- Look at the miner log, observe the packing block situation of the transaction, record the time when the first empty block appears,
 and when more than three empty blocks appear in a row, we can think that the transaction has been processed, 
 and take the first empty block time as the end time.
- View the total number of transactions through the logs of the miner
- TPS is calculated by dividing the total number of transactions by the test time.
TPS = Number of Successful Transactions /(Completion Time - Start Transaction Time)

## Transactions and Blocks log
![Txs_Blocks_log](./images/transactionLog.jpg)

It can be seen that a total of 9955 transactions have been sent, which takes 00:21:21, 
which is 1281 seconds, and the transaction transmission speed is 7.77 transactions/s.

## Test result
Number of transactions/sec:
![numberOfTransactionPerSecond](./images/numberOfTransactionPerSecond.jpg)

Number of active Threads:
![numberOfActiveThreads](./images/numberOfActiveThreads.jpg)

CPU and Memory of Full node(miner connected) :
![cpuMem](./images/cpuMem.jpg)

According to the steps described above, three tests, taking the average of three results, 
the final results are as follows:

num of TXs | send rate | success % | num of blocks | duration | TPS 
------------ | ------------- | ------------- | ------------- | ------------- | -------------
10,000 | 500/s  | 99.56% | 10 | 1281s | 7.77

## Conclusion
During the test, different transmission rates were used and different transaction volumes were tested. 
The test results TPS reached more than 7.77.

TPS is very related to the following two configurations: 
1) The maximum number of transactions in a block (block sizes)
2) The average block time

issue：
- connection timed out error:
![connectionTimeOut](./images/connectionTimeOut.jpg)

