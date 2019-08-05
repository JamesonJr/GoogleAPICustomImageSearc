//
//  CustomCell.h
//  GoogleAPIImageSearch
//
//  Created by Eugenie Tyan on 5/29/19.
//  Copyright © 2019 Eugenie Tyan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/*! Класс для кастомных настроек UITableViewCell
 */

@interface CustomCell : UITableViewCell

/*! Отображение ошибки в случае отсутствия изображения
 */
@property (nonatomic, strong) UILabel *title;

/*! показывает или скрывает label
 * \param hasError TRUE-если показываем label с ошибкой, FALSE-если есть thumbnail
 */
- (void) hideTitleOrShowError: (BOOL) hasError;

@end

NS_ASSUME_NONNULL_END
