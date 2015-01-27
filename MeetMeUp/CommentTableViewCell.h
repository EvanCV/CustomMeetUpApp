//
//  CommentTableViewCell.h
//  MeetMeUp
//
//  Created by Evan Vandenberg 1/26/2015.
//  Copyright (c) 2014 Evan Vandenberg.
//

#import <UIKit/UIKit.h>

@interface CommentTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end
