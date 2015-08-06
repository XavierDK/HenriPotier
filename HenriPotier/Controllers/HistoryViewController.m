//
//  HistoryViewController.m
//  HenriPotier
//
//  Created by Xavier De Koninck on 23/07/2015.
//  Copyright (c) 2015 XavierDeKoninck. All rights reserved.
//

#import "HistoryViewController.h"
#import "HistoryViewControllerDataSource.h"
#import <MagicalRecord/MagicalRecord.h>
#import <OpenSans/UIFont+OpenSans.h>
#import "Basket.h"
#import "Book.h"

@interface HistoryViewController ()

@property (nonatomic, strong) HistoryViewControllerDataSource *historyControllerDataSource;

@end


@implementation HistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.historyControllerDataSource = [[HistoryViewControllerDataSource alloc] init];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.baskets = [[[Basket MR_findAll] reverseObjectEnumerator] allObjects];
    self.basketsBooks = [NSMutableArray array];
    for (Basket *basket in self.baskets) {
        
        NSArray *books = basket.books.allObjects;
        [self.basketsBooks addObject:books];
    }
    
    self.historyControllerDataSource.baskets = self.baskets;
    self.historyControllerDataSource.basketsBooks = self.basketsBooks;
    
    [self.tableView reloadData];
}


#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return [self.historyControllerDataSource tableView:tableView heightForHeaderInSection:section];
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [self.historyControllerDataSource tableView:tableView viewForHeaderInSection:section andFrame:CGRectMake(0, 0, self.view.frame.size.width, headerHeight)];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.historyControllerDataSource numberOfSectionsInTableView:tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.historyControllerDataSource tableView:tableView numberOfRowsInSection:section];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.historyControllerDataSource tableView:tableView cellForRowAtIndexPath:indexPath];
}

@end
