# 解决Windows下某些AI工具整合包中的PyTorch无法启用的问题

*版本：1.0*

查看Github渲染器中的**目录**：使用Github Markdown渲染页面右上角的“菜单”（⋮☰）按钮。

---

## 太长不看：下载libomp140.x86_64.dll并安装进System32。

## 测试环境

- CUDA提供：Nvidia Geforce RTX 4060 Ti (16Gb) 
- CUDA驱动程序：Nvidia CUDA 12.6.41 Driver (32.0.15.6081)
- OS：Windows 11 23H2 (x86_64)
- 整合包：[【AI绘画·24年4月最新】Stable Diffusion整合包v4.8发布！解压即用 防爆显存 三分钟入门AI绘画 ☆更新 ☆训练 ☆汉化 秋叶整合包](https://www.bilibili.com/video/BV1iM4y1y7oA/)

## 解决历程

显卡买了有10个月了，当初用“将来可以拿来玩AI啊，用AV1硬编码视频也是极好的”搪塞自己，结果光玩游戏了。这几天捣鼓B站上的Stable Diffusion整合包，用度盘下了一整天，结果解压后没法运行，上来就碰壁。启动报错：

`Torch is not able to use GPU; add --skip-torch-cuda-test to COMMANDLINE_ARGS variable to disable this check`

这个报错其实我并不陌生，因为上次尝试用AI翻唱也是遇到了一模一样的报错信息，那时候因为忄束负而且训练自有语音模型太麻烦，所以就摆烂放弃继续研究了。但这次再摆烂怕不是要彻底离开买显卡的初衷，于是照着报错在评论区、论坛和搜索引擎上一通找，尝试了以下解决方案，均失败：

- 更新显卡驱动
- 安装独立CUDA Toolkit
- webui-user.bat修改COMMANDLINE_ARGS（感觉整合包中的启动器并不使用这些bat文件）
- 安装独立的Python环境
- 修改PATH中的Python HOME路径
- 在启动器中修改PyTorch版本
- 在启动器中更新Stable Diffusion内核版本
- 祈祷

当然并不是所有人都在上面几步后还卡在这里，但至此我也一筹莫展了。既然问题出在PyTorch上，我寻思或许PyTorch更新一下呢，死马当活马医。找到内置的Python环境文件夹，运行pip3查看整合包内置PyTorch版本，确实比官网上的低一级；遂运行pip3对PyTorch进行更新，但问题依旧。

搜索时在GitHub上看到了相同的问题：
[Torch is not able to use GPU; add --skip-torch-cuda-test to COMMANDLINE_ARGS variable to disable this check · Issue #1742 · AUTOMATIC1111/stable-diffusion-webui](https://github.com/AUTOMATIC1111/stable-diffusion-webui/issues/1742#issuecomment-2055804422)。按照其指示，运行`torch.cuda.is_available()`，但直接报错：`OSError: [WinError 126] The specified module could not be found. Error loading “***\site-packages\torch\lib\fbgemm.dll” or one of its dependencies.`。

顺着这条报错继续搜索，在PyTorch论坛上发现了这样一条解决方案：[Failed to import pytorch fbgemm.dll or one of its dependencies is missing - windows - PyTorch Forums](https://discuss.pytorch.org/t/failed-to-import-pytorch-fbgemm-dll-or-one-of-its-dependencies-is-missing/201969/2)。和几条其他搜索结果交叉对比，能确定就是PyTorch在Windows上的动态链接库fbgemm.dll的链式调用缺了一个叫`libomp140.x86_64.dll`的库。这招我试过了啊，上次用AI翻唱那会儿就瞎搜搜到这了，然后按照下面的评论说的，安装最新版Visual C++运行库，问题根本没有得到解决。

但这次就是轴了一点，专门去搜的缺少的这个`libomp140.x86_64.dll`，搜到了微软的这篇开发博客：[Improved OpenMP Support for C++ in Visual Studio - C++ Team Blog](https://devblogs.microsoft.com/cppblog/improved-openmp-support-for-cpp-in-visual-studio/)。即PyTorch在Windows上需要调用微软的“利用 LLVM 的 OpenMP 运行时库”。微软Visual Studio开发组认为这个库还不够成熟，于是就没有放到Visual C++的正式再分发运行库中。如果想要单独获取这个库，可以装一遍预览版Visual Studio然后在软件的文件夹中提取……

哦我说呢为啥装了运行库也无济于事。但我真的懒得为了一个库装一个超重的IDE，我电脑上已经有好几个IDE了……于是就单独下了个`libomp140.x86_64.dll`，秉着试一试的态度扔进System32，结果，WebUI还真就开始跑起来了……

这么看来我上次就差那么一点就能把这个问题解决了，还是懒。