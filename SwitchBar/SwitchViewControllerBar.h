//
//  SwitchViewControllerBar.h
//  SwitchBar
//
//  Created by qq on 2017/4/11.
//  Copyright © 2017年 qq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SwitchBar.h"


@class SwitchViewControllerBar;
@protocol SwitchViewControllerBarDelegate <NSObject>
@required
-(UIView*)containerViewInSwitchBar:(SwitchViewControllerBar*)switchBar;
-(UIViewController*)controllerInSwitchBar:(SwitchViewControllerBar*)switchBar atIndex:(NSInteger)index;
@end

IB_DESIGNABLE
@interface SwitchViewControllerBar : SwitchBar
@property(weak,nonatomic)UIViewController<SwitchViewControllerBarDelegate> *delegate;
-(void)switchTo:(NSInteger)to;
@end
