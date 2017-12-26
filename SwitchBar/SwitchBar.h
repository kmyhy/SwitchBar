//
//  SwitchBar.h
//  SwitchBar
//
//  Created by qq on 2017/2/20.
//  Copyright © 2017年 qq. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface SwitchBar : UIControl{
    NSMutableArray* textFrames;
    CGFloat lastTextOffset;
}
@property(assign,nonatomic)IBInspectable CGFloat fontSize;
@property(strong,nonatomic)IBInspectable UIColor* normalTitleColor;
@property(strong,nonatomic)IBInspectable UIColor* selTitleColor;
@property(strong,nonatomic)IBInspectable UIColor* normalUnderlineColor;
@property(strong,nonatomic)IBInspectable UIColor* selUnderlineColor;
@property(assign,nonatomic)IBInspectable CGFloat normalUnderlineWidth;
@property(assign,nonatomic)IBInspectable CGFloat selUnderlineWidth;
@property(assign,nonatomic)IBInspectable CGFloat textTopOffset;
@property(assign,nonatomic)IBInspectable CGFloat underlineTopOffset;
@property(assign,nonatomic)IBInspectable CGFloat textMaxHeight;

@property(strong,nonatomic)NSArray<NSString*>* titles;
@property(assign,nonatomic)IBInspectable NSInteger selIndex;

@property(assign,nonatomic)IBInspectable BOOL splitterVisible;
@property(assign,nonatomic)IBInspectable CGFloat splitterWidth;
@property(strong,nonatomic)IBInspectable UIColor* splitterColor;
@property(assign,nonatomic)IBInspectable BOOL selUnderlineWidthAlignToText;//选中时下划线对齐标题文本宽度

// 大小字模式特殊样式专用属性
@property(assign,nonatomic)IBInspectable BOOL advancedMode;// 是否使用大小字模式
@property(assign,nonatomic) BOOL underlineVisible;// 下划线是否可见
@property(assign,nonatomic) BOOL textAlignToLeft;// 文字左对齐
@property(assign,nonatomic) CGFloat textAlignToLeftPadding;// 文字左对齐边距
@property(assign,nonatomic) CGFloat bigFontSize;// 大字字号


@end
