#一个 iOS 自定义的 Switch 控件

## 简介

一个 iOS 自定义 Switch 开关控件，提供简单的文字-下划线选择风格：

<img src='1.png' width=300/>

特点：用法简单，初始化一个 SwitchViewControllerBar 然后在你的 View Controller 中实现两个 SwitchViewControllerBarDelegate 委托方法。

## 用法

将 SwitchBar.h/.m、SwitchViewControllerBar.h/.m 拖到你的项目中。

在用到 SwitchViewControllerBar 的类中，导入头文件：

	#import "SwitchViewControllerBar.h"

###设置 UI

在故事版中，拖入一个 UIView，设置 Class 为 SwitchBar。
为这个 SwitchBar 创建一个 IBOutlet 连接，比如

	@property (weak, nonatomic) IBOutlet SwitchViewControllerBar *switchBar;
	
在拖入一个普通的 UIView，作为你的子 ViewController 的容器视图，并布局其位置和大小使其符合你要展示的子控制器大小。例如上图中的红色方块即是容器视图所在。为这个 UIView 创建一个 IBOutlet，并进行适当的命名，比如命名为 placeholderView。
###初始化 switchBar

初始化 SwitchBar 的 items：

```swift
	 _switchBar.titles = @[@"节目列表",@"专辑详情"];
    _switchBar.delegate = self;
    [_switchBar switchTo:0];
```

首先指定了子控制器的两个标题，然后设置 delegate 属性为当前 View Controller。最后，将第一个子控制器作为默认显示的子控制器。
### 实现 SwitchViewControllerBarDelegate 协议

代码：

```swift
// 1
-(UIView*)containerViewInSwitchBar:(SwitchViewControllerBar *)switchBar{
    return _placeholderView;
}
// 2
-(UIViewController*)controllerInSwitchBar:(SwitchViewControllerBar *)switchBar atIndex:(NSInteger)index{
    UIViewController* vc=[UIViewController new];
    switch(index){
        case 0:
            vc.view.backgroundColor = [UIColor lightGrayColor];
            break;
        case 1:
            vc.view.backgroundColor = [UIColor redColor];
            break;
        default:
            break;
    }
    return vc;
}
```

1. 用这个委托方法指定子控制器将放在哪个容器视图中显示。这里返回了我们在 IB 中创建的 placeholderView。
2. 这个方法根据子控制器索引，返回对应的子控制器。例如，第一个子控制器返回一个灰色背景的 UIViewController，第二个子控制器则返回一个红色背景的 UIViewController。
### 自定义属性

SwitchViewControllerBar 是 SwitchBar 的子类，继承了 SwitchBar 的以下属性：

* fontSize ：标题文本的字体大小;
* normalTitleColor：未选中时标题的文本颜色;
* selTitleColor：选中时标题的文本颜色;
* normalUnderlineColor：未选中时下划线的颜色;
* selUnderlineColor：选中时下划线颜色;
* normalUnderlineWidth：未选中时下划线的粗细;
* selUnderlineWidth：选中时下划线的粗细;
* textTopOffset：文字距离控件的上边距;
* underlineTopOffset：下划线距离文字的上边距;
* textMaxHeight：文字理论上（最大）可占据的高度;

* titles：字符串数组，有几个标题就有几个选项;
* selIndex：用户当前选中的标题索引。默认是 0;

* splitterVisible：标题之间的分割线是否可见;
* splitterWidth：分割线粗细;
* splitterColor：分割线颜色;
* selUnderlineWidthAlignToText:选中时下划线是否和标题宽度对齐，默认为 NO;
	
### Demo

在 Xcode 8 中打开 SwitchBar.xcodeproj。

有任何问题和建议，请与[作者](kmyhy@126.com)联系。






