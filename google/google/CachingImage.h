//
//  CachingImage.h
//  GoogleAPIImageSearch
//
//  Created by Eugenie Tyan on 6/24/19.
//  Copyright © 2019 Eugenie Tyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

/*! Класс для загрузки модели кеширования в core data
 */

@interface CachingImage : NSObject

/*! Первоначальное сохранение данных в core data
 * \param thumb thumnail url
 * \param title description
 * \param cacheID уникальный идентефикатор
 */
- (void) saveThumbToCoreData: (NSString *) thumb title: (NSString *) title cacheID: (NSString *) cacheID;

/*! Добавление url на увеличенное изображение к существующей модели в core data
 * \param image url большого изображения
 * \param cacheID уникальный идентефикатор
 */
- (void) saveImage: (NSString *) image cacheID: (NSString *) cacheID;

/*! Получение url по уникальному идентификатору в core data
 * \param cacheID уникальный идентефикатор
 * \returns NSString thumbnail url
 */
- (NSString *) getThumb: (NSString *) cacheID;

/*! Получение url по уникальному идентификатору в core data
 * \param cacheID уникальный идентефикатор
 * \returns NSString image url
 */
- (NSString *) getImage: (NSString *) cacheID;

/*! title по уникальному идентификатору в core data
 * \param cacheID уникальный идентефикатор
 * \returns NSString title
 */
- (NSString *) getTitle: (NSString *) cacheID;


@end

NS_ASSUME_NONNULL_END
