//
//  SwitchViewControllerBar.m
//  SwitchBar
//
//  Created by qq on 2017/4/11.
//  Copyright © 2017年 qq. All rights reserved.
//

#import "SwitchViewControllerBar.h"

@implementation SwitchViewControllerBar

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){
        [self initAction];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self initAction];
    }
    return self;
}
-(instancetype)init{
    CGRect rect = CGRectMake(0, 0, 220, 220);
    self = [self initWithFrame:rect];
    return self;
}
-(void)initAction{
    [self addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventValueChanged];
}
-(void)valueChange:(SwitchViewControllerBar*)sender{
    [self switchTo:sender.selIndex];
}
-(void)switchTo:(NSInteger)to{
    
    if(self.delegate){
        
        NSInteger from = self.selIndex;
        
        UIViewController* toVC=[self.delegate controllerInSwitchBar:self atIndex:to];// toVC 都是新建的
        
        UIView* containerView = [self.delegate containerViewInSwitchBar:self];
        if(toVC == nil || containerView == nil){
            return;
        }
        
        if(self.delegate.childViewControllers.count == 0 || to==from){// 第一次显示(或者要切换的两个视图是同一个)，不需要转换动画
            toVC.view.frame = CGRectMake(0,0, containerView.frame.size.width, containerView.frame.size.height);
            [self.delegate addChildViewController:toVC];
            [containerView addSubview:toVC.view];
            [toVC didMoveToParentViewController:self.delegate];
            [self setSelIndex:to];// 这句重要！否则 title 的选中样式不会变！
        }else if(self.delegate.childViewControllers.count == 1){
            // 每次转换动画完成后，fromVC 都会被抛弃，childViewController 中只包含 toVC
            UIViewController* fromVC = self.delegate.childViewControllers[0];
            
            if(to > from ) {
                toVC.view.frame = CGRectMake(containerView.frame.size.width,0, containerView.frame.size.width, containerView.frame.size.height);
            }else if(to < from){
                toVC.view.frame = CGRectMake(-containerView.frame.size.width,0,containerView.frame.size.width,containerView.frame.size.height);
            }
            
            // 添加 toVC，这样 childViewController 的数目为 2 了
            [self.delegate addChildViewController:toVC];
            [toVC didMoveToParentViewController:self.delegate];
            
            //                NSLog(@"Transition before，subviews:%ld,childViewControllers:%ld",self.containerView.subviews.count,self.childViewControllers.count);
            
            ;
            // 转换动画
            [self.delegate transitionFromViewController:fromVC toViewController:toVC duration:0.4 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                [containerView addSubview:toVC.view];
                if(to > from){
                    fromVC.view.frame = CGRectMake(-containerView.frame.size.width, 0,containerView.frame.size.width,containerView.frame.size.height);
                }else{// 如果导航到 SecondController
                    fromVC.view.frame = CGRectMake(containerView.frame.size.width, 0,containerView.frame.size.width,containerView.frame.size.height);
                }
                toVC.view.frame = CGRectMake(0, 0,containerView.frame.size.width,containerView.frame.size.height);
                //        [toVC didMoveToParentViewController:self];
                
            } completion:^(BOOL finished) {
                // 清理动作，保证动画结束后，childViewControllers 中只有 1 个 view controller,
                // subviews 中只有 1 个 view。
                [fromVC willMoveToParentViewController:nil];
                // 移除 fromViewController
                [fromVC removeFromParentViewController];
                
                [fromVC.view removeFromSuperview];
                
                //            NSLog(@"Transition finished，subviews:%ld,childViewControllers:%ld",self.containerView.subviews.count,self.childViewControllers.count);
                
                [self setSelIndex:to];// 这句重要！否则 title 的选中样式不会变！
            }];
            
        }
    }else{
        self.selIndex = to;
    }  
}
@end
