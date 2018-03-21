---
layout: post
title: 通过Python入门区块链
category: 技术
---


> 本文翻译自 Adil Moujahid 的文章 A Practical Introduction to Blockchain with Python

> 原文地址：[http://adilmoujahid.com/posts/2018/03/intro-blockchain-bitcoin-python/](http://adilmoujahid.com/posts/2018/03/intro-blockchain-bitcoin-python/)



区块链可能是继互联网之后最重大和最具突破性的技术。它是比特币和其他加密货币背后的核心技术，在近几年可谓赚足了人们的眼球。

本质上讲，区块链是一种不需第三方权威机构，直接在两者之间点对点交易的分布式数据库。这种简单却强大的理念对银行、政府和市场等各种各样的机构产生了巨大的影响。任何以中央数据库作为技术壁垒的公司和组织都可能被区块链技术颠覆。

先不管对比特币和其他加密货币价格的疯狂行情，本文旨在帮助读者入门区块链技术。第一、二节讲解了一些区块链的核心概念，第三节展示了如何通过Python实现区块链。我们也将实现两个web网站方便用户与我们的区块链交互。

本文通过比特币作为例子来解释主流的区块链技术，大部分概念在其他区块链应用场景和加密货币中同样适用。

下图使我们将在第三节实现的web应用：

![](http://adilmoujahid.com/images/blockchain-simulation.gif)

## 1. 区块链快速入门

所有的一切开始于2008年，一个自称中本聪的匿名的人或者团体发表了一篇白皮书。这篇名为『比特币：一种点对点的电子现金系统』的白皮书为后来成为区块链的技术打下了基础。在白皮书中，重本从描述了如何建立一个点对点的电子货币系统，可以直接从个体支付给另一个个体，而不需要中央权威机构的介入。该系统解决了电子货币的一个重要问题——双重支付。

### 1.1 什么是双重支付？

假设Alice想要付1美元给Bob。如果Alice和Bob使用物理货币，那么Alice在支付给Bob1美元之后，将不再拥有那1美元货币。如果Alice和Bob使用数字货币，那么问题就变复杂了。数字货币很容易被复制，比如说，如果Alice通过电子邮件发给Bob一个价值1美元的数字文件，Bob并不知道Alien是否已经删掉她自己的文件。如果Alice没有删掉，并且又用同样的方式发给了Carol。这就是双重支付问题。

![](http://adilmoujahid.com/images/blockchain-double-spending.png)

一种双重支付的解决方案是通过一个独立于Aliec，Bob和其他网络中的参与者的可信第三方机构（比如说银行）。主要职责是维护一个用于记录和验证网络中所有的交易的中央账本。这个解决方案的缺点是需要一个可信的中心化第三方机构。

### 1.2 比特币：一个双重支付问题的去中心化解决方案

为了解决双重支付问题，中本聪提出了一种公开账本，换言之，比特币中的区块链技术用于记录网络中所有的交易，有如下几个特征：

* 分布性：账本复制存储在大量的计算机中，而不是一个中央数据库。任何联网的且运行比特币软件的计算机都会下载一份区块链的完整拷贝。
* 加密性：密码学用来保证付款方拥有他发送的比特币，并且决定交易如何添加到区块链上。
* 不可篡改性：区块链仅仅能在添加元素的时候被修改，也就是说，交易只能添加到区块链，而不能删除或篡改。
* 工作量证明机制：网络中一种特殊的参与者叫做矿工，他们通过计算寻找密码学难题，解开难题的矿工可以将新的交易块添加到区块链中。

![](http://adilmoujahid.com/images/blockchain-cash-bitcoin.png)

发送比特币需要如下几步操作：

* 第一步（只需一次）：创建比特币钱包。对于发送和接受比特币的人来说，他们都需要创建一个比特币钱包。比特币钱包保存了两部分信息：私钥和公钥。私钥是一个密码，允许拥有者发送比特币给另一位用户，或者把比特币作为支付手段来使用。 公钥是一串用来接受比特币的字符串，同时也被称作比特币钱包地址（不完全正确，但一般来说我们认为公钥和钱包地址是相同的）。请注意钱包不存储比特币本身，比特币余额的信息被存储在区块链上。
* 第二步：创建比特币交易。如果Alice想发送1美元给Bob，Alice需要使用私钥打开她的比特币钱包，创建一个包含金额的交易（该场景中，使用Bob的公钥地址）
* 第三步：向比特币网络广播该交易事件。一旦Alice创建了比特币交易，他需要向整个比特币网络广播这个交易。
* 第四步：确认交易。监听比特币网络的某个矿工使用Alice的公钥对交易进行验证，确认她的钱包中有足够的比特币（该场景中，最少1个比特币），并且向区块链中添加包含交易详情的新纪录。
* 第五步：向所有矿工广播区块链的修改。一旦交易被确认，该矿工应该向所有的矿工广播区块链的修改，以保证其他矿工的区块链内容及时同步。

## 2. 深入理解区块链
本节旨在深入探讨驱动区块链的核心步骤——新建区块的技术细节，将从公开密钥加密，哈希函数，挖矿和区块链安全几个方便展开。
### 2.1 公开密钥加密
公开密钥加密，或者说非对称加密，是指一种使用一对钥匙的加密系统，公钥可能被广泛的三波，私钥只有拥有者本人知道。它实现了两个功能：认证，公钥可以验证持有者通过私钥加密的信息；加密，只有私钥拥有者可以解开通过公钥加密的信息。

RSA和椭圆曲线数字签名算法（ECDSA）是最广泛应用的两种公开密钥加密算法。

对比特币来说，ECDSA算法被用于生成比特币钱包。比特币通常使用多个钥匙和地址，但简单起见，本文中假设每个比特币钱包只使用一堆公钥和私钥，并且比特币钱包地址就是公钥。如果你对比特币钱包的完整技术感兴趣，我推荐这篇[文章](https://en.bitcoin.it/wiki/Technical_background_of_version_1_Bitcoin_addresses)。

发送和接受比特币时，用户首先创建一个包含公钥和私钥的钱包。如果Alice想要给Bob发送一些比特币，她在创建交易的时候需要将她和Bob双方的公钥，以及比特币金额输入进去。然后使用自己的私钥签署这笔交易。区块链上的某台计算机可以通过Alice的公钥去验证这笔交易是不是Alice本人发出的，然后将交易添加到区块上，之后该区块会被添加到区块链当中。

![](http://adilmoujahid.com/images/blockchain-public-crypto.png)

### 2.2. 哈希函数和挖矿
所有比特币交易被存放在成为区块的文件中。比特币每十分钟向区块链中添加一个包含新增交易记录的新区块。一旦新区快被添加进区块链，它将不可修改和删除。在区块链网络中，一种被称为矿工（他们的计算机连接着区块链）的特殊群体负责创建新的交易区块。矿工必须使用发送者的公钥验证每一笔交易，确认发送者拥有足够的余额支付完成该交易，并且将交易添加到区块中。矿工可以完全自主选择将哪些交易添加到区块中，因此发送者需要提交一些交易费来激励矿工将它们的交易添加到区块中。

对于每一个被区块链接受的区块，都需要被挖矿。挖一个区块的时候，矿工需要寻找一个极难的加密难题的答案。如果一个被挖矿的区块被区块链接受，矿工将获得一定的比特币作为除了交易费的额外奖励。挖矿程序也被称为工作量证明机制，它是保障区块链可靠和安全的主要机制（稍后再讨论区块链的安全性）。

### 哈希和区块链加密难题

为了理解区块链加密难题，需要先理解哈希函数。哈希函数可以将任意范围的数据映射到指定的数据范围。哈希函数返回的结果成为哈希值。哈希函数通常被用于通过重复检查来加速数据库查找，并且在密码学中也有广泛的应用。加密哈希函数帮助人们轻松地验证某些输入数据是否映射到了给定的哈希值，但如果不知道输入数据，那么通过哈希值来构造输入数据是极其困难的。[2]

比特币使用SHA-256作为加密哈希函数。SHA-256应用于区块数据（比特币交易）与一种名为nonce（译者注：实际上是一个随机数）的数字的组合。通过改变区块数据和nonce，可以得到完全不同的哈希值。对于一个被认为是有效或者说是被挖矿的区块，区块和nonce的哈希值需要满足一个特定的条件。比如说，哈希值前面的四位数等于"0000"。我们可以通过规定更加复杂的条件来提高挖矿的难度，比如说我们可以要求哈希值的开头包含更多个0。

矿工面临的加密难题需要寻找一个nonce值，使得哈希值满足挖矿成功条件。我们可以通过下面的应用来模拟区块挖矿。当在Data栏输入内容或者改变nonce值时，哈希值会随之改变。当点击"挖矿"按钮，应用从0开始枚举nonce的值，并检查哈希值的前四位数是否等于"0000"。如果前四位数不等于"0000"，那么nonce值加一并重复相同的操作直到nonce值满足条件。如果区块完成挖矿，那么背景色会变成绿色。

> 为了保证体验，请到[原文链接](http://adilmoujahid.com/posts/2018/03/intro-blockchain-bitcoin-python/)中相应位置进行模拟。

### 2.3. 从区块到区块链

如前一节所述，交易被分组存放在区块中，区块被附加在区块链中。为了把区块串成链，每个新区块都存储着它前一个区块的哈希值。创建新区块时，矿工选择一些交易，添加前一个区块的哈希值，并且对区块进行挖矿。

任何区块中任何数据上的改变都会影响该区块的哈希值，进而导致该区块失效。这赋予了区块链不可篡改的特性。

![](http://adilmoujahid.com/images/blockchain-from-blocks.png)

你可以通过如下软件模拟包含三个区块的区块链。当你在Data栏输入内容或者概念nonce值时，可以发现该区块的哈希值和下一个区块的前导值（前导哈希值）随之改变。可以通过点击每个独立区块的"挖矿"按钮模拟挖矿过程。三个区块挖矿完成后，尝试改变区块1或区块2的内容，会发现该操作导致该区块之后的区块失效。

> 为了保证体验，请到[原文链接](http://adilmoujahid.com/posts/2018/03/intro-blockchain-bitcoin-python/)中相应位置进行模拟。


上面的两个挖矿模拟器都是由Anders Brownworth的[BlockChain Demo](https://anders.com/blockchain/blockchain.html)改编而来的。

### 2.4. 向区块链添加区块

比特币网络中的所有矿工互相竞争，率先找到可以添加到区块链的合法区块的矿工将获得奖励。找到可以验证区块的nonce值是极其困难的，但由于比特币网络中有大量的矿工，寻找到该值并验证区块的可能性是非常高的。第一个矿工提交一个有效区块到区块链，会得到一定的比特币作为奖励。但如果两个或更多矿工同时提交了他们的区块该如何处理呢？

### 解决冲突
如果两个矿工几乎在同一时间验证了区块，那么区块链便产生了分叉，需要等待下一个区块去解决冲突。一些矿工会选择在第一条分叉上挖矿，另一些矿工选择在第二条分叉上挖矿。第一个找到新区块的矿工将解决该冲突。如果新区块在第一条分叉上，那么第二条分叉便失效了，前一个区块的奖励由将区块提交到第一个分叉上的矿工获得，第二个分叉上的交易没有被提交到区块链中，将回到交易池等待被提交到之后的区块中。简言之，如果区块链中产生分叉，最长的分叉将被保留下来。

### 2.5. 区块链和双重支付

本节将探讨区块链双重支付攻击的最常见方法，和用户需要采取的一些使自己免于伤害的措施。

### Race 攻击

攻击者在极短的时间内使用同一个货币发送给两个不同的地址。为了防范这种攻击，推荐等待至少1个区块确认后，再接受对方的支付。

### Finney 攻击

攻击者预先挖好一个包含某条交易的区块，释放该区块之前，在第二次交易中使用相同的货币。在该场景中，第二次交易将不会生效。为了防范这种攻击，推荐等待至少6个区块确认后，再接受对方的支付。

### 多数人攻击（也称为51%攻击）
在该攻击中，攻击者掌握了比特币网络中51%的算力。攻击者首先把构造好的交易广播到整个网络，然后对包含双重支付货币交易的私有区块链进行挖矿。由于掌握了多数的算力，他可以保证在某个点上比正确的区块链拥有更长的链，这将取代正确的区块链，并取消原来的交易。这种攻击极其不可能发生，因为成本很高。

## 3. 通过Python实现的区块链

本节我们讲使用Python实现一个简单的区块链和区块链客户端。我们的区块链将有如下特征：

* 支持向区块链网络中添加多个节点
* 工作量证明机制（PoW）
* 节点之间简单的冲突处理
* 基于RSA加密的交易

区块链客户端将有如下特性：

* 通过公钥和私钥生成钱包（基于RSA算法）
* 基于RSA加密生成交易

我们将实现两个仪表盘：

* 矿工使用的"区块链后台"
* 用户用来生成钱包和发送比特币的"区块链客户端"

区块链实现主要基于这个[Github项目](https://github.com/dvf/blockchain)。我对源码进行了一些修改，添加了RSA加密算法交易。钱包生成和交易加密基于[Jupyter notebook](https://github.com/julienr/ipynb_playground/blob/master/bitcoin/dumbcoin/dumbcoin.ipynb).这两个仪表盘通过HTML/CSS/JS实现。

你可以从[https://github.com/adilmoujahid/blockchain-python-tutorial](https://github.com/adilmoujahid/blockchain-python-tutorial)下载完整源码。

### 3.1. 区块链客户端实现

通过终端进入`blockchain_client`文件夹中的blockchain客户端，输入`python blockchain_client.py`。在浏览器中打开`http://localhost:8080`将看到如下仪表盘。
![](http://adilmoujahid.com/images/blockchain-client.png)
仪表盘的导航栏中有三个标签页：

* 生成钱包：通过RSA加密算法生成钱包（公钥私钥对）
* 发起交易：生成交易，并且将它们发送给区块链节点
* 查看交易：查看区块链中的交易

为了发起或查看交易，需要至少运行一个区块链节点（下一节将讲解此内容）

接下来将解释一些`blockchain_client.py`中的关键代码。

我们定义了含有`sender_address`, `sender_private_key`, `recipient_address`, value这4个属性的Transaction类。用户发起一笔交易时需要填写这4个内容。

`to_dict()`方法以Python字典格式返回交易信息（无需发送者密钥）。`sign_transaction()`方法取出交易信息（无需发送者密钥），并使用发送者的私钥签署该交易信息。


```python
class Transaction:

    def __init__(self, sender_address, sender_private_key, recipient_address, value):
        self.sender_address = sender_address
        self.sender_private_key = sender_private_key
        self.recipient_address = recipient_address
        self.value = value

    def __getattr__(self, attr):
        return self.data[attr]

    def to_dict(self):
        return OrderedDict({'sender_address': self.sender_address,
                            'recipient_address': self.recipient_address,
                            'value': self.value})

    def sign_transaction(self):
        """
        Sign transaction with private key
        """
        private_key = RSA.importKey(binascii.unhexlify(self.sender_private_key))
        signer = PKCS1_v1_5.new(private_key)
        h = SHA.new(str(self.to_dict()).encode('utf8'))
        return binascii.hexlify(signer.sign(h)).decode('ascii')
```

下面这行代码会初始化一个`Python Flask`应用，我们将用它创建API，使客户端与区块链进行交互。

```python
app = Flask(__name__)
```

下面我们定义了三个返回html页面的Flask路由，每个标签页都有个一个html页面与之对应。


```python
@app.route('/')
def index():
  return render_template('./index.html')

@app.route('/make/transaction')
def make_transaction():
    return render_template('./make_transaction.html')

@app.route('/view/transactions')
def view_transaction():
    return render_template('./view_transactions.html')
```

下面我们定义了一个生成钱包（公钥私钥对）的API。

```python
@app.route('/wallet/new', methods=['GET'])
def new_wallet():
  random_gen = Crypto.Random.new().read
  private_key = RSA.generate(1024, random_gen)
  public_key = private_key.publickey()
  response = {
    'private_key': binascii.hexlify(private_key.exportKey(format='DER')).decode('ascii'),
    'public_key': binascii.hexlify(public_key.exportKey(format='DER')).decode('ascii')
  }

  return jsonify(response), 200
```

![](http://adilmoujahid.com/images/blockchain-generate-wallet.gif)

下面我们定义了一个入参包括`sender_address`, `sender_private_key`, `recipient_address`, `value`的API，它会返回交易（无需私钥）和签名。


```python
@app.route('/generate/transaction', methods=['POST'])
def generate_transaction():

  sender_address = request.form['sender_address']
  sender_private_key = request.form['sender_private_key']
  recipient_address = request.form['recipient_address']
  value = request.form['amount']

  transaction = Transaction(sender_address, sender_private_key, recipient_address, value)

  response = {'transaction': transaction.to_dict(), 'signature': transaction.sign_transaction()}

  return jsonify(response), 200
```

![](http://adilmoujahid.com/images/blockchain-generate-transaction.gif)

### 3.2. 区块链实现

通过终端进入`blockchain`文件夹，输入`python blockchain.py`或者`python blockchain.py -p <PORT NUMBER>`。如果你不想指定端口号，那么默认的端口号是5000。在浏览器中打开`http://localhost:<PORT NUMBER>`可以看到区块链后台仪表盘。

![](http://adilmoujahid.com/images/blockchain-frontend.png)

仪表盘的导航栏中有两个标签页：

* 挖矿：查看交易和区块链数据，对新的交易区块进行挖矿。
* 配置：配置不同区块链节点之间的链接。

接下来将解释一些`blockchain.py`中的关键代码。

我们定义`Blockchain`类，包含如下属性：

* `transactions`: 将被添加到下一个区块的所有交易的集合。
* `chain`: 实际的区块链，以区块类型数组的形式存放。
* `nodes`: 节点url的集合。区块链通过这些节点检索区块链数据，更新节点上尚未同步的区块链数据。
* `node_id`: 用于标识区块链节点的随机字符串。

`Blockchain`类实现了如下方法：

* `register_node(node_url)`: 向节点列表添加新的区块链节点。
* `verify_transaction_signature(sender_address, signature, transaction)`: 使用公钥（发送者地址）验证提供的签名。
* `submit_transaction(sender_address, recipient_address, value, signature)`: 如果签名验证通过，向交易列表中添加交易。
* `create_block(nonce, previous_hash)`: 向区块链添加新的区块。
* `hash(block)`: 为区块创建`SHA_256`哈希值。
* `proof_of_work()`: 工作量证明算法。寻找满足挖矿条件的nonce值。
* `valid_proof(transaction, last_hash, nonce, difficulty=MININGDIFFICULTY)`: 检查哈希值是否满足挖矿条件。这个方法在proof\_of\_work方法中使用。
* `valid_chain(chain)`: 检查区块链是否合法。
* `resolve_conflicts()`: 通过保留最长分叉解决区块链节点之间的冲突。


```python
class Blockchain:

    def __init__(self):

        self.transactions = []
        self.chain = []
        self.nodes = set()
        #Generate random number to be used as node_id
        self.node_id = str(uuid4()).replace('-', '')
        #Create genesis block
        self.create_block(0, '00')

    def register_node(self, node_url):
        """
        Add a new node to the list of nodes
        """
        ...

    def verify_transaction_signature(self, sender_address, signature, transaction):
        """
        Check that the provided signature corresponds to transaction
        signed by the public key (sender_address)
        """
        ...

    def submit_transaction(self, sender_address, recipient_address, value, signature):
        """
        Add a transaction to transactions array if the signature verified
        """
        ...

    def create_block(self, nonce, previous_hash):
        """
        Add a block of transactions to the blockchain
        """
        ...

    def hash(self, block):
        """
        Create a SHA-256 hash of a block
        """
        ...

    def proof_of_work(self):
        """
        Proof of work algorithm
        """
        ...

    def valid_proof(self, transactions, last_hash, nonce, difficulty=MINING_DIFFICULTY):
        """
        Check if a hash value satisfies the mining conditions. This function is used within the proof_of_work function.
        """
        ...

    def valid_chain(self, chain):
        """
        check if a bockchain is valid
        """
        ...

    def resolve_conflicts(self):
        """
        Resolve conflicts between blockchain's nodes
        by replacing our chain with the longest one in the network.
        """
        ...
```

下面这行代码初始化一个`Python Flask`应用，我们将用它创建API，使客户端与区块链进行交互。

```python
app = Flask(__name__)
CORS(app)
```

接下来，初始化一个`Blockchain`实例。

```python
blockchain = Blockchain()
```

下面我们为区块链后台仪表盘定义了两个返回html页面的`Flask`路由。


```python
@app.route('/')
def index():
    return render_template('./index.html')

@app.route('/configure')
def configure():
    return render_template('./configure.html')
```

下面我们定义了一些`Flask API`来管理交易和挖矿。

* `'/transactions/new'`: 这个API对应在签名验证正确后，添加包含`sender_address`，`'recipient_address'`, `amount` 和 `signature`参数的交易到新的区块中。
* `/transaction/get`: 这个API返回所有将被添加到下一个区块的交易。
* `/chain`: 这个API返回所有的区块链数据。
* `/mine`: 这个API运行工作量证明算法，并且添加新的交易区块到区块链上。


```python
@app.route('/transactions/new', methods=['POST'])
def new_transaction():
    values = request.form

    # Check that the required fields are in the POST'ed data
    required = ['sender_address', 'recipient_address', 'amount', 'signature']
    if not all(k in values for k in required):
        return 'Missing values', 400
    # Create a new Transaction
    transaction_result = blockchain.submit_transaction(values['sender_address'], values['recipient_address'], values['amount'], values['signature'])

    if transaction_result == False:
        response = {'message': 'Invalid Transaction!'}
        return jsonify(response), 406
    else:
        response = {'message': 'Transaction will be added to Block '+ str(transaction_result)}
        return jsonify(response), 201

@app.route('/transactions/get', methods=['GET'])
def get_transactions():
    #Get transactions from transactions pool
    transactions = blockchain.transactions

    response = {'transactions': transactions}
    return jsonify(response), 200

@app.route('/chain', methods=['GET'])
def full_chain():
    response = {
        'chain': blockchain.chain,
        'length': len(blockchain.chain),
    }
    return jsonify(response), 200

@app.route('/mine', methods=['GET'])
def mine():
    # We run the proof of work algorithm to get the next proof...
    last_block = blockchain.chain[-1]
    nonce = blockchain.proof_of_work()

    # We must receive a reward for finding the proof.
    blockchain.submit_transaction(sender_address=MINING_SENDER, recipient_address=blockchain.node_id, value=MINING_REWARD, signature="")

    # Forge the new Block by adding it to the chain
    previous_hash = blockchain.hash(last_block)
    block = blockchain.create_block(nonce, previous_hash)

    response = {
        'message': "New Block Forged",
        'block_number': block['block_number'],
        'transactions': block['transactions'],
        'nonce': block['nonce'],
        'previous_hash': block['previous_hash'],
    }
    return jsonify(response), 200
```
![](http://adilmoujahid.com/images/blockchain-mine.gif)

下面我们定义`Flash API`来管理区块链节点：

* `'/nodes/register'`: 这个API的入参是节点url列表，然后将它们更新到列表中每一个节点中。
* `'/nodes/resolve'`: 这个API通过保留最长分叉解决区块链节点之间的冲突。
* `'/nodes/get'`: 这个API返回所有的节点列表。


```python
@app.route('/nodes/register', methods=['POST'])
def register_nodes():
    values = request.form
    nodes = values.get('nodes').replace(" ", "").split(',')

    if nodes is None:
        return "Error: Please supply a valid list of nodes", 400

    for node in nodes:
        blockchain.register_node(node)

    response = {
        'message': 'New nodes have been added',
        'total_nodes': [node for node in blockchain.nodes],
    }
    return jsonify(response), 201


@app.route('/nodes/resolve', methods=['GET'])
def consensus():
    replaced = blockchain.resolve_conflicts()

    if replaced:
        response = {
            'message': 'Our chain was replaced',
            'new_chain': blockchain.chain
        }
    else:
        response = {
            'message': 'Our chain is authoritative',
            'chain': blockchain.chain
        }
    return jsonify(response), 200


@app.route('/nodes/get', methods=['GET'])
def get_nodes():

    nodes = list(blockchain.nodes)
    response = {'nodes': nodes}
    return jsonify(response), 200
```

![](http://adilmoujahid.com/images/blockchain-manage-nodes.gif)

## 总结

本文探讨了区块链底层的核心概念和如何通过Python实现一个区块链系统。简单起见，本文并没有覆盖一些技术细节，比如说：钱包地址和默克尔树。如果你想深入了解这些细节，我推荐阅读比特币白皮书原文，和[bitcoin wiki](https://en.bitcoin.it/wiki/Main_Page)，以及Andreas Antonopoulos的精彩著作: [Mastering Bitcoin: Programming the Open Blockchain](https://www.amazon.com/gp/product/1491954388/ref=as_li_tl?ie=UTF8&camp=1789&creative=9325&creativeASIN=1491954388&linkCode=as2&tag=adilmoujahid-20&linkId=bd776f9224715e8a022d4984909d6a69)

## 参考文献

1. [Wikipedia - Public-key cryptography](https://en.wikipedia.org/wiki/Public-key_cryptography)
2. [Wikipedia - Hash function](https://en.wikipedia.org/wiki/Hash_function)
3. [Bitcoin Stackexchange - What happens to a transaction once generated?](https://bitcoin.stackexchange.com/questions/58687/what-happens-to-a-transaction-once-generated)
4. [Bitcoin Wiki - Majority attack](https://en.bitcoin.it/wiki/Majority_attack)

