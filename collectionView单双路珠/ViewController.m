//
//  ViewController.m
//  collectionView单双路珠
//
//  Created by IMAC on 2017/3/2.
//  Copyright © 2017年 小四. All rights reserved.
//

#import "ViewController.h"
#import "TestVC.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    NSLog(@"测试一下");
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"分支111");
}
- (IBAction)btnClick:(id)sender {
    NSLog(@"分支2");
    TestVC *vc = [[TestVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
    NSLog(@"分支222");
}

 


@end
