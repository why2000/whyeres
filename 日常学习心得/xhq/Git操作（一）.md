# Git及其相关操作(一)

## Git安装

### Linux

使用如下命令安装Git:

```bash
sudo apt-get install git
```

### Windows

转到[Git下载页面](https://git-scm.com/downloads)下载并默认安装即可

## Git设置

安装完成后，还需要最后一步设置，在命令行输入：

```bash
$ git config --global user.name "Your Name"
$ git config --global user.email "email@example.com"
```

> 因为Git是分布式版本控制系统，所以，每个机器都必须自报家门：你的名字和Email地址。你也许会担心，如果有人故意冒充别人怎么办？这个不必担心，首先我们相信大家都是善良无知的群众，其次，真的有冒充的也是有办法可查的。 --摘自廖雪峰的[Git教程](https://www.liaoxuefeng.com/wiki/0013739516305929606dd18361248578c67b8067c8c017b000)

* 注意`git config`命令的`--global`参数，用了这个参数，表示你这台机器上所有的Git仓库都会使用这个配置，当然也可以对某个仓库指定不同的用户名和Email地址。

接下来的内容在Windows+Git中完成

## 建立一个Git Repository（版本仓库）

在Git Bash中选择并进入一个空目录 运行：

```bash
$ git init
```

若出现如下内容：

```
Initialized empty Git repository in /YourFolder/.git/
```

则说明版本库创建成功

* **一般不推荐将Git仓库建在含中文路径的文件夹中以防莫名其妙的错误**

## 把文件添加到版本库

和把大象放到冰箱需要3步相比，把一个文件放到Git仓库只需要两步。

第一步，用命令git add告诉Git，把文件添加到仓库：
```bash
git add <file> 
```
其中`<file>`是文件相对git仓库的位置

第二步，用命令git commit告诉Git，把文件提交到仓库：
```bash
git commit -m <message>
```
其中`<message>`是提交时的信息

2018年7月23日
Alaric Gilbert
