//
//  SearchVC.h
//  GoogleAPIImageSearch
//
//  Created by Eugenie Tyan on 5/29/19.
//  Copyright © 2019 Eugenie Tyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CachingImage.h"
#import "CustomCell.h"
#import "DetailResult.h"
#import "ParseJSON.h"
#import "Views.h"
#import "CachingImage.h"
#import "Cache.h"

NS_ASSUME_NONNULL_BEGIN

/*! Основной контроллер отсюда все начинается
 */

@interface SearchVC : UIViewController <UITableViewDelegate, UITableViewDataSource>

/*! Кнопка поиск
 */
@property (nonatomic, strong) UIButton *buttonSearch;

/*! Текстовое поле для запроса
 */
@property (nonatomic, strong) UITextField *textField;

/*! Лейбл с заголовком
 */
@property (nonatomic, strong) UILabel *labelTitle;

/*! Таблица с результатами
 */
@property (nonatomic, strong) UITableView *tableView;

/*! Временное хранилище для результатов запроса
 */
@property (nonatomic, strong) NSMutableArray *rows;

/*! Запрос с параметрами объединенный в одну строку
 */
@property (nonatomic, strong) NSString *urlRequest;

/*! Navigation item для возврата от таблицы к поиску
 */
@property (nonatomic, strong) UINavigationItem *navItem;

/*! Загружает похожие контролы в конкретном случае спиннер
 */
@property (nonatomic, strong) Views *views;

/*! Извлечение и добавление модели в core data для кеширования
 */
@property (nonatomic, strong) CachingImage *cacheImage;

@end

NS_ASSUME_NONNULL_END
