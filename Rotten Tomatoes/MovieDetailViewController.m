//
//  MovieDetailViewController.m
//  Rotten Tomatoes
//
//  Created by Eduardo Aranega on 1/22/15.
//  Copyright (c) 2015 Eduardo Aranega. All rights reserved.
//

#import "MovieDetailViewController.h"
#import "UIImageView+AFNetworking.h"

@interface MovieDetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;
@property (weak, nonatomic) IBOutlet UIImageView *hdPicture;

@end

@implementation MovieDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSLog(@"titleLabel: %@", self.movie[@"title"]);
    NSLog(@"titleLabel: %@", self.movie[@"synopsis"]);
    
    self.titleLabel.text = self.movie[@"title"];
    self.synopsisLabel.text = self.movie[@"synopsis"];
    
    NSString *thumbnailUrl = [self.movie valueForKeyPath:@"posters.thumbnail"];
    NSString *imageUrl = [[self.movie valueForKeyPath:@"posters.original"] stringByReplacingOccurrencesOfString:@"_tmb" withString:@"_ori"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:imageUrl] cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:5.0f];
    
    [self.hdPicture setImageWithURLRequest:request placeholderImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:thumbnailUrl]]] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        [UIView transitionWithView:self.hdPicture duration:2.0f options:UIViewAnimationOptionTransitionCrossDissolve animations:^{ self.hdPicture.image = image;
        } completion:nil];
    } failure:nil];


    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
