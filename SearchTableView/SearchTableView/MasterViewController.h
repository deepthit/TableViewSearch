//
//  MasterViewController.h
//  SearchTableView
//
//  Created by Deepthi Tayi on 12/11/13.
//  Copyright (c) 2013 D.T. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@interface MasterViewController : UITableViewController
<
UISearchBarDelegate,
UISearchDisplayDelegate
>

@property (strong, nonatomic) DetailViewController *detailViewController;

@end
