//
//  Cache.m
//  google
//
//  Created by Eugenie Tyan on 7/16/19.
//  Copyright © 2019 Eugenie Tyan. All rights reserved.
//

#import "Cache.h"

static Cache *sharedInstance;

@implementation Cache

@synthesize cache = _cache;

+ (Cache *)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[Cache alloc] init];
    });
    return sharedInstance;
}
- (instancetype)init {
    self = [super init];
    if (self) {
        _cache = [[NSCache alloc] init];
    }
    return self;
}

- (void) addToCache:(UIImage *) image forKey: (NSString *)url {
    if (!_cache) {
        _cache = [[NSCache alloc] init];
    }
    if (![_cache objectForKey: url]) {
        [_cache setObject: image forKey: url];
    }
}

- (UIImage *) getFromCache: (NSString *)url {
    if (_cache) {
        if ([_cache objectForKey: url]) {
            return [_cache objectForKey: url];
        }
    }
    return nil;
}

@end
