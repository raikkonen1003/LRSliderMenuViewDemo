//
//  ViewController.m
//  LRSliderMenuViewDemo
//
//  Created by liliansi on 2018/6/15.
//  Copyright © 2018年 liliansi. All rights reserved.
//

#import "ViewController.h"
#import "SliderMenuDemoViewController.h"

@interface ViewController ()

@end

@implementation ViewController
- (IBAction)toggleAction:(id)sender {
    
    SliderMenuDemoViewController *vc = [[SliderMenuDemoViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
