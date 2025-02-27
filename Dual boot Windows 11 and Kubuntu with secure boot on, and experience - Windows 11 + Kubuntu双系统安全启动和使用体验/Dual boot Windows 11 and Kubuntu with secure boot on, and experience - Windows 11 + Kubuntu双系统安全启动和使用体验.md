# Windows 11 + Kubuntu双系统安全启动和使用体验

*版本：1.1*

查看Github渲染器中的**目录**：使用Github Markdown渲染页面右上角的“目录”（⋮☰）按钮。

---

![Cover.png](Cover.png)

网络上有很多关于使Windows 10以上的Windows系统和Linux系统多重启动的文章，第一件事便是要求关闭UEFI中的安全启动功能，甚至这算作是一项必要条件。我理解很多Linux用户对于微软主导的安全启动嗤之以鼻甚至恨之入骨（见过有的Arch Linux社区问安全启动就关帖），但是吧，我认为安全启动还是有一定可取之处的。比如说我主力平台是Windows 11，而且Bitlocker对于我来说是真的有用😂。所以还是不想在关闭安全启动的情况下，希望Linux和Windows可以共存。

在之前弃过坑的，在PC上使用Manjaro Linux并尝试安全启动，在多种方式多次失败之后（超长的挫败历程），最后只能遗憾地其装进虚拟机。之前（202405）再次尝试再次失败（在联想拯救者R9000P 2020上，MokManager死活无法录入rEFInd的签名，不知道是不是主板限制）。不过听说这几年终于有Linux发行版将其引导efi文件签入了安全启动密钥库，其中就有大名鼎鼎的Ubuntu。Arch系及其衍生发行版如Manjaro Linux极度痛恨安全启动，就别想了。由于之前使用Manjaro KDE Plasma给我留下了很深的印象，我非常想要继续在KDE Plasma上的桌面体验，于是便找到了Kubuntu——默认使用KDE Plasma桌面环境的Ubuntu分支。

（本来打算5月写的，后来躺了，开学了之后课上要求必须使用Linux被强制催更……）

## 一、准备工作

本文章将在已安装Windows 11系统 + 已启用安全启动的情况下进行说明。

**检查Windows下的安全启动状态**

如果PC是购买的OEM机器，那么一般情况下默认是开启了安全启动。对于Windows 8~11，可以使用如下方法在系统内快速确定：
按 *“Windows徽标键 + R”* 或从 *“开始菜单”* 打开 *“运行”* 窗口，输入`msinfo32`，并确定，打开 *“系统信息”* 。

在打开的 *系统信息* 页面中，向下滚动，找到 *“安全启动状态”项目* ，如果 *值* 显示为 *“启用”* ，则安全启动已启用。

![Msinfo32.png](Msinfo32.png)

### 1. 下载Kubuntu镜像

进入Kubuntu官网：[Kubuntu | Friendly Computing](https://kubuntu.org/)，直接点击 *“Download Kubuntu”* 链接，网页将自动下载最新的LTS版Kubuntu。

![Kubuntu_org0.png](Kubuntu_org0.png)

在点击后自动跳转的页面中，也可以自行下载以前版本的Kubuntu。默认情况下，上一步中自动下载的镜像是本页面中最上面的镜像，其镜像校验和在卡片中的 *“Alternative downloads, torrents, mirrors and check-sums ›”* 链接中，推荐在下载后检查一下校验和。

![Kubuntu_org1.png](Kubuntu_org1.png)

### 2. 烧写启动U盘

个人推荐使用 *Rufus* 这款软件进行系统盘烧写。具体操作步骤，在之前的《[用树莓派躺床上玩PC游戏](../Playing%20PC%20games%20in%20bed%20with%20a%20Raspberry%20Pi%20-%20用树莓派躺床上玩PC游戏/Playing%20PC%20games%20in%20bed%20with%20a%20Raspberry%20Pi%20-%20用树莓派躺床上玩PC游戏.md)》文章中的 *二、1.2* 中已经介绍过，在此不再赘述。

> Rufus可能会默认以MBR分区类型进行刷写，我还是推荐更改为GPT分区类型。

### 3. 进行必要备份

由于当下任何安装现代系统的操作都涉及到对EFI分区的读写，而且在操作过程中存在误操作将全盘擦除的风险（大佬小白都有可能湿鞋），所以提前对电脑重要数据进行备份，甚至直接进行全盘备份也是必要的，给自己留后悔药。关于全盘备份，在之前的《[制作自己的Windows 7安装镜像](../Build%20your%20own%20Windows%207%20installation%20image%20-%20制作自己的Windows%207安装镜像/Build%20your%20own%20Windows%207%20installation%20image%20-%20制作自己的Windows%207安装镜像.md)》文章中的 *一、4* 中已经介绍过，在此不再赘述。

### 4. 确定有足够空余存储空间

由于要安装双系统，所以需要提前保证在本地硬盘上有一定空余空间来进行Kubuntu的安装。鉴于我个人且大部分本文章的读者（我猜）都相对于Windows更加熟悉，所以我还是推荐在Windows上对本地硬盘进行操作。

对于腾出这片空余空间，一般有（不限于）以下几种情况：
1. 空间是在一开始装机的时候就提前预留的
   ![Disk_manager.png](Disk_manager.png)
   *(我一开始是给黑苹果留的，那就更是个远古的大坑了……)*
2. 空间是通过缩小Windows系统分区得来的
3. 空间是通过缩小其他分区得来的
4. 空间是通过直接删除卷得来的
5. 空间是通过添加本地物理磁盘得来的
   
对于上面2.3.，可以使用 *“计算机管理”* 中的 *“磁盘管理”* 在对应分区上进行 *“压缩卷”* 来得到，或者推荐使用[数据恢复软件，硬盘分区工具，系统备份软件 - DiskGenius官方网站](https://www.diskgenius.cn/)来进行分区压缩。对于上面的4.，可以选择一个不再需要的分区（注意不是磁盘！），直接将其删除即可。

推荐将Kubuntu与Windows安装在同一磁盘上。即，如果你像上图一样在一台PC上连接了多个物理磁盘，假设Windows安装在**磁盘2**上，那么Kubuntu也最好安装在**磁盘2**上。如果你知道该如何编辑EFI分区以及EFI文件，则可忽略本段。

## 二、进行安装

### 1. 从启动U盘引导

请根据使用的PC主板说明，或OEM机器的说明，确认在开机时进入到默认系统前，选择其他引导媒介的快捷键。该快捷键通常会使UEFI进入到 *引导选择菜单* 。

> 例如，我所使用的开源UEFI *coreboot* 使用ESC键进入引导选择菜单，华擎主板使用F11，其他品牌也有使用F1、F2、F6、F7、F8、F10、F12等键。

在进入 *引导选择菜单* 后，选择插入的 *启动U盘* 。

<img alt="coreboot.jpeg" src="coreboot.jpeg" width="70%" title="This image has been scaled to 70% of its original size.">

另一种选择是，由于本文介绍的是Windows已经安装到电脑中的情况，也可使用已经安装在Windows系统中的 *Windows Boot Manager（Windows启动管理器）* 引导进入启动U盘。

（以Windows 11为例）在PC运行中，将 *启动U盘* 插入PC，然后点击 *“开始菜单” - “电源”*，在按住键盘上的 *“Shift键”* 的同时，点击 *电源选项* 中的 *“↺重启”*。

<img alt="Windows_Boot_Manager0.png" src="Windows_Boot_Manager0.png" width="80%" title="This image has been scaled to 80% of its original size.">  

之后Windows将进入到Windows Boot Manager页面。点击 *“使用设备”* ，

<img alt="Windows_Boot_Manager1.jpeg" src="Windows_Boot_Manager1.jpeg" width="60%" title="This image has been scaled to 60% of its original size.">

选择插入的 *启动U盘* 。

<img alt="Windows_Boot_Manager2.jpeg" src="Windows_Boot_Manager2.jpeg" width="60%" title="This image has been scaled to 60% of its original size.">

### 2. 安装Kubuntu

*（由于饶罗翔实在是太难绷了，此处选择在虚拟机上安装来方便截图。具体操作和实体机上相同，实在无法同步的点会继续饶罗翔）*

在上一步的操作之后，应该可以引导到安装U盘的GRUB界面；等待自动进入默认选项，或者使用键盘上的 *方向键* ，将高亮的选项选择到第一项 *“Try or Install Kubuntu”* ，然后按下 *回车（Enter）键* 。

![Kubuntu_install0.png](Kubuntu_install0.png)

稍等片刻，安装程序将进入GUI安装界面：

![Kubuntu_install1.png](Kubuntu_install1.png)

选择系统语言和网络连接，完成后点击 *“Install Kubuntu”* 。

> 之前有种说法是，在安装时尽量选择英语，因为一些Linux发行版在安装后会根据安装时选择的系统语言对 *主文件夹* 下的各默认用户分类文件夹使用对应的语言进行命名，如选择英语则有“Document”“Download”文件夹，选择中文则会有“文档”“下载”文件夹。一些优化或没有考虑到不同系统语言的软件可能会因为非英语用户分类文件夹名而产生问题。但就我个人近期使用经验，Manjaro Linux和Kubuntu均无这个问题；而且如果使用英文语言进行安装，则许多内置软件的中文界面包不会被系统安装程序自动安装，需要一个个地在系统安装后手动安装。因此此处的语言选项应按照具体情况选择，本文中将以 *简体中文 (中国) - Chinese (China)* 作为例子。

> 如果你可以顺畅通过网关连接到国际互联网，则我推荐在此处就连接到互联网；否则不推荐在此处联网，在系统安装完成后再联网。如果选择通过WiFi联网，点击 *“Internet Connection”* 菜单中的 *“你的WiFi SSID: Disconnected”* ，然后输入你的 *WiFi密码* ，并点击 *“Connect”* 。

>  *“Try Kubuntu”* 选项将会将此Kubuntu启动U盘作为 *“LiveCD”* 启动，进入到一个小型的、临时的Linux环境中，类似于Windows的Windows PE系统，常用于故障恢复。

进入Kubuntu安装程序界面，点击 *“下一步”* ：

![Kubuntu_install2.png](Kubuntu_install2.png)

下一步，在 *“位置”* 选项卡中，设定 *“地区”* 和 *“区域”* （也可在 *地图* 上点击）。设定 *“数字和日期地域”* ，设定语言和字符集，然后点击 *“确定”* 。

![Kubuntu_install3.png](Kubuntu_install3.png)

下一步，在 *“键盘”* 选项卡中，选择 *键盘布局* 。

![Kubuntu_install4.png](Kubuntu_install4.png)

下一步，在 *“Customize（自定义）”* 选项卡中，选择 *“Installation Mode（安装模式）”* ，推荐默认 *“Normal Installation”* 。对于 *“Additional Options（附加选项）”* 中的 *“Download and install updates following installation（在安装后下载并安装更新）”* 复选框，如果在前面连入了国际互联网，则推荐在此处勾选，否则不推荐勾选。

![Kubuntu_install5.png](Kubuntu_install5.png)

下一步，*“分区”* 选项卡，整个安装过程中最容易没有回头路的一步。

首先，在上方的 *“选择存储器”下拉菜单* 中选择要安装Kubuntu的正确的本地磁盘，如果在上面的 *一、准备工作* 中已经留出了空余空间，那么应该在此处能够在下面的 *分区表条状图* 中看到预留的空余磁盘空间。若是，选择上方的 *“取代一个分区”* 选项，并点击下方 *选择要安装到的分区 - 当前* 条状图中的 *（灰色）空闲空间* 条。在 *之后* 条状图中， *（红色）Kubuntu_2404* 即为Kubuntu安装后应该装载到的分区。

![Kubuntu_install6.jpeg](Kubuntu_install6.jpeg)

> 在选中 *“取代一个分区”* 选项后，其下方应该出现一个下拉菜单，选择分区文件系统。一般情况下默认的ext4即可。

> 如果选中下方 *“取代一个分区”* 选项上面的 *“加密系统”* 复选框，则会使得安装后的Kubuntu系统分区被LUKS加密。这个加密类似于Windows下的Bitlocker，执行全盘加密，通过提供有效密钥来进行解密，不同的是Bitlocker在TPM下可以通过验证Windows管理员账户密钥来进行解密。Android中的User分区加密类似。

> 由于已经安装了Windows，所以PC上应已存在现有的EFI分区。该分区将会被Kubuntu自动识别，显示为最下方的 *“...处的 EFI 系统分区将被用来启动 Kubuntu”*。 

下一步，在 *“用户”* 选项卡中，输入 *“您的姓名？”“您想要使用的登陆用户名是？”“计算机名称为？”“选择一个密码来保证您的账户安全。”* 。

![Kubuntu_install7.png](Kubuntu_install7.png)

> 极不推荐密码留空，即使勾选 *“不询问密码自动登录”*。

下一步，在 *“摘要”* 选项卡中，最后检查一下各项设置，尤其是 *“分区”* 项是否正确。

![Kubuntu_install8.png](Kubuntu_install8.png)  
*（这是虚拟机上的截图，和实机不符，仅作参考）*

检查无误后，点击 *“▶️⬇️安装”* 按钮，在弹出的 *“继续安装？”* 窗口中，点击 *“现在开始安装”* ，进行正式安装。

![Kubuntu_install9.png](Kubuntu_install9.png)  

> 如果未连接到国际互联网，且在前面勾选了 *“Download and install updates following installation”* 复选框，则这一步可能将等待极长时间。

之后安装完成，在 *“结束”* 选项卡中保持默认勾选的 *“现在重启”* 复选框，点击 *“完成”* 按钮，自此Windows + Kubuntu双系统正式完成安装。之后还需要进行一些设置，不过起码U盘不用一直插着了。

![Kubuntu_install10.png](Kubuntu_install10.png)  

> 若在重启过程中出现 *“Please remove the installation medium, then press ENTER:”* 字样，拔下 *启动U盘* 并按 *回车（Enter）* 键。*（在虚拟机上又忘截图了，淦）*

重启并登录后，即可进入Kubuntu的OOBE页面：

![Kubuntu_install11.png](Kubuntu_install11.png)  
*（虚拟机截完图就可以删了，哦耶）*

## 三、正式使用前的一些设置

以下操作均非必须，仅按个人需求说明。

### 1. 安装Chrome浏览器

由于这篇文章是在另一台Windows PC上用VS Code写的，我习惯使用[PairDrop | Transfer Files Cross-Platform. No Setup, No Signup.](https://pairdrop.net/)来通过网页在局域网中传输少量数据，这就必须要先经过网络浏览器，我还是惯用自己习惯的浏览器。

KDE官方应用市场（[Discover 软件管理中心 - KDE 应用程序](https://apps.kde.org/zh-cn/discover/)）在未添加第三方软件源时，未提供Google Chrome浏览器。不过，可以先通过Chrome浏览器官网安装.deb包的形式来安装。

首先，下载Chrome浏览器：
[Google Chrome - 快速安全的网络浏览器，专为您而打造](https://www.google.com/chrome/)，进入官网后，点击 *“下载 Chrome”* ，然后在弹出的控件中保持默认选项 *“64 位 .deb （适用于 Debian/Ubuntu）”* ，然后点击 *“接受并安装”* 。 

![Chrome_deb0.png](Chrome_deb0.png)

在 *Dolphin 文件管理器* 中定位到 *“下载（Download）”* 文件夹，找到下载的`google-chrome-stable_current_amd64.deb`文件，在其上 *右键 - 打开方式 - Discover 软件管理中心* ，使用 *Discover 软件管理中心* 打开该软件包。

<img alt="Chrome_deb1.png" src="Chrome_deb1.png" width="80%" title="This image has been scaled to 80% of its original size.">

> *Discover 软件管理中心* 可以自动解决.deb软件包的依赖问题。

在打开的 *Discover 软件管理中心* 页面中，点击右上角的 *“⬇️安装”* 按钮，在弹出的 *“需要进行身份验证 — PolicyKit1 KDE 代理程序”* 窗口中，输入在安装Ubuntu时的账户密码 *（以下统称 *“账户密码”* ）* ，然后点击 *“确定”* 按钮。

![Chrome_deb2.png](Chrome_deb2.png)

等待Discover安装Chrome软件包即可。在启动Chrome浏览器后，可能会先弹出以下的 *“KDE 密码库服务”* 弹窗：

<img alt="Chrome_deb3.png" src="Chrome_deb3.png" width="50%" title="This image has been scaled to 50% of its original size.">

一开始没太搞明白这个密码库是干啥的，一直放着没管，结果有一次重启之后发现开启Chrome不再弹出这个窗口，而是直接询问密码库密码。试着输入了 *账户密码* ，结果就通过了，怀疑是Chrome直接创建了一个以blowfish方式加密、使用 *账户密码* 作为密钥的密码库？

### 2. 调整主题、字体DPI、桌面缩放、夜间模式

**2.1 调整全局主题**

依次打开 *“应用程序启动器 - 设置 - 系统设置”* ，进入 *系统设置* 。点击左侧栏的 *“外观”* ，进入 *外观设置* 。在默认进入的 *“全局主题”* 设置项中，选择一个自己偏好的全局主题，此处以 *“Breeze 微风深色”* 为例。点击 *“Breeze 微风深色”* ，在弹出的 *“应用...吗？”* 窗口中，依喜好勾选自定义选项，并点击 *“确定”* 按钮。

![KDE_settings0.png](KDE_settings0.png)

**2.2 调整字体DPI（可选）**

DPI（Dots Per Inch，每英寸点数）是指每一英寸长度中，取样或可显示或输出点的数目。对于显示器，这个值应被定义为PPI（Pixels Per Inch，每英寸像素数）。

$$PPI = \frac{\sqrt{像素宽度（个）^2 + 像素高度（个）^2}}{屏幕斜对角长度（英寸）}$$

例如我的笔记本屏幕为1920*1080像素，15.6英寸，则结果为PPI=141.2。[DPI Calculator / PPI Calculator](https://www.sven.de/dpi/)这个网站可以快速计算出屏幕PPI。

调整显示DPI与屏幕PPI相同有助于系统显示字体更加清晰、渲染更加精确，但同时也会因为字体大小调整而带来整体UI比例上的变化。因此这一项调整是非必要的。**如果仅是想要调整字体大小或者调整UI缩放大小，请不要调整此项。字体DPI设置和UI缩放会互相覆盖。**

在 *系统设置* 中点击左侧栏的 *“外观”* ，进入 *外观设置* 。点击 *“字体”* ，在右侧的 *“字体”* 设置页面中，勾选 *“固定字体 DPI”* 并输入要设定的DPI值。

![KDE_settings9.png](KDE_settings9.png)

**2.3 调整桌面缩放**

**如果上一步中调整了DPI，则这一步将覆盖上一步的操作。**  
在 *系统设置* 中点击左侧栏的 *“硬件 - 显卡与显示器”* ，进入 *显卡与显示器设置* 。点击 *“显示器配置”* ，在右侧的 *“全局缩放率”* 中，调整自己偏好的缩放倍率，然后点击 *“应用”* 按钮。与Windows下调整桌面缩放类似，在更改缩放倍率后，需要 *注销并重新登录* 或 *重启* 。

![KDE_settings1.png](KDE_settings1.png)

**2.4 启用夜间模式**

在 *系统设置* 中点击左侧栏的 *“硬件 - 显卡与显示器”* ，进入 *显卡与显示器设置* 。点击 *“夜间颜色”* ，在右侧的 *“夜间颜色”* 设置中，依喜好调整，然后点击 *“应用”* 按钮。

![KDE_settings2.png](KDE_settings2.png)

### 3. 安装与更改字体

**3.1 安装字体**

&ensp;&ensp;&ensp;&ensp;**3.1.a 从文件安装字体**

许多Linux发行版使用的默认系统字体“Noto Sans”，在显示中文上，会使得字体偏窄（我都怀疑Noto Sans中是否包含有中文字体，当显示中文时是不是找的缺省字体代替了）。因此当使用中文作为系统语言时，替换系统字体还是蛮必要的。

虽然KDE官方提供了在线字体库，可以直接在系统设置内下载，但我搜了一下我喜欢的两款开源字体：“Fira Code”和“更纱黑体”都没有……因此还是从第三方下载吧。

本文以 *“更纱黑体”* 为例：进入 *“更纱黑体”* 仓库：[be5invis/Sarasa-Gothic: Sarasa Gothic / 更纱黑体 / 更紗黑體 / 更紗ゴシック / 사라사 고딕](https://github.com/be5invis/Sarasa-Gothic)，在 *“Release”* 中选择偏好的字体包下载（给选择困难的人：作为系统字体，下载`SarasaUiSC-TTF-x.x.xx.7z`）。

下载后解压到单独的文件夹，例如`/home/user/Downloads/SarasaUiSC-TTF-1.0.20/`。

在 *系统设置* 中点击左侧栏的 *“外观”* ，进入 *外观设置* 。点击 *“字体管理”* ，在右侧的 *“字体管理”* 设置页面中，点击 *“从文件安装”* 按钮。

![KDE_settings3.png](KDE_settings3.png)

在打开的 *“打开文件”* 窗口中导航到刚才解压的文件夹中，全选所有 *字体文件* ，然后点击 *“打开”* 按钮。

![KDE_settings4.png](KDE_settings4.png)

之后会弹出 *“安装位置 - 系统设置”* 窗口，选择 *“用户字体”* ——为当前用户安装字体，或是 *“系统字体”* ——使所有已存在和将来新建的用户都可以使用这些字体。如果选择 *“系统字体”* ，则需要在弹出的 *“需要进行身份验证 — PolicyKit1 KDE 代理程序”* 窗口中，输入 *“账户密码”* ，然后点击 *“确定”* 按钮。

<img alt="KDE_settings5.png" src="KDE_settings5.png" width="60%" title="This image has been scaled to 60% of its original size.">

安装完成后，在之前的 *“字体管理”* 设置页面的上方 *搜索栏* 中，输入 *“sarasa”* ，就可以搜索到刚才安装的字体。

![KDE_settings6.png](KDE_settings6.png)

&ensp;&ensp;&ensp;&ensp;**3.1.b 使用APT安装字体**

其实没想这么早就进入到命令行内容的，毕竟对于想从Windows丝滑过渡到Windows的新人来说，最劝退的一步就是命令行了。但说实在，Windows和Mac可能还好，但日用Linux不可能绕得过命令行，只不过是早晚的事。之前看过 *LinusTechTips* 的日用Linux代替Windows的视频，他要是把“CLI Warning”写在片头，那完播率估计只有现在的一半。

有些字体被收录到Ubuntu的官方软件仓库中，如我喜欢用的[tonsky/FiraCode: Free monospaced font with programming ligatures](https://github.com/tonsky/FiraCode)。这种收录到库中的字体，会有自动脚本帮助用户下载并安装到系统中，仅需一条命令即可。

依次打开 *“应用程序启动器 - 系统 - Konsole 命令行终端”* ，或者按下 *“Ctrl + Alt + T”* 进入 *Konsole（以下称“终端”）* 。

<img alt="KDE_settings12.png" src="KDE_settings12.png" width="60%" title="This image has been scaled to 60% of its original size.">

首先，查找你想要用的开源字体是否在软件仓库中；输入以下命令：

```Shell
apt list | grep <关键字>
```

在本例中，输入`apt list | grep fira`，按 *“回车（Enter）键”* 执行：

![KDE_settings13.png](KDE_settings13.png)

从返回的结果来看，我们要找的字体包名为`fonts-firacode`。

在 *“终端”* 中继续输入以下命令：

```Shell
sudo apt install <字体包名>
```

在本例中，输入`sudo apt install fonts-firacode`，按 *“回车（Enter）键”* 执行：

![KDE_settings14.png](KDE_settings14.png)

由于`apt install`是高权限操作（类似于在Windows Vista及以后的Windows中，向`%ProgramFiles%`和`%ProgramFiles(x86)%`中安装软件，默认情况下需要通过UAC管理员批准），该命令需要 *超级管理员* 权限批准。`sudo`是实现该批准的一种方法，在命令或批处理脚本前加入此命令字段可以使之后的操作获得 *超级管理员* 批准。注意：在一个 *终端会话* 中第一次使用该命令，则该命令要求提供 *当前用户* 的 *账户密码* 。**该密码在 *“终端”* 中输入时不会显示任何字符，包括“*（星号）”。** 在盲输完成后，按 *“回车（Enter）键”* 确定。

<img alt="KDE_settings15.png" src="KDE_settings15.png" width="60%" title="This image has been scaled to 60% of its original size.">  

*（再次打开 *“字体管理”* 设置页面，可以查找到刚才安装的字体。）*

**3.2 更改系统字体**

在 *系统设置* 中点击左侧栏的 *“外观”* ，进入 *外观设置* 。点击 *“字体”* ，在右侧的 *“字体”* 设置页面中，点击 *“调整所有字体…”* 按钮。

![KDE_settings7.png](KDE_settings7.png)

在弹出的 *“选择字体”* 窗口中，先勾选 *“字体”* 复选框，然后在下方选择自己偏好的字体，然后点击 *“确定”* 按钮。这里调整的字体，如果是等宽字体，则将影响上图中的所有系统字体；如果不是等宽字体，则将影响上图中除了 *固定宽度（等宽）* 以外的所有系统字体。

<img alt="KDE_settings8.png" src="KDE_settings8.png" width="60%" title="This image has been scaled to 60% of its original size.">

> 不建议在此处更改字体大小。如果觉得显示字体小，请在 *上一小节（2.2、2.3）* 中调整字体API和桌面缩放。

**3.3 字体微调（可选）**

上图的上图中蓝色框中的下拉菜单 *“微调”* ，类似于Windows中的ClearType（[Microsoft ClearType - Typography | Microsoft Learn](https://learn.microsoft.com/zh-cn/typography/cleartype/)）：通过微调字体在液晶显示屏上的对齐方式，使得字体可以渲染地更加清晰。这是一项纯靠体验改变的选项——即调成什么样，效果好不好全凭个人感觉。选择你认为清晰的一项，然后点击 *“应用”* 按钮。

### 4. 开机NumLock状态、更改光标和滚轮速度

**4.1 调整开机NumLock状态**

在 *系统设置* 中点击左侧栏的 *“输入设备 - 键盘”* ，在右侧的 *“键盘”* 设置页面中，选择 *“硬件”* 选项卡，调整 *“NumLock 在 Plasma 启动时的状态”* 选项，然后点击 *“应用”* 按钮。

![KDE_settings10.png](KDE_settings10.png)

> 如果发现在登录屏幕时，NumLock状态与此处设置不同步，可参照本大节下方的 *16.* 。

**4.2 更改光标速度**

在 *系统设置* 中点击左侧栏的 *“输入设备 - 鼠标”* ，在右侧的 *“鼠标”* 设置页面中，调整 *“光标速度”* 选项，然后点击 *“应用”* 按钮。

![KDE_settings11.png](KDE_settings11.png)

**4.3 更改滚轮速度**

本来是某次启动后滚轮速度变得很慢，先在此处标记待后面修复再来记录，结果重启了一下又好了，emm……

### 5. 任务栏与应用程序启动器的操作与设置

**5.1 搜索控制**

在 *系统设置* 中点击左侧栏的 *“工作区 - 搜索 - 文件搜索”* ，在右侧的 *“文件搜索”* 设置页面中，依需求勾选 *“启用文件搜索”* 选项，然后点击 *“应用”* 按钮。

![KDE_settings16.png](KDE_settings16.png)

在 *系统设置* 中点击左侧栏的 *“工作区 - 搜索 - Plasma 搜索”* ，在右侧的 *“Plasma 搜索”* 设置页面中，去掉勾选 *“书签”“浏览器历史记录”“浏览器标签页”“网络搜索关键词”* 复选框，依需求勾选 *“软件中心”* 复选框，然后点击 *“应用”* 按钮。

![KDE_settings17.png](KDE_settings17.png)

<img alt="KDE_settings18.png" src="KDE_settings18.png" width="60%" title="This image has been scaled to 60% of its original size.">  

**5.2 固定项目到图标任务管理器**

> 为避免与屏幕下方的整条 *任务栏* 相混淆，此处使用专有名词 *图标任务管理器* 来指代 *任务栏* 中显示窗口任务图标的这一组件。  
> ![KDE_settings78.png](KDE_settings78.png)

&ensp;&ensp;&ensp;&ensp;**5.2.a 通过图标任务管理器添加**

对于 *图标任务管理器* 上已经固定的项目，在其 *图标* 上 *右键 - 取消固定到任务栏* ，可以使其不再固定到 *图标任务管理器* 上。对于没有固定到 *图标任务管理器* 的项目，在其 *图标* 上 *右键 - 固定到任务栏* ，可以使其固定到 *图标任务管理器* 上。

<img alt="KDE_settings19.png" src="KDE_settings19.png" width="40%" title="This image has been scaled to 40% of its original size.">  

&ensp;&ensp;&ensp;&ensp;**5.2.b 通过应用程序启动器添加**

对于没有出现在 *图标任务管理器* 上但存在于 *应用程序启动器* 的应用，可以在 *应用程序启动器* 中的应用上 *右键 - 固定到任务管理器* 来固定到 *图标任务管理器* 上。

<img alt="KDE_settings79.png" src="KDE_settings79.png" width="80%" title="This image has been scaled to 80% of its original size."> 

**5.3 调整任务栏高度**

在 *任务栏* 上的空白位置上 *右键 - 进入编辑模式* ，在弹出的 *浮动任务栏与配置面板* 上，调整 *“面板高度”* 到你偏好的高度，然后按 *退出（ESC）* 键或按屏幕最上方的 *红叉❌* 。

![KDE_settings20.png](KDE_settings20.png)  

**5.4 调整系统托盘图标可见性**

点击 *任务栏* 上的 *系统托盘* 中的 *^（显示隐藏的图标）* 按钮，在弹出的 *状态和通知* 面板上，点击右上角的 *“配置系统托盘…”* 按钮。在弹出的 *系统托盘 设置* 窗口上，点击左侧栏中的 *“项目”* ，调整右侧 *“项目”* 面板中各图标的 *可见性* 设置。最后，点击 *“确定”* 按钮。

![KDE_settings21.png](KDE_settings21.png)  

> 点击 *“应用”* 按钮保存当前设置但不退出 *系统托盘 设置* 面板；点击 *“确定”* 按钮保存当前设置并退出 *系统托盘 设置* 面板。

&ensp;&ensp;&ensp;&ensp;**5.4.a 打开系统托盘上的天气报告小组件（可选）**

在本步中的 *系统托盘 设置 - 项目* 面板上，滚动到列表下方，找到 *“其他 - 天气报告”* ，调整其 *可见性* 设置为 *“有作用时显示”* 或 *“总是显示”* ，然后点击 *“确定”* 按钮。

<img alt="KDE_settings22.png" src="KDE_settings22.png" width="60%" title="This image has been scaled to 60% of its original size.">  

此时， *“天气报告”* 小组件应该显示到 *系统托盘* 上了。点击 *“天气报告”* 小组件图标，在弹出的 *“天气报告”* 小组件面板中，点击 *“设置位置…”* 或者右上角的 *“配置天气报告…”* 按钮，在弹出的 *“天气报告 设置”* 窗口中，选中左侧栏中的 *“气象站”* 按钮，在右侧的 *“气象站”* 面板中，在 *“搜索位置”* 搜索框中输入你想要搜索的城市名（英文），然后选择下方搜索结果中符合你想要搜索的城市，然后点击 *“确定”* 按钮。

![KDE_settings23.png](KDE_settings23.png)  

设置成功后的 *“天气报告”* 小组件：

<img alt="KDE_settings24.png" src="KDE_settings24.png" width="40%" title="This image has been scaled to 40% of its original size.">  

**5.5 调整数字时间小组件**

在 *任务栏* 上的 *系统托盘* 右边的 *数字时钟* 小组件上右键，选择 *“配置数字时钟…”* ；或在其上点击，在弹出的 *事件及日历* 面板上，点击右上角的 *“配置数字时钟…”* 按钮。在弹出的 *数字时钟 设置* 窗口上，点击左侧栏中的 *“外观”* 。调整右侧 *“外观”* 面板中的 *时间显示方式：* 为你偏好的方式； *“日期格式：”* 为你偏好的方式。如果下拉菜单提供的三种日期格式都不适合，可以选择 *“自定义”* 选项，参照下方的 *“[时间格式文档](https://doc.qt.io/qt-5/qml-qtqml-qt.html#formatDateTime-method)”* 来调整。

![KDE_settings25.png](KDE_settings25.png)  

点击左侧栏中的 *“日历”* ，调整右侧面板中的 *可用插件：* 为你偏好的日历插件（ *“天文事件”* 主要为月相）； *“特定文化日历”* 为你偏好的历法； *“节假日”* 中，缺省情况下为当前系统语言设置中的区域的节假日，如果需要修改，勾选 *“节假日”* 面板列表中的节假日区域。最后，点击 *“确定”* 按钮。

<img alt="KDE_settings26.png" src="KDE_settings26.png" width="70%" title="This image has been scaled to 70% of its original size.">  

<img alt="KDE_settings27.png" src="KDE_settings27.png" width="70%" title="This image has been scaled to 70% of its original size.">  

### 6. 区域和语言设置

在 *系统设置* 中点击左侧栏的 *“个性化 - 语言和区域设置 - 区域和语言”* ，在右侧的 *“区域和语言”* 设置页面中，依需求修改语言和各项标准设置。如需修改，点击要修改的项目右侧的 *“修改…”* 按钮。最后，点击 *“确定”* 按钮。

![KDE_settings28.png](KDE_settings28.png)  

以 *“货币”* 为例，在弹出的窗口中，在搜索栏中搜索区域关键字，然后在下方的搜索结果中选择需要设定为的标准，然后，点击 *“确定”* 按钮。

<img alt="KDE_settings29.png" src="KDE_settings29.png" width="70%" title="This image has been scaled to 70% of its original size.">  

> 如果在重启之后一些软件界面的语言改变为了非之前设置的系统语言，可能是系统语言被区域设置脚本自动重置为了区域语言。重新进入 *“区域和语言设置”* 并修改系统语言即可。

### 7. 认证网络与证书设置（可选）

**本节并不适用于所有人。如果你仅连接家用网络，则可以忽略本节。**

有时需要连接一些需要账户认证才能连接的网络，比如学校、工作场所、公共场所等。这些场所有时需要输入可认证的账户密码才能够通过网关认证，在Windows、Mac、Android和iOS设备上连接时，这些设备往往会自动判断并提示用户输入账户和密码，或是打开网关认证网页。而对于一些Linux发行版，则没有提供类似的功能，需要用户手动设置；很不幸，Kubuntu就是其中之一。在连接到这些网络之前，可以先搜索该网络所属机构或场所的说明，如搜索关键字`<机构或场所名>+WiFi+Linux`，或`<机构或场所WiFi品牌名>+Linux`，下面是一个示例结果：

<img alt="KDE_settings31.png" src="KDE_settings31.png" width="70%" title="This image has been scaled to 70% of its original size.">  

在 *系统设置* 中点击左侧栏的 *“网络 - 连接”* ，在右侧的 *“连接”* 设置页面中，选择要账户认证的WiFi网络。按说明修改各项设置，并输入账户和密码。最后，点击 *“应用”* 按钮。

![KDE_settings32.png](KDE_settings32.png)  

证书设置

![KDE_settings33.png](KDE_settings33.png)  

### 8. 调整电源计划和锁屏超时

**8.1 调整电源计划**

还在为了上课/开会的时候，笔记本没隔几分钟就黑屏睡眠，还总是要动不动就碰一下鼠标要它保持亮屏而苦恼吗，现在就是改变的时刻，去调整电源计划吧！

在 *系统设置* 中点击左侧栏的 *“硬件 - 电源管理 - 省电功能”* ，在右侧的 *“省电功能”* 设置页面中，点击 *“交流供电”* 和 *“电池供电”（对于笔记本用户）* 选项卡，对相应的情况进行电源计划设置。 *（这里的 *“省电设置”* 应为 *“电源计划”* ，因为我没看到哪里有电源计划任务，也没见过情景模式，而且这里的电源计划仅由主供电方式切换触发）* 只有勾选了复选框的项目会在主供电方式切换时被自动调整，如果项目没有被勾选，则其保持不变。

![KDE_settings34.png](KDE_settings34.png)  

>  *“键盘背光”* 和 *“屏幕亮度”* 两项仅影响切换时，并不是持久性设置。假设从电池供电切换到外置电源供电时因电源计划设置而自动将屏幕亮度调整为了50%，则之后仍可以由用户手动调整到其他值。这两项不是固定不可变的。

**8.2 调整锁屏超时**

在 *系统设置* 中点击左侧栏的 *“工作区 - 工作区行为 - 锁屏”* ，在右侧的 *“锁屏”* 设置页面中，更改 *“自动锁定屏幕：”* 和 *“锁屏多久后需要密码解锁：”* 。最后，点击 *“应用”* 按钮。

![KDE_settings37.png](KDE_settings37.png)  

### 9. Kubuntu驱动的安装与显卡驱动的验证

**9.1 安装驱动**

一般情况下，Ubuntu及其衍生发行版会在系统安装时自动检测和安装驱动，但这些驱动仅限 **开源驱动** ，一些非开源的专利驱动不会被安装（常见的就是 *Nvidia显卡驱动* ）。如果要使这些硬件发挥最大作用，可以使用 *“驱动管理器”* 下载非Ubuntu软件源的驱动并安装。

在 *系统设置* 中点击左侧栏的 *“硬件 - 驱动管理器”* ，一般情况下，会自动弹出 *“以 root 运行”* 窗口；若没有，点击 *“驱动管理器”* 设置页面中的 *“重新打开驱动管理器”* 按钮。在 *“以 root 运行”* 窗口中的 *“密码：”* 密码框中输入 *“账户密码”* ，然后点击 *“确定”* 按钮。在弹出的 *“驱动管理器”* 窗口中，点击 *“Additional Drivers”* 选项卡，在下方的页面中应该会显示可供选装的第三方（非Ubuntu软件源）驱动，如专利驱动等。

![KDE_settings35.png](KDE_settings35.png)  

对于 *Nvidia显卡* ，如果偏好开源驱动，则选择 *Nouveau* 驱动，这也是Ubuntu系发行版默认的 *Nvidia显卡驱动* ，完全开源，但性能远逊于专利驱动；如果偏好英伟达专利驱动，下面是 *ChatGPT 4o* 给出的各不同后缀解释：

![KDE_settings83.png](KDE_settings83.png)  

勾选偏好的驱动的单选框，然后点击 *“Apply Changes”* 按钮， *“驱动管理器”* 会自动下载并安装驱动，并在安装完成后要求重新启动。重启后，再次打开 *“驱动管理器”* ，可以看到 *“驱动管理器”* 提示的是否安装了推荐的驱动（ *“This device is using the recommended driver.”* ）和已安装的专利驱动的数量（ *“\* proprietary driver(s) in use.”* ）。

如果在此处没有你想要找的驱动，有以下几种情况：

1. 你电脑上不存在非开源驱动涉及到的硬件。比如对于显卡来说，Intel、AMD官方均为Linux提供了开源驱动，所以如果你使用的这两个提供商提供的显卡（集成显卡、独立显卡），那么Ubuntu软件源中应该已经提供了能够很好支持的开源驱动。
2.  *驱动管理器* 无法检测到你想要找的硬件。比如我手上这台Chromebook的声卡驱动。这种情况就只能搜索解决方案了。
3.  *软件源* 中没有涵盖你想要找的硬件，或网络连通性问题。对于前者，如果你知道其他软件源，或者你的硬件提供商提供了第三方软件源，可以在 *“驱动管理器”* 窗口中，点击 *“Other Software”* 选项卡，点击左下角的 *“Add...”* 按钮，在弹出的 *“Add APT repository”* 窗口中，输入第三方软件源命令行，然后点击 *“确定”* 按钮。对于后者，尝试改变网络环境。  
   <img alt="KDE_settings36.png" src="KDE_settings36.png" width="50%" title="This image has been scaled to 50% of its original size.">  

如果以上都无法解决你的问题，那可能需要手动安装驱动，从硬件提供商或者网络上的其他资源来安装。

**9.2 验证显卡驱动正确安装**

&ensp;&ensp;&ensp;&ensp;**9.2.a 通过图形实际表现粗略验证**

与在Windows上验证图形驱动表现类似，一个在安装了满足基础使用要求的驱动的系统中，应该有以下表现：

1. 系统能够自动探测到显示器的最大物理分辨率支持、最大刷新率支持
2. 系统UI，如展开和关闭 *开始菜单* / *应用程序启动器* 、拖动窗口等不会出现卡顿和延迟
3. 可以在理论性能上流畅运行对图形性能有一定需求的应用，如播放高码率视频；或使用DirectX/Vulkan/OpenGL等高性能图形API的程序，如游戏

如果显卡驱动被正确安装，那么上面三条应该被满足；但满足了上面三条要求并不一定说明显卡驱动安装了最佳的版本。如果要进一步验证（或者直接跳过粗略验证），可以使用下面的方式。

&ensp;&ensp;&ensp;&ensp;**9.2.b 通过驱动信息以及性能测试工具验证**

为了查看详细的驱动信息，可以安装 *hwinfo* 和 *inxi* 。两个工具的介绍、下载、安装位于另一篇文章[Linux下的个人偏好应用的安装和使用体验，以及运行Windows应用](../Installation%20and%20experience%20of%20personal%20preference%20applications%20under%20Linux%20-%20Linux下的个人偏好应用的安装和使用体验/Installation%20and%20experience%20of%20personal%20preference%20applications%20under%20Linux%20-%20Linux下的个人偏好应用的安装和使用体验.md)的 *二、3.* 。

以我使用的 *Intel Xe Graphics (80EU)* 集成显卡为例：

在 *“终端”* 中输入以下命令并执行：

```Shell
hwinfo --gfxcard
inxi -G
```

在 *hwinfo* 输出的结果中，查找`Driver Info #?:`部分。对于Intel显卡，若显卡驱动被正确安装，则必定有一个存在`i915 is active`的行。

在 *inxi* 输出的结果中，查找`API:`部分。对于任何显卡，若显卡驱动被正确安装，则其`drivers:`或`renderer:`属性下应存在驱动/渲染器名称。

<img alt="KDE_settings80.png" src="KDE_settings80.png" width="80%" title="This image has been scaled to 80% of its original size.">  

> Intel将其在Linux上的开源驱动程序统称为 *“i915”* 。详情可见[Intel - Gentoo Wiki](https://wiki.gentoo.org/wiki/Intel/zh-cn)。

> 在 *inxi* `API:`部分输出的结果中显示`N/A`并不一定是该驱动没有被安装，也有可能是该API的驱动未被 *inxi* 检测到。本例在下面的 *六、1.* 中有更多信息。

对于 *英伟达* 显卡，则此处会变得更复杂一些，也是我为什么在上一小子节中说 *“并不一定说明显卡驱动安装了最佳的版本。”* 英伟达驱动由于不开源的原因，其官方驱动适配只能由 *英伟达* 官方提供，该适配效果也只能由官方保证；这意味着，如果 *英伟达* 不愿意提供广泛而强劲的适配，开源社区对此毫无办法——开源社区无法探知驱动的代码，便也无法探知其中出现的问题以及帮助开发解决方案；即使能够逆向到代码，也将面临 *英伟达* 的法律诉讼。即使是 *英伟达* 官方也在其[下载 NVIDIA 官方驱动 | NVIDIA](https://www.nvidia.cn/drivers/lookup/)中指出（2024年10月）：

![KDE_settings81.png](KDE_settings81.png) 

因此， *英伟达* 显卡在Linux上的驱动，社区完全开源/社区半开源/官方闭源/移植等版本的驱动性能表现各异，问题也各异，换句话说就算上面的两中方法都验证成功，也不能说明就是安装了那个性能最好的、问题最少的、兼容性最强的 *英伟达* 显卡驱动。

### 10. 拼音输入法设置

在 *系统设置* 中点击左侧栏的 *“个性化 - 区域和语言设置 - 输入法”* ，在右侧的 *“输入法”* 设置页面中，点击列表中的 *“输入法开启 - Pinyin - 配置”* 按钮。

![KDE_settings38.png](KDE_settings38.png) 

不知道是设置里的哪步出问题了（估计是区域设置），我这里的输入法设置界面只有英文。如果需要详细设置说明，还请另寻他处吧😂。

~~img alt="KDE_settings39.png" src="KDE_settings39.png" width="60%" title="This image has been scaled to 60% of its original size."~~   

20241116更新：在 *Fcitx 5* 更新一次之后，中文界面回来了，但是服务无法开机自启。

解决办法：

在 *系统设置* 中点击左侧栏的 *“工作区 - 开机与关机 - 自动启动”* ，在右侧的 *“自动启动”* 设置页面中，点击下方的 *“＋添加…”* 按钮，然后在弹出的菜单中选择 *“＋添加应用程序…”* 项。在弹出的 *“选择应用程序”* 窗口中，展开下方的列表中的 *“工具”* 项，选中 *“Fcitx 5”* ，然后点击 *“确定”* 按钮。此时 *“自动启动”* 设置页面内的列表中应该会出现 *“应用 - Fcitx 5”* 。

![KDE_settings39.png](KDE_settings39.png) 

**更改切换输入法热键** ：如果你也像我一样苦恼于默认的更改切换输入法热键 *Ctrl + 空格键（Space）* 与一些IDE的代码提示热键相冲，又不想改变IDE的热键，那么可以更改切换输入法的热键。在上一步中的 *“输入法”* 设置页面中，点击下方的 *“配置全局选项…”* 按钮，在 *“全局选项”* 面板中，点击 *Hotkeys（热键设置） - Trigger Input Method:（切换输入法：）* 后面的 *快捷键选择框* ，点击后，在键盘上按下你想要用来设置的快捷（组合）键。如我设置成和Windows下 *切换输入语言* 的热键相同： *Windows徽标键 + 空格键（Space）* ，在Linux下， *Windows徽标键* 被定义为 *超级（Super）键* 或 *元（Meta）键* 。

![KDE_settings72.png](KDE_settings72.png) 

**更改Fcitx5输入面板主题** ：还是在 *“输入法”* 设置页面中，点击下方的 *“配置附加组件…”* 按钮，在 *“附加组件”* 面板中，点击下方列表中的 *界面 - Classic User Interface（经典用户界面）* 右方的 *配置* 按钮。在打开的 *Classic User Interface* 面板中，调整 *“Font:（字体：）”“Menu Font:（菜单字体：）”“Tray Font:（托盘字体：）”* 三个字体选项。如果你觉得输入面板字体较小，那么适当在此处调整字体大小。字体设置下方的 *“Prefer Text Icon:（偏好文字图示：）”* 的作用是使托盘处的输入法指示图标从 *“⌨️ - ☐拼”* 变为 *“en - 拼”* 。再下方， *“Theme:（亮色主题：）”“Dark Theme:（暗色主题：）”* 右侧的下拉菜单中可以分别选择输入面板的亮色和暗色主题； *“Follow system light/dark color scheme:（跟随系统亮/暗色样式）”* 复选框则可以使输入面板的亮/暗色主题跟随系统亮/暗色主题。

![KDE_settings73.png](KDE_settings73.png) 

> *Classic User Interface* 面板下方的 *“Force font DPI on Wayland:（在Wayland中使用强制字体DPI：）”* 功能无效，我只能调字体大小来改变输入面板样式的大小。

<img alt="KDE_settings74.png" src="KDE_settings74.png" width="60%" title="This image has been scaled to 60% of its original size."> 

如果想要安装 **第三方输入法**，可以阅读这篇文章：[再也不用为中文输入法而烦恼了 - 四叶草](https://www.fkxxyz.com/d/cloverpinyin/)，或者这个Github仓库：[iDvel/rime-ice: Rime 配置：雾凇拼音 | 长期维护的简体词库](https://github.com/iDvel/rime-ice)。

### 11. 安装、更新和卸载应用；系统更新

**11.1 使用Discover 软件管理中心安装、更新、卸载应用**

 *（ *Discover 软件管理中心* 中只能管理那些被软件中心收录的应用，且其无法直接管理这些应用的插件与依赖包。）* 

&ensp;&ensp;&ensp;&ensp;**11.1.a 安装应用**

依次打开 *“应用程序启动器 - 系统 - Discover 软件管理中心”* ，进入 *Discover 软件管理中心* 。

<img alt="KDE_settings40.png" src="KDE_settings40.png" width="60%" title="This image has been scaled to 60% of its original size.">  

点击左下角的 *“主页”* 标签即可浏览Discover中的热门应用，或者在左侧的各项分类标签中进行浏览。在左上角的 *“搜索…”* 搜索框内输入关键词并按下 *回车（Enter）键* ，即可在选中的标签内进行搜索。在搜索结果中查找想要安装的应用，点击应用卡片可以展开详细信息页面，在页面中查看截图、发行商/开发者、支持页面是否符合预期。若是，点击右上角的 *“⬇️安装”* 按钮。在之后弹出的 *“需要进行身份验证 — PolicyKit1 KDE 代理程序”* 窗口中，输入 *“账户密码”* ，然后点击 *“确定”* 按钮， *Discover 软件管理中心* 将会开始安装任务。此时在左下角将显示 *任务进度条* ，点击该进度条可以看到详细任务进度。

![KDE_settings41.png](KDE_settings41.png) 

&ensp;&ensp;&ensp;&ensp;**11.1.b 卸载应用**

在 *Discover 软件管理中心* 中，点击左下角的 *“已安装的软件包”* 标签即可浏览系统中已被安装并被 *Discover 软件管理中心* 收录的应用。在左上角的 *“在“已安装的软件包”中搜索…”* 搜索框内输入关键词并按下 *回车（Enter）键* ，即可在这些应用中搜索。对于右方的搜索结果，点击想要卸载的应用卡片右方的 *“移除”* 按钮。 *Discover 软件管理中心* 将会自动准备卸载该应用和其全部的独立依赖软件（只被该应用依赖，而不被任何其他软件依赖的依赖软件）。如果该应用是其他软件的依赖，则会弹出 *“确认移除软件包”* 弹窗。如果其中提到的一并移除的软件包也不是你想要保留的软件包，点击 *“移除”* 按钮。在之后弹出的 *“需要进行身份验证 — PolicyKit1 KDE 代理程序”* 窗口中，输入 *“账户密码”* ，然后点击 *“确定”* 按钮， *Discover 软件管理中心* 将会开始卸载任务。此时在左下角将显示 *任务进度条* ，点击该进度条可以看到详细任务进度。

![KDE_settings42.png](KDE_settings42.png) 

>  *Discover 软件管理中心* 可能无法完全卸载掉所有的依赖，即使这些依赖已经不再被任何软件（包）依赖。要更完整地卸载应用，请使用APT。对于Linux轻量用户，卸不干净也没事，这些残留不会有影响。

&ensp;&ensp;&ensp;&ensp;**11.1.c 更新应用/系统**

在 *Discover 软件管理中心* 中，点击左下角的 *“更新(U)”* 标签即可浏览系统中可被更新的应用。**此处的应用不限于被 *Discover 软件管理中心* 收录于否，只要是 *系统软件源* 内的软件均可被检查。** 该更新列表并不是随时更新的，所以可以按右上角的 *“刷新”* 按钮来刷新更新列表。如果更新列表中有可以更新的软件（包），可以点击它们的卡片来查看简介，也可点击 *“更多信息…”* 按钮查看详情。勾选各软件（包）卡片左边的复选框，即可将其标记为待更新软件（包）；或是点击下方的 *“全部选中”* 按钮来全选所有软件（包）。最后，点击右上角的 *“更新选中项目”* 按钮。在之后弹出的 *“需要进行身份验证 — PolicyKit1 KDE 代理程序”* 窗口中，输入 *“账户密码”* ，然后点击 *“确定”* 按钮， *Discover 软件管理中心* 将会开始更新各软件（包）。此时在左下角将显示 *任务进度条* ，点击该进度条可以看到详细任务进度。

![KDE_settings43.png](KDE_settings43.png) 

由于操作系统也是由许多软件（包）构成，所以此处 *Discover 软件管理中心* 对所有软件源内的软件（包）更新，也可以覆盖到**系统更新**。这点与许多商业操作系统不同，它们（如 *Windows* 、 *MacOS* 、*Andriod* 等）往往将系统更新放在单独的设置页面中。

![KDE_settings49.png](KDE_settings49.png)  

可以设定系统进行自动更新。在 *系统设置* 中点击左侧栏的 *“系统管理 - 软件更新”* ，在右侧的 *“软件更新”* 设置页面中，调整自动/手动更新、更新/提醒频率、是否使用离线更新。

![KDE_settings84.png](KDE_settings84.png)  

> 有些应用/软件包要在应用重启/系统重启后才能使更新生效。  
> 系统软件更新必须在系统重启后才能生效。  
> <img alt="KDE_settings75.png" src="KDE_settings75.png" width="50%" title="This image has been scaled to 50% of its original size.">  
> <img alt="KDE_settings76.jpeg" src="KDE_settings76.jpeg" width="50%" title="This image has been scaled to 50% of its original size.">  
>  *（重启后安装更新时的进度条）* 

**11.2 使用下载的软件包安装应用**

.deb软件包是Debian Linux及其衍生发行版（如Ubuntu和其衍生发行版（如Kubuntu））的可携带软件包格式。具体使用下载到的.deb软件包安装应用的方法，在本大节的1. 便介绍过了。

**11.3 使用包管理器APT安装、更新、卸载应用/系统**

在本大节的 *3.* 曾简略地提到过使用`apt`命令来安装软件包，这个命令即是Linux中最知名的几个命令之一——高级打包工具（Advanced Packaging Tools）， *APT* 。

此维基页面介绍了 *APT* 的一些基础操作：[APT - 维基百科，自由的百科全书](https://zh.wikipedia.org/zh-cn/APT)

你可能发现了，既然是 *APT* 的维基页面，为什么其中给出的所有命令都是`apt-get`？这有一篇AWS的文章解释了这一点：[apt 与 apt-get — Linux 中软件包管理工具的区别 — AWS](https://aws.amazon.com/cn/compare/the-difference-between-apt-and-apt-get/)。简而言之，如果要使用，使用`apt`便可；但如果要编写脚本文件（如.sh文件），则**或许**`apt-get`更好一点。

和之前在本大节的 *1.* 中描述的一样，使用 *APT* 对所有软件源内的软件（包）更新，也可以覆盖到**系统更新**。但与其使用`apt upgrade`命令，我更推荐使用 **`apt full-upgrade`** 。

![KDE_settings44.png](KDE_settings44.png) 

&ensp;&ensp;&ensp;&ensp;**11.3.a apt list**

维基中没有提到的另一项十分重要的 *APT* 命令：查看软件包列表。在 *“终端”* 中输入以下命令并执行：

```Shell
apt list | grep <你想要查找的软件包关键字>
```

可以显示在 ***软件仓库*** 中的所有含有该关键字的软件包。在 *“终端”* 中输入以下命令并执行：

```Shell
apt list --installed | grep <你想要查找的软件包关键字>
```

可以显示在 ***本地已经安装的*** 所有含有该关键字的软件包。

&ensp;&ensp;&ensp;&ensp;**11.3.b apt autoremove**

维基中没有提到的另一项十分重要的 *APT* 命令：自动卸载不再被依赖的软件包，尤其适用于 *Discover 软件管理中心* 卸不干净的应用。在 *“终端”* 中输入以下命令并执行：

```Shell
sudo apt autoremove
```

在`sudo`提示输入当前账户的密码时盲输 *“账户密码”* 并按 *回车（Enter）键* 确定。若有残留软件包，则`apt autoremove`会提问用户是否执行自动卸载。再确认一下给出的卸载列表中没有需要保留的软件包，然后按 *“回车（Enter）键”* 确认，或输入 *n* 再按 *“回车（Enter）键”* 取消。

<img alt="KDE_settings82.png" src="KDE_settings82.png" width="80%" title="This image has been scaled to 80% of its original size.">  

**11.4 使用网络应用程序代替一般应用程序**

什么是 ***“网络应用程序（Web Application）”*** ？摘抄一段维基页面上的文字：

> “渐进式 Web 应用” 这一术语由设计师 Frances Berriman 和 Google Chrome 工程师 Alex Russell 于 2015 年首次提出，指的是利用现代浏览器支持的新功能的应用程序，这些应用程序最初在 Web 浏览器选项卡内运行，但后来可以完全离线运行，并且无需在浏览器中输入应用程序 URL 即可启动。
> > [Web application - Wikipedia](https://en.wikipedia.org/wiki/Web_application#History)

即：这些Web应用可以像真正安装在电脑上的应用一样，可以通过图标启动，可以离线运行，可以接受更新，也可以操作本地文件。只不过载体是浏览器罢了。优点是，只要有支持Web应用的浏览器就可以安装，无论操作系统和CPU指令集，完全跨平台；缺点是稳定性较差，且网页能做的不如真正安装在电脑上的应用能做的功能多。以 *[Microsoft 365](https://www.microsoft365.com/)* Web应用为例：

&ensp;&ensp;&ensp;&ensp;**11.4.a 安装一般Web应用**

在访问了一款可以作为Web应用安装的网页后，其在 *Chromium内核* 的浏览器中（如 *Google Chrome* 或 *Brave 浏览器* 等），在 *“地址栏”* 的右侧将显示一个 *“安装“Web应用名””* 的按钮，点击该按钮，在弹出的 *“安装应用”* 弹窗中，点击 *“安装”* 按钮。

![KDE_settings45.png](KDE_settings45.png) 

在安装成功后，依次打开 *“应用程序启动器 - （Chromium内核浏览器）应用 - Microsoft 365”* ，或双击桌面上自动生成的 *“Microsoft 365”* 图标，进入 *“Microsoft 365”* Web应用。

![KDE_settings46.png](KDE_settings46.png) 

每次打开Web应用，浏览器都将自动检查应用更新。

&ensp;&ensp;&ensp;&ensp;**11.4.b 将任意网页安装为Web应用**

想在Kubuntu上安装 *Microsoft Copilot* ，但进入到[Copilot](https://copilot.microsoft.com/)网站后却发现， *Copilot* 的页面 *“地址栏”* 的右侧没有“安装“Copilot””的按钮。只能说微软真鸡贼啊，Windows上的 *Copilot* 明明就是Web应用，被强制只能使用 *Microsoft Edge* 打开也就算了，居然还不提供安装Web应用的标识。但毕竟 *Microsoft Edge* 也是Chromium内核的浏览器，Chrome肯定也能以Web应用形式使用的。

以 *Google Chrome浏览器* 为例，打开 *Google Chrome浏览器* ，点击右上角的三点菜单按钮 *“自定义及控制 Google Chrome” - 投放、保存和分享 - 将网页作为应用安装…* ，在弹出的 *“将网页作为应用安装”* 窗口中，点击 *“安装”* 按钮。

![KDE_settings69.png](KDE_settings69.png) 

这样， *Copilot* 便从网页安装为了一款Web应用了。

![KDE_settings70.png](KDE_settings70.png) 

&ensp;&ensp;&ensp;&ensp;**11.4.c 卸载Web应用**

要卸载Web应用，打开 *要卸载的Web应用* ，点击右上角的 *“自定义和控制（Web应用）”* 按钮，选择 *“卸载（Web应用）”* ，在弹出的 *“要删除“（Web应用）”吗”* 弹窗中，点击 *“移除”* 按钮。

![KDE_settings47.png](KDE_settings47.png) 

因为有时Web应用所能提供的功能已经足够轻量级使用，更别提有些所谓桌面应用就是网页套壳，所以有些时候与其去找一款在Linux上的Windows平替软件，不如看看这些软件是否已经提供了Web应用，逛逛Chrome应用商店也挺好的。

**11.5 使用Flatpak**

在另一篇文章[Linux下的个人偏好应用的安装和使用体验，以及运行Windows应用](../Installation%20and%20experience%20of%20personal%20preference%20applications%20under%20Linux%20-%20Linux下的个人偏好应用的安装和使用体验/Installation%20and%20experience%20of%20personal%20preference%20applications%20under%20Linux%20-%20Linux下的个人偏好应用的安装和使用体验.md)中介绍了使用 *Flatpak软件包* 安装应用的方式，均可使用在Kubuntu中，此处不再赘述。摘录其中介绍 *Flatpak* 的描述如下：

“Flatpak 是一种软件包管理工具，允许开发人员打包和分发软件。它也是允许最终用户在其 Linux 系统上下载和安装该软件的同一种技术。与使用默认软件包管理器（apt、dnf、pacman等）相比，它有一些优势，因为它可以访问 Linux 社区贡献的大量应用程序，并且通常非常安全地安装和运行软件，因为它为应用程序创建了一个沙盒环境。最重要的是，它在任何发行版中都以相同的方式工作。”

### 12. Kubuntu的磁盘管理

**12.1 访问本地磁盘上的已格式化、非Linux创建的分区**

现代Linux发行版，尤其是带有桌面环境的发行版中很多都内置了多种非Linux常用文件系统的驱动，如NTFS（常见于Windows）和APFS（常见于MacOS）。以我笔记本上的为例，原Windows下的D盘卷标题为“Software, Workspace, Temp”，打开 *Dolphin 文件管理器* ，在左下角的 *“存储设备”* 菜单中便可以看到它。点击该卷标题，即可访问其内容；此时， *Dolphin 文件管理器* 将会自动将该卷挂在在`/media/<username>/<卷标题>`这一路径，如图所示，其中已经显示了卷内包含的 *Windows可执行文件（.exe文件）* ，且卷属性中也显示了 *文件系统* 为`ntfs3`。

![KDE_settings55.png](KDE_settings55.png)  
 *（我没有测试过Linux上的开源文件系统驱动的性能，对于我来说能读写文件就行。）* 

但仍要注意，这并不保证Linux能够访问所有使用非常见Linux文件系统的卷，即使是未经加密的：

![KDE_settings56.png](KDE_settings56.png) 

**12.2 访问Bitlocker分区**

KDE中的 *Dolphin 文件管理器* 已经整合了访问Bitlocker加密的卷的功能（太屌了）：打开 *Dolphin 文件管理器* ，在左下角的 *“存储设备”* 菜单中先找到 *“Basic data partition”* ，这是所有 *Dolphin 文件管理器* 没有获取到合适访问方式的分区的默认名。点击该条目，在弹出的 *“密码 — KDE Daemon”* 窗口中，输入 ***Bitlocker解密密钥*** ，然后点击 *“确定”* 按钮。

![KDE_settings57.png](KDE_settings57.png) 

如果密钥正确，则可以正确将卷解密并挂载。

![KDE_settings58.png](KDE_settings58.png)  
 *（图中的Bitlocker恢复密钥ID被正确识别。）*

**12.3 KDE分区管理器**

 *KDE 分区管理器* 类似Windows中的 *磁盘管理* ，顾名思义，就是管理分区/磁盘的设置组件。依次打开 *“应用程序启动器 - 系统 - KDE 分区管理器”* ，在弹出的 *“需要进行身份验证 — PolicyKit1 KDE 代理程序”* 窗口中，输入 *“账户密码”* ，然后点击 *“确定”* 按钮。

![KDE_settings59.png](KDE_settings59.png)  

在打开的 *KDE 分区管理器* 窗口中，即可使用各种分区操作了。 *KDE 分区管理器* 比 *磁盘管理* 强的其中一点是，在 *“设备”* 菜单中，可以备份（活动和非活动硬盘）和恢复（非活动硬盘）的分区表，也能看硬盘的 *SMART* 信息（虽然识别新硬件的信息这方面有所欠缺，我手上的这块联芸主控只能识别一个健康度，连温度都看不了）。

![KDE_settings60.png](KDE_settings60.png)  
 *（没啥要操作的，就不多截了）* 

### 13. 在Linux上设置OneDrive

在Windows上用OneDrive用爽了，这种从家里切换到上课用的设备之间无感同步的感觉太棒了，已经离不开微软生态了咧。换了Linux之后，突然没得OneDrive用，有种由奢入俭难的感觉。还好，有人有着相同的需求：  
[abraunegg/onedrive: OneDrive Client for Linux](https://github.com/abraunegg/onedrive/tree/master)

这个开源项目中可以使Linux用户也用上OneDrive。不过，目前（2.5.0版本）还存在两个问题：1. 该项目无法像Windows上的OneDrive那样，使用个人保管库中的文件可以即时加密和解密；2. 该项目无法像OneDrive整合进Windows文件资源管理器那样自动按需保留文件，因此只能手动控制保留文件与否。

虽然我很想尝鲜下，不过还是有些疑虑，倒不是怕该项目会泄漏文件，主要是怕万一脚本把我整个云存储都清空了😂虽然感觉不至于，但毕竟文件太重要了，没办法以身试险，最后还是用了Web应用。

![KDE_settings48.png](KDE_settings48.png) 

### 14. 修改GRUB菜单

 *GRUB 2* 是Linux上一款经典的跨平台通用引导加载器，其功能类似于Windows的 *Windows Boot Manager（Windows启动管理器）* ，可以通过该引导加载器引导进入系统。我曾经尝试过让 *Windows Boot Manager* 引导几个Linux发行版，均以失败告终；而让 *GRUB 2* 引导Windows则可以正常进入系统，两个引导加载器均是引导至.efi文件，可能我当初在 *Windows Boot Manager* 注册错了.efi文件，反正也懒得管了，有个能用的就行。

尽管尝试着去找了带GUI的修改方式—— *“Grub Customizer”* ，但搜索Kubuntu软件仓库无果，尝试网络搜索才发现该软件包已经被Ubuntu官方软件仓库撤下，这篇文章解释了一部分原因：[Easy Linux Tips Project: Grub Customizer: why you shouldn't use it](https://easylinuxtipsproject.blogspot.com/p/grub-customizer.html)。看来还是得手动改配置文件了。

假设你的Windows没有将引导.efi文件顺序的首位改回 *Windows Boot Manager* ，那么在Kubuntu中，使用 *Dolphin 文件管理器* 导航到`/etc/default`路径下，找到`grub`文件， *双击* 打开，或是在文件上 *右键 - “使用 Kate文本编辑器 打开”* 。

![KDE_settings30.png](KDE_settings30.png)  

可以对该配置文件中的条目进行以下修改（部分）：

1. `GRUB_DEFAULT="xxx"` 设置默认引导项为指定 *GRUB菜单条目名称* 。在 *“终端”* 中输入以下命令获取所有的 *GRUB菜单条目名称* ：
   
   ```Shell
   sudo cat /boot/grub/grub.cfg | grep "menuentry '"
   ```

   并按 *回车（Enter）键* 执行命令。在`sudo`提示输入当前账户的密码时盲输 *“账户密码”* 并按 *回车（Enter）键* 确定。之后， *“终端”* 的返回信息将显示当前的所有 *GRUB菜单条目名称* 。

   ![KDE_settings61.png](KDE_settings61.png)  
    *（在我的笔记本上有8个GRUB菜单条目。）* 
   
   在每个`menuentry`的一对单引号中的文本，即是一个 *GRUB菜单条目名称* 。例如，我的笔记本上安装的Windows 11的引导项，在此对应为`Windows Boot Manager (on /dev/nvme0n1p1)`。

   > 注意：若要使用该条目名称来指定默认引导项，则必须使用全长名称，不得省略。

   例：将Windows 11设置为默认引导项，则修改为`GRUB_DEFAULT="Windows Boot Manager (on /dev/nvme0n1p1)"`。
2. `GRUB_DEFAULT=saved`和`GRUB_SAVEDEFAULT=true`两项，设置每次启动的引导项为上次开机的引导项。
3. `GRUB_TIMEOUT=x`在x秒后，引导默认引导项。例：设置5秒无输入则引导至默认引导项，则修改为`GRUB_TIMEOUT=5`。
4. `GRUB_GFXMODE=640x480`GRUB显示的分辨率列表，GRUB将从前到后尝试。例：`GRUB_GFXMODE=640x480,1920x1080`，则GRUB将先尝试以640x480分辨率显示，若无法以该分辨率显示，再尝试使用1920x1080分辨率显示。 *（我的笔记本上GRUB只能用这两个分辨率，绝了）* 

> 若文件中没有出现你想要修改的条目，就新建一行并加入该条目。  

> 在任意条目前加入 *“#（井号）”* 可以将该条注释掉， *GRUB 2* 将自动以程序默认值执行。  

> 对于`GRUB_GFXMODE=`一项，如果不清楚 *GRUB 2* 可以使用哪些分辨率，可以在系统引导至GRUB界面时按 *c* 键打开GRUB的命令行模式，在该模式下输入`videoinfo`并按 *回车（Enter）键* ， *GRUB 2* 将显示其支持的分辨率列表。
> ![KDE_settings62.jpeg](KDE_settings62.jpeg)  
> 但开启了安全启动的电脑上，这一步是废的😓

修改后保存，在之后弹出的 *“需要进行身份验证 — PolicyKit1 KDE 代理程序”* 窗口中，输入 *“账户密码”* ，然后点击 *“确定”* 按钮。

![KDE_settings68.png](KDE_settings68.png)  

要使更改后的配置文件生效，还需要最后一步：在 *“终端”* 中输入以下命令：
   
```Shell
sudo update-grub
```

并按 *回车（Enter）键* 执行命令。在`sudo`提示输入当前账户的密码时盲输 *“账户密码”* 并按 *回车（Enter）键* 确定。 *“终端”* 返回的信息若无报错且最后显示`done`，则修改生效。

![KDE_settings63.png](KDE_settings63.png)  

### 15. 登录屏幕配套和行为

在自定义 *登录屏幕（SDDM）* 之后，登录屏幕居然不像进入桌面之后那样会自动将NumLock打开。一开始无头绪地折腾了一会，后来瞎点居然给弄好了。

在 *系统设置* 中点击左侧栏的 *“工作区 - 开机与关机 - 登录屏幕（SDDM）”* ，在右侧的 *登录屏幕（SDDM）* 设置页面中，可以选择一个偏好的 *登录屏幕样式* 。**这时候 *登录屏幕样式* 并未与整体外观和其他Plasma桌面设置配套**（例如开机时NumLock键状态），需要点击下方的 *“应用 Plasma 设置…”* 来使其配套。

![KDE_settings64.png](KDE_settings64.png)  

 *登录屏幕* 还可以设置登录时是否自动登录，点击下方的 *“行为设置…”* 按钮，进入 *“行为设置”* 设置页面。勾选 *“自动登录：”* 复选框并选择要自动登录的用户，在下次Kubuntu启动后，便会自动登录到这个用户的账户中。最后，点击 *“确定”* 按钮。

<img alt="KDE_settings65.png" src="KDE_settings65.png" width="70%" title="This image has been scaled to 70% of its original size."> 

### 16. 修改注销屏幕超时时间

厌倦了每次想关机/重启的时候都要弹出的30秒 *注销屏幕* 吗？在 *系统设置* 中点击左侧栏的 *“工作区 - 开机与关机 - 桌面会话”* ，在右侧的 *桌面会话* 设置页面中，取消 *“显示：”* 复选框即可。

![KDE_settings66.png](KDE_settings66.png)  

或许，也可以修改这个等待的秒数，只不过没有快捷的修改设置，只能从代码下手。使用 *Dolphin 文件管理器* 导航到`/usr/share/plasma/look-and-feel/org.kde.breeze.desktop/contents/logout`路径下，找到`Logout.qml`文件， *双击* 打开，或是在文件上 *右键 - “使用 Kate文本编辑器 打开”* 。然后，在 *Kate文本编辑器* 中找到约在44行的

```qt
property real timeout: 30
```

将这个30秒改为你想要的秒数。在之后弹出的 *“需要进行身份验证 — PolicyKit1 KDE 代理程序”* 窗口中，输入 *“账户密码”* ，然后点击 *“确定”* 按钮。

<img alt="KDE_settings67.png" src="KDE_settings67.png" width="80%" title="This image has been scaled to 80% of its original size."> 

再弹出的 *注销屏幕* 的倒计时现在都会变为新的倒计时秒数了。不过，每次系统（KDE Plasma）更新都会覆盖掉这个更改，需要再次修改才能继续生效。

参考：  
[Change the 30 second timeout for shutdown, reboot, and log off? - Help - KDE Discuss](https://discuss.kde.org/t/change-the-30-second-timeout-for-shutdown-reboot-and-log-off/1502)

### 17. 更改桌面图标排列方式

KDE Plasma桌面图标的默认排列方式是横向从左到右的，有点不习惯。在 *桌面* 的空白处上 *右键 - 图标 - 排列方式 - 从上到下* 可将图标的排列方式改为纵向从上到下排列。

<img alt="KDE_settings71.png" src="KDE_settings71.png" width="70%" title="This image has been scaled to 70% of its original size."> 

### 18. 同步Linux与Windows的硬件时间

在成功安装好Windows 11 + Kubuntu双系统后，切换这两个系统时总会发生系统时间与实际当地时间有差别的情况。以下解决方案部分为 *ChatGPT* 生成：

问题原因：  
&ensp;&ensp;&ensp;&ensp;Linux默认硬件时间 (RTC) 是 UTC（协调世界时）时间，然后根据系统时区调整为本地时间。  
&ensp;&ensp;&ensp;&ensp;Windows默认硬件时间 (RTC) 是本地时间，因此不对时间做时区调整。

因此，当在Windows中同步时间后，再次启动Linux，其错误地认为是UTC时间，需要再次同步时间；再次启动Windows，其错误地认为是本地时间，需要再次同步时间。仅有部分国家/地区如格陵兰、冰岛、圣赫勒拿等，因为使用UTC+0时区且不使用日光节约时间，所以这个问题是可以忽略的。

解决方法：
- 配置Windows：适合常用Linux而不常用Windows
  1. 按下 Win + R 打开运行框，输入 regedit 并按回车，打开 *“注册表编辑器”* 。
  2. 定位到以下路径：`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\TimeZoneInformation`
  3. 右键空白处，选择 *“新建 -> DWORD (32 位) 值”* ，命名为`RealTimeIsUniversal`。
  4. 双击新建的键，将值设置为 1。
  5. 重启 Windows。
- 配置Linux：适合常用Windows而不常用Linux
  1. 打开 *终端* 并运行以下命令：`timedatectl set-local-rtc 1 --adjust-system-clock`
  2. 验证设置：打开 *终端* 并运行以下命令：`timedatectl`
  3. 输出中应该显示`RTC in local TZ: yes`。

潜在问题：
- Linux配置后：如果使用双时区或 UTC 的某些功能（如日志记录），可能会引起混淆。
- Windows配置后：一些旧版 Windows 程序或设备可能不支持此设置。

## 四、个性化设置、个人应用偏好、小技巧

完成上一节，你的Kubuntu终于可以进入正式使用的阶段了。下面是我的一些个人的个性化设置、应用偏好和小技巧。

### a. 个性化设置

#### 1. 修改应用程序启动器图标

打开 *“应用程序启动器”* ，点击右上角的 *“配置应用程序启动器…”* 按钮，打开 *“应用程序启动器 设置”* 窗口。点击左侧栏的 *“常规”* ，在 *“常规”* 面板中，点击 *“图标：”* 按钮，选择下拉菜单中的 *“选择…”* 项。在打开的 *“选择图标”* 窗口中，从下拉菜单中选择分类，在右上角的 *搜索框* 中搜索；如果没有想要的，点击左下角的 *“浏览…”* 按钮，选择自定义的图标文件作为应用程序启动器图标。然后，点击 *“确定”* 按钮。最后，点击 *“确定”* 按钮。

![Personal_perf0.png](Personal_perf0.png)  

<img alt="Personal_perf1.png" src="Personal_perf1.png" width="70%" title="This image has been scaled to 70% of its original size.">  

#### 2. 修改任务栏行为

在 *任务栏* 上的空白位置上 *右键 - 配置图标任务管理器…* ，在弹出的 *图标任务管理器* 上，点击左侧 *“行为”* 按钮，在右侧的 *“行为”* 面板中，调整 *“分组：”* 下拉菜单： *“按程序名称”* 则将会使相同程序的不同窗口的任务栏图标合并为一个，并在下面加一个绿色的 *“＋”* 图标；或者选择 *“不分组”* 来关掉合并功能。勾选 *“鼠标滚轮：”* 项中的 *“循环切换任务”* ，则在光标悬停在 *图标任务管理器* 上时，滚动鼠标滚轮可以在不同窗口中轮换；取消勾选 *“跳过最小化的任务”* 则可以使滚轮滚动也可滚动到已最小化的窗口，此时该窗口将取消最小化。最后，点击 *“确定”* 按钮。

<img alt="Personal_perf2.png" src="Personal_perf2.png" width="70%" title="This image has been scaled to 70% of its original size.">  

#### 3. 固定应用或文件到任务栏

为避免混淆，此处 *任务栏* 指代的是除 *三、5.2* 中提到的 *图标任务管理器* 外的屏幕下方的整条 *任务栏* 空间。此处固定的应用或文件将作为 *任务栏* 的“小组件”。

**3.1 通过应用程序启动器添加**

打开 *“应用程序启动器”* ，在想要添加为小组件的应用上 *“右键 - 添加到面板（挂件）”* 来作为小组件固定到 *任务栏* 上。此时，该应用图标将出现在 *任务栏* 上且不在 *图标任务管理器* 中。

![Personal_perf8.png](Personal_perf8.png)  

若要调整位置或删除该小组件，在 *任务栏* 上的空白位置上 *“右键 - 进入编辑模式”* ，在弹出的 *浮动任务栏与配置面板* 上，按住并左右拖动小组件的图标可以调整小组件在 *任务栏* 上的位置；或者将光标悬停在小组件上并点击 *“移除”* 按钮来移除该小组件。

![Personal_perf16.png](Personal_perf16.png)  
 *（进入此配置面板的截图请见 *三、5.3* 。）* 

**3.2 通过Dolphin 文件管理器添加**

不同于Windows 11（截止到编写时的23H2正式版本），任意用 *Dolphin 文件管理器* 能够双击打开的文件都可以通过拖拽其图标到 *任务栏* 的方式将其作为一个小组件固定在 *任务栏* 上。这意味着文件、文件夹甚至是脚本都可以固定在 *任务栏* 上。

#### 4. 更改锁屏壁纸；更改壁纸

**4.1 更改锁屏壁纸（以必应每日一图为例）**

在 *系统设置* 中点击左侧栏的 *“工作区行为 - 锁屏 - 配置”* ，在右侧的 *“外观”* 设置页面中，依个人偏好更改设置，本例以更换为必应每日一图为例：在 *“壁纸类型：”* 下拉菜单中选择 *“每日一图”* ， *“提供：”* 下拉菜单中选择 *“必应”* ；如果显示器非标准16:9显示比例，则可以调整 *“位置：”* 下拉菜单。

![Personal_perf3.png](Personal_perf3.png)  

> 点击 *“应用”* 按钮保存当前设置但不退出 *锁屏 外观* 面板；点击 *“确定”* 按钮保存当前设置并退出 *锁屏 外观* 面板。

![Personal_perf4.png](Personal_perf4.png)  

**4.2 更改桌面壁纸**

在 *桌面* 上的空白位置上 *右键 - 配置桌面和壁纸…* ，在弹出的 *桌面文件夹 设置* 窗口上，点击左侧 *“壁纸”* 按钮，在右侧的 *“壁纸”* 面板中，依个人偏好更改设置。 

![Personal_perf16.png](Personal_perf17.png)  

> 点击 *“应用”* 按钮保存当前设置但不退出 *桌面文件夹 设置* 窗口；点击 *“确定”* 按钮保存当前设置并退出 *桌面文件夹 设置* 窗口。

#### 5. Dolphin 文件管理器永久显示标签栏

在Windows 7时代我就期待 *Windows 资源管理器* 有一天可以像浏览器那样多标签页了，直到Windows 11 22H2才实现了这一点。KDE的 *Dolphin 文件管理器* 自带多标签页功能，但没有像Windows 11的*Windows 资源管理器* 那样，标签页常驻且有 *“＋添加新标签”* 按钮。查了一下， *Dolphin 文件管理器* 的开发者们好像无意添加这一功能：[Add options to always show tab bar and to hide close buttons on tabs (!269) · 合并请求 · System / Dolphin · GitLab](https://invent.kde.org/system/dolphin/-/merge_requests/269)。哎，看来只能用快捷键或者右键菜单来添加新标签页了。

![Personal_perf18.png](Personal_perf18.png) 

#### 6. 修改GRUB背景

厌倦了黑底的 *GRUB 2* 启动菜单，想要发挥开源软件高度可自定的特性，搞杀马特 *GRUB 2* 背景吗？更改 *GRUB 2* 背景的方式有多种，本节介绍一种相对简单的：首先将想要显示的背景图片放在一可访问路径中，如`~/Downloads`下。然后，在 *“终端”* 中输入以下命令：

```Shell
sudo cp <想要显示的背景图片路径> /boot/grub/
sudo update-grub
```

在`sudo`提示输入当前账户的密码时盲输 *“账户密码”* 并按 *回车（Enter）键* 确定。若在 *“终端”* 的返回信息中出现`Found background image: <想要显示的背景图片文件名>`，则更换 *GRUB 2* 背景成功。

>  *GRUB 2* 接受的背景图片格式为PNG、JPG/JPEG和TGA。具体格式请见[Grub2/Displays - Community Help Wiki](https://help.ubuntu.com/community/Grub2/Displays#Choosing_a_GRUB_2_Background_Image)。 *GRUB 2* 可以自动拉抻和缩放图片，但无法手动调整拉抻和缩放方式，且可能不总是生效。

![Personal_perf5.png](Personal_perf5.png)  

![Personal_perf6.jpeg](Personal_perf6.jpeg)  
 *（SHODAN is watching you boot.）* 

#### 7. 修改账户头像和名称

打开 *“应用程序启动器”* ，点击左上角的头像按钮 *“打开用户设置”* ，或者在 *系统设置* 中点击左侧栏的 *“个性化 - 用户”* ，在右侧的 *管理用户* 设置页面中，选择左侧 *“您的帐号”* 列表中要修改账户头像和名称的账户。在面板右侧，点击 *“头像”* 可以进入 *“更换头像”* 面板，可在里面挑选一个偏好的头像，或者点击第一排第一个 *“选择文件…”* 按钮来选择一张图片作为头像；修改 *“名称：”* 文本框可以修改账户用于UI显示的账户名称，类似于Windows中 *微软账户* 中的 *“全名”* ；而修改 *“用户名：”* 文本框可以修改账户用于系统中的账户名，类似于Windows中`C:\Users\`下的账户名。

![Personal_perf12.png](Personal_perf12.png)  

> 可以尝试多种图片格式作为用户头像，.svg图像可以作为头像使用。

#### 8. 保持蓝牙启动状态

要想使蓝牙的开关在每次启动时都保持上次关机前的状态，在 *系统设置* 中点击左侧栏的 *“硬件 - 蓝牙”* ，在右侧的 *“蓝牙”* 设置页面中，更改 *“登录时”* 右侧的单选框 *“恢复之前的状态”* 。

![Personal_perf10.png](Personal_perf10.png)  

#### 9. 更改应用程序启动器中应用的类别

在安装一些应用后，其将会把启动快捷方式放置在 *应用程序启动器* 中。有时可能想要改变其快捷方式的分类，以 *“爱思助手”* 为例：依次打开 *“应用程序启动器 - 系统 - 菜单编辑器”* ，打开 *“KDE 菜单编辑器”* 。在 *KDE 菜单编辑器* 左栏列表中，选择想要更改分类的快捷方式，使用 *“左键”* 按住它，然后拖动到偏好的分类中。在分类中拖动，还可以改变其在分类中的位置。最后，点击上方工具栏中的 *“保存”* 按钮。

![Personal_perf30.png](Personal_perf30.png)  

### b. 个人Kubuntu下的应用偏好

以下没有特别提到安装方式的，均可使用 *三、11.* 中介绍的各种方式来进行安装。

#### 0. 通用

在另一篇文章[Linux下的个人偏好应用的安装和使用体验，以及运行Windows应用](../Installation%20and%20experience%20of%20personal%20preference%20applications%20under%20Linux%20-%20Linux下的个人偏好应用的安装和使用体验/Installation%20and%20experience%20of%20personal%20preference%20applications%20under%20Linux%20-%20Linux下的个人偏好应用的安装和使用体验.md)中介绍了一些不指定发行版和桌面环境的个人偏好应用的安装和使用体验，均可使用在Kubuntu中，此处不再赘述。其中还介绍了在Linux环境下运行Windows应用的方式。

#### 1. 倒计时工具：KTimer

为了在Kubuntu里找一款能倒计时并在倒计时结束后发送通知并发出声音的应用废了死劲了，以前还嘲笑过 *Windows 11* 预装的 *时钟* 应用简朴，结果在Kubuntu里翻了好几个都不堪用，最后找到的这个也只是将将凑活。怎么找个Kubuntu下的倒计时工具这么难……

要使用能发送通知并发出声音的倒计时工具，需要安装一个应用和一个软件包：

1.  *KTimer* ，可在 *Discover 软件管理中心* 安装。
2.  *pulseaudio-utils* ，可在 *APT* 安装。

安装完成后，在 *主文件夹（~）* 下的任意路径中创建一个名为`timer_notify_alarm.sh`的文件。本节以`/home/user/Public/timer_notify_alarm.sh`为例。

将以下内容粘贴进`timer_notify_alarm.sh`并保存：

```bash
#!/bin/bash
notify-send "KTimer 倒计时程序" "计时完毕。"
paplay /usr/share/sounds/freedesktop/stereo/alarm-clock-elapsed.oga
```

依次打开 *“应用程序启动器 - 工具 - KTimer 倒计时程序启动器”* ，进入 *KTimer 倒计时程序启动器* 。在窗口右侧可以新建倒计时计划，或移除选定的计划。选中一条计划，在下方的 *“设置”* 面板中，编辑 *“命令行：”* 的文本框或者点击右侧 *“打开文件对话框”* 按钮，选择脚本文件或者可执行文件。在下方的 *“延迟：”* 处，调整要计时的时间。最后，使用右下角的 *“状态”* 面板上方的三个按键 *“>开始倒计时”“⏸️暂停倒计时”“⏹️停止倒计时”* 来控制计时进度。

![Personal_perf13.png](Personal_perf13.png)  

本例使用两条计划：

1. 第一条使用 *“打开文件对话框”* 按钮，选择刚才的`timer_notify_alarm.sh`文件。这样使得倒计时结束后发送通知并发出声音提醒。
2. 第二条编辑 *“命令行：”* 的文本框，输入：
   ```sh
   notify-send "KTimer 倒计时程序" "计时完毕。"
   ```
   这样使得倒计时结束后只发送通知但不发出声音提醒。

<img alt="Personal_perf14.png" src="Personal_perf14.png" width="50%" title="This image has been scaled to 50% of its original size."> 

### c. 小技巧

#### 1. 全局滚轮切换

&ensp;&ensp;&ensp;&ensp;**1.1 使用滚轮在任意标签间切换**

无论是 *图标任务管理器* 中的各窗口图标、 *Google Chrome 浏览器* 的各网页标签页，还是 *“终端”* 和 *Dolphin 文件管理器* 的各标签页，KDE桌面环境均支持当光标悬停在标签栏上时，使用鼠标滚轮可以在各个标签页之间轮换。希望Windows有一天也可以跟进。

&ensp;&ensp;&ensp;&ensp;**1.2 使用滚轮快捷调整托盘设置**

当将光标悬停在 *任务栏* 上的 *系统托盘* 上的 *系统设置图标* 上时，滚动鼠标滚轮可以更改某些系统设置：比如悬停在 *“🔉”* 上时滚动滚轮可以调整音量大小， 悬停在*“🔋”* 上时滚动滚轮可以调整屏幕亮度（对于拥有内置屏幕的设备，外接显示器没有测试过），等等。同时，鼠标中键单击这些图标也可以更改一些设置。

<img alt="Personal_perf19.png" src="Personal_perf19.png" width="70%" title="This image has been scaled to 70% of its original size."> 

 *（问ChatGPT回答KDE在2000年初就实现了这一功能，但问Copilot两次都说是Windows 11先实现的，啊这……）*

#### 2. KDE Connect

（本节不是一个详细介绍 *KDE Connect* 的说明。如果将来要扩展 *KDE Connect* 到其他平台且使用更多功能，可能会移动到其他文章中。）

 *KDE Connect* 是一个用于在多个设备之间实现无缝连接和交互的开源软件，设计之初是用于连接使用 *KDE桌面环境* 的Linux电脑与Android设备，**现已扩展到许多设备和平台**，成为一种通用的解决方案，甚至可完全脱离Linux。它通过使用局域网连接，让用户可以在设备之间共享数据和执行多种功能，包括通知同步、文件传输、远程控制、共享剪贴板、远程输入、设备电量监控等功能。

[【开源】全平台文件共享设备互联 KDE Connect——iOS 最新版本演示（AirDrop 跨全平台替代）_哔哩哔哩_bilibili](https://www.bilibili.com/video/BV1Yu411o7zM)

&ensp;&ensp;&ensp;&ensp;**2.1 测试平台、安装与启动位置**

本节将介绍在仅两台设备间使用 *KDE Connect* 的情景，仅简单介绍，无性能测试。

| 设备及版本简介： | （20241006） |
|:----------------- | -----------------:|
| Asus Chromebook Vibe CX55 Flip | Apple iPhone 13 mini |
| Kubuntu 24.04 LTS | iOS 17.3 |
| KDE Connect 23.08.5 | KDE Connect 0.4.1 |
| WiFi连接 | WiFi连接 |
| 随KDE桌面环境预装，或从Discover 软件管理中心安装，或`apt install kdeconnect` | App Store - KDE Connect |
| *“应用程序启动器 - 互联网 - KDE Connect”或“任务栏 - 系统托盘 - KDE Connect”* | *“主屏幕 - KDE Connect”或“App资源库 - 效率与财务 - KDE Connect”* |

&ensp;&ensp;&ensp;&ensp;**2.2 配对**

在KDE桌面环境中，（本节以 *“任务栏 - 系统托盘 - KDE Connect”* 方式启动为例）启动 *KDE Connect* 之后，点击 *“配对设备…”* 或右上角的 *“KDE Connect 设置…”* 按钮，进入 *“配置”* 设置页面。保留此页面待命。

![Personal_perf22.png](Personal_perf22.png)  

在iOS中，启动 *KDE Connect* 之后，等待 *KDE Connect* 搜寻局域网中的其他使用 *KDE Connect* 的设备。在两端 *KDE Connect* 均处于前台的情况下，在各自的设备列表中，将看到对方设备的图标和 *KDE Connect 设备名* 。

点击KDE桌面环境 *KDE Connect* 中左侧的设备列表中的iOS端设备，在右方设备详情和可用插件列表面板中， *设备名（未配对）* 下方将显示一行 *“密钥：”* ，该密钥在每次新建连接时产生，你可以当作本次连接的唯一密钥。密钥的前8位将用于iOS *KDE Connect* 向用户确认设备身份。

点击iOS *KDE Connect* 中的 *“DISCOVERED DEVICES（发现的设备）”* 列表中的电脑端设备，iOS *KDE Connect* 将弹出确认窗口 *“Initiate Pairing?（启动配对？）”* ，在 *“Verification key:（验证密钥：）”* 处将显示KDE桌面环境 *KDE Connect* 的密钥的前8位；或点击KDE桌面环境 *KDE Connect* 左侧设备列表中的iOS端设备，*KDE Connect* 将显示配对进度条，iOS *KDE Connect* 将弹出确认窗口 *“Incoming Pairing Request（传入配对请求）”* ，在 *“Verification key:（验证密钥：）”* 处将显示KDE桌面环境 *KDE Connect* 的密钥的前8位。在确认两个前8位密钥无误后，点击 *“Pair（配对）”* 按钮。

![Personal_perf23.png](Personal_perf23.png)  

如果列表中没有出现对方设备，可以尝试在KDE桌面环境 *KDE Connect* 左下角的 *“刷新”* 按钮，或是iOS *KDE Connect* 右上角的 *“菜单○···”* 按钮，然后选择 *“Refresh Discovery（刷新发现的设备）”* 。

<img alt="Personal_perf24.png" src="Personal_perf24.png" width="60%" title="This image has been scaled to 60% of its original size."> 

KDE桌面环境 *KDE Connect* 在设备名旁边显示 *“已配对”* ，且iOS *KDE Connect* 弹出 *“Pairing Complete（配对已成功）”* 窗口且在 *“CONNECTED DEVICES（已配对设备）”* 列表中出现电脑端设备，则配对成功。

![Personal_perf25.png](Personal_perf25.png)  

&ensp;&ensp;&ensp;&ensp;**2.3 使用**

目前iOS端 *KDE Connect* （0.4.1）还无法实现 *KDE Connect* 退出前台后保持连接的功能（就iOS这个留后台的能力我估计也不行），KDE桌面环境 *KDE Connect* 倒是可以保留在后台（可作为常驻系统服务）。

**a. 远程键盘输入**

在iOS *KDE Connect* 中的 *“CONNECTED DEVICES（已配对设备）”* 列表中选择电脑端设备，然后选择 *“Remote Input（远程输入）”* ，在打开的 *“Remote Input（远程输入）”* 页面中，其中间的整个区域便是一个虚拟触摸板，在其上的输入会被同步推送到电脑端。但这里有个问题，一个是传输受网络影响太大，其次点按并拖动手指触发的拖动手势敏感度很奇怪，经常误触。好在我并不需要模拟触摸板（出行带一个无线鼠标没什么问题），最让我头大的是模拟键盘。

![Personal_perf26.png](Personal_perf26.png)  

点击 *“Remote Input（远程输入）”* 页面右上角的 *“模拟键盘⌨️”* 按钮，展开 *iOS键盘* ，在此使用字母输入法即可直接将字母发送到电脑端。但该模式受到iOS逻辑限制：1. 在App内没有输入框就无法唤起中文输入法，意味着此处的中文输入法废了 2. 点击 *iOS键盘* 以外的位置会使 *iOS键盘* 缩回，误触很烦。而且App此处的设计也不符合我的需求：我希望此处的虚拟键盘可以模拟真正的84键键盘，因为 *iOS键盘* 可没有 *Ctrl、Alt、Tab、Shift* 等功能键。你问为什么我要给笔记本弄虚拟84键键盘，其实我也不是给笔记本准备的，我想买个 *联想 Legion Go* 。

#### 3. Spectacle截图工具和Gwenview的标注工具

 *Spectacle 截图工具* 是KDE桌面环境自带的截图工具，默认情况下可以通过按下 *Print Screen/Prt Scr/Ptrsc键* 来唤出，或者依次打开 *“应用程序启动器 - 工具 - Spectacle 截图工具”* 。在 *Spectacle 截图工具* 的上方操作栏，可以对截图结果进行复制或保存，打开 *“显示标注工具”* 以及 *“配置”* 。下左方为截图预览，注意**这个截图预览并不是活动的，其只显示应用切换到前台时的截图，实际截图仍以执行截图操作后刷新的预览为准**。下右方为截图操作按钮以及截图快捷设置。光标悬停在截图操作按钮上可以看到快捷键提示。 *“延迟：”* 为按下截图操作按钮后， *Spectacle 截图工具* 在执行截图前等待的延迟时间。比如要截某一二级菜单，在菜单显示后快捷键被菜单独占而无法使用 *Print Screen/Prt Scr/Ptrsc键* 进行截图时，就可使用延迟功能截图。

 点击操作栏中的 *“配置”* 按钮进入 *Spectacle 截图工具* 的 *“配置”* 窗口。点击左侧 *“保存”* 按钮，进入 *“保存”* 设置页面，可以自定义默认保存位置、图像质量和文件名格式。保存位置和文件名仅影响操作栏中的  *“保存”* 按钮和 *自动保存* 功能。

 要更改 *Spectacle 截图工具* 各项截图模式的快捷键，在 *系统设置* 中点击左侧栏的 *“工作区 - 快捷键 - 快捷键”* ，在右侧的 *“快捷键”* 设置页面的左侧列表中选择 *“应用程序 - Spectacle 截图工具”* ，然后在右侧更改快捷键。在Linux下， *Windows徽标键* 被定义为 *超级（Super）键* 或 *元（Meta）键* 。

![Personal_perf21.png](Personal_perf21.png)  

> 为了和主力Windows 11 PC上的截图快捷键同步，我将 *“截取整个桌面”* 和 *“截取活动窗口”* 的快捷键进行了对调。

KDE桌面环境自带的可实现标注功能的工具有两个，1.  *Spectacle 截图工具 - 显示标注工具* 和 2. *Gwenview - 显示编辑工具 - 图像操作 - 标注* 。这两个标注工具试了一下，感觉都没有特别好用，没办法和Windows 11上的新版UWP *画图* 拉开差距，尤其是新版UWP *画图* 还加入了分层功能，虽然 *画图* 的形状工具里的箭头还是一坨。所以此处仅留一段占位，将来如果遇到了更好的Linux端标注工具再更新。本文中涉及KDE界面的大部分图片均是使用 *Spectacle 截图工具* 和新版UWP *画图* 编辑并制作的。

#### 4. Dolphin 文件管理器管理文件权限和查看校验和

**4.1 管理文件权限**

对于一些文件，可能想要更改其访问权限来预防潜在的误操作，或阻止某些程序访问它们。虽然这可以在 *“终端”* 中通过`chmod`命令来更改，但毕竟本篇主要介绍的是通过UI操作，所以此处使用 *Dolphin 文件管理器* 来实现这一点。

在 *Dolphin 文件管理器* 中，在想要更改访问权限的文件上 *右键 - 属性* ，在弹出的 *““...”的属性”* 窗口中，选择 *“权限”* 选项卡，更改 *“访问权限”* 中的三个下拉菜单 *“所有者：”“所有组：”“其他：”* 以及勾选/不勾选 *“可执行”* 复选框。比如，如果一个文件你只想要它可读而不可写来避免失误覆盖内容，可以将三个复选框全部选择为 *“可查看”* ；具体情境和解释请在线搜索。最后，点击 *“确定”* 按钮。

<img alt="Personal_perf15.png" src="Personal_perf15.png" width="80%" title="This image has been scaled to 80% of its original size."> 

> 即使被设置为只读的文件，仍然可以通过提权（如`sudo`）来进行写入。这只是加了一道安全措施，并不是绝对安全。

**4.2 查看文件校验和**

对重要的、经过传输的大文件进行校验和校验是一项很好的习惯，你也不想费半天劲下载下来的.iso安装镜像出现传输错误，或者在安装半截才发现数据错误，甚至安装后才发现吧。

对于提供了校验和的文件，在传输完成后，可以在 *Dolphin 文件管理器* 中定位到并在其上 *右键 - 属性* ，在弹出的 *““...”的属性”* 窗口中，选择 *“校验和”* 选项卡。在下方的方框中， *Dolphin 文件管理器* 提供了四种校验方式： *MD5、SHA1、SHA256和SHA512* 。根据提供的校验和方法选择对应的校验和计算，如在 *一、1.* 中提到的Kubuntu安装镜像，官方提供的是SHA256方式，则此处也选择SHA256进行计算。文件越大计算时间越长。将提供的校验和结果（数字和字母文本串，不含空格和文件名）粘贴进 *“校验和”* 选项卡上方的文本框中，若计算校验和结果和提供校验和相同，则文本框变绿且下方提示 *“校验和一致。”* 。这样，传输的文件便可证明是完全与原址相同了。

![Personal_perf20.png](Personal_perf20.png)  

>  *Dolphin 文件管理器* 暂不提供对文件夹的校验功能，如需要还请使用其他工具。

#### 5. root用户切换全局深色主题

打开 *终端* ，输入以下命令并运行：

```Shell
sudo systemsettings5
```

然后在打开的 *快速设置 - 系统设置* 窗口中，选择 *“主题： - Breeze 微风深色”* ，然后点击 *“✅应用”* 按钮。

![Personal_perf29.png](Personal_perf29.png)  

#### 6. Ubuntu系死机无屏重启

记录这一节的动机很简单：我刚才死机了，从睡眠中唤醒后桌面除了光标什么也没有，切换TTY更是一片漆黑。

简短版：
- 按下 *“Ctrl + Alt + SysRq/Prt Scr/Ptrsc”* 组合键，持续一秒，不要松开 *“Ctrl + Alt”* 组合键，松开“SysRq/Prt Scr/Ptrsc键”* 。
- 在前面按住 *“Ctrl + Alt”* 组合键的同时，依次按下并松开 *“R、E、I、S、U、B”* 键（“busier”反过来）。

来源：[Ubuntu卡机重启快捷键总结 - 风行天下-2080 - 博客园](https://www.cnblogs.com/yaok430/p/17593974.html)

### d. 个人卸载预装应用偏好

这里没有特别提到卸载方式的，均可按 *三、11.* 中介绍的方式进行卸载。

**1. 彻底卸载LibreOffice**

不是不喜欢LibreOffice，只是在线的 *Microsoft 365* 已经足够用了，而且还整合了 *Microsoft OneDrive* ，像我这样被微软生态绑架的还省去了学习成本，因此就没必要留了。

无论是从 *Discover 软件管理中心* 还是手动使用apt命令卸载LibreOffice，都删不干净， *Dolphin 文件管理器* 的新建项目中还是留有LibreOffice的项目。因此搜索到了这篇文章：[Debian 彻底卸载 LibreOffice](https://blog.baicai.me/article/2023/debian_remove_libreoffice/)，按照文章中的步骤，已完全卸载且目前未遇到问题。以下为执行命令的部分截图：

![Personal_perf7.png](Personal_perf7.png)  

**2. 卸载NeoChat**

官网说是个端到端的开源IM程序，我个人觉得没啥用。

## 五、与Windows 11的性能对比测试

测试平台：  

<img alt="Personal_perf27.png" src="Personal_perf27.png" width="80%" title="This image has been scaled to 80% of its original size."> 

// TODO 修好电脑后

以下测试结果均基于此测试平台。

### a. 跨平台测试

#### 1. Geekbench 6

Linux下 *Geekbench 6* 的介绍、下载、安装与基本操作步骤位于另一篇文章[Linux下的个人偏好应用的安装和使用体验，以及运行Windows应用](../Installation%20and%20experience%20of%20personal%20preference%20applications%20under%20Linux%20-%20Linux下的个人偏好应用的安装和使用体验/Installation%20and%20experience%20of%20personal%20preference%20applications%20under%20Linux%20-%20Linux下的个人偏好应用的安装和使用体验.md)的 *二、8.* ，此处直接展示结果。

Linux下 *Geekbench 6* CPU性能测试结果：

![Kubuntu_Geekbench_Plug_in_Performance0.png](Kubuntu_Geekbench_Plug_in_Performance0.png)  
 *（冷机单次测试）* 

Linux下 *Geekbench 6* GPU性能测试结果：

![Kubuntu_Geekbench_Plug_in_Performance1_hot.png](Kubuntu_Geekbench_Plug_in_Performance1_hot.png)  
 *（热机单次测试）* 

通过 *Geekbench 6* 判断性能释放，请参考另一篇文章《[联想Legion Go使用体验和自定义](../Lenovo%20Legion%20Go%20Experience%20and%20Customization%20-%20联想Legion%20Go使用体验和自定义/Lenovo%20Legion%20Go%20Experience%20and%20Customization%20-%20联想Legion%20Go使用体验和自定义.md)》的 *二、9.4* 。

#### 2. 跨平台游戏测试

我得先找到一个原生跨平台的、不太吃配置又不能一点配置都不吃的游戏，先等我找到吧💦  

原生跨平台，意味着其不能使用不受支持的专利图形API，如 *Microsoft DirectX* 。 *OpenGL* 和 *Vulkan* 是常见的开源图形API， *OpenCL* 是常见的开源计算框架。

20241011更新：找到了，但是都不太爱玩：

- [Steam 上的 Hollow Knight](https://store.steampowered.com/app/367520/Hollow_Knight/)
- [Steam 上的 塔罗斯的法则](https://store.steampowered.com/app/257510/)

20241011更新：啊！找到能玩的了！

- [Steam 上的 Shadow of the Tomb Raider: Definitive Edition](https://store.steampowered.com/app/750920/Shadow_of_the_Tomb_Raider_Definitive_Edition/)

![Personal_perf9.png](Personal_perf9.png) 

原来一直都在我愿望单里放着，汗流浃背了💦

虽然在Steam页面和游戏启动器上两次提醒不支持英特尔GPU运行，但实测是可以运行的，只是需要在启动器 *“高级选项”* 中选中 *“Intel(R) Xe Graphics with Vulkan (...)”* 渲染器选择项。

![Personal_perf11.png](Personal_perf11.png) 

Linux下 *《古墓丽影：暗影：终极版》* 在Vulkan API的如下的画面设定下的游戏内基准性能测试结果：

![Kubuntu_SOTR_Vulkan_Plug_in_Performance0_hot.png](Kubuntu_SOTR_Vulkan_Plug_in_Performance0_hot.png)

![Kubuntu_SOTR_Vulkan_Plug_in_Performance1_hot.png](Kubuntu_SOTR_Vulkan_Plug_in_Performance1_hot.png)
 *（热机单次测试）* 

### b. Windows兼容测试

#### 1. 3DMark

 *UL 3DMark* 的介绍、下载、问题解决和说明，请见另一篇文章《[Linux下的个人偏好应用的安装和使用体验，以及运行Windows应用](../Installation%20and%20experience%20of%20personal%20preference%20applications%20under%20Linux%20-%20Linux下的个人偏好应用的安装和使用体验/Installation%20and%20experience%20of%20personal%20preference%20applications%20under%20Linux%20-%20Linux下的个人偏好应用的安装和使用体验.md)》的 *三、1.* 。

Linux下通过 *Steam Play 兼容性* 运行 *3DMark Fire Strike* 的基准性能测试结果：

![Kubuntu_3DMark_FireStrike_Plug_in_Performance0_hot.png](Kubuntu_3DMark_FireStrike_Plug_in_Performance0_hot.png)  
 *（热机单次测试）* 

#### 2. Windows兼容游戏测试

&ensp;&ensp;&ensp;&ensp;**2.1 《命令与征服：红色警戒3》**

在画面设置全高、抗锯齿下调至8x、使用Proton Experimental的情况下，可以维持30FPS，个别多粒子画面会掉帧。

![Personal_perf28.png](Personal_perf28.png) 

&ensp;&ensp;&ensp;&ensp;**2.2 《奇点灰烬：扩展版》**

// TODO 修好电脑后

## 彩蛋

我勒个时光机啊

![Easter_egg.png](Easter_egg.png) 
