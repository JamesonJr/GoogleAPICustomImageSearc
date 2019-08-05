//
//  DetailResult.m
//  GoogleAPIImageSearch
//
//  Created by Eugenie Tyan on 5/29/19.
//  Copyright © 2019 Eugenie Tyan. All rights reserved.
//

#import "DetailResult.h"

@interface DetailResult ()

@end

@implementation DetailResult

@synthesize imageView = _imageView;
@synthesize labelDesc = _labelDesc;
@synthesize labelError = _labelError;
@synthesize imageURL = _imageURL;
@synthesize cacheID = _cacheID;
@synthesize views = _views;
@synthesize cacheImage = _cacheImage;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _cacheImage = [[CachingImage alloc] init];
    _views = [[Views alloc] init];
    [_views addSpinner: self.view];
    
    self.view.backgroundColor = [UIColor whiteColor];
    CGFloat width = self.view.bounds.size.width - 40;
    CGFloat height = self.view.bounds.size.height - 200;
    
    _labelDesc = [[UILabel alloc] initWithFrame:CGRectMake(20, 70, width, 30)];
    _labelDesc.textColor = [UIColor blackColor];
    _labelDesc.font = [UIFont fontWithName: @"Arial" size: 12.0f];
    _labelDesc.lineBreakMode = NSLineBreakByWordWrapping;
    _labelDesc.numberOfLines = 0;
    _labelDesc.text = [_cacheImage getTitle: _cacheID];
    
    [_views.spinner startAnimating];
    
    if (![_imageURL isEqualToString: @""]) {
        if (_imageURL) {
            NSString *url = [_cacheImage getImage: _cacheID];
            if (url) {
                if ([[Cache sharedInstance] getFromCache: url]) {
                    _imageView = [[UIImageView alloc] initWithFrame: CGRectMake(20, 120, width, height)];
                    _imageView.contentMode = UIViewContentModeScaleAspectFit;
                    _imageView.image = [[Cache sharedInstance] getFromCache: url];
                    [self.view addSubview: _imageView];
                    [_views.spinner stopAnimating];
                } else {
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                        NSURL *url = [NSURL URLWithString: self->_imageURL];
                        NSData * data = [NSData dataWithContentsOfURL: url];
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            if (data) {
                                self->_imageView = [[UIImageView alloc] initWithFrame: CGRectMake(20, 120, width, height)];
                                UIImage *image = [UIImage imageWithData: data];
                                self->_imageView.image = image;
                                [[Cache sharedInstance] addToCache: image forKey: self->_imageURL];
                                self->_imageView.contentMode = UIViewContentModeScaleAspectFit;
                                [self->_views.spinner stopAnimating];
                                [self.view addSubview: self->_imageView];
                                [self->_cacheImage saveImage: self->_imageURL cacheID: self->_cacheID];
                            } else {
                                self->_labelError = [[UILabel alloc] initWithFrame:CGRectMake(20, 120, width, 30)];
                                self->_labelError.textColor = [UIColor blackColor];
                                self->_labelError.font = [UIFont fontWithName: @"Arial" size: 12.0f];
                                self->_labelError.text = @"Отсутствует изображение";
                                [self->_views.spinner stopAnimating];
                                [self.view addSubview: self->_labelError];
                            }
                            
                        });
                        
                    });
                }
            } else {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSURL *url = [NSURL URLWithString: self->_imageURL];
                    NSData * data = [NSData dataWithContentsOfURL: url];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (data) {
                            self->_imageView = [[UIImageView alloc] initWithFrame: CGRectMake(20, 120, width, height)];
                            UIImage *image = [UIImage imageWithData: data];
                            self->_imageView.image = image;
                            [[Cache sharedInstance] addToCache: image forKey: self->_imageURL];
                            self->_imageView.contentMode = UIViewContentModeScaleAspectFit;
                            [self->_views.spinner stopAnimating];
                            [self.view addSubview: self->_imageView];
                            [self->_cacheImage saveImage: self->_imageURL cacheID: self->_cacheID];
                        } else {
                            self->_labelError = [[UILabel alloc] initWithFrame:CGRectMake(20, 120, width, 30)];
                            self->_labelError.textColor = [UIColor blackColor];
                            self->_labelError.font = [UIFont fontWithName: @"Arial" size: 12.0f];
                            self->_labelError.text = @"Отсутствует изображение";
                            [self->_views.spinner stopAnimating];
                            [self.view addSubview: self->_labelError];
                        }
                        
                    });
                    
                });
            }
        }
        
    }
    
    [self.view addSubview: _labelDesc];
}


@end
