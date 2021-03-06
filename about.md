---
layout: page
permalink: /about/
---

# 工作经历

## 北京爱视游科技文化有限公司 （ 2014年12月 ~ 2016年4月 ）

### 葡萄游戏厅－服务端开发 

产品为智能电视端的游戏平台，提供各种支持遥控器和手柄的游戏。

后端项目中使用了Django和Cyclone两个Web框架，后期由我独立负责开发，维护以及优化。主要内容有：

- 为大厅客户端提供各种数据接口，如游戏列表，游戏详情，大厅礼包等等
- Python脚本：同步文件（rsync，金山云，阿里云），NGINX日志分析，APK文件数据提取等
- 为其他服务提供游戏数据的RPC接口，比如官网中的游戏数据
- 引入了apidoc工具编写接口文档，并在后续的所有项目中使用

### 好友德州－服务端开发 
项目是一个德州扑克的棋牌类IOS手游。后端使用了Django和Tornado的Websocket框架。我在此项目中独立负责提供API数据接口和Websocket打牌逻辑的处理。

- 将牌桌服务分拆为Websocket broker和牌桌逻辑处理服务，使用Redis的Publish/Subscribe负责在这两个服务中传递消息；这样不光方便后期通过增加服务进程来提高处理能力，还方便了牌桌的单元测试。

- 在此项目中充分使用了单元测试，使用Django的unittest测试HTTP接口，使用Python的unittest测试牌桌逻辑，保证了代码质量和开发效率。所以虽然后端只有我一个人，但是开发进度一直领先于客户端，并且后期测试出的BUG数量很少。

- 项目中使用了tornado-redis开源库，broker偶尔会与redis连接断开，由于此BUG无法重现，所以通过检查代码、网上搜索资料，一直没有找到问题原因，最后通过阅读tornado-redis的源代码，定位问题并解决了。

### 葡萄支付
此项目为Django搭建的支付平台，负责为葡萄SDK提供支付接口，对接多家支付渠道，包括：微信，支付宝，短信以及各种TV端的支付渠道。我负责：

- 维护，修复BUG，为运营定制管理后台（Django admin）
- 对接各种支付渠道，包括：创维，海信，视博云，易视腾，联通TV等
- 并且为游戏方提供接入的技术支持。

### 其他项目
- [公司官网](http://www.putaogame.com): 主要负责服务端，也负责一部分前端开发，比如手柄介绍页面。
- 微信服务号（葡萄游戏厅）：主要是菜单定制，客服消息以及关键字处理。
- 摇奖活动：使用随机数的简单摇奖系统，支持了抢红包，抓羊，砸蛋者三次活动。

 
## 北京顶点唯峰科技有限公司 （ 2013年3月 ~ 2014年11月 ）

### 反外挂 
- 驱动级：网络数据加密，鼠标键盘保护等
- 应用级：VMP加壳检测，GUI线程，窗口保护，文件校验，HOOK检测等一系列用来检测外挂的小功能。

### 基于NGINX的反外挂服务器 
在Nginx的基础上进行反外挂服务器的开发，在开源的tcp_proxy的代码上进行开发，虽然最后由于模拟器项目而搁置，但因此对Nginx的代码比较熟悉。

### 基于Virtual Box的Android模拟器
使用Virtual Box来运行Android系统，并使用QT来实现模拟器的界面，独立实现了前期界面的所有代码，做出基本的框架，并在后期完成了模拟器的安装和更新程序，以及使用python实现了一个半自动打包发布的程序。


## 深圳市迈安腾技术有限公司（2012年7月 ~ 2012年12月）
- 职位：服务器端开发工程师。
- 工作语言：C++。
- 工作职责：虚拟桌面的服务器端开发，包括部分RDP协议的实现，完成了剪贴板以及音视频重定向。

## 北京游国网络有限公司（2011年8月 ~ 2012年2月）
实习，职位为网页游戏服务端开发，使用Erlang作为工作语言。Erlang是在去公司以后初次接触，六个月内由不熟悉到承担主要开发任务，而且对商业开发和多人协作有了更深的了解。

###  页游－斗魂世界
- 完成了游戏《斗魂世界》的寻宝，坐骑系统，神鼎，护送任务等多个模块。
- 通过与策划的交流，进一步了解了ARPG游戏的设计
- 对WebGame的后台开发模式有了深刻的了解


# 开源项目
- [HTML5-ARPG](http://github.com/sherwinkoo/html5-arpg-game) :使用HTML5编写的ARPG页游前端


# 技能清单
- Web开发：Python
- Web框架：Django/Cyclone/Tornado
- 前端框架：Bootstrap
- 数据库相关：PostgreSQL/Redis
- 版本管理、文档和自动化部署工具：Git/ApiDoc
- 单元测试：PyUnit
- 云和开放平台：微信服务号开发
