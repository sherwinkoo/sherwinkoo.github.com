---
layout: post
title: "Linux知识集锦"
date: 2015-10-06 18:30:00
categories: Linux
---

## **一、SSH**
--------

### 1. SSH中文乱码

***原因：***
这通常是由于服务器locale使用本地locale，但是服务器并没有安装相关语言包导致的。

***解决方法：***
在`/etc/ssh/ssh_config`中，把`SendEnv LANG LC_*`这一行注释掉即可。
