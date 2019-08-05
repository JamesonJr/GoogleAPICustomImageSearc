//
//  Views.m
//  GoogleAPIImageSearch
//
//  Created by Eugenie Tyan on 7/9/19.
//  Copyright © 2019 Eugenie Tyan. All rights reserved.
//

#import "Views.h"

@implementation Views

@synthesize spinner = _spinner;


- (void) addSpinner: (UIView *)view {
    _spinner = [[UIActivityIndicatorView alloc]
                initWithActivityIndicatorStyle: UIActivityIndicatorViewStyleGray];
    CGFloat centerX = view.bounds.size.width/2;
    CGFloat centerY = view.bounds.size.height/2;
    _spinner.center = CGPointMake(centerX, centerY);
    [view addSubview: _spinner];
}

@end
