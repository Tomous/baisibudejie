//
//  NSCalendar+DCExtension.m
//  百思不得姐
//
//  Created by 大橙子 on 2019/4/19.
//  Copyright © 2019 Tomous. All rights reserved.
//

#import "NSCalendar+DCExtension.h"

@implementation NSCalendar (DCExtension)
+ (instancetype)calendar {
    if ([NSCalendar respondsToSelector:@selector(calendarWithIdentifier:)]) {
        return [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    }else {
        return [NSCalendar currentCalendar];
    }
}
@end
