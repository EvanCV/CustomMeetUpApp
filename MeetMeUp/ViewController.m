//
//  ViewController.m
//  MeetMeUp
//
//  Created by Evan Vandenberg 1/26/2015.
//  Copyright (c) 2014 Evan Vandenberg.
//

#import "Event.h"
#import "EventDetailViewController.h"
#import "ViewController.h"

@interface ViewController () <UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UITableView *searchBar;
@property (nonatomic, strong) NSArray *dataArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController
            
- (void)viewDidLoad {
    [super viewDidLoad];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"eventCell"];
    
    Event *e = self.dataArray[indexPath.row];
    
    cell.textLabel.text = e.name;
    cell.detailTextLabel.text = e.address;
    if (e.photoURL)
    {
        //Instance method for setting custom event images
         [e getImageWithCompletion:e.photoURL :^(NSData *imageData) {
             cell.imageView.image = [UIImage imageWithData:imageData];
             [cell layoutSubviews];//forces the view to update/re-draw itself
         }];
    }
    else
    {
        //Defaults to MeetUp Logo
       [cell.imageView setImage:[UIImage imageNamed:@"logo"]];
    }
    
    return cell;
}


//Class method - Takes text entered into search bar and searches for similar events using MeetUp API
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [Event performSearchWithKeyword:searchBar.text :^(NSArray *meetUps) {
        self.dataArray = meetUps;
        [self.tableView reloadData];
    }];
    
    [searchBar resignFirstResponder];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    EventDetailViewController *detailVC = [segue destinationViewController];

    Event *e = self.dataArray[self.tableView.indexPathForSelectedRow.row];
    detailVC.event = e;
}

@end
