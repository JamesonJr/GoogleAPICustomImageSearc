//
//  Cache.h
//  google
//
//  Created by Eugenie Tyan on 7/16/19.
//  Copyright © 2019 Eugenie Tyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/*! Класс для работы непосредственно с NSCache
 */

@interface Cache : NSObject

@property (nonatomic, strong) NSCache *cache;

/*! Синглтон для кеша, чтоб не создавался каждый раз новый объект
 */
+ (Cache *)sharedInstance;

/*! Добавление картинки в NSCache
 * \param image картинка которую загрузили
 * \param url ключ, используем url картинки
 */
- (void) addToCache: (UIImage *) image forKey: (NSString *) url;

/*! Извлечение картинки из NSCache
 * \param url ключ, используем url картинки
 * \returns UIImage
 */
- (UIImage *) getFromCache: (NSString *) url;

@end

NS_ASSUME_NONNULL_END
