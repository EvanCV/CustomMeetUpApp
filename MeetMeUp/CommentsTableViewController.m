//
//  CommentsTableViewController.m
//  MeetMeUp
//
//  Created by Evan Vandenberg 1/26/2015.
//  Copyright (c) 2014 Evan Vandenberg.
//

#import "Event.h"
#import "MemberViewController.h"
#import "CommentTableViewCell.h"
#import "CommentsTableViewController.h"

@interface CommentsTableViewController ()

@property (nonatomic, strong)NSArray *dataArray;
@property (nonatomic, strong)NSDateFormatter *dateFormatter;

@end

@implementation CommentsTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];


    [self.event getEventDetailsWithEventID:self.event.eventID :^(NSArray *eventDetailsArray) {
        self.dataArray = eventDetailsArray;
        [self.tableView reloadData];
    }];

    self.dateFormatter = [[NSDateFormatter alloc]init];
    [self.dateFormatter setDateStyle:NSDateFormatterShortStyle];
}

- (void)setDataArray:(NSArray *)dataArray
{
    _dataArray = dataArray;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"commentCell"];
    
    Comment *c = [[Comment alloc]initWithDictionary:[self.dataArray objectAtIndex:indexPath.row]];
    cell.authorLabel.text = c.author;
    cell.commentLabel.text = c.text;
    cell.dateLabel.text = [self.dateFormatter stringFromDate:c.date];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    MemberViewController *memberVC = [segue destinationViewController];
    NSIndexPath *path = [self.tableView indexPathForSelectedRow];
    Comment *comment = [[Comment alloc]initWithDictionary:[self.dataArray objectAtIndex:path.row]];
    memberVC.memberID = comment.memberID;
}


@end
