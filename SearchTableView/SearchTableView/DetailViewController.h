//
//  DetailViewController.h
//  SearchTableView
//
//  Created by Deepthi Tayi on 12/11/13.
//  Copyright (c) 2013 D.T. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
