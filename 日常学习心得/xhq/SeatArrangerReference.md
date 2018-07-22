# SeatArranger库开发思路~~与正确使用姿势~~

* ~~我才不会说这个库是答应的某班长的委托的日常跳票操作~~

## 库源码文件说明

|类名|SeatArranger|Peoples|PeopleCombination|RelationshipsManager|  
|:--:|:----------:|:-----:|:---------------:|:------------------:|
|对应文件名|SeatArranger.cs|Peoples.cs|PeopleCombination.cs|RelationshipsManager.cs|  
|公有|√|×|×|×|
|可序列化|×|√|√|√|
|作用|外部调用封装|根据编号获取人的姓名|用于存储人的固定组合（关系）的类|对人与人之间的关系进行增减更变存储读取|

## 开发思路及源码说明

### Peoples.cs

就是一个类似枚举类型的类没啥可看的→_→

* ~~暴露了同学们的姓名ta们应该不会打我吧~~
```cs
namespace Alaric.SeatArranger
{
    class Peoples {
        static string[] People ={"彭  奥","杨新宇","朱玥澄","邱  丹","石雯昕","汤舒仪",
        "胡冰晴","许皓钦","桂雨涵","康静怡","刘国庆","刘子龙","姚  丰","郭熙宇","黄远昊",
        "尹希至","蒋月明","鲁  力","张美威","尹浩安","陈洪伟","张  衡","魏鸣之","杨  凯",
        "高子淇","鲍嫣然","周欣欣","龙  婕","汪  冲","蒋子龙","林崎帆","沈子皓","夏  铁",
        "陈佳敏","李佳辰","韩  煜","翟羽佳","程  卓","程小倩","胡佳奇","张紫千","田思举",
        "肖晨薇","李飞杨","刘晨光","魏宇帆","肖世寰","聂纹莎","陈慕华","刘  念","孙佳彬",
        "卢建益","毛永昊","张  孟","廖心怡","黄雨泽","黄毅成","艾子天","朱龙康","饶华涛",
        "徐李阳","陆鹤灵","刘雅伦","李沐阳","王  依","舒婉怡"};
        //根据编号返回其对应人的姓名
        public static string Get(int i)
        {
            return People[i];
        }
    }
}
```

### PeopleCombination.cs

```cs
using System;
using System.Collections;

namespace SeatArranger
{
    [Serializable]
    public class PeopleCombination
    {
        //存储人物间关系的ArrayList
        private ArrayList bond = new ArrayList();
        //构造函数 可用int型可变参数初始化数据
        //如:new PeopleCombination(11,23) 返回的是11号与23号组成的PeopleCombination
        //   new PeopleCombination(11,23,24) 返回的是11号、23号、24号按其顺序组成的PeopleCombination 
        public PeopleCombination(params int[] data) => bond.AddRange(data);
        //获取内部人物关系数据
        public ArrayList GetInnerData() => bond;
        //添加数据组合
        public virtual void AddRange(ArrayList list) => bond.AddRange(list);
        public virtual void AddRange(PeopleCombination pc) => AddRange(pc.bond);
        public static PeopleCombination Combine(PeopleCombination pc1, PeopleCombination pc2)
        {
            pc1.AddRange(pc2);
            return pc1;
        }
        //组合中人物数
        public int Count() => bond.Count;
        //获取该组合中指定人物的序号
        public int GetIndexOf(int A) => bond.IndexOf(A);
        //反向排列
        public void Reverse() => bond.Reverse();
        //判断该组合中是否包含指定人物
        public bool Contians(int A) => bond.Contains(A);
        //添加数据
        public void Add(int A) => bond.Add(A);
        //分割人物组合
        public PeopleCombination[] Split(int firstCombinationCount)
        {
            PeopleCombination[] result = new PeopleCombination[2];
            result[0] = new PeopleCombination();
            result[1] = new PeopleCombination();
            for (int i = 0; i < bond.Count; i++)
            {
                if (i < firstCombinationCount)
                    result[0].Add((int)bond[i]);
                else
                    result[1].Add((int)bond[i]);
            }
            return result;
        }
        //转为字符串
        public override string ToString()
        {
            string r = "";
            for (int i = 0; i < bond.Count; i++)
            {
                r += Peoples.Get((int)bond[i]);
                r += "  ";
            }
            return r.Substring(0, r.Length - 2);
        }
        //在控制台中打印
        public void Print() => Console.WriteLine(this.ToString());
    }
}
```

### RelationshipsManager.cs

* ~~忘干净怎么设计的了.avi~~
```cs
using System;
using System.IO;
using System.Runtime.Serialization.Formatters.Binary;

namespace Alaric.SeatArranger
{
    [Serializable]
    public class RelationshipsManager
    {
        private PeopleCombination[] Relationships;
        private RelationshipsManager(PeopleCombination[] r)
        {
            Relationships = r;
        }
        private PeopleCombination tmp1;
        private PeopleCombination tmp2;
        public static RelationshipsManager Read()
        {
            string dir = Directory.GetCurrentDirectory();
            if (!dir.EndsWith(@"\")) {
                dir += @"\";
            }
            dir += "relation.dat";
            FileStream fileStream;
            BinaryFormatter b = new BinaryFormatter();
            if (!File.Exists(dir))
            {
                fileStream = new FileStream(dir, FileMode.Create);
                PeopleCombination[] Relationships = new PeopleCombination[67];
                for (int i = 0; i < 67; i++)
                {
                    Relationships[i] = new PeopleCombination(i);
                }
                b.Serialize(fileStream, new RelationshipsManager(Relationships));
                fileStream.Close();
            }
            fileStream = new FileStream(dir, FileMode.Open, FileAccess.Read, FileShare.Read);
            RelationshipsManager c = b.Deserialize(fileStream) as RelationshipsManager;
            fileStream.Close();
            return c;
        }
        public void Save()
        {
            string dir = Directory.GetCurrentDirectory();
            if (!dir.EndsWith(@"\"))
            {
                dir += @"\";
            }
            dir += "relation.dat";
            FileStream fileStream;
            BinaryFormatter b = new BinaryFormatter();
            fileStream = new FileStream(dir, FileMode.Create);
            b.Serialize(fileStream, this);
            fileStream.Close();
        }
        public PeopleCombination GetCombinationOf(int A)
        {
            return Relationships[A];
        }
        public bool AddCombinationOf(int A,int B)
        {
            if ((!(Judge(A) && Judge(B))) || Relationships[A].Contians(B))
                return false;
            tmp1 = Relationships[A];
            tmp2 = Relationships[B];
            if (tmp2.GetIndexOf(B) != 0)
                tmp2.Reverse();
            if (tmp1.GetIndexOf(A) != (tmp1.Count() - 1))
                tmp1.Reverse();
            PeopleCombination re= PeopleCombination.Combine(tmp1, tmp2);
            
            Relationships[A] = re;
            Relationships[B] = re;
            return true;
        }
        private bool Judge(int A)
        {
            switch (Relationships[A].Count())
            {
                case 4:
                    return false;
                case 3:
                    if (Relationships[A].GetIndexOf(A) == 1)
                        return false;
                    else
                        return true;
                default:
                    return true;
            }
        }
        public bool RemoveCombinationOf(int A, int B)
        {
            if (!(GetCombinationOf(A) == (GetCombinationOf(B))))
            {
                Console.WriteLine("Unable to REMOVE combination of {0} and {1} , because there is not any relationship between them.", Peoples.Get(A), Peoples.Get(B));
                return false;
            }
            int larger = (GetCombinationOf(A).GetIndexOf(A) > GetCombinationOf(B).GetIndexOf(B)) ? GetCombinationOf(A).GetIndexOf(A) : GetCombinationOf(B).GetIndexOf(B);
            PeopleCombination[] pcs = GetCombinationOf(A).Split(larger);
            Relationships[A] = pcs[0].Contians(A) ? pcs[0] : pcs[1];
            Relationships[B] = pcs[0].Contians(B) ? pcs[0] : pcs[1];
            return true;
        }
    }
}
```

### SeatArranger.cs

emmmmmmmm 不就是一年前的祖传代码吗

> "~~我绝对还记得是什么回事~~"

```cs
using System;
using System.Collections;

namespace Alaric.SeatArranger
{
    public class SeatArranger
    {
        ArrayList PeoplePool = new ArrayList();
        ArrayList SinglePeoplePool = new ArrayList();
        ArrayList _4C = new ArrayList();
        ArrayList _3C = new ArrayList();
        ArrayList _2C = new ArrayList();
        //各组合最大容纳数
        int _4 = 7;
        int _3 = 11;
        int _2 = 3;
        Random r = new Random(DateTime.Now.Millisecond);
        int nowIndex;
        PeopleCombination nowCombination;
        PeopleCombination nowCombination_;
        RelationshipsManager rm = RelationshipsManager.Read();
        public void Arrange()
        {
            for (int i = 0; i < 67; i++)
            {
                PeoplePool.Add(i);
            }
            for (; PeoplePool.Count != 0;)
            {
                nowIndex = r.Next(0, PeoplePool.Count);
                nowCombination = rm.GetCombinationOf((int)PeoplePool[nowIndex]);
                foreach (var item in nowCombination.GetInnerData())
                {
                    PeoplePool.Remove(item);
                }
                switch (nowCombination.Count())
                {
                    case 1:
                        SinglePeoplePool.Add(nowCombination);
                        break;
                    case 2:
                        _2C.Add(nowCombination);
                        break;
                    case 3:
                        _3C.Add(nowCombination);
                        break;
                    case 4:
                        _4C.Add(nowCombination);
                        break;
                }
            }
            //去余补缺
            while (_4C.Count > _4)
            {
                Console.WriteLine("Can't keep up!! Four people Combination is too much. Try to divide some...");
                nowIndex = r.Next(0, _4C.Count);
                if (Ran())
                    _2C.AddRange(((PeopleCombination)_4C[nowIndex]).Split(2));
                else
                {
                    if (Ran())
                    {
                        SinglePeoplePool.Add(((PeopleCombination)_4C[nowIndex]).Split(1)[0]);
                        _2C.Add(((PeopleCombination)_4C[nowIndex]).Split(1)[1]);
                    }
                    else
                    {
                        SinglePeoplePool.Add(((PeopleCombination)_4C[nowIndex]).Split(3)[1]);
                        _2C.Add(((PeopleCombination)_4C[nowIndex]).Split(3)[0]);
                    }
                    _4C.Remove(_4C[nowIndex]);
                }
                _4C.Remove(_4C[nowIndex]);
            }
            while (_3C.Count > _3)
            {
                if ((_4C.Count < _4) && (SinglePeoplePool.Count > 0))
                {
                    nowIndex = r.Next(0, SinglePeoplePool.Count);
                    nowCombination = (PeopleCombination)SinglePeoplePool[nowIndex];
                    SinglePeoplePool.Remove(nowCombination);
                    nowIndex = r.Next(0, _3C.Count);
                    nowCombination_ = (PeopleCombination)_3C[nowIndex];
                    _3C.Remove(nowCombination_);
                    _4C.Add(PeopleCombination.Combine(nowCombination, nowCombination_));
                }
                else
                {
                    Console.WriteLine("Can't keep up!! Three people Combination is too much. Try to divide some...");
                    nowIndex = r.Next(0, _3C.Count);
                    nowCombination = (PeopleCombination)_3C[nowIndex];
                    _3C.Remove(nowCombination);
                    if (Ran())
                    {
                        SinglePeoplePool.Add(nowCombination.Split(1)[0]);
                        _2C.Add(nowCombination.Split(1)[1]);
                    }
                    else
                    {
                        SinglePeoplePool.Add(nowCombination.Split(2)[1]);
                        _2C.Add(nowCombination.Split(2)[0]);
                    }
                }
            }
            while (_2C.Count > _2)
            {
                if (_4C.Count < _4)
                {
                    nowIndex = r.Next(0, _2C.Count);
                    nowCombination = (PeopleCombination)_2C[nowIndex];
                    _2C.Remove(_2C[nowIndex]);
                    nowIndex = r.Next(0, _2C.Count);
                    nowCombination_ = (PeopleCombination)_2C[nowIndex];
                    _2C.Remove(_2C[nowIndex]);
                    nowCombination.AddRange(nowCombination_.GetInnerData());
                    _4C.Add(nowCombination);
                }
                else if ((_3C.Count < _3) && (SinglePeoplePool.Count > 0))
                {
                    nowIndex = r.Next(0, SinglePeoplePool.Count);
                    nowCombination = (PeopleCombination)SinglePeoplePool[nowIndex];
                    SinglePeoplePool.RemoveAt(nowIndex);
                    nowIndex = r.Next(0, _2C.Count);
                    nowCombination_ = (PeopleCombination)_2C[nowIndex];
                    _2C.RemoveAt(nowIndex);
                    _3C.Add(PeopleCombination.Combine(nowCombination, nowCombination_));
                }
                else
                {
                    Console.WriteLine("Can't keep up!! Two people Combination is too much. Try to divide some...");
                    nowIndex = r.Next(0, _2C.Count);
                    nowCombination = (PeopleCombination)_2C[nowIndex];
                    _2C.Remove(nowCombination);
                    SinglePeoplePool.AddRange(nowCombination.Split(1));
                }
            }
            //去单人化
            while (SinglePeoplePool.Count > 0)
            {
                if(_2C.Count < _2){
                    nowIndex = r.Next(0, SinglePeoplePool.Count);
                    nowCombination = (PeopleCombination)SinglePeoplePool[nowIndex];
                    SinglePeoplePool.Remove(nowCombination);
                    nowIndex = r.Next(0, SinglePeoplePool.Count);
                    nowCombination_ = (PeopleCombination)SinglePeoplePool[nowIndex];
                    SinglePeoplePool.Remove(nowCombination_);
                    _2C.Add(PeopleCombination.Combine(nowCombination, nowCombination_));
                }
                else if (_3C.Count < _3)
                {
                    nowIndex = r.Next(0, SinglePeoplePool.Count);
                    nowCombination = (PeopleCombination)SinglePeoplePool[nowIndex];
                    SinglePeoplePool.Remove(nowCombination);
                    nowIndex = r.Next(0, SinglePeoplePool.Count);
                    nowCombination_ = (PeopleCombination)SinglePeoplePool[nowIndex];
                    SinglePeoplePool.Remove(nowCombination_);
                    nowCombination = PeopleCombination.Combine(nowCombination, nowCombination_);
                    nowIndex = r.Next(0, SinglePeoplePool.Count);
                    nowCombination_ = (PeopleCombination)SinglePeoplePool[nowIndex];
                    SinglePeoplePool.Remove(nowCombination_);
                    _3C.Add(PeopleCombination.Combine(nowCombination, nowCombination_));
                }
                else
                {
                    nowIndex = r.Next(0, SinglePeoplePool.Count);
                    nowCombination = (PeopleCombination)SinglePeoplePool[nowIndex];
                    SinglePeoplePool.Remove(nowCombination);
                    nowIndex = r.Next(0, SinglePeoplePool.Count);
                    nowCombination_ = (PeopleCombination)SinglePeoplePool[nowIndex];
                    SinglePeoplePool.Remove(nowCombination_);
                    nowCombination = PeopleCombination.Combine(nowCombination, nowCombination_);
                    nowIndex = r.Next(0, SinglePeoplePool.Count);
                    nowCombination_ = (PeopleCombination)SinglePeoplePool[nowIndex];
                    SinglePeoplePool.Remove(nowCombination_);
                    nowCombination = PeopleCombination.Combine(nowCombination, nowCombination_);
                    nowIndex = r.Next(0, SinglePeoplePool.Count);
                    nowCombination_ = (PeopleCombination)SinglePeoplePool[nowIndex];
                    SinglePeoplePool.Remove(nowCombination_);
                    _4C.Add(PeopleCombination.Combine(nowCombination, nowCombination_));
                }
            }
        }
        private bool Ran()
        {
            if (r.Next(0, 2) == 0)
                return false;
            return true;
        }
    }
}
```

## ~~正确使用姿势~~

> "你写的什么傻---哔---玩意儿，鬼他妈知道怎么用"

> "我....我还有代码"

> 代码重装不见了。。。。。。

> 自己van去吧   逃)
