# <font color=Chocolate size=6>Stress Testing scheme of the Nox-DAG Network</font>

## Test Environment

#### Full Node
Each node is an Aliyun VPS, total six full nodes.

Hardware Configurations:
1. CPU: Intel Xeon E5-2682v4, 2.50 GHz, 1 core
2. Memory: 1 GB
3. Disk: Ultra Disk 40 GB
4. Internal Network Bandwidth: 1 Gbps

Software Configurations:
1. Operation System: ubuntu 16.04.4 LTS
2. Golang Version: go1.12.5.  linux-amd64

Full node Configurations:
1. mem-pool size:
2. Block Size: 1 MB
3. Block Reward: 50 HLC
4. Block Time: 2 minute

#### Test Server
Hardware Configurations:
1. CPU: Intel Xeon E5-2682v4, 2.50 GHz, 1 core
2. Memory: 1 GB
3. Disk: Ultra Disk 40 GB
4. Internal Network Bandwidth: 1 Gbps

Software Configurations:
1. Operation System: ubuntu 16.04.4 LTS
2. Jave Version: go1.12.5  linux-amd64
3. Stress Testing Software: Apache JMeter 5.1.1

#### Miner
To be added

## Test Step
1. Configure the test environment
Miner Log Information: 

2. Start qitmeer test network with 6 nodes

3. Create two accounts: Send Transaction Account and Receive Transaction Account
Script: To be added

4. configurate miner
Configure the address of the sending transaction account to the mining address of the miner
Specific configuration instructions: To be added

5. Mining to the address of Send Transaction Account: 601 blocks, 30050 HLC

6. Create 30,000 signed RAW transactions through scripts and export them to CSV files
Script: To be added

7. Configure the test server， JMeter
Key configuration parameters:
Number of Threads (users): 500
Ramp-Up Period (in seconds):
Loop Count:

8. JMeter loads CSV files and sends RAW transactions to the test network 
by calling the sendRawTransaction RPC of the miner's full node. JMeter configures 500 threads to send them, 
recording the start time of sending transactions.

9. Look at the miner log, observe the packing block situation of the transaction, record the time when the first empty block appears,
 and when more than three empty blocks appear in a row, we can think that the transaction has been processed, 
 and take the first empty block time as the end time.
 
10. View the total number of transactions through the logs of the miner

11. TPS is calculated by dividing the total number of transactions by the test time.
TPS = Number of Successful Transactions /(Completion Time - Start Transaction Time)






