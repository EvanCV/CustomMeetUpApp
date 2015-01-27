//
//  Event.h
//  MeetMeUp
//
//  Created by Evan Vandenberg 1/26/2015.
//  Copyright (c) 2014 Evan Vandenberg.
//

#import "Comment.h"
#import <Foundation/Foundation.h>

@interface Event : NSObject

@property (nonatomic, strong) NSString *eventID;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *RSVPCount;
@property (nonatomic, strong) NSString *hostedBy;
@property (nonatomic, strong) NSString *eventDescription;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSURL *eventURL;
@property (nonatomic, strong) NSURL *photoURL;
@property (nonatomic, strong) NSArray *commentsArray;

+ (NSArray *)eventsFromArray:(NSArray *)incomingArray;
+ (void)performSearchWithKeyword:(NSString *)keyword :(void(^)(NSArray *meetUps))complete;
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
- (void)getEventDetailsWithEventID :(NSString *)eventID :(void(^)(NSArray *eventDetailsArray))complete;
- (void)getImageWithCompletion: (NSURL *)photoURL :(void(^)(NSData *imageData))complete;


@end
