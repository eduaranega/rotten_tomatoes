//
//  MovieDetailViewController.h
//  Rotten Tomatoes
//
//  Created by Eduardo Aranega on 1/22/15.
//  Copyright (c) 2015 Eduardo Aranega. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieDetailViewController : UIViewController

@property (nonatomic, strong) NSDictionary *movie;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;

@end