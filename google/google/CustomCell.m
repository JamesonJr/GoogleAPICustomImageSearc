//
//  CustomCell.m
//  GoogleAPIImageSearch
//
//  Created by Eugenie Tyan on 5/29/19.
//  Copyright © 2019 Eugenie Tyan. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell

@synthesize title = _title;

- (id)initWithStyle: (UITableViewCellStyle) style reuseIdentifier: (NSString *) reuseIdentifier
{
    self = [super initWithStyle: style reuseIdentifier: reuseIdentifier];
    if (self) {
        _title = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 300, 30)];
        _title.textColor = [UIColor blackColor];
        _title.font = [UIFont fontWithName: @"Arial" size: 12.0f];
        
        
        [self addSubview: _title];
    }
    return self;
}

- (void) hideTitleOrShowError: (BOOL)hasError {
    if (hasError) {
        _title.hidden = NO;
        _title.text = @"Thumbnail отсутствует";
    } else {
        _title.hidden = YES;
    }
}

@end
