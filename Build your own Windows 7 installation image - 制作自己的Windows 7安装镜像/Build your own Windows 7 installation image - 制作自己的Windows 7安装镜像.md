## 制作自己的Windows 7安装镜像

*版本：1.0*

查看Github渲染器中的**目录**：使用Github Markdown渲染页面右上角的“菜单”（⋮☰）按钮。

---

2009年7月22日，微软发布了Windows 7工厂压片版本（RTM）。

2009年8月22日，微软发布了Windows 7正式版（GA），Windows 7正式进入历史进程。

2011年2月9日，微软发布了Windows 7 首个服务包（SP1）。

2012年8月1日，微软发布了Windows 8 RTM。

2013年4月9日，微软停止了对没有更新到SP1的Windows 7的支持。

2014年8月31日，微软停止向OEM提供除专业版外的所有版本的Windows 7密钥。

2015年1月13日，微软停止了对Windows 7的“主流”支持，但是“延长”支持到2020年1月14日。这意味着原则上不会再有任何的功能性和性能更新，只有安全性更新。

2015年7月15日，微软发布了Windows 10 RTM。

2016年8月31日，微软停止向OEM提供专业版Windows 7密钥。至此，无论是OEM还是零售版，不会再有新的正版Windows 7流出。

2020年1月14日，微软停止了所有的Windows 7 (SP1)支持。只有付费订阅了Windows 7扩展安全更新（ESU）的企业用户，能够接收后续的安全性更新。

2020年6月17日，微软发布了KB4567409补丁，Windows 7的最后一个功能性补丁：基于Chromium的Microsoft Edge。

2021年6月11日，英伟达宣布停止对Windows 7提供Game Ready显卡驱动程序。6月21日，AMD也宣布停止对Windows 7提供Adrenalin显卡驱动程序。

2021年6月24日，微软发布了Windows 11 RTM。

2023年1月10日，微软停止了Windows 7 ESU支持。原则上不会再有对Windows 7的任何更新。至此，Windows 7正式离开历史舞台。

**2009~2023，一代传奇的操作系统Windows 7。**

## 零、为什么要制作一个自己的Windows 7安装镜像？

除了缅怀一代传奇操作系统的情怀，最重要的还是因为最近（202301）我是真的在一台实体机上安装了Windows 7。  
为什么要安装Windows 7呢，因为这台实体机年头有点旧了。i3-3240是一款2012年9月发布的CPU，那时候Windows 8刚压完盘。  
但并不是老机器一定要安装符合时代的操作系统。在我个人的体验中，对旧机兼容性最好的Windows其实是Windows 8.1。实际上手，Windows 8.1甚至表现比Windows 7还要好，不仅在于Windows 8.1支持快速启动、UEFI，而且其后台服务比Windows 10少，兼具轻量与现代化，还没有Windows 8那么反人类。  
但为什么最后还是安装了Windows 7呢？因为这台实体机是借来的，我拔下上面安装的SSD，塞了一块2006年的机械硬盘。  
2006年还没有Windows 7什么事呢，2007年7月Codename Windows 7才出现。把一块机械硬盘交给Windows 8.1就已经是很头疼的事了，更别提是一块Windows XP时代的机械硬盘，跑在SATA 1.5协议上，还跑不满理论速度，实测是这个德行：  
![img0.png](img0.png)  
我寻思着可能插个SD卡都比这表现好。所以最后选择了安装Windows 7。

既然系统装上是要用的，一般我都会保持更新到最新版本，能打上的官方补丁都打上。我个人是不喜欢网络上对个人PC禁用Windows更新的风气，永恒之蓝漏洞和后续WannaCry病毒的肆虐所敲响的警钟，保持更新最新的安全性补丁是非常有必要的。所以我一如往常地在安装好系统之后，打开Windows Update，更新系统。

安装2小时，更新2个周……

是的没错，无论是慢的要死的Windows 7更新服务器（Windows 10和11的很快），还是这个，平均响应时间2000多毫秒的2006年的机械硬盘，我断断续续地更新了2周才更完……后来又想到，以后玩老设备，或者还有给一些老人的电脑重装系统（我确实有这个需要），要是都得经历这漫长的系统更新过程，那真是爽的一批。于是我就想，既然有DISM工具能够将补丁部署在Windows安装镜像中，为何我不自己制作一个更新到最新补丁的Windows 7安装镜像呢？

其实网上已经有类似的镜像了，不过这就像用各种什么菜市场PE装机大师啥的装系统一样，用那玩意，真不定在装完系统的电脑上搞点什么花活。反正搞一个自己的安装镜像也不是什么难事，不如自己手动制作一个。

## 一、准备所需镜像、文件、制作工具

### 1. 微软官方Windows 7 SP1镜像

或许以前，甚至现在还有人跟你说去 *MSDN，我告诉你* 这个网站下载原版镜像。其实我以前也是去这个网站下载过几次iso安装镜像，不过现在来看，这个网站提供的许多ed2k链接已经无法连通（或许你用迅雷可以下载ed2k链接，不过那也是迅雷服务器中的资源，其他下载软件很难获取到资源），网站本身也挪到了新的地址（next.itellyou.cn），很遗憾地说，这个网站也已经进入到历史的长河中了。

既然提到了历史的长河，有一个地方专门放互联网的历史，它就是[Internet Archive](https://archive.org/)。下面这个链接可以直接直链下载到历史的、已经被微软停止提供的微软官方 *Windows 7 SP1 专业VL版* 镜像：

[Windows 7 Professional (VL) with Service Pack 1 (Simplified Chinese) (x86/x64) : Microsoft : Free Download, Borrow, and Streaming : Internet Archive](https://archive.org/details/windows-7-professional-vl-with-service-pack-1-simplified-chinese)

在打开的页面中，找到右边的“DOWNLOAD OPTIONS”，将光标悬停在下面的“ISO IMAGE”右边，会出现一个下尖括号（V），点击它，会出现两个iso文件链接。点击文件名中带有“x64”的链接下载64位系统安装镜像，点击文件名中带有“x86”的链接下载32位系统安装镜像。

![Internet_Archive0.png](Internet_Archive0.png)

如果你想要下载其他的版本，可以在网站的搜索框中搜索关键词如`creator:"Microsoft" windows 7 chinese`。

![Internet_Archive1.png](Internet_Archive1.png)

#### QA：

##### a. 为什么是专业版？旗舰版不是更NB功能更广吗？

旗舰版比专业版只多三个主要功能:Bitlocker、Bitlocker To Go和多语言界面。而且专业版被官方支持的时间更久。还有一点，专业版有VL版，而旗舰版没有。  
虽然我很喜欢Bitlocker（可能挺多人不喜欢吧……），但Windows 7中的Bitlocker是**不能向后兼容**的：Windows 7创建的Bitlocker加密磁盘，可以被Windows 7以后的系统读取；但Windows 8.1以后的系统创建的Bitlocker加密磁盘，无法被Windows 8.1以前的系统读取。既然是个残废那还不如不用。

##### b. 什么是VL版？不是VL版可以吗？

VL是Volume Licensing for organizations的简称，即“团体批量许可证”，面向一次采购大量系统副本的大客户。VL版在安装时不要求立即输入激活密钥，在安装后可以统一通过企业联网激活。
不是VL版当然可以。提倡支持正版的意识。

##### c. 不下载SP1可以吗？

呃……本教程旨在把所有的更新装完，装完之后不就是SP1了吗……

##### d. 我需要选择64位还是32位安装镜像？

我的推荐是只要CPU支持64位指令集，就选64位的，具体CPU支不支持64位指令集，可以搜索一下。

### 2. 让Windows Update自动打上所有补丁

如何才能知道Windows 7所需要的所有补丁呢？  
答案很简单：直接装一台，然后让Windows Update打上所有补丁就好了。

打开Windows Update（控制面板 - 系统和安全 - Windows Update，或者开始菜单 - 所有程序 - Windows Update），点击左边的“检查更新”，然后在弹出更新选项后，选中需要更新的更新。推荐只要列表中针对Windows 7和.net Framework的更新能更新都更新，无论是重要还是可选；对于明确不需要的更新，右键更新 - 忽略来隐藏特定更新。

刚刚装好官方镜像的Windows 7 SP1，系统状态还停留在2011年5月。要让Windows Update能够跟上近年来微软的更新调整，在进行系统更新之前，Windows Update平台应该会先进行自我更新。更新完Windows Update平台后，就可以进一步使用Windows Update自动扫描Windows 7缺失的补丁了。