# 技巧集合

*版本：1.0 本文章不提供英文版*

一些杂七杂八的小技巧合集，主要是怕忘了，哪天可以捡起来接着看。

查看Github渲染器中的**目录**：使用Github Markdown渲染页面右上角的“菜单”（⋮☰）按钮。

## 综合目录

根据Tag进行分类的一个综合目录

### Windows

[设置ADB到Windows环境变量中](#设置adb到windows环境变量中)  
[Windows查询校验和](#windows查询校验和)  
[卸载Windows 11小组件](#卸载windows-11小组件)  
[关闭Windows 11开始菜单的Bing网络搜索](#关闭windows-11开始菜单的bing网络搜索)  
[跳过Windows 11 OOBE时的登入微软账户需求](#跳过windows-11-oobe时的登入微软账户需求)

### Andriod

[去除MIUI（6+）开机系统完整性验证（破解卡米）](#去除miui6开机系统完整性验证破解卡米)  
[安卓手机双系统（同安卓版本，不同ROM）制作](#安卓手机双系统同安卓版本不同rom制作)  
[安卓设备查看UFS闪存损耗程度（健康信息）](#安卓设备查看ufs闪存损耗程度健康信息)  
[MIUI查询电池健康](#miui查询电池健康)  
[MIUI线刷降级报错MiFlash update sparse crc list failed](#miui线刷降级报错miflash-update-sparse-crc-list-failed)  
[MIUI云控的一些讨论](#miui云控的一些讨论)  
[监控哪些安卓应用在内部存储空间拉屎](#监控哪些安卓应用在内部存储空间拉屎)  

### 虚拟机与跨平台

[解决VMware Workstation长期占用硬盘和卡顿的问题](#解决vmware-workstation长期占用硬盘和卡顿的问题)  
[VMWare虚拟磁盘使用SCSI和SATA的比较](#VMWare虚拟磁盘使用SCSI和SATA的比较)  
[跨平台的局域网间测速工具——iperf3](#跨平台的局域网间测速工具iperf3)  
[真正的跨平台性能测试工具——Geekbench 6](#真正的跨平台性能测试工具geekbench-6)  
[局域网间跨平台临时数据传送，仅需浏览器](#局域网间跨平台临时数据传送仅需浏览器)

### 无Tag



## 设置ADB到Windows环境变量中

假设 *<ADB文件夹地址>* 为D:\Program Files (UWPfree)\Android Debug Bridge，那么使用Windows徽标键 + R打开“运行”，输入“SYSDM.CPL”，回车打开“系统属性”，点击“高级”选项卡，点击下方“环境变量”按钮，在弹出的“环境变量”页面中选中下方“系统变量”(或“用户变量”)中的“Path”一行，点击“编辑”按钮，在弹出的“编辑环境变量”页面中点击“新建”按钮，然后输入ADB文件夹的地址，一路确定。

![adb.png](adb.png)

在任意位置打开命令提示符，输入“adb”并回车，如果出现大量提示符并在第三行显示“Installed as *<ADB文件夹地址>*\adb.exe”，就说明adb环境变量设置成功了。

![adb1.png](adb1.png)

这样的好处是今后使用他人分享的使用了adb命令的bat脚本时不需要再配置/使用附带的adb组件，而且可以在任意位置启动adb，而不需要一遍遍复制文件到adb文件夹下。不过需要注意的是，传输本地电脑上的文件应尽量使用绝对路径，以免adb找不到文件。

## 去除MIUI（6+）开机系统完整性验证（破解卡米）

[图文分享 - 酷安](https://www.coolapk.com/feed/28722337)

## 安卓手机双系统（同安卓版本，不同ROM）制作

[保姆级-小米手机双系统制作教程_哔哩哔哩_bilibili](https://www.bilibili.com/video/BV133411n7QW)

根据教程，我已经成功将红米K30S刷入MIUI国际版 V12.5.8.0和Nusantara Project LTS A11并可灵活切换。Dot OS 5.2.1失败，是刷机包的问题，鉴于Dot OS开发组目前的懒狗状况也只能叹息一下了。

视频中没有提到的几点：

1. 双系统最好不要跨安卓版本，可以试试，但不推荐。
2. 一定要保留好各个时候/sdcard/rannki文件夹下的文件并归档！节省时间甚至可能用来救砖！
3. 安装双系统后OTA升级基本寄了，可以下载卡刷包在TWRP里刷入升级，不用双清。
4. 一些重定位app储存空间的app会导致失效或者系统出现严重问题。
5. 我的机出现一个系统掉基带一个不掉的问题，不清楚是不是共性问题。

## 安卓设备查看UFS闪存损耗程度（健康信息）

使用任意工具（需要ROOT）打开

`/sys/devices/platform/soc/1d84000.ufshc/health_descriptor/`

下面三个文件，其中life_time_estimation_a和life_time_estimation_b一般是相同的可视作一个量，初始健康度这两个值都应该是“0x01”。

<div>
<img alt="life_time_estimation.jpg" src="life_time_estimation.jpg" width="40%" title="This image has been scaled to 40% of its original size.">
<img alt="bPreEOLInfo.jpg" src="bPreEOLInfo.jpg" width="40%" title="This image has been scaled to 40% of its original size.">
</div>

## Windows查询校验和

```PowerShell
certutil -hashfile <文件路径> <校验算法>
```
![certutil.png](certutil.png)

certutil工具从Windows XP Professional版本之后的所有Windows上提供。

## MIUI查询电池健康

[图文分享 - 酷安](https://www.coolapk.com/feed/32766278)

## MIUI线刷降级报错MiFlash update sparse crc list failed

[MIUI12.5降级 MiFlash update sparse crc list failed 错误解决方案 sparsecrclist_哔哩哔哩_bilibili](https://www.bilibili.com/video/BV1XX4y1K79f)

## MIUI云控的一些讨论

[MIUI云控的部分说明 来自 代号10007 - 酷安](https://www.coolapk.com/feed/39260011)

MIUI云控这个事吧，我觉得没必要非得彻底干掉它，第一是完全摆脱MIUI云控唯一的办法就是不用MIUI，第二云控并不一定会限制所有应用的机能（赛马娘甚至比原生还流畅了点），第三是云控删了，温控删了，下一步可能就是主板烧了……

## 监控哪些安卓应用在内部存储空间拉屎

[媒体存储设备管理 - 防止媒体存储滥用的 Xposed 模块](https://github.com/MaterialCleaner/Media-Provider-Manager/blob/main/README_zh-CN.md)

## 解决VMware Workstation长期占用硬盘和卡顿的问题

最近（202405）VMware的Workstation Pro对个人用户免费了，我也是从Player 17切到了Workstation 17 Pro。之前使用的时候发现只要用它就会导致虚拟磁盘所在的机械硬盘占用长时间维持在100%，且虚拟机很卡；给了16G的虚拟内存，但主机的占用显示虚拟机远未占用这么多的内存；在虚拟机运行期间查看虚拟机文件夹发现有和虚拟内存一样大小的.vmem文件，于是猜测VMware应该是将内存随时转储到硬盘中了，或者是某种很恼人的swap机制。

以前使用Virtual Box和Hyper-V的时候从来没遇到过这样的问题。我的内存足够给虚拟机开这么多的虚拟内存，完全不需要VMware帮我swap到本地硬盘中。写这段之前通过搜索并编辑了VMware的配置文件.vmx解决了这个问题，不过在切换到Workstation Pro之后发现这个配置可以直接在设置中更改，下面是更改的步骤：

1. 在VMware Workstation中，打开 *“编辑 - 首选项 - 内存”* 。  
    <img alt="VMware_RAM0.png" src="VMware_RAM0.png" width="60%" title="This image has been scaled to 60% of its original size.">
2. 在“额外内存”选项块中，选中 *“调整所有虚拟机内存使其适应预留的主机 RAM”* 。
3. 对于某个虚拟机实例，打开 *虚拟机 - 设置 - 选项 - 高级 - 设置* ，勾选 *“禁用内存页面调整”* 。  
    <img alt="VMware_RAM1.png" src="VMware_RAM1.png" width="60%" title="This image has been scaled to 60% of its original size.">

这样，VMware便会在主机内存剩余空间足够的情况下，不会再将虚拟机内存转储（或swap）到主机本地硬盘中。因为我是将虚拟机虚拟硬盘放在了机械硬盘中（Windows 7也不需要很高的I/O性能），所以在原来VMware Player总是动不动就swap，导致虚拟机一直卡的不行，这下终于是解决了。

> 保留.vmx文件的配置以便备用：
```ini
MemTrimRate = "0"
sched.mem.pshare.enable = "FALSE"
sched.mem.maxmemctl = 0
MemAllowAutoScaleDown = "FALSE" 
mem.ShareScanTotal = 0
mem.ShareScanVM = 0
mem.ShareScanThreshold = 8192
mainMem.useNamedFile = "FALSE"
```

## 卸载Windows 11小组件

[doc/240119.md · 技术爬爬虾/技术爬爬虾资源汇总 - Gitee.com](https://gitee.com/tech-shrimp/me/blob/master/doc/240119.md#%E5%8D%B8%E8%BD%BD%E5%B0%8F%E7%BB%84%E4%BB%B6)

## 关闭Windows 11开始菜单的Bing网络搜索

复制以下代码，保存为.reg文件并并入到注册表中。
```re
Windows Registry Editor Version 5.00

[HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\Explorer]
"DisableSearchBoxSuggestions"=dword:00000001
```

<img alt="Windows_11_search.png" src="Windows_11_search.png" width="60%" title="This image has been scaled to 60% of its original size.">

这样开始菜单搜索就不会联网搜索了，只会显示本地相关结果。

## 跨平台的局域网间测速工具——iperf3

[iperf3测速服务器搭建和使用指南](https://www.zhihu.com/tardis/bd/art/473778492)

## 真正的跨平台性能测试工具——Geekbench 6

一直用3DMark测综合性能，但是3DMark免不了不支持Linux、Vulkan API需要的功能较多、奇怪的设备上支持较少（比如虚拟机等），Geekbench 6能支持的就比较全面支持Windows、Linux、Android、iOS等，真正的综合分数能跨平台测试的工具。而且其Vulkan API要求的功能比较少，像3DMark Wild Life就不能在树莓派4b上的安卓14运行，也不能在Bliss OS 15 Android 12L x86上运行，但Geekbench 6可以。

跨平台性能测试我主要用于测手（折）游（腾）在不同平台上的运行性能（毕竟大型PC游戏也没有比较的必要）。目前来看（粗测，Vulkan），Nvidia GeForce RTX 2060是Apple silicon A15 Bionic的5倍多，A15是Qualcomm Snapdragon 865的2倍。

[Geekbench 6 - Cross-Platform Benchmark](https://www.geekbench.com/)

## 局域网间跨平台临时数据传送，仅需浏览器

[PairDrop | Transfer Files Cross-Platform. No Setup, No Signup.](https://pairdrop.net/)

## 跳过Windows 11 OOBE时的登入微软账户需求

1.  *Shift + F10* 
2. `oobe\bypassnro`

## VMWare虚拟磁盘使用SCSI和SATA的比较

**1. 不同类型之间的互相转换**

 *“编辑虚拟机设置 - 硬件 - 添加 - 硬盘 - 下一步 - <选择虚拟硬盘类型> - 下一步 - 使用现有虚拟磁盘 - 下一步 - 现有磁盘文件 - 完成”* 

<img alt="VMware_HardDrive0.png" src="VMware_HardDrive0.png" width="60%" title="This image has been scaled to 60% of its original size.">  

**2. 同虚拟机内虚拟磁盘两种模式的比较**

虚拟机系统：Windows 7 SP1 x86_64，CrystalDiskMark 8.0.4  
实体磁盘：HGST HTS721010A9E630 1TB
测试结果：左（或上）：SATA；右（或下）：SCSI

<div>
<img alt="VMWare_SATA_VirtualDisk_(on_HDD)_CrystalDiskMark_20240522193628.png" src="VMWare_SATA_VirtualDisk_(on_HDD)_CrystalDiskMark_20240522193628.png" width="45%" title="This image has been scaled to 45% of its original size.">  
<img alt="VMWare_SCSI_VirtualDisk_(on_HDD)_CrystalDiskMark_20240521230444.png" src="VMWare_SCSI_VirtualDisk_(on_HDD)_CrystalDiskMark_20240521230444.png" width="45%" title="This image has been scaled to 45% of its original size."> 
</div>

从测试结果可见，VMWare的虚拟SCSI磁盘在顺序读取和4K效果上有优势，而在顺序写入逊于虚拟SATA磁盘。综合来说，选择虚拟SCSI磁盘在大多数常见使用场景下更好。