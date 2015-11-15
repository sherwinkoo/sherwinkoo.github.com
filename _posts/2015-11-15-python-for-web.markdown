---
layout: post
title: Python for Web
date: 2015-11-15 20:44:46
categories: Web开发
---

### 导语：
> 从去年12月到现在，我已经使用Python做Web开发快一年了。从最初的亮眼茫然，到中间的烦躁，再到现在的如饥似渴，让我觉得有必要把这个过程回忆一下。对我来说，最初学习Python的时候，最大的感受就是Python项目中用到的库太多了，跟怒江七十二拐似的，总在你行的顺畅的时候来那么一下。

> 今天这篇就先总结下这一年来，一个纯Python构建的Web服务器的开发流程。

##  一、环境配置

### Python的选择
这一年来一直都是使用2.7版本的Python，所以也没有办法对3.4进行比较，等有机会实践过再记录吧。

### virtualenv是个好东西
字面理解的话，它是一个虚拟Python环境的管理器；它的目的呢，就是允许在一个系统中安装多个Python环境，并且可以随时切换。比如公司某个项目使用的是Django 1.5，而我想用Django 1.7来开发新项目，如果都安装在系统目录的话，它们是无法共存的（非严格意义上）。这时候，我就可以用virtualenv构建两个Python环境，一个安装1.5的Djnago，另一个安装1.7的Django，互不干扰。

### Python的包管理器: pip
来自官方的包管理器有俩：easy_install和pip。官方说法，pip是easy_install的改良版，理论上应该是更好用的，但是我一直都是用的pip，并且也没有发生过不愉快的事，所以也就没有去试用easy_install。

## 二、框架选择
> 作为一门可以进行web开发的语言，Python是Web框架最多的一个，而且每个框架都拥有不少支持者；大概是因为用Python创建框架并不是多么困难的一件事，从这里也能看出Python这门语言的开发效率之高。我用过的框架有：Django，Cyclone，Tornado。

### Django
作为一个大而全的Web框架，对于新手来说，确实是要方便很多的。不会SQL，没有关系，有ORM帮你处理；项目时间紧，没关系，有强大的Admin帮你自动生成管理后台。我用它开发了好几个项目：微信服务号后台，逢年过节的各种抽奖活动，还有我们的官网。就算是到了后期服务器压力上来了，依旧可以保留原有的admin，用tornado或者golang来重构API接口。

对于我来说，Django的用途通常有以下三种：

+ 小项目，而且短时间内不会有特别高的访问量
+ 项目时间紧，需要快速上线
+ 单纯需要一个管理后台，Django强大的admin，真的是很赞

### Cyclone
这是一个来自Tornado的fork，不过使用了twisted（一个异步的Python网络库）进行了修改，与Tornado的接口是一致的。不过最近其作者宣布不再维护此项目了。而我们使用它全是历史原因，一直想用tornado进行重构，但时间不够，只能作罢了。

### Tornado
tornado是我最近才开始使用的框架，由于之前一直用的是Cyclone，所以转到tornado也没有什么困难，基本就是把Cyclone中的defer.inlineCallbac换成gen.coroutine就OK啦。数据库连接使用momoko，Redis连接使用TornadoRedis就OK了。

> 使用momoko的时候遇到一个很奇怪的问题，如果数据库密码或者用户名写错了，它不会提示你用户名或密码错误，而是直接抛出一个OSError：No such file or directory。我曾尝试过解决这个问题，最后发现在用epoll和kqueue的时候才有，使用select是正确的，貌似是tornado的epoll和kqueue封装有问题？还没有最终确定。


TornadoRedis的接口并不简洁，不能像在Cyclone下面快乐地使用@defer.inlineCallback和yield那样写异步，所以我就对它的接口做了又一层封装，这样就可以快乐地用@gen.coroutine和yield写异步代码了：

    class TornadoRedisWrapper(object):                                                 

        def __init__(self, redis):
            self.redis = redis

        @concurrent.return_future                                                      
        def __call__(self, method, *args, **kwargs):
            getattr(self.redis, method)(*args, **kwargs)

        def __getattr__(self, method):
            return lambda *args, **kwargs: self(method, *args, **kwargs)

## 三、常用Python库

**django-grappelli**  如果你不觉得Django默认的Admin丑的话，当我没说。这是一个单纯用来为Djnago.admin增加颜值的库（嗯，这是一个看脸的世界）。

**django-filebrowser**  有时候（其实是大多数时候）运维同学们会想要上传一些文件，比如各种类型图片（还想要自动生成各种尺寸），Excel，视频文件等，这时候你就可以傲娇地告诉他们：等着，半小时搞定！

**requests**  做Web开发，免不了要与其他各种Web系统进行交互。相信我吧，不要再用urllib， urllib2了，尝试一下requests，你会爱上它的。

## 四、开发工具
> 理论上，做Python开发，只需要一个编辑器就OK了。但是很多时候我们需要的不仅仅是编辑功能。

### 系统选择
Windows与Linux之争由来已久，我也无意挑起争端。用Python做Web开发请一定要选择Linux，请一定要选择Linux，请一定要选择Linux。

### 编辑器 OR IDE
我是坚定不移的VIM用户，所以，你懂的。我只见过一个人用PyCharm做开发，后台被离职了（这不是在黑IDE）。对于Python开发来说，除了编辑，你需要的其他功能也就以下几种：

+ 用空格替换TAB缩紧，千万不要空格和TAB混用，最好也不要使用TAB
+ 自动提示，PyCharm配置好Python路径就可以了，VIM也有相应的插件
+ 语法检查，Python代码规范请遵循PEP8，VIM中的flake8插件可以在保存的时候提示错误
+ 函数或类的定义跳转，这个功能VIM中还没有配置好，不过现在已经基本习惯不能跳转了；PyCharm似乎是支持跳转的。

### 版本管理
最近突然发现许多工作两三年的人还都不知道或者不会用GIT，更有许多人不了解或者不在意版本管理，作为一名合格的后台开发，熟练掌握GIT也是一门基本功（不要跟我说SVN，我不听，我不听）。我推荐阅读《pro-git》的中文版。

### Shell命令
基础的查看系统信息，查看进程，内存，端口占用，网络连接，网卡流量这些也都得知道啊。

你至少得会grep吧，要不Nginx的日志怎么查；还得会awk吧，要不怎么从Nginx的日志中提取关键字段；sort， unique也得会吧，总有些数据的优先级要比其他的高，得排序，去重啊。至于会不会写shell脚本，我觉得不用苛求，毕竟我们都是搞Python的，毕竟脚本语言嘛。

### 文档生成
作为后台，必须要为你写的Web接口写出准确，简洁的文档，并且要随时更新文档。我们现在才用的是一个叫做apidoc的工具，用node写的。它会扫描项目的所有py文件来生成文档，而我需要做的就是在我的HTTP Handler上面根据它的格式写出文档，这样文档和代码写在一起，如果代码修改了，同时也不会忘记修改文档了。

## 五、服务部署
简单来说，使用Nginx做反向代理，把请求分发给后面的Python服务器。

+ 如果使用Django，那么在线上环境中，我们通常会使用gunicorn来运行它，并且可以使用－k gevent来使同步IO变成异步IO。
+ 如果是Cyclone，使用twistd -n cyclone -p <port> -r app.Application来运行
+ 如果是Tornado，使用Tornado自带的HTTPServer运行即可。

在线上部署的时候，我们必须使用一种简单的方式来批量启动，停止，重启这些进程，自己写一个管理的脚本也可以，不过现在已经有了一个很好用的工具: supervisor，它分为Server端(supervisord)和Client端(supervisorctl)，Server端负责监控Web进程，Client端负责接收用户命令并发送给Server端。

## 尾语
> 以上只是简单介绍了使用Python做Web开发需要用到的各种东西，以及一些基本的流程；并没有详细的介绍，后续会对每个点做详细的讲解。
