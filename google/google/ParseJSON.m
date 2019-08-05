//
//  ParseJSON.m
//  GoogleAPIImageSearch
//
//  Created by Eugenie Tyan on 6/4/19.
//  Copyright © 2019 Eugenie Tyan. All rights reserved.
//

#import "ParseJSON.h"

@implementation ParseJSON

- (NSArray *) getURLs: (NSDictionary *)dict {
    NSMutableArray *urls = [[NSMutableArray alloc] init];
    
    if ([dict objectForKey: @"items"] == [NSNull null]) {
        return nil;
    }
    NSArray *items = [dict objectForKey: @"items"];
    for (int i = 0; i < items.count; i++) {
        if (i == 10) {
            break;
        }
        NSMutableDictionary *url = [[NSMutableDictionary alloc] init];
        NSDictionary *tempDict = items[i];
        if ([self checkingObject: tempDict andKey: @"title"]) {
            [url setObject: [tempDict objectForKey: @"title"] forKey: @"title"];
        } else {
            [url setObject: @"default name" forKey: @"title"];
        }
        if ([self checkingObject: tempDict andKey: @"cacheId"]) {
            [url setObject: [tempDict objectForKey: @"cacheId"] forKey: @"cacheID"];
        } else {
            [url setObject: @"" forKey: @"cacheID"];
        }
        if ([self checkingObject: tempDict andKey: @"pagemap"]) {
            NSDictionary *pagemap = [tempDict objectForKey: @"pagemap"];
            if ([self checkingObject: pagemap andKey: @"cse_thumbnail"]) {
                NSArray *thumb = [pagemap objectForKey: @"cse_thumbnail"];
                NSDictionary *thumURL = thumb[0];
                if ([self checkingObject: thumURL andKey: @"src"]) {
                    [url setObject: [thumURL objectForKey: @"src"] forKey: @"thumb"];
                } else {
                    [url setObject: @"" forKey: @"thumb"];
                }
            } else {
                [url setObject: @"" forKey: @"thumb"];
            }
            if ([self checkingObject: pagemap andKey: @"cse_image"]) {
                NSArray *image = [pagemap objectForKey: @"cse_image"];
                NSDictionary *imageURL = image[0];
                if ([self checkingObject: imageURL andKey: @"src"]) {
                    [url setObject: [imageURL objectForKey: @"src"] forKey: @"image"];
                } else {
                    [url setObject: @"" forKey: @"image"];
                }
            } else {
                [url setObject: @"" forKey: @"image"];
            }
        } else {
            [url setObject: @"" forKey: @"thumb"];
            [url setObject: @"" forKey: @"image"];
        }
        [urls addObject: url];
    }
    
    
    return urls;
}

- (BOOL) isNeedParsing:(NSDictionary *)dict {
    if ([self checkingObject: dict andKey: @"queries"]) {
        NSDictionary *temp = [dict objectForKey: @"queries"];
        if ([self checkingObject: temp andKey: @"request"]) {
            NSArray *arr = [temp objectForKey: @"request"];
            if (arr[0]) {
                temp = arr[0];
                if ([self checkingObject: temp andKey: @"totalResults"]) {
                    NSInteger count = [[temp objectForKey: @"totalResults"] integerValue];
                    if (count == 0) {
                        return FALSE;
                    }
                }
            }
        }
    }
    return TRUE;
}

- (BOOL) checkingObject: (NSDictionary *) dict andKey: (NSString *) key {
    if ([dict objectForKey: key]) {
        if ([dict objectForKey: key] != [NSNull null]) {
            return TRUE;
        }
    }
    return FALSE;
}

@end
