//
//  ViewController.m
//  MJAlertViewDemo
//
//  Created by Mayur on 2/19/15.
//  Copyright (c) 2015 MjApps. All rights reserved.
//

#import "ViewController.h"
#import "UIView+MJAlertView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Button actions
- (IBAction)showAlert:(id)sender {
    [UIView addMJNotifierWithText:@"This won't go. Click Dismiss to hide it!" dismissAutomatically:NO];
}
- (IBAction)showDismissableAlert:(id)sender {
    [UIView addMJNotifierWithText:@"Hey there!" dismissAutomatically:YES];
}
- (IBAction)dismissAlert:(id)sender {
    [UIView dismissMJNotifier];
}
- (IBAction)showWiderAlert:(id)sender {
    [UIView addMJNotifierWithText:@"Showing off a wider alert. #Yay" dismissAutomatically:YES];
}

@end