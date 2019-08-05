//
//  CachingImage.m
//  GoogleAPIImageSearch
//
//  Created by Eugenie Tyan on 6/24/19.
//  Copyright © 2019 Eugenie Tyan. All rights reserved.
//

#import "CachingImage.h"

@implementation CachingImage {
    AppDelegate *appDelegate;
    NSManagedObjectContext *context;
    NSArray *results;
}

/*! Проверка существования записи в core data, чтоб не было дупликатов
 * \param cacheID уникальный идентефикатор
 * \returns TRUE если существует запись с таким cacheID, FALSE в противоположном случае
 */
- (BOOL) checkExisting: (NSString *) cacheID {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName: @"Images"];
    results = [context executeFetchRequest: request error: nil];
    NSDictionary *dictionary;
    NSArray *keys;
    NSMutableArray *resultsData = [[NSMutableArray alloc] init];
    for (NSManagedObject *obj in results) {
        keys = [[[obj entity] attributesByName] allKeys];
        dictionary =[obj dictionaryWithValuesForKeys: keys];
        [resultsData addObject: dictionary];
        
    }
    for (int i =0; i < resultsData.count; i++) {
        NSDictionary *dict = resultsData[i];
        if ([[dict valueForKey: @"cacheID"] isEqualToString: cacheID]) {
            return TRUE;
        }
    }
    return FALSE;
}

/*! Проверка существования записи в core data
 * \param cacheID уникальный идентефикатор
 * \returns NSDictionary с искомым cscheID либо nil если отсутствует запись в core data
 */
- (NSDictionary *) checkExistingReturnArray: (NSString *) cacheID {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName: @"Images"];
    results = [context executeFetchRequest: request error: nil];
    NSDictionary *dictionary;
    NSArray *keys;
    NSMutableArray *resultsData = [[NSMutableArray alloc] init];
    for (NSManagedObject *obj in results) {
        keys = [[[obj entity] attributesByName] allKeys];
        dictionary =[obj dictionaryWithValuesForKeys: keys];
        [resultsData addObject: dictionary];
        
    }
    for (int i =0; i < resultsData.count; i++) {
        NSDictionary *dict = resultsData[i];
        if ([[dict valueForKey: @"cacheID"] isEqualToString: cacheID]) {
            return dict;
        }
    }
    return nil;
}

- (void) runContext {
    if (!context) {
        appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
        context = appDelegate.persistentContainer.viewContext;
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }
}

#pragma mark - Setters
- (void) saveThumbToCoreData: (NSString *)thumb title:(NSString *)title cacheID:(NSString *)cacheID {
    [self runContext];
    if (![cacheID isEqualToString: @""]) {
        if (![self checkExisting: cacheID]) {
            NSManagedObject *entityObject = [NSEntityDescription insertNewObjectForEntityForName: @"Images" inManagedObjectContext: context];
            if (title) {
                [entityObject setValue: title forKey: @"title"];
            }
            if (cacheID) {
                [entityObject setValue: cacheID forKey: @"cacheID"];
            }
            if (thumb) {
                [entityObject setValue: thumb forKey: @"thumbnail"];
            }
            [appDelegate saveContext];
        }
    }
}

- (void) saveImage:(NSString *)image cacheID:(NSString *)cacheID {
    [self runContext];
    if (![cacheID isEqualToString: @""]) {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName: @"Images"];
        results = [context executeFetchRequest: request error: nil];
        NSDictionary *dictionary;
        NSArray *keys;
        NSMutableArray *resultsData = [[NSMutableArray alloc] init];
        for (NSManagedObject *obj in results) {
            keys = [[[obj entity] attributesByName] allKeys];
            dictionary =[obj dictionaryWithValuesForKeys: keys];
            [resultsData addObject: dictionary];
            
        }
        for (int i =0; i < resultsData.count; i++) {
            NSDictionary *dict = resultsData[i];
            if ([[dict valueForKey: @"cacheID"] isEqualToString: cacheID]) {
                NSManagedObject *obj = results[i];
                [obj setValue: image forKey: @"image"];
                [appDelegate saveContext];
                return;
            }
        }
    }
}

#pragma mark - Getters
- (NSString *) getThumb: (NSString *)cacheID {
    [self runContext];
    if (![cacheID isEqualToString: @""]) {
        NSDictionary *dict = [self checkExistingReturnArray: cacheID];
        if (dict) {
            return [dict valueForKey: @"thumbnail"];
        }
    }
    return nil;
}

- (NSString *) getTitle:(NSString *)cacheID {
    [self runContext];
    if (![cacheID isEqualToString: @""]) {
        NSDictionary *dict = [self checkExistingReturnArray: cacheID];
        if (dict) {
            return [dict valueForKey: @"title"];
        }
    }
    return nil;
}

- (NSString *) getImage:(NSString *)cacheID {
    [self runContext];
    if (![cacheID isEqualToString: @""]) {
        NSDictionary *dict = [self checkExistingReturnArray: cacheID];
        if (dict) {
            return [dict valueForKey: @"image"];
        }
    }
    return nil;
}


@end
