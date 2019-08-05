//
//  Views.h
//  GoogleAPIImageSearch
//
//  Created by Eugenie Tyan on 7/9/19.
//  Copyright © 2019 Eugenie Tyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/*! Класс для отображения одинаковых контролов
 */
@interface Views : NSObject

/*! Спиннер
 */
@property (nonatomic, strong) UIActivityIndicatorView *spinner;

/*! Добавляем спиннер к переданному view
 *\param view все контролы будут примененны к этому view
 */
- (void) addSpinner: (UIView *) view;

@end

NS_ASSUME_NONNULL_END
