//
//  BNRTableViewController.m
//  FieldTech
//
//  Created by Stephen Christopher on 3/3/14.
//  Copyright (c) 2014 Jonathan Blocksom. All rights reserved.
//

#import "TableViewController.h"

@interface TableViewController ()

@end

@implementation TableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (CGFloat)barHeight
{
    CGRect statusBarFrame = [[UIApplication sharedApplication] statusBarFrame];
    CGFloat statusBarHeight = statusBarFrame.size.height;

    CGRect navBarFrame = self.navigationController.navigationBar.frame;
    CGFloat navHeight = navBarFrame.size.height;

    return statusBarHeight + navHeight;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return [self barHeight];
    }
    return 0.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        CGRect viewRect = CGRectMake(0.0, 0.0, self.tableView.frame.size.width, [self barHeight]);
        UIView *headerView = [[UIView alloc] initWithFrame:viewRect];
        [headerView setBackgroundColor:[UIColor whiteColor]];
        return headerView;
    }
    return nil;
}

@end
