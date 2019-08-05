//
//  DetailResult.h
//  GoogleAPIImageSearch
//
//  Created by Eugenie Tyan on 5/29/19.
//  Copyright © 2019 Eugenie Tyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CachingImage.h"
#import "Views.h"
#import "Cache.h"

NS_ASSUME_NONNULL_BEGIN

/*! Контроллер с подробной инфой по каждой картинке
 */

@interface DetailResult : UIViewController

/*! Контрол для отображения изображения
 */
@property (nonatomic, strong) UIImageView *imageView;

/*! Контрол для отображения title
 */
@property (nonatomic, strong) UILabel *labelDesc;

/*! Контрол для отображения ошибки если изображение отсутствует
 */
@property (nonatomic, strong) UILabel *labelError;

/*! URL с полноразмерным изображением
 */
@property (nonatomic, strong) NSString *imageURL;

/*! Уникальный идентификатор для получения данных из core data
 */
@property (nonatomic, strong) NSString *cacheID;

/*! Загружает похожие контролы в конкретном случае спиннер
 */
@property (nonatomic, strong) Views *views;

/*! Извлечение модели из core data для кеширования
 */
@property (nonatomic, strong) CachingImage *cacheImage;

@end

NS_ASSUME_NONNULL_END
