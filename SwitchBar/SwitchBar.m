//
//  SwitchBar.m
//  SwitchBar
//
//  Created by qq on 2017/2/20.
//  Copyright © 2017年 qq. All rights reserved.
//

#import "SwitchBar.h"

@implementation SwitchBar
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){
        [self setup];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self setup];
    }
    return self;
}
-(instancetype)init{
    CGRect rect = CGRectMake(0, 0, 220, 220);
    self = [self initWithFrame:rect];
    return self;
}
-(void)setup{
    self.fontSize = 14.0;
    self.normalTitleColor = [UIColor colorWithRed:0x43/255.0 green:0x43/255.0 blue:0x43/255.0 alpha:1];
    self.selTitleColor = [UIColor colorWithRed:0x1d/255.0 green:0xc2/255.0 blue:0xc0/255.0 alpha:1];
    self.normalUnderlineColor = [UIColor colorWithRed:0xe8/255.0 green:0xe8/255.0 blue:0xe8/255.0 alpha:1];
    self.selUnderlineColor = _selTitleColor;
    
    self.normalUnderlineWidth = 2;
    
    self.selUnderlineWidth = 4;
    self.selIndex = 0;
    self.titles = @[@"语音通知语音",@"通知语音通知语",@"音通知语音通知",@"文字通知"];
    
    self.textTopOffset = 17; // 文字距离上边距的距离
    self.underlineTopOffset =17; // 下划线距离文字的距离
    self.textMaxHeight = 14;// 文字占据的高度
    self.splitterVisible = YES;// 是否显示分割线
    self.splitterWidth = 2;
    self.splitterColor = [UIColor colorWithRed:0xf4/255.0 green:0xf4/255.0 blue:0xf4/255.0 alpha:1];
}
-(void)setSelIndex:(NSInteger)selIndex{
    if(selIndex != _selIndex){
        if(selIndex <= 0){
            _selIndex = 0;
        }else if(selIndex >= _titles.count){
            _selIndex = _titles.count -1;
        }else{
            _selIndex = selIndex;
        }
        [self setNeedsDisplay];
    }
}

- (void)drawRect:(CGRect)rect {
    
    for(int i=0;i<_titles.count;i++){
        [self drawTitleAtIndex:i];
        [self drawUnderlineAtIndex:i];
        
    }
}

-(void)drawUnderlineAtIndex:(NSInteger)index{
    
    BOOL selected = index==_selIndex;
    
    CGFloat itemWidth = CGRectGetWidth(self.frame)/_titles.count;
    
    CGPoint origin = CGPointMake(index*itemWidth, (_textTopOffset+_textMaxHeight+_underlineTopOffset)-(selected?_selUnderlineWidth/[UIScreen mainScreen].scale:_normalUnderlineWidth/[UIScreen mainScreen].scale)/2);
    
    UIBezierPath* linePath = [UIBezierPath bezierPath];
    [linePath moveToPoint: origin];
    [linePath addLineToPoint: CGPointMake(origin.x+itemWidth-2, origin.y)];
    linePath.lineCapStyle = kCGLineCapSquare;
    
    [selected?_selUnderlineColor:_normalUnderlineColor setStroke];
    linePath.lineWidth = selected?_selUnderlineWidth/[UIScreen mainScreen].scale:_normalUnderlineWidth/[UIScreen mainScreen].scale;
    [linePath stroke];
}
-(void)drawTitleAtIndex:(NSInteger)index{
    BOOL selected = index==_selIndex;
    CGFloat itemWidth = CGRectGetWidth(self.frame)/_titles.count;
    NSString* title = _titles[index];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    NSMutableParagraphStyle* textStyle = NSMutableParagraphStyle.defaultParagraphStyle.mutableCopy;
    textStyle.alignment = NSTextAlignmentCenter;
    
    NSDictionary* textFontAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize: _fontSize], NSForegroundColorAttributeName: selected?_selTitleColor:_normalTitleColor, NSParagraphStyleAttributeName: textStyle};
    
    CGFloat textHeight = [title boundingRectWithSize: CGSizeMake(itemWidth, _textMaxHeight)  options: NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingTruncatesLastVisibleLine attributes: textFontAttributes context: nil].size.height;
    
    CGRect textRect = CGRectMake(index*itemWidth, _textTopOffset+_textMaxHeight/2-textHeight/2, itemWidth, textHeight);
    
    CGContextSaveGState(context);
    CGContextClipToRect(context, textRect);
    [title drawInRect: textRect withAttributes: textFontAttributes];
    CGContextRestoreGState(context);
    
    // 绘制分隔线
    if(_splitterVisible && index>0){
        
        UIBezierPath* linePath = [UIBezierPath bezierPath];
        [linePath moveToPoint: textRect.origin];
        [linePath addLineToPoint: CGPointMake(textRect.origin.x, CGRectGetMaxY(textRect))];
        linePath.lineCapStyle = kCGLineCapSquare;
        
        [_splitterColor setStroke];
        linePath.lineWidth = _splitterWidth/[UIScreen mainScreen].scale;
        [linePath stroke];
        
    }
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if(touches.count == 1){
        CGPoint touchPos = [[touches anyObject] locationInView:self];
        
        int i = touchPos.x/(CGRectGetWidth(self.frame)/_titles.count);
        
        self.selIndex = i;
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
    
}

@end
