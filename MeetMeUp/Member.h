//
//  Member.h
//  MeetMeUp
//
//  Created by Evan Vandenberg 1/26/2015.
//  Copyright (c) 2014 Evan Vandenberg.
//

#import <Foundation/Foundation.h>

@interface Member : NSObject


@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSString *country;
@property (nonatomic, strong) NSURL *photoURL;


+ (void)getMemberByID:(NSString *)memberID withCompletion:(void(^)(Member *memberInfo))complete;
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
- (void)getUserImageWithCompletion:(void(^)(NSData *imageData))complete;



@end
