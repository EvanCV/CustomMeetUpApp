//
//  Comment.h
//  MeetMeUp
//
//  Created by Evan Vandenberg 1/26/2015.
//  Copyright (c) 2014 Evan Vandenberg.
//

#import <Foundation/Foundation.h>

@interface Comment : NSObject

@property (nonatomic, strong) NSString *memberID;
@property (nonatomic, strong) NSString *author;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) NSString *text;

+ (NSArray *)objectsFromArray:(NSArray *)incomingArray;
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
