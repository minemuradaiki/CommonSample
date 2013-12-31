//
//  ANZCalendarNavigator.m
//  CommonSample
//
//  Created by ANZ on 2013/12/20.
//  Copyright (c) 2013年 ANZ. All rights reserved.
//

#import "ANZCalendarNavigator.h"

@interface ANZCalendarNavigator()

@property (nonatomic) UILabel* lbl;

@end

@implementation ANZCalendarNavigator

- (id)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame navigationType:ANZCalendarNavigatorTypePrevYear];
}

- (id)initWithFrame:(CGRect)frame navigationType:(ANZCalendarNavigatorType)navigationType
{
    if (self = [super initWithFrame:frame]) {
        _navigationType = navigationType;
        
        _lbl = [self createLabel];
        [self addSubview:_lbl];
    }
    return self;
}

- (UILabel *)createLabel {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    if ([self isTypeYear]) {
        label.adjustsFontSizeToFitWidth = YES;
    } else {
        label.numberOfLines = 3;
    }
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    return label;
}

- (BOOL)isTypeYear {
    return _navigationType == ANZCalendarNavigatorTypePrevYear || _navigationType == ANZCalendarNavigatorTypeNextYear;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    [self adjustNavigatorLabel];
    
}

- (void)adjustNavigatorLabel {
    self.lbl.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}

- (void)updateLabeWithDisplayDate:(NSDate *)displayDate attributes:(NSDictionary *)attributes
{
    NSDateComponents* components = [NSDateComponents new];
    NSTimeZone* tz = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    [components setTimeZone:tz];
    switch (self.navigationType) {
        case ANZCalendarNavigatorTypePrevYear:
            [components setYear: -1];
            break;
           
        case ANZCalendarNavigatorTypeNextYear:
            [components setYear: 1];
            break;
            
        case ANZCalendarNavigatorTypePrevMonth:
            [components setMonth: -1];
            break;
            
        default:
            [components setMonth: 1];
            break;
    }
    
    NSCalendar* calendar =  [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate* targetDate = [calendar dateByAddingComponents:components toDate:displayDate options:0];
    components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth fromDate:targetDate];
    
    if ([self isTypeYear]) {
        self.lbl.attributedText = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%ld", [components year]] attributes:attributes];
    } else {
        NSString* month;
        switch ([components month]) {
            case 1:
                month =@"J\nA\nN";
                break;
            
            case 2:
                month = @"F\nE\nB";
                break;
                
            case 3:
                month = @"M\nA\nR";
                break;
                
            case 4:
                month = @"A\nP\nR";
                break;
                
            case 5:
                month = @"M\nA\nY";
                break;
                
            case 6:
                month = @"J\nU\nN";
                break;
                
            case 7:
                month = @"J\nU\nL";
                break;
                
            case 8:
                month = @"A\nU\nG";
                break;
                
            case 9:
                month = @"S\nE\nP";
                break;
                
            case 10:
                month = @"O\nC\nT";
                break;
                
            case 11:
                month = @"N\nO\nV";
                break;
                
            case 12:
            default:
                month = @"D\nE\nC";
                break;
        }
        
        self.lbl.attributedText = [[NSAttributedString alloc] initWithString:month attributes:attributes];
    }
}

@end
