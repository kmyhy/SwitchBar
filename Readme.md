#一个 iOS 自定义的 Switch 控件

## 简介

一个 iOS 自定义 Switch 开关控件，提供简单的文字-下划线选择风格：

<img src='1.png' width=300/>

特点：用法简单，只需要在一个字符串数组中指定你要提供的选项。

## 用法

将 SwitchBar.h 和 SwitchBar.m 拖到你的项目中。

导入头文件：

	#import "SwitchBar.h"

###设置 UI

在故事版中，拖入一个 UIView，设置 Class 为 SwitchBar。
为这个 SwitchBar 创建一个 IBOutlet 连接，比如

	@property (weak, nonatomic) IBOutlet SwitchBar *switchBar;
	
为 SwitchBar 的 valueChanged 事件创建 IBAction 连接，并在 IBAction 方法中进行处理。

###初始化设置

初始化 SwitchBar 的 items：

```swift
switchBar.titles = @[@"公司同事",@"往来单位联系人",@"个人联系人"];
```

### 实现 valueChanged 事件处理

代码：

```swift
-(IBAction)valueChanged:(SwitchBar*)sender{
	NSLog(@"选择了:%@",sender.titles[sender.selIndex]);
}
```

### 自定义属性

SwitchBar 支持以下自定义属性：

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
	
### Demo

在 Xcode 8 中打开 SwitchBar.xcodeproj。

有任何问题和建议，请与[作者](kmyhy@126.com)联系。






