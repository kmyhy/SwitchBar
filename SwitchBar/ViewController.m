//
//  ViewController.m
//  SwitchBar
//
//  Created by qq on 2017/2/20.
//  Copyright © 2017年 qq. All rights reserved.
//

#import "ViewController.h"
#import "SwitchViewControllerBar.h"

@interface ViewController ()<SwitchViewControllerBarDelegate>
@property (weak, nonatomic) IBOutlet UIView *placeholderView;
@property (weak, nonatomic) IBOutlet SwitchViewControllerBar *switchBar;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _switchBar.titles = @[@"节目列表",@"专辑详情"];
    _switchBar.selUnderlineWidthAlignToText = YES;
    _switchBar.delegate = self;
    [_switchBar switchTo:0];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// MARK: - SwitchViewControllerBarDelegate
-(UIView*)containerViewInSwitchBar:(SwitchViewControllerBar *)switchBar{
    return _placeholderView;
}
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
@end
