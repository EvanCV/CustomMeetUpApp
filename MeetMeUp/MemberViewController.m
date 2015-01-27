//
//  MemberViewController.m
//  MeetMeUp
//
//  Created by Evan Vandenberg 1/26/2015.
//  Copyright (c) 2014 Evan Vandenberg.
//

#import "Member.h"
#import "MemberViewController.h"

@interface MemberViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (nonatomic, strong) Member *member;

@end

@implementation MemberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.photoImageView.alpha = 0;

    [Member getMemberByID:self.memberID withCompletion:^(Member *memberInfo) {
        self.member = memberInfo;
    }];
}

- (void)setMember:(Member *)member
{
    _member = member;
    self.nameLabel.text = member.name;

   [member getUserImageWithCompletion:^(NSData *imageData) {
       self.photoImageView.image = [UIImage imageWithData:imageData];

       [UIView animateWithDuration:.3 animations:^{
           self.photoImageView.alpha = 1;
       }];
   }];

}



@end
