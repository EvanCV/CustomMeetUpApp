//
//  Event.m
//  MeetMeUp
//
//  Created by Evan Vandenberg 1/26/2015.
//  Copyright (c) 2014 Evan Vandenberg.
//

#import "Event.h"

@implementation Event


- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        
        self.name = dictionary[@"name"];
        self.eventID = dictionary[@"id"];
        self.RSVPCount = [NSString stringWithFormat:@"%@",dictionary[@"yes_rsvp_count"]];
        self.hostedBy = dictionary[@"group"][@"name"];
        self.eventDescription = dictionary[@"description"];
        self.address = dictionary[@"venue"][@"address"];
        self.eventURL = [NSURL URLWithString:dictionary[@"event_url"]];
        self.photoURL = [NSURL URLWithString:dictionary[@"photo_url"]];
    }
    return self;
}


+ (NSArray *)eventsFromArray:(NSArray *)incomingArray
{
    NSMutableArray *newArray = [[NSMutableArray alloc] initWithCapacity:incomingArray.count];
    
    for (NSDictionary *d in incomingArray) {
        Event *e = [[Event alloc]initWithDictionary:d];
        [newArray addObject:e];
    }
    return newArray;
}


+ (void)performSearchWithKeyword:(NSString *)keyword :(void(^)(NSArray *meetUps))complete
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.meetup.com/2/open_events.json?zip=60604&text=%@&time=,1w&key=477d1928246a4e162252547b766d3c6d",keyword]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {

                               // called when done with connection
                               NSDictionary *tempDict;
                               tempDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                               NSArray *tempArray;
                                tempArray = [tempDict objectForKey:@"results"];

                               NSMutableArray *meetUpsArray = [[NSMutableArray alloc]init];
                               
                               for (NSDictionary *dictionary in tempArray)
                               {
                                   Event *meetUpEvent = [[Event alloc]initWithDictionary:dictionary];
                                   [meetUpsArray addObject:meetUpEvent];
                               }
                               complete(meetUpsArray);
                           }];
}


- (void)getEventDetailsWithEventID :(NSString *)eventID :(void(^)(NSArray *eventDetailsArray))complete
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.meetup.com/2/event_comments?&sign=true&photo-host=public&event_id=%@&page=20&key=477d1928246a4e162252547b766d3c6d",eventID]];

    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {

                               NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                               NSArray *jsonArray = [dict objectForKey:@"results"];
                               complete(jsonArray);
                           }];
}


- (void)getImageWithCompletion: (NSURL *)photoURL :(void(^)(NSData *imageData))complete
{
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:photoURL]
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                               complete(data);
                           }];
}


@end
