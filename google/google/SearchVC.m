//
//  SearchVC.m
//  GoogleAPIImageSearch
//
//  Created by Eugenie Tyan on 5/29/19.
//  Copyright © 2019 Eugenie Tyan. All rights reserved.
//

#import "SearchVC.h"

static const NSString *kGoogleAPI = @"https://www.googleapis.com/customsearch/v1?key=";
static const NSString *kGoogleAPIKeyString = @"AIzaSyCZFYw8BeW8yX8XJxuecIF6jGo0h6hZ1jE";
static const NSString *kSearchParams = @"&cx=017576662512468239146:omuauf_lfve&searchtype=image&q=";
static const NSString *kGoogleStart = @"&start=";

@interface SearchVC ()

@end

@implementation SearchVC


@synthesize buttonSearch = _buttonSearch;
@synthesize textField = _textField;
@synthesize labelTitle = _labelTitle;
@synthesize tableView = _tableView;
@synthesize rows = _rows;
@synthesize urlRequest = _urlRequest;
@synthesize navItem = _navItem;
@synthesize views = _views;
@synthesize cacheImage = _cacheImage;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _cacheImage = [[CachingImage alloc] init];
    _rows = [[NSMutableArray alloc] init];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString: @"Please Wait..."];
    [refreshControl addTarget: self action: @selector(refresh:) forControlEvents:UIControlEventValueChanged];
    
    _views = [[Views alloc] init];
    [_views addSpinner: self.view];
    

    CGFloat width = self.view.bounds.size.width - 40;
    
    _tableView = [[UITableView alloc] initWithFrame: self.view.bounds style: UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor whiteColor];
    
    [_tableView addSubview: refreshControl];

    _labelTitle = [[UILabel alloc] initWithFrame: CGRectMake(20, 150, width, 20)];
    _labelTitle.textColor = [UIColor blackColor];
    _labelTitle.font = [UIFont fontWithName: @"Helvetica" size: 15.0f];
    _labelTitle.text = @"Enter text";

    _textField = [[UITextField alloc] initWithFrame: CGRectMake(20, 180, width, 30)];
    _textField.borderStyle = UITextBorderStyleRoundedRect;
    _textField.placeholder = @"Enter text";
    _textField.autocorrectionType = UITextAutocorrectionTypeNo;
    _textField.keyboardType = UIKeyboardTypeDefault;
    _textField.returnKeyType = UIReturnKeyDone;
    _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;

    _buttonSearch = [UIButton buttonWithType: UIButtonTypeRoundedRect];
    [_buttonSearch addTarget: self
                      action: @selector (buttonSearchPressed:)
            forControlEvents: UIControlEventTouchUpInside];
    [_buttonSearch setTitle: @"Search" forState: UIControlStateNormal];
    _buttonSearch.frame = CGRectMake(20 + width/4, 220, width/2, 40.0);
    
    _navItem = [[UINavigationItem alloc] initWithTitle: @"Поиск"];
    UIBarButtonItem* cancelBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemCancel
                                                                               target: self
                                                                               action: @selector(onTapCancel:)];
    _navItem.leftBarButtonItem = cancelBtn;

    [self.view addSubview: _tableView];
    [self.view addSubview: _labelTitle];
    [self.view addSubview: _textField];
    [self.view addSubview: _buttonSearch];
    [self.navigationItem setLeftBarButtonItem: cancelBtn];
    [self.navigationController.navigationBar setHidden: YES];
    [_tableView setHidden: YES];
}

- (void)refresh:(UIRefreshControl *)refreshControl
{
    [refreshControl endRefreshing];
}


/*! Возврат от таблицы к поиску
 */
- (void) onTapCancel: (id) sender {
    [_buttonSearch setHidden: NO];
    [_textField setHidden: NO];
    [_labelTitle setHidden: NO];
    [self.navigationController.navigationBar setHidden: YES];
    [_tableView setHidden: YES];
}

/*! Поиск по запрошенному в текстфилде слову
 */
- (void) buttonSearchPressed: (id) sender {
    [_views.spinner startAnimating];
    _urlRequest = [[NSString stringWithFormat: @"%@%@%@%@%@", kGoogleAPI, kGoogleAPIKeyString, kSearchParams, _textField.text, kGoogleStart] stringByAddingPercentEncodingWithAllowedCharacters: [NSCharacterSet URLFragmentAllowedCharacterSet]];
    [self requestGoogleAPI];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)theTableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (NSInteger)tableView:(UITableView *)theTableView numberOfRowsInSection:(NSInteger)section
{
    if (_rows) {
        return _rows.count;
    } else {
        return 1;
    }
}

// the cell will be returned to the tableView
- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"HistoryCell";
    
    CustomCell *cell = (CustomCell *)[theTableView dequeueReusableCellWithIdentifier: cellIdentifier];
    if (cell == nil) {
        cell = [[CustomCell alloc] initWithStyle: UITableViewCellStyleDefault
                                 reuseIdentifier: cellIdentifier];
    }
    NSDictionary *dict;
    if (_rows[indexPath.row]) {
        dict = _rows[indexPath.row];
        UIImage *image;
        
        NSString *cacheID = [dict objectForKey: @"cacheID"];
        if (![cacheID isEqualToString: @""]) {
            NSString *url = [_cacheImage getThumb: cacheID];
            if (url) {
                if ([[Cache sharedInstance] getFromCache: url]) {
                    cell.imageView.image = [[Cache sharedInstance] getFromCache: url];
                    [cell hideTitleOrShowError: NO];
                }
            }
        }
        
        if ([[dict objectForKey: @"thumb"] isEqualToString: @""]) {
            [cell hideTitleOrShowError: YES];
            cell.imageView.image = nil;
        } else {
            if ([dict objectForKey: @"thumb"]) {
                NSURL *url = [NSURL URLWithString: [dict objectForKey: @"thumb"]];
                NSData * data = [NSData dataWithContentsOfURL: url];
                image = [UIImage imageWithData: data];
                cell.imageView.image = image;
                [cell hideTitleOrShowError: NO];
                [_cacheImage saveThumbToCoreData: [dict objectForKey: @"thumb"]
                                           title: [dict objectForKey: @"title"]
                                         cacheID: [dict objectForKey: @"cacheID"]];
                [[Cache sharedInstance] addToCache: image forKey: [dict objectForKey: @"thumb"]];
            }
        }
    }
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailResult *detailController = [[DetailResult alloc] init];
    if (_rows[indexPath.row]) {
        NSDictionary *dict = _rows[indexPath.row];
        if (![[dict objectForKey: @"image"] isEqualToString: @""]) {
            detailController.imageURL = [dict objectForKey: @"image"];
            detailController.cacheID = [dict objectForKey: @"cacheID"];
        }
    }
    [[self navigationController] pushViewController: detailController animated: YES];
}

- (UIImage *) checkURLAndDownloadImage: (NSString *) url {
    if (![url isEqualToString: @""]) {
        NSData *data = [NSData dataWithContentsOfURL: [NSURL URLWithString: url]];
        UIImage *image = [UIImage imageWithData: data];
        return image;
    }
    return nil;
}

#pragma mark - Request Google API
- (void) requestGoogleAPI {
    [_rows removeAllObjects];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURLSession *session = [NSURLSession sharedSession];
        for (int i = 0; i < 5; i ++) {
            NSString *count = [@(1+i*10) stringValue];
            NSString *request = [NSString stringWithFormat: @"%@%@", self->_urlRequest, count];
            NSURL *url = [NSURL URLWithString: request];
            NSURLSessionDataTask *dataTask = [session dataTaskWithURL: url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                ParseJSON *JSON = [[ParseJSON alloc] init];
                if ([JSON isNeedParsing: json]) {
                    [self->_rows addObjectsFromArray: [JSON getURLs: json]];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self->_tableView reloadData];
                    });
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self->_views.spinner stopAnimating];
                        [self->_tableView setHidden: NO];
                        [self->_buttonSearch setHidden: YES];
                        [self->_textField setHidden: YES];
                        [self->_labelTitle setHidden: YES];
                        [self.navigationController.navigationBar setHidden: NO];
                    });
                }
            }];
            [dataTask resume];
        }
    });
}

@end
