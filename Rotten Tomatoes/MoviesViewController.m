//
//  MoviesViewController.m
//  Rotten Tomatoes
//
//  Created by Eduardo Aranega on 1/22/15.
//  Copyright (c) 2015 Eduardo Aranega. All rights reserved.
//

#import "MoviesViewController.h"
#import "MovieCell.h"
#import "UIImageView+AFNetworking.h"
#import "MovieDetailViewController.h"

@interface MoviesViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *names;
@property (nonatomic, strong) NSArray *movies;




@end

@implementation MoviesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.names = @[ @"a", @"b", @"c", @"d"];
    
    NSURL *url = [NSURL URLWithString:@"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=dagqdghwaq3e3mxyrp7kmmj5&limit=20&country=us"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // async call
    [NSURLConnection sendAsynchronousRequest:request queue: [NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error: nil];
        self.movies = responseDictionary[@"movies"];
        NSLog(@"resonse: %@", responseDictionary);
        
        [self.tableView reloadData];
                                            
    }];
    
    // set myself to the data source
    self.tableView.dataSource = self;
    
    
    // to know when someone clicked  (UITableViewDelegate)
    self.tableView.delegate = self;
    
    
    self.tableView.rowHeight = 128;
    
    
    // hey tableView if I say @"MovieCell", you give me an instance of nibWithNibName:@"MovieCell"
    [self.tableView registerNib:[UINib nibWithNibName:@"MovieCell" bundle:nil] forCellReuseIdentifier:@"MovieCell"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.movies.count;
    //return 50;
    //return self.names.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //NSLog(@"%@", [NSString stringWithFormat:@"Section %d, Row %ld", indexPath.section, (long)indexPath.row]);
    //UITableViewCell *cell = [[UITableViewCell alloc] init];
    
    // this is to remove the gray selection of the table view
    MovieCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieCell"];
    
    NSDictionary *movie = self.movies[indexPath.row];
    
    // cell.textLabel.text = self.names[indexPath.row];
    // cell.textLabel.text = [NSString stringWithFormat:@"Section %d, Row %ld", indexPath.section, (long)indexPath.row];
    
    cell.titleLabel.text = movie[@"title"];
    cell.synopsisLabel.text = movie[@"synopsis"];
    
    [cell.posterView setImageWithURL:[NSURL URLWithString: [movie valueForKeyPath:@"posters.thumbnail"]]];
    
    self.title = @"Rotten Tomatoes Movies";
    
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // responsible to remove the gray selection of the cell
    [tableView deselectRowAtIndexPath:indexPath animated: YES];
    
    MovieDetailViewController *movieDetailvc = [[MovieDetailViewController alloc] init];
    
    movieDetailvc.movie = self.movies[indexPath.row];
    
    [self.navigationController pushViewController:movieDetailvc animated: YES];
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
