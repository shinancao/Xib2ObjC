//
//  XibLayoutViewController.m
//  Xib2ObjC_Client
//
//  Created by 张楠[产品技术中心] on 2019/4/21.
//  Copyright © 2019 zhangnan. All rights reserved.
//

#import "XibLayoutViewController.h"

@interface XibLayoutViewController ()<UITableViewDataSource, UICollectionViewDataSource>

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
    UIView *xibView = [[[NSBundle mainBundle] loadNibNamed:self.xibName owner:self options:nil] lastObject];
    CGFloat width = CGRectGetWidth(xibView.frame);
    CGFloat height = CGRectGetHeight(xibView.frame);
    
    if ([xibView isKindOfClass:[UITableViewCell class]]) {
        [self configTableView];
        return;
    }
    
    if ([xibView isKindOfClass:[UICollectionViewCell class]]) {
        [self configCollectionViewWithSize: CGSizeMake(width, height)];
        return;
    }
    
    [self.view addSubview:xibView];
    [xibView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    // 让要展示的界面居中
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(xibView);
    
    NSDictionary *metrics = @{@"width": @(width), @"height": @(height)};
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[containerView(==width)]" options:0 metrics:metrics views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[containerView(==height)]" options:0 metrics:metrics views:viewsDictionary]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:xibView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:xibView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
}

- (void)configTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    [tableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(tableView);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[tableView]-0-|" options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[tableView]-|" options:0 metrics:nil views:viewsDictionary]];
    
    tableView.dataSource = self;
    
    [tableView registerNib:[UINib nibWithNibName:self.xibName bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"tableCell"];
}

- (void)configCollectionViewWithSize:(CGSize)itemSize {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = itemSize;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:collectionView];
    [collectionView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(collectionView);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[collectionView]-0-|" options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[collectionView]-|" options:0 metrics:nil views:viewsDictionary]];
    
    collectionView.dataSource = self;
    
    [collectionView registerNib:[UINib nibWithNibName:self.xibName bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"collectionCell"];
}

- (void)generateCodeAction:(id)sender {
    NSString *cmd = [NSString stringWithFormat:@"parse:%@", self.xibName];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"com.xib2objc.sendMsg" object:cmd];
}

#pragma mark - Table View Data Source
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

#pragma mark - Collection View Data Source
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionCell" forIndexPath:indexPath];
    return cell;
}

@end
