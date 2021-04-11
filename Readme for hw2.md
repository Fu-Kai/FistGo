## **函数功能使用指南：**

## 一：添加功能

### 1. constructor()

![image-20210411151336189](https://raw.githubusercontent.com/Fu-Kai/hello-world/main/img/image-20210411151336189.png)

这个函数是部署时建立管理员档案用的

五个参数：管理员地址，id，管理员名字，管理员年龄和经历。

### 2. getNumberOfPersons()

![image-20210411161717631](https://raw.githubusercontent.com/Fu-Kai/hello-world/main/img/image-20210411161717631.png)

这个函数用于查看个人档案数组中节点个数（ view修饰）

### 3. addPerson()

![image-20210411161731788](https://raw.githubusercontent.com/Fu-Kai/hello-world/main/img/image-20210411161731788.png)

这个函数是用于个人对自己的 **基础信息 **的添加，不需要管理员身份

四个参数：个人地址，id，个人名字，个人年龄。

信息会被存入 persons[] 数组 ，并且将id和信息添加map索引在PersonInfo中，并在isPersonExsist中标记此地址已被添加（true)

### 4.addPersonExperience()

![image-20210411161814690](https://raw.githubusercontent.com/Fu-Kai/hello-world/main/img/image-20210411161814690.png)

这个函数是用于个人对人的 **个人经历 **的添加，需要管理员身份

两个参数：需要被添加的人的ip，个人经历。

使用storage 把经历保存到PersonInfo中



## 二：授权查看功能

首先两个索引建立

![image-20210411162015026](https://raw.githubusercontent.com/Fu-Kai/hello-world/main/img/image-20210411162015026.png)

### 1.authorizeBasicInfo()

![image-20210411162128653](https://raw.githubusercontent.com/Fu-Kai/hello-world/main/img/image-20210411162128653.png)

用于把自己的 **基础信息** 授权给他人

两个参数：他人的地址，授权次数

把次数存入索引中，大于0即为可以查看



### 2.viewBasicInfo()

![image-20210411162237547](https://raw.githubusercontent.com/Fu-Kai/hello-world/main/img/image-20210411162237547.png)

查看他人基础信息

一个参数：他人地址

require判断当前账户对他人的查看次数是否大于0，如果是就返回这个人的**基础信息**

### 3.authorizeExperience() , viewExperience()

![](https://raw.githubusercontent.com/Fu-Kai/hello-world/main/img/image-20210411162515200.png)

与上面两个函数逻辑一致，返回值变为**个人经历**

