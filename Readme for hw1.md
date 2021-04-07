created by KaiFu   			2021 4.7

#### 1.首先是第一个小bug

![image-20210407184946441](https://raw.githubusercontent.com/Fu-Kai/hello-world/main/img/image-20210407184946441.png)

字符串匹配是否相等时不能直接单纯的 == 判断，应该判断他们的哈希值是否相等

#### 2.完善注册，修改密码功能

**首先是注册`register()`函数的完善**:

添加回调事件

`event Register(uint8 id, string passwd, uint time);`

该函数传入两个参数，一个 是注册账号，一个是密码

` function register(uint8 id, string memory passwd) public returns (bool) `

首先一个人（一个ip）只能注册一次，所以函数体内第一个require就要限制好

`require(ips[id] == address(0));//一个ip只能注册一次`

如果该ip没注册过，就可以进行注册

```solidity
ips[id] = msg.sender;//把当前发送信息者的ip添加到ips集合中
accounts[id] = passwd;//设置初始密码
```

注册成功之后生成log 返回true

```solidity
emit Register(id,passwd,now);
return true;
```

完整code：

![image-20210407185001177](https://raw.githubusercontent.com/Fu-Kai/hello-world/main/img/image-20210407185001177.png)

**第二个是修改密码`setPassword()`功能：**

添加回调事件

`event SetPassword(uint8 id, uint time);`

该函数也是传入两个参数，一个 是账号，一个是密码

` function register(uint8 id, string memory passwd) public returns (bool) `

首先需要本人才能修改密码，所以函数体内第一个require判断此账号地址和msg.sender的地址是否匹配

`require(ips[id] == msg.sender);`

修改密码

`        accounts[id] = passwd;`

修改成功之后生成log 返回true

```solidity
emit Register(id,passwd,now);
return true;
```

完整de code：

![image-20210407185014663](https://raw.githubusercontent.com/Fu-Kai/hello-world/main/img/image-20210407185014663.png)