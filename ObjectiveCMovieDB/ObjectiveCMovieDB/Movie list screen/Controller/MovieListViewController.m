//
//  ViewController.m
//  ObjectiveCMovieDB
//
//  Created by Rafael Ferreira on 16/03/20.
//  Copyright © 2020 Rafael Ferreira. All rights reserved.
//

#import "MovieListViewController.h"
#import "MovieTableViewCell.h"
#import "MovieDetailViewController.h"
#import "MovieDBAPI.h"
#import "NowPlayingTableViewCell.h"

@interface MovieListViewController ()

@end

@implementation MovieListViewController {
    NSMutableArray *popularMovies;
    NSMutableArray *nowPlayingMovies;
    NSArray *searchedMovies;
    NSInteger currentPage;
    NSInteger totalPages;
    BOOL requestDone;
    BOOL requestError;
    BOOL isSearching;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavBar];
    
    isSearching = NO;
    currentPage = 1;
    totalPages = -1;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.loader.color = [UIColor colorNamed:@"LoaderColor"];
    
    [self getMoviesFromDB];
    
}

- (void)getMoviesFromDB {
    [self.tableView setHidden:YES];
    requestDone = NO;
    requestError = NO;
    isSearching = NO;
    popularMovies = [NSMutableArray array];
    nowPlayingMovies = [NSMutableArray array];
    
    MovieDBAPI *movieDBAPI = [[MovieDBAPI alloc] init];
    
    [movieDBAPI getNowPlayingMovies: ^(QTMovies *movies, NSError *error){
        if (error == nil) {
            self->nowPlayingMovies = [NSMutableArray arrayWithArray:[movies results]];
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
    
    NSInteger page = 1;
    [movieDBAPI getPopularMovies: page completionHandler:^(QTMovies *movies, NSError *error){
        if (error == nil) {
            self->popularMovies = [NSMutableArray arrayWithArray:[movies results]];
            self->totalPages = [movies totalPages];
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

- (void)getNextPage {
    currentPage += 1;
    MovieDBAPI *movieDBAPI = [[MovieDBAPI alloc] init];
    [movieDBAPI getPopularMovies: currentPage completionHandler:^(QTMovies *movies, NSError *error){
        if (error == nil) {
            NSArray *results = [movies results];
            for (QTResult *movie in results) {
                movie.coverData = [movieDBAPI getCoverFrom: movie.posterPath];
                [self->popularMovies addObject:movie];
            }
            dispatch_async(dispatch_get_main_queue(), ^(void){
                [self.tableView reloadData];
            });
        }
    }];
    
}

- (void)searchMoviesInDB: (NSString *) text completionHandler:(void (^_Nullable)(NSString * _Nonnull searchedText))completionHandler {
    isSearching = YES;
    searchedMovies = [NSArray array];
    MovieDBAPI *movieDBAPI = [[MovieDBAPI alloc] init];
    [movieDBAPI search:text completionHandler:^(QTMovies *movies, NSError *error, NSString *movieTitle){
        if (error == nil) {
            self->searchedMovies = [movies results];
            for (QTResult *movie in self->searchedMovies) {
                movie.coverData = [movieDBAPI getCoverFrom: movie.posterPath];
            }
            completionHandler(text);
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
    self.navigationItem.searchController.searchBar.delegate = self;
    self.navigationItem.searchController.searchResultsUpdater = self;
    self.navigationItem.hidesSearchBarWhenScrolling = NO;
    searchController.obscuresBackgroundDuringPresentation = NO;
    
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    if (indexPath.section == 0 && !isSearching) {
        static NSString *cellIdentifier = @"nowPlayingCell";
        NowPlayingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: cellIdentifier];
        
        if (cell == nil) {
            return [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault
            reuseIdentifier: cellIdentifier];
        }
        [cell configure: nowPlayingMovies];
        cell.movieListViewController = self;
        
        return cell;
        
    } else {
        static NSString *cellIdentifier = @"movieCell";
        MovieTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: cellIdentifier];
        
        if (cell == nil) {
            return [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault
            reuseIdentifier: cellIdentifier];
        }
        if (isSearching) {
            [cell configure: [searchedMovies objectAtIndex: [indexPath row]]];
        }else {
            [cell configure: [popularMovies objectAtIndex: [indexPath row]]];
        }
        
        return cell;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (isSearching) {
        return 1;
    }
    else {
        return 2;
    }
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (isSearching) {
        return [searchedMovies count];
    }
    else {
        if (section == 0) {
            return 1;
        } else {
            return [popularMovies count];
        }
    }
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    // Background color
    view.tintColor = [UIColor colorNamed:@"HeaderColor"];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (isSearching) {
        return @"Results";
    }
    else {
        if (section == 0) {
            return @"Now Playing Movies";
        } else {
            return @"Popular Movies";
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (isSearching || indexPath.section == 1) {
        _rowSelected = [indexPath row];
        _sectionSelected = [indexPath section];
        [self performSegueWithIdentifier: @"movieDetailsSegue" sender: self];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (([indexPath section] == 1) && ([indexPath row] == ([popularMovies count] - 10))) { // Load next page when half page was displayed
        if (currentPage + 1 < totalPages)
            [self getNextPage];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //colocar aqui os dados a serem passados adiante
    MovieDetailViewController *detailsViewController = [segue destinationViewController];
    if (isSearching) {
        detailsViewController.receivedMovie = [searchedMovies objectAtIndex: _rowSelected];
    }
    else {
        if (_sectionSelected == 0) {
            detailsViewController.receivedMovie = [nowPlayingMovies objectAtIndex: _rowSelected];
        } else {
            detailsViewController.receivedMovie = [popularMovies objectAtIndex: _rowSelected];
        }
    }
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    if ([searchBar.text length] == 0) {
        [self.tableView setHidden:YES];
    }
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if ([searchBar.text length] >= 2) { //Only starts searching when the user has entered at least 2 characters
        
        //Waits 0.5 seconds before creating a request, this is done so that we dont create a request for each letter the user enters
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            if([searchText isEqualToString: searchBar.text]){
                [self searchMoviesInDB:searchBar.text completionHandler:^(NSString * _Nonnull searchedText) {
                    dispatch_async(dispatch_get_main_queue(), ^(void){
                        //Run UI Updates
                        //Double checks that the request that came back is what the user currently has written on the search bar
                        if([searchedText isEqualToString:searchBar.text]){
                            [self.tableView setHidden:NO];
                            [self.tableView reloadData];
                        }
                    });
                }];
            }
        });
    }
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    if (![searchController isActive]) {
        [self.tableView setHidden:YES];
        [self getMoviesFromDB];
    }
}


@end
