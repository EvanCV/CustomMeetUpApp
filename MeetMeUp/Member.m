//
//  Member.m
//  MeetMeUp
//
//  Created by Evan Vandenberg 1/26/2015.
//  Copyright (c) 2014 Evan Vandenberg.
//

#import "Member.h"

@implementation Member

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.name = dictionary[@"name"];
        self.state = dictionary[@"state"];
        self.city = dictionary[@"city"];
        self.country = dictionary[@"country"];
        
        self.photoURL = [NSURL URLWithString:dictionary[@"photo"][@"photo_link"]];
    }
    return self;
}

+ (void)getMemberByID:(NSString *)memberID withCompletion:(void(^)(Member *memberInfo))complete
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.meetup.com/2/member/%@?&sign=true&photo-host=public&page=20&key=477d1928246a4e162252547b766d3c6d",memberID]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                               NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                               Member *member = [[Member alloc]initWithDictionary:dict];
                               complete(member);
                           }];
}


- (void)getUserImageWithCompletion:(void(^)(NSData *imageData))complete
{
[NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:self.photoURL] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
    complete(data);
}];
}

@end
