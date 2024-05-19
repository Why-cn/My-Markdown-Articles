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

2020年6月17日，微软发布了KB4567409更新，Windows 7的最后一个功能性更新：基于Chromium的Microsoft Edge。

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

既然系统装上是要用的，一般我都会保持更新到最新版本，能打上的官方更新都打上。我个人是不喜欢网络上对个人PC禁用Windows更新的风气，永恒之蓝漏洞和后续WannaCry病毒的肆虐所敲响的警钟，保持更新最新的安全性更新是非常有必要的。所以我一如往常地在安装好系统之后，打开Windows Update，更新系统。

安装2小时，更新2个周……

是的没错，无论是慢的要死的Windows 7更新服务器（Windows 10和11的很快），还是这个，平均响应时间2000多毫秒的2006年的机械硬盘，我断断续续地更新了2周才更完……后来又想到，以后玩老设备，或者还有给一些老人的电脑重装系统（我确实有这个需要），要是都得经历这漫长的系统更新过程，那真是爽的一批。于是我就想，既然有DISM工具能够将更新部署在Windows安装镜像中，为何我不自己制作一个更新到最新更新的Windows 7安装镜像呢？

其实网上已经有类似的镜像了，不过这就像用各种什么菜市场PE装机大师啥的装系统一样，用那玩意，真不定在装完系统的电脑上搞点什么花活。反正搞一个自己的安装镜像也不是什么难事，不如自己手动制作一个。

## 一、准备所需镜像、文件、制作工具

### 1. 微软官方Windows 7 SP1镜像

或许以前，甚至现在还有人跟你说去“MSDN，我告诉你”这个网站下载原版镜像。其实我以前也是去这个网站下载过几次iso安装镜像，不过现在来看，这个网站提供的许多ed2k链接已经无法连通（或许你用迅雷可以下载ed2k链接，不过那也是迅雷服务器中的资源，其他下载软件很难获取到资源），网站本身也更新了新的地址（next.itellyou.cn），很遗憾地说，这个网站也已经进入到历史的长河中了。

既然提到了历史的长河，有一个地方专门放互联网的历史，它就是 *[Internet Archive](https://archive.org/)* 。下面这个链接可以直接直链下载到历史的、已经被微软停止提供的微软官方 *Windows 7 SP1 专业VL版* 镜像：

[Windows 7 Professional (VL) with Service Pack 1 (Simplified Chinese) (x86/x64) : Microsoft : Free Download, Borrow, and Streaming : Internet Archive](https://archive.org/details/windows-7-professional-vl-with-service-pack-1-simplified-chinese)

在打开的页面中，找到右边的 *“DOWNLOAD OPTIONS”* ，将光标悬停在下面的 *“ISO IMAGE”* 右边，会出现一个下 *尖括号（V）* ，点击它，会出现两个iso文件链接。点击文件名中 *带有“x64”的链接* 下载64位系统安装镜像，点击文件名中 *带有“x86”的链接* 下载32位系统安装镜像。

![Internet_Archive0.png](Internet_Archive0.png)

如果你想要下载其他的版本，可以在网站的 *搜索框* 中搜索关键词如`creator:"Microsoft" windows 7 chinese`。

![Internet_Archive1.png](Internet_Archive1.png)

#### QA：

**a. 为什么是专业版？旗舰版不是更NB功能更广吗？**

旗舰版比专业版只多三个主要功能:Bitlocker、Bitlocker To Go和多语言界面。而且专业版被官方支持的时间更久。还有一点，专业版有VL版，而旗舰版没有。  
虽然我很喜欢Bitlocker（可能挺多人不喜欢吧……），但Windows 7中的Bitlocker是**不能向后兼容**的：Windows 7创建的Bitlocker加密磁盘，可以被Windows 7以后的系统读取；但Windows 8.1以后的系统创建的Bitlocker加密磁盘，无法被Windows 8.1以前的系统读取。既然是个残废那还不如不用。

**b. 什么是VL版？不是VL版可以吗？**

VL是Volume Licensing for organizations的简称，即“团体批量许可证”，面向一次采购大量系统副本的大客户。VL版在安装时不要求立即输入激活密钥，在安装后可以统一通过企业联网激活。
不是VL版当然可以。提倡支持正版的意识。

**c. 不下载SP1可以吗？**

呃……本教程旨在把所有的更新装完，装完之后不就是SP1了吗……

**d. 我需要选择64位还是32位安装镜像？**

我的推荐是只要CPU支持64位指令集，就选64位的，具体CPU支不支持64位指令集，可以搜索一下。

### 2. 让Windows Update自动打上所有更新

如何才能知道Windows 7所需要的所有更新呢？  
答案很简单：直接装一台，然后让Windows Update打上所有更新就好了。

打开 *Windows Update（控制面板 - 系统和安全 - Windows Update，或者开始菜单 - 所有程序 - Windows Update）* ，点击左边的 *“检查更新”* ，然后在弹出更新选项后，选中需要更新的更新。推荐只要列表中针对Windows 7和.net Framework的更新能更新都更新，无论是重要还是可选；对于明确不需要的更新， *右键更新 - 忽略* 来隐藏特定更新。

![WU0.png](WU0.png)  
~~二级菜单的图忘截了~~

刚刚装好官方镜像的Windows 7 SP1，系统状态还停留在2011年5月。要让Windows Update能够跟上近年来微软的更新调整，在进行系统更新之前，Windows Update平台应该会先进行自我更新。更新完Windows Update平台后，就可以进一步使用Windows Update自动扫描Windows 7缺失的更新了。

> 如果想要提前下载离线更新包对Windows Update平台进行更新，请依次下载并安装以下更新：  
[KB3138612 - Windows 7 和 Windows Server 2008 R2 的 Windows 更新客户端：2016 年 3 月](https://www.microsoft.com/zh-CN/download/details.aspx?id=51212)  
[KB4474419 - 适用于 Windows Server 2008 R2、Windows 7 和 Windows Server 2008 的 SHA-2 代码签名支持更新：2019 年 9 月 23 日](https://catalog.update.microsoft.com/search.aspx?q=kb4474419) - 这个更新也是安装火绒的必需更新  
[KB4490628 - Windows 7 SP1 和 Windows Server 2008 R2 SP1 的服务堆栈更新：2019 年 3 月 12 日](https://catalog.update.microsoft.com/search.aspx?q=4490628)  
[KB4575903 - 适用于 Windows 7 SP1 和 Windows Server 2008 R2 SP1 的扩展安全更新（ESU）许可准备程序包的更新](https://www.catalog.update.microsoft.com/Search.aspx?q=kb4575903)  
[KB4592510 - 2020-适用于 Windows 7 的 12 服务堆栈更新，适合基于 x64 的系统](https://www.catalog.update.microsoft.com/Search.aspx?q=4592510)  
由于Windows 7在2020 年1月14日后结束扩展支持，理论上没有续费ESU的Windows 7将无法更新任何更新号大于KB4522133的更新。这点将在后面进行说明。

对于隐藏的更新，如果要恢复，在Windows Update中点击 *左栏的“还原隐藏的更新”* 。

![WU1.png](WU1.png)

但这基本上是不可能的。

### 3. “劝说”系统允许更新ESU - 扩展安全更新

为什么上一步最后说Windows Update无法帮我们打上所有的Windows 7更新？我自己在实践的时候，最后总有几个更新永远重复在更新失败 - 重试 - 更新失败的循环当中。按更新号进行寻找并下载到离线更新包后，手动离线安装，会提示更新包不兼容当前的系统。原因在于，Windows 7在2020年1月14日后结束扩展支持，理论上没有续费ESU（Extended Security Update, 扩展安全更新）的Windows 7将无法更新任何更新号大于KB4522133的更新。在这个更新之后的Windows 7更新在安装前会先搜索系统中有没有获取到ESU MAK加载项密钥，如果没有，则拒绝安装。这个密钥的获取途径是购买了Windows 7 专业版的企业用户从微软购买Windows NT 6.1系列的扩展安全更新，没有续费的用户，或者说根本没法续费的用户是得不到后续的安全更新的。

鉴于潜在的法律问题，我在这里就不分享相应解决方案的链接了。有意者可自行搜素关键字“BypassESU v12”。

~~使用管理员权限运行LiveOS-Setup.cmd，弹出操作选项后，按1进行安装（其他选项也可，有能力者自行决断）。安装后重启电脑，应该就可以安装后续更新了。这样最后应该能一路更新到KB5022338，2023年1月10日最后的ESU更新。~~

（话说既然不让普通用户安装ESU更新，为啥Windows Update还能扫描到这些更新？）

### 4. 进行更新清理

由于Windows 7的Windows Update在更新时并不像后续Windows 10、Windows 11的Windows 更新那么智能——能够分析每个需要的更新是否被后面的更新覆盖而跳过过时更新，Windows 7的Windows Update基本上是一股脑地挨个装一遍，许多过时更新也被安装上了，即使后面的更新会覆盖掉这些过时的更新，或者因为后面的更新已被安装，所以过时更新所做的操作会被忽略。因此清理掉这些过时更新记录是很重要的，因为我们要根据实体机上已经安装好的更新列表来下载离线更新包，下载这些过时更新毫无疑问是无意义且浪费时间的。

举我自己的例子，我更新完所有更新之后，更新列表显示安装了约147个更新，在更新清理之后，总数只有71个，说明之前安装的约一半的更新是过时的。

由于潜在的玄学问题和不可抗力的可能性，我十分推荐在执行更新清理之前，先使用实体机一段时间，看看有没有什么问题，是由于更新造成的，防止在后续工作中突然发现前面哪个更新会造成某种问题而返工。

> 好了，已经玩嗨了，忘掉还要做镜像的事了o(*≧▽≦)ツ┏━┓

然后推荐对系统分区做一次分区备份。这里可以使用DiskGenius软件来进行一次全盘备份。其优点是该软件可以创建一个超级精简的Win PE环境到U盘中，在我们把系统玩挂掉之后，可以用该软件在其他电脑上创建一个恢复U盘，恢复系统分区到之前备份的能用的版本。该功能是免费的，到官网下载最新版软件即可使用。

[备份分区 - DiskGenius](https://www.diskgenius.cn/help/part2file.php)

（当然这一步不是必须的。）

在做好安全准备后，通过Windows 7自带的磁盘清理就可以进行更新清理了。

打开 *Windows资源管理器* ，在 *系统盘* （以C盘为例）上 *右键 - 属性* ，打开驱动器属性页面。在 *“常规”* 选项卡中，点击 *“容量”* 下的 *“磁盘清理”* 按钮，在弹出的 *“(C:)的磁盘清理”* 窗口中，点击带有UAC图标的 *“清理系统文件”* 按钮。

![Disk_cleaning0.png](Disk_cleaning0.png)

在重新打开的 *“(C:)的磁盘清理”* 窗口中，选中 *“要删除的文件:”* 列表中的 *“Windows 更新清理”* 选项，点击 *“确定”* ，等待清理完成。

![Disk_cleaning1.png](Disk_cleaning1.png)

清理之后重新启动电脑，打开 *“命令提示符”(Windows徽标键 + R，输入“CMD”后运行，或从开始菜单查找并进入)* ，输入

`systeminfo`

并 *回车* 运行，在输出的结果中找到 *“修补程序”* 部分，即可看到进行了更新清理后的更新列表。

<img alt="systeminfo.png" src="systeminfo.png" width="40%" title="This image has been scaled to 40% of its original size.">

> 请注意：这仅是一个示例图片。因后续更新发布以及其他情况，实际结果可能与图片产生区别。

之后就是根据这个列表来下载离线更新包了。除了复制控制台输出以外，还可以通过输入以下命令将systeminfo输出到 *文本文档* 里：

```PowerShell
systeminfo > <输出文档.txt>
```
### 5. 下载离线更新包

#### 5.1 搜索离线更新包

我们现在根据上文的更新列表中的每个更新号，来依次下载离线更新包。到微软的更新目录中进行搜素并下载：

[Microsoft Update Catalog](https://www.catalog.update.microsoft.com/Home.aspx)

在右上角的搜索框中输入要下载的更新号并搜索，以“KB2491683”为例：

![Microsoft_Update_Catalog0.png](Microsoft_Update_Catalog0.png)

#### 5.2 找到最新的离线更新包

搜到后先确定该更新适用的Windows版本和指令集，在本例中我们选择 *Windows 7* 并标明类似于 *“适用于基于 x64 的系统的”* 。先不要急着下载，先点进该更新的 *标题链接* ，在弹出的 *“更新详情”* 弹出式窗口中，先点选 *“Package Details”* 选项卡，在下面的 *“本更新已被下列更新取代 (This update has been replaced by the following updates:)”* 列表中，查看是否已经有更新取代了这个更新。如果有，那就说明这个更新也是过时更新，只不过没有被更新清理清理掉。找出“本更新已被下列更新取代”列表中更新号最大的一个更新，点进链接，重复以上过程，直到该列表中显示 *“n/a”* ，即没有更新取代新更新，那就是最初更新的目前为止的最新版本了。  
（注：可能会有多个旧更新被同一个新更新取代的情况。）

![Microsoft_Update_Catalog1.png](Microsoft_Update_Catalog1.png "图例为KB2491683")

在这个例子中，这个2014年9月发布的更新在经过多次被取代后，最后停在了目前最新的更新——2023年1月月度安全质量汇总 KB5022338上。

