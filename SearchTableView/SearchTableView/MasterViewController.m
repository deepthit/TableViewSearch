//
//  MasterViewController.m
//  SearchTableView
//
//  Created by Deepthi Tayi on 12/11/13.
//  Copyright (c) 2013 D.T. All rights reserved.
//

#import "MasterViewController.h"

#import "DetailViewController.h"

@interface MasterViewController () {
  __strong NSMutableArray *parseResults;
  __strong NSArray *mFilteredArray_;
  __strong UISearchBar *mSearchBar_;
  __strong UISearchDisplayController *mSearchDisplayController_;
}
@end

@implementation MasterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    self.title = NSLocalizedString(@"Master", @"Master");
      NSDictionary *d1 = [NSDictionary dictionaryWithObjectsAndKeys:
                         @"title one", @"title",
                         @"title one summary", @"summary",
                         nil];
      NSDictionary *d2 = [NSDictionary dictionaryWithObjectsAndKeys:
                          @"title two", @"title",
                          @"title two summary", @"summary",
                         nil];
      NSDictionary *d3 = [NSDictionary dictionaryWithObjectsAndKeys:
                          @"title three", @"title",
                          @"title three summary", @"summary",
                         nil];
      NSDictionary *d4 = [NSDictionary dictionaryWithObjectsAndKeys:
                          @"title four", @"title",
                          @"title four summary", @"summary",
                         nil];
      NSDictionary *d5 = [NSDictionary dictionaryWithObjectsAndKeys:
                          @"title five", @"title",
                          @"title five summary", @"summary",
                         nil];
      parseResults = [NSArray arrayWithObjects:d1, d2, d3, d4, d5, nil];
    }
    return self;
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
  
  mSearchBar_ = [[UISearchBar alloc] initWithFrame:CGRectMake(0,
                                                              0,
                                                              self.view.bounds.size.width,
                                                              44)];
  mSearchBar_.delegate = self;
  mSearchBar_.placeholder = @"search";
  self.tableView.tableHeaderView = mSearchBar_;
  
  mSearchDisplayController_ = [[UISearchDisplayController alloc] initWithSearchBar:mSearchBar_
                                                                contentsController:self];
  mSearchDisplayController_.searchResultsDelegate = self;
  mSearchDisplayController_.searchResultsDataSource = self;
  mSearchDisplayController_.delegate = self;

}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
  numberOfRowsInSection:(NSInteger)section
{
  if (tableView == self.searchDisplayController.searchResultsTableView ||
      [mFilteredArray_ count] > 0)
  {
    return [mFilteredArray_ count];
  }
  return parseResults.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  id result;
  if (tableView == self.searchDisplayController.searchResultsTableView ||
      [mFilteredArray_ count] > 0)
  {
    result = [mFilteredArray_ objectAtIndex:indexPath.row];
  }
  else
  {
    result = [parseResults objectAtIndex:indexPath.row];
  }
  
 static NSString *CellIdentifier = @"Cell";
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
 if (cell == nil)
 {
   cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:CellIdentifier];
   cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
 }

  cell.textLabel.text = [result objectForKey:@"title"];
  cell.detailTextLabel.text = [result objectForKey:@"summary"];
  
  return cell;
}

- (void)tableView:(UITableView *)tableView
  didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!self.detailViewController) {
        self.detailViewController = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
    }
    NSDate *object = parseResults[indexPath.row];
    self.detailViewController.detailItem = object;
    [self.navigationController pushViewController:self.detailViewController animated:YES];
}

#pragma mark - UISearchBarDelegate

- (void)searchBar:(UISearchBar *)searchBar
    textDidChange:(NSString *)searchText
{
  if ([searchText length] == 0)
  {
    [self.tableView reloadData];
    return;
  }
  
  NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.title contains[cd] %@ OR SELF.summary contains[cd] %@", searchText, searchText];
  mFilteredArray_ = [parseResults filteredArrayUsingPredicate:predicate];
  
  [self.tableView reloadData];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
  mFilteredArray_ = nil;
  [self.tableView reloadData];
}


@end
