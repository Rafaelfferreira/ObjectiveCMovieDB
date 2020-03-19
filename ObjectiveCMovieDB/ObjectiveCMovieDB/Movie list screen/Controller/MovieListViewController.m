//
//  ViewController.m
//  ObjectiveCMovieDB
//
//  Created by Rafael Ferreira on 16/03/20.
//  Copyright © 2020 Rafael Ferreira. All rights reserved.
//

#import "MovieListViewController.h"
#import "MovieTableViewCell.h"
#import "MovieDBAPI.h"

@interface MovieListViewController ()

@end

@implementation MovieListViewController {
    NSArray *popularMovies;
    NSArray *nowPlayingMovies;
    BOOL requestDone;
    BOOL requestError;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavBar];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self getMoviesFromDB];
    
}

- (void)getMoviesFromDB {
    [self.tableView setHidden:YES];
    requestDone = NO;
    requestError = NO;
    popularMovies = [NSArray array];
    nowPlayingMovies = [NSArray array];
    
    MovieDBAPI *movieDBAPI = [[MovieDBAPI alloc] init];
    [movieDBAPI getNowPlayingMovies: ^(QTMovies *movies, NSError *error){
        if (error == nil) {
            self->nowPlayingMovies = [movies results];
            for (QTResult *movie in self->nowPlayingMovies) {
                movie.coverData = [movieDBAPI getCoverFrom: movie.posterPath];
            }
            if (self->requestDone && !self->requestError) {
                dispatch_async(dispatch_get_main_queue(), ^(void){
                    //Run UI Updates
                    [self.tableView setHidden:NO];
                    [self.tableView reloadData];
                });
            } else {
                self->requestDone = YES;
            }
        } else {
            dispatch_async(dispatch_get_main_queue(), ^(void){
                [self showErrorAlert:error];
            });
            self->requestError = YES;
        }
    }];
    
    [movieDBAPI getPopularMovies: ^(QTMovies *movies, NSError *error){
        if (error == nil) {
            self->popularMovies = [movies results];
            for (QTResult *movie in self->popularMovies) {
                movie.coverData = [movieDBAPI getCoverFrom: movie.posterPath];
            }
            if (self->requestDone && !self->requestError) {
                dispatch_async(dispatch_get_main_queue(), ^(void){
                    //Run UI Updates
                    [self.tableView setHidden:NO];
                    [self.tableView reloadData];
                });
            } else {
                self->requestDone = YES;
            }
        } else {
            dispatch_async(dispatch_get_main_queue(), ^(void){
                [self showErrorAlert:error];
            });
            self->requestError = YES;
        }
    }];
}

- (void)showErrorAlert: (NSError*) error {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Error"
                                   message:error.localizedDescription
                                   preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Try again" style:UIAlertActionStyleDefault
       handler:^(UIAlertAction * action) {
        [self getMoviesFromDB];
    }];

    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)setupNavBar {
    self.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeAlways;
    self.navigationController.navigationBar.prefersLargeTitles = YES;
    self.navigationItem.title = @"Movies";
    
    UISearchController *searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.navigationItem.searchController = searchController;
    self.navigationItem.hidesSearchBarWhenScrolling = NO;
    searchController.obscuresBackgroundDuringPresentation = NO;
    
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"movieCell";
    
    MovieTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: cellIdentifier];
    
    if (cell == nil) {
        return [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault
        reuseIdentifier: cellIdentifier];
    }
    
    if (indexPath.section == 0) {
        [cell configure: [popularMovies objectAtIndex: [indexPath row]]];
    } else {
        [cell configure: [nowPlayingMovies objectAtIndex: [indexPath row]]];
    }
    
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return [popularMovies count];
    } else {
        return [nowPlayingMovies count];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    // Background color
    view.tintColor = [UIColor whiteColor];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"Popular Movies";
    } else {
        return @"Now Playing Movies";
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}

@end
