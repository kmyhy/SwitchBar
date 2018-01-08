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

    self.normalTitleColor = [UIColor colorWithRed:0x8a/255.0 green:0x8a/255.0 blue:0x82/255.0 alpha:1];
    self.selTitleColor = [UIColor colorWithRed:0xfa/255.0 green:0x50/255.0 blue:0x42/255.0 alpha:1];

//    self.normalTitleColor = [UIColor colorWithRed:0x43/255.0 green:0x43/255.0 blue:0x43/255.0 alpha:1];

    self.normalUnderlineColor = [UIColor colorWithRed:0xe8/255.0 green:0xe8/255.0 blue:0xe8/255.0 alpha:1];
    self.selUnderlineColor = _selTitleColor;
    
    self.normalUnderlineWidth = 2;
    
    self.selUnderlineWidth = 4;
    _selIndex = -1;
    self.titles = @[@"语音通知语音",@"通知语音通知语",@"音通知语音通知",@"文字通知"];
    
    self.textTopOffset = 17; // 文字距离上边距的距离
    self.underlineTopOffset =17; // 下划线距离文字的距离
    self.textMaxHeight = 14;// 文字占据的高度
    self.splitterVisible = YES;// 是否显示分割线
    self.splitterWidth = 2;
    self.splitterColor = [UIColor colorWithRed:0xf4/255.0 green:0xf4/255.0 blue:0xf4/255.0 alpha:1];
    self.selUnderlineWidthAlignToText = NO;
    self.selBoldFont = NO;
    self.underHairlineVisible = YES;
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
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
}

- (void)drawRect:(CGRect)rect {
    
    for(int i=0;i<_titles.count;i++){
        [self drawTitleAtIndex:i];

    }
}

-(void)drawUnderlineAtIndex:(NSInteger)index width:(CGFloat)width{
    
    BOOL selected = index==_selIndex;
    
    CGFloat itemWidth = CGRectGetWidth(self.frame)/_titles.count;
    
    CGPoint origin = CGPointMake(index*itemWidth, (_textTopOffset+_textMaxHeight+_underlineTopOffset+2)-(selected?_selUnderlineWidth/[UIScreen mainScreen].scale:_normalUnderlineWidth/[UIScreen mainScreen].scale)/2);
    
    CGFloat endX = 0;
    
//    if(selected && _selUnderlineWidthAlignToText){
//        
//    }
    
    UIBezierPath* linePath = [UIBezierPath bezierPath];
    
    [linePath moveToPoint: origin];
    
//    if(selected && _selUnderlineWidthAlignToText){
//        

//    }
    
    endX = origin.x+itemWidth-2;
    
    [linePath addLineToPoint: CGPointMake(endX, origin.y)];
    linePath.lineCapStyle = kCGLineCapSquare;
    
//    if(selected && _selUnderlineWidthAlignToText){
//        [_selUnderlineColor setStroke];
//    }
    [_normalUnderlineColor setStroke];
    
//    if(selected && _selUnderlineWidthAlignToText){
//        linePath.lineWidth = _selUnderlineWidth/[UIScreen mainScreen].scale;
//    }
    linePath.lineWidth = _normalUnderlineWidth/[UIScreen mainScreen].scale;
    if(_underHairlineVisible){
        [linePath stroke];
    }
    
    if(selected){ // 绘制加粗的选中下划线
        if(_selUnderlineWidthAlignToText){
            CGFloat offset = index*(itemWidth-1)+(itemWidth-width)/2;
            origin = CGPointMake(offset, (_textTopOffset+_textMaxHeight+_underlineTopOffset+2)-_selUnderlineWidth/[UIScreen mainScreen].scale);

            endX = origin.x + width + 4;// 加几个像素

        }
        
        UIBezierPath* linePath = [UIBezierPath bezierPath];
        [linePath moveToPoint: origin];
        [linePath addLineToPoint: CGPointMake(endX, origin.y)];
        linePath.lineCapStyle = kCGLineCapSquare;
        [_selUnderlineColor setStroke];
        
        linePath.lineWidth = _selUnderlineWidth/[UIScreen mainScreen].scale;
        [linePath stroke];
    }
}
-(void)drawTitleAtIndex:(NSInteger)index{
    BOOL selected = index==_selIndex;
    CGFloat itemWidth = CGRectGetWidth(self.frame)/_titles.count;
    NSString* title = _titles[index];
    
    CGContextRef context = UIGraphicsGetCurrentContext();

    NSMutableParagraphStyle* textStyle = NSMutableParagraphStyle.defaultParagraphStyle.mutableCopy;
    textStyle.alignment = NSTextAlignmentCenter;
    
    UIFont * font= (selected && _selBoldFont)?[UIFont boldSystemFontOfSize:_fontSize]:[UIFont systemFontOfSize:_fontSize];
    
    NSDictionary* textFontAttributes = @{NSFontAttributeName: font, NSForegroundColorAttributeName: selected?_selTitleColor:_normalTitleColor, NSParagraphStyleAttributeName: textStyle};
    
    CGSize textSize = [title boundingRectWithSize: CGSizeMake(itemWidth, _textMaxHeight)  options: NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingTruncatesLastVisibleLine attributes: textFontAttributes context: nil].size;
        
    CGRect textRect = CGRectMake(index*itemWidth, _textTopOffset+_textMaxHeight/2-textSize.height/2, itemWidth, textSize.height);
    
    CGContextSaveGState(context);
    CGContextClipToRect(context, textRect);
    [title drawInRect: textRect withAttributes: textFontAttributes];
    CGContextRestoreGState(context);
    
    [self drawUnderlineAtIndex:index width:textSize.width];// 绘制下划线
    
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
        
        if(i != self.selIndex){
            if(i <= 0){
                self.selIndex = 0;
            }else if(i >= _titles.count){
                self.selIndex = _titles.count -1;
            }else{
                self.selIndex = i;
            }
        }
        
    }
    
}

@end
