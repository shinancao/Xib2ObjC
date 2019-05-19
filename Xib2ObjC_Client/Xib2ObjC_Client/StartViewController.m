//
//  StartViewController.m
//  Xib2ObjC_Client
//
//  Created by 张楠[产品技术中心] on 2019/4/21.
//  Copyright © 2019 zhangnan. All rights reserved.
//

#import "StartViewController.h"
#import "XibFileHelper.h"
#import "XibLayoutViewController.h"

@interface StartViewController ()

@property (nonatomic, strong) XibFileHelper *xibHelper;

@end

@implementation StartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    self.clearsSelectionOnViewWillAppear = YES;
    
    _xibHelper = [[XibFileHelper alloc] init];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _xibHelper.xibFileNames.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableCell" forIndexPath:indexPath];
    cell.textLabel.text = _xibHelper.xibFileNames[indexPath.row];
 
    return cell;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    static NSString *const kIdy = @"toXibLayout";
    if ([[segue identifier] isEqualToString:kIdy]) {
        UITableViewCell *cell = (UITableViewCell *)sender;
        NSString *xibName = cell.textLabel.text;
        
        XibLayoutViewController *nextViewCtrl = [segue destinationViewController];
        nextViewCtrl.xibName = xibName;
    }
}


@end
