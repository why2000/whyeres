# Markdown学习心得（一）

2018年7月22日 许皓钦

## #关键字

* #-######分别表示1-6级标题。
* #后加空格才有效，否则直接显示#+内容。
* #行前后要用空行隔开，这是一般的md编写风格。

  上述代码：
    ```markdown
    * #-######分别表示1-6级标题。
    * #后加空格才有效，否则直接显示#+内容。
    * #行前后要用空行隔开，这是一般的md编写风格。
    ```

## *关键字
* *后空格为内容点
  * 可以嵌套
  * 这是嵌套第二层
    
  上述代码：
    ```markdown
    * *后空格为内容点
      * 可以嵌套
      * 这是嵌套第二层
    ```
* `*内容*`表示*斜体*
* `**内容**`表示**加粗**

## ~关键字

* ~~目测不需多说~~
* 用于表示删除线，这是上一行的代码：
  
  `~~目测不需多说~~`

## >关键字

> 就像这样，> 后的为引用内容

## `关键字

* 用`包裹行间代码
* 如`*Codes*`并不为斜体

    上一行代码：
    ```markdown
    * 如`*Codes*`并不为斜体
    ```
* 用```包裹多行代码
* 比如：
    ```cs
    using System;

    namespace HelloWorld
    {
        class Program
        {
            static void Main(string[] args)
            {
                Console.WriteLine("Hello World!");
                Console.Read();
            }
        }
    }
    ```
* 头部后紧跟语言对应代号可实现高亮，如上述C#代码的头部后紧跟有cs(csharp也可)

## 表格

如SeatArrangerReference.md的表格:

|类名|SeatArranger|Peoples|PeopleCombination|RelationshipsManager|  
|:--:|:----------:|:-----:|:---------------:|:------------------:|
|对应文件名|SeatArranger.cs|Peoples.cs|PeopleCombination.cs|RelationshipsManager.cs|  
|公有|√|×|×|×|
|可序列化|×|√|√|√|
|作用|外部调用封装|根据编号获取人的姓名|用于存储人的固定组合（关系）的类|对人与人之间的关系进行增减更变存储读取|

它的代码为:
```markdown
|类名|SeatArranger|Peoples|PeopleCombination|RelationshipsManager|  
|:--:|:----------:|:-----:|:---------------:|:------------------:|
|对应文件名|SeatArranger.cs|Peoples.cs|PeopleCombination.cs|RelationshipsManager.cs|  
|公有|√|×|×|×|
|可序列化|×|√|√|√|
|作用|外部调用封装|根据编号获取人的姓名|用于存储人的固定组合（关系）的类|对人与人之间的关系进行增减更变存储读取|
```

## 
