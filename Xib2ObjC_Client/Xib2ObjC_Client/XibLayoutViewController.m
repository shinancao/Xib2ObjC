//
//  XibLayoutViewController.m
//  Xib2ObjC_Client
//
//  Created by 张楠[产品技术中心] on 2019/4/21.
//  Copyright © 2019 zhangnan. All rights reserved.
//

#import "XibLayoutViewController.h"

@interface XibLayoutViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation XibLayoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = [NSString stringWithFormat:@"%@ Layout", self.xibName];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Generate Code" style:UIBarButtonItemStylePlain target:self action:@selector(generateCodeAction:)];
    
    [self configView];
}

- (void)configView {
    UIView *containerView = [[[NSBundle mainBundle] loadNibNamed:self.xibName owner:self options:nil] lastObject];
    
    if ([containerView isKindOfClass:[UITableViewCell class]]) {
        [self configTableView];
        return;
    }
    
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

- (void)configTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    [tableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(tableView);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[tableView]-0-|" options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[tableView]-|" options:0 metrics:nil views:viewsDictionary]];
    
    tableView.delegate = self;
    tableView.dataSource = self;
    
    [tableView registerNib:[UINib nibWithNibName:self.xibName bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"tableCell"];
}

- (void)generateCodeAction:(id)sender {
    NSString *cmd = [NSString stringWithFormat:@"parse:%@", self.xibName];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"com.xib2objc.sendMsg" object:cmd];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableCell" forIndexPath:indexPath];
    return cell;
}

@end
