//
//  SwitchBar.m
//  SwitchBar
//
//  Created by qq on 2017/2/20.
//  Copyright © 2017年 qq. All rights reserved.
//

#import "SwitchBar.h"
#import "UIColor+Hex.h"

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
    self.selTitleColor = [UIColor colorWithRed:0xfa/255.0 green:0x50/255.0 blue:0x42/255.0 alpha:1];
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
    self.selUnderlineWidthAlignToText = NO;
    
    self.advancedMode = NO;
    self.underlineVisible = YES;// 默认下划线可见
    self.textAlignToLeft = NO; // 默认文字不左对齐（中对齐）
    self.textAlignToLeftPadding = 32;// 默认文字左对齐间距 0
    self.bigFontSize = self.fontSize;// 默认大小字体一致
    
}
-(void)setAdvancedMode:(BOOL)advancedMode{
    _advancedMode = advancedMode;
    if(advancedMode){
        _underlineVisible = NO;
        _textAlignToLeft = YES;
        _textAlignToLeftPadding = 13;
        _bigFontSize = 28;
        _selTitleColor = [UIColor blackColor];
        _normalTitleColor = [UIColor colorWithHex:0x868686];
        _fontSize = 16;
    }else{
        self.underlineVisible = YES;// 默认下划线可见
        self.textAlignToLeft = NO; // 默认文字不左对齐（中对齐）
        self.textAlignToLeftPadding = 0;// 默认文字左对齐间距 0
        self.bigFontSize = self.fontSize;// 默认大小字体一致
    }
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
    textFrames = [NSMutableArray new];
    lastTextOffset = 0;
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
    [linePath stroke];
    
    if(selected){ // 绘制加粗的选中下划线
        if(_selUnderlineWidthAlignToText){
            CGFloat offset = index*(itemWidth-1)+(itemWidth-width)/2;
            origin = CGPointMake(offset, (_textTopOffset+_textMaxHeight+_underlineTopOffset+2)-_selUnderlineWidth/[UIScreen mainScreen].scale);

            endX = origin.x + width;

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
    CGFloat itemWidth = 0;
    itemWidth=CGRectGetWidth(self.frame)/_titles.count;
    NSString* title = _titles[index];
    
    CGContextRef context = UIGraphicsGetCurrentContext();

    NSMutableParagraphStyle* textStyle = NSMutableParagraphStyle.defaultParagraphStyle.mutableCopy;
    textStyle.alignment = NSTextAlignmentCenter;
    
    UIFont* font = [UIFont systemFontOfSize:_fontSize];
    if(_advancedMode){
        font = selected?[UIFont boldSystemFontOfSize:_bigFontSize]:[UIFont systemFontOfSize:_fontSize];
    }
    NSDictionary* textFontAttributes = @{NSFontAttributeName: font, NSForegroundColorAttributeName: selected?_selTitleColor:_normalTitleColor, NSParagraphStyleAttributeName: textStyle};
    
    
    CGSize textSize = CGSizeZero;
    CGRect textRect = CGRectZero;
    
    if(self.textAlignToLeft){// 文字左对齐
        textSize = [title boundingRectWithSize: CGSizeMake(CGFLOAT_MAX, _textMaxHeight)  options: NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingTruncatesLastVisibleLine attributes: textFontAttributes context: nil].size;
        itemWidth = textSize.width+self.textAlignToLeftPadding*2;
        textRect = CGRectMake(lastTextOffset, _textTopOffset+_textMaxHeight/2-textSize.height/2, itemWidth, textSize.height);
        lastTextOffset = CGRectGetMaxX(textRect);
    }else{// 文字中对齐
        textSize = [title boundingRectWithSize: CGSizeMake(itemWidth, _textMaxHeight)  options: NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingTruncatesLastVisibleLine attributes: textFontAttributes context: nil].size;
         textRect = CGRectMake(index*itemWidth, _textTopOffset+_textMaxHeight/2-textSize.height/2, itemWidth, textSize.height);
    }
    
    [textFrames addObject:[NSValue valueWithCGRect:textRect]];
    
    if(self.textAlignToLeftPadding){
        textRect = CGRectMake(textRect.origin.x+self.textAlignToLeftPadding, textRect.origin.y, textRect.size.width-self.textAlignToLeftPadding*2, textRect.size.height);
    }
    CGContextSaveGState(context);
    CGContextClipToRect(context, textRect);
    [title drawInRect: textRect withAttributes: textFontAttributes];
    CGContextRestoreGState(context);
    
    if(self.underlineVisible){
        [self drawUnderlineAtIndex:index width:textSize.width];// 绘制下划线
    }
    
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
        
        int i = 0;//touchPos.x/(CGRectGetWidth(self.frame)/_titles.count);
        
        for(int j=0;j<textFrames.count;j++){
            NSValue *value = textFrames[j];
            CGRect rect = [value CGRectValue];
            if(CGRectContainsPoint(rect, touchPos)){
                i = j;
                break;
            }
        }
        
        if(i != self.selIndex){
            if(i <= 0){
                self.selIndex = 0;
            }else if(i >= _titles.count){
                self.selIndex = _titles.count -1;
            }else{
                self.selIndex = i;
            }
            [self sendActionsForControlEvents:UIControlEventValueChanged];
        }
        
    }
    
}

@end
