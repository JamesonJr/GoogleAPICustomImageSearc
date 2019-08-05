//
//  ParseJSON.h
//  GoogleAPIImageSearch
//
//  Created by Eugenie Tyan on 6/4/19.
//  Copyright © 2019 Eugenie Tyan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/*! Класс для парсинга JSON
 */

@interface ParseJSON : NSObject

/*! Парсим входящий NSDictionary
 * \param dict входной словарь
 * \returns NSMutableDictionary в котором thumbnail URL, image URL, cacheID, title
 */
- (NSMutableArray *) getURLs: (NSDictionary *) dict;

/*! Проверяем есть ли в словаре элементы для выведения в таблицу
 * \param dict входной словарь
 * \returns FALSE-если элементов нет, TRUE-если есть элементы и надо их распарсить
 */
- (BOOL) isNeedParsing: (NSDictionary *) dict;

@end

NS_ASSUME_NONNULL_END
