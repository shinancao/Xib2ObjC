//
//  XibLayoutViewController.m
//  Xib2ObjC_Client
//
//  Created by 张楠[产品技术中心] on 2019/4/21.
//  Copyright © 2019 zhangnan. All rights reserved.
//

#import "XibLayoutViewController.h"
#import "StreamHelper.h"

@interface XibLayoutViewController ()

@property (nonatomic, strong) StreamHelper *streamHelper;

@end

@implementation XibLayoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = [NSString stringWithFormat:@"%@ Layout", self.xibName];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Generate Code" style:UIBarButtonItemStylePlain target:self action:@selector(generateCodeAction:)];
    
    [self configView];
    
    self.streamHelper = [[StreamHelper alloc] init];
}

- (void)configView {
    UIView *containerView = [[[NSBundle mainBundle] loadNibNamed:self.xibName owner:self options:nil] lastObject];
    [self.view addSubview:containerView];
    [containerView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    // 让要展示的界面居中
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(containerView);
    
    CGFloat width = CGRectGetWidth(containerView.frame);
    CGFloat height = CGRectGetHeight(containerView.frame);
    NSDictionary *metrics = @{@"width": @(width), @"height": @(height)};
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[containerView(==width)]" options:0 metrics:metrics views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[containerView(==height)]" options:0 metrics:metrics views:viewsDictionary]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:containerView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:containerView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
    
}

- (void)generateCodeAction:(id)sender {
    NSLog(@"generateCodeAction");
}

@end
