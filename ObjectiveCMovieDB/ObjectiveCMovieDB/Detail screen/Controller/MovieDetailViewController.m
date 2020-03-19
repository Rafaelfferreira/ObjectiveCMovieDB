//
//  MovieDetailViewController.m
//  ObjectiveCMovieDB
//
//  Created by Rafael Ferreira on 17/03/20.
//  Copyright © 2020 Rafael Ferreira. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MovieDetailViewController.h"

@interface MovieDetailViewController ()

@end

@implementation MovieDetailViewController {
    NSString *genres;
    BOOL requestDone;
    BOOL requestError;
}

- (void)viewWillAppear:(BOOL)animated {
    //Precisa substituir o texto de back por um botao mesmo
//    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"TESTE" style:UIBarButtonItemStylePlain target:self action: @selector(Back)];
//    self.navigationItem.leftBarButtonItem = backButton;
    
//    self.receivedMovie = [QTResult alloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.movieDetailTableView setDelegate: self];
    [self.movieDetailTableView setDataSource: self];
    
    [self getGenres];
}
- (IBAction)Back {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    int cellIdentifier = indexPath.row;
    
    if (cellIdentifier == 0) {
        HeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Header"];
        [cell configure: _receivedMovie];
        return cell;
    }
    else if (cellIdentifier == 2) {
        DescriptionCell *cell = [tableView dequeueReusableCellWithIdentifier: @"Description"];
        [cell configure: _receivedMovie];
        return cell;
    }

    return [tableView dequeueReusableCellWithIdentifier:@"Overview"];
    
}

- (void)getGenres {
    requestDone = NO;
    requestError = NO;
    genres = @"";
    
    MovieDBAPI *movieDBAPI = [[MovieDBAPI alloc] init];
    [movieDBAPI getMovieGenres: _receivedMovie completionHandler:^(NSArray * _Nullable genres, NSError * _Nullable error) {
        NSLog(genres);
    }];
}

//- (void)getMoviesFromDB {
//    [self.tableView setHidden:YES];
//    requestDone = NO;
//    requestError = NO;
//    popularMovies = [NSArray array];
//    nowPlayingMovies = [NSArray array];
//
//    MovieDBAPI *movieDBAPI = [[MovieDBAPI alloc] init];
//    [movieDBAPI getNowPlayingMovies: ^(QTMovies *movies, NSError *error){
//        if (error == nil) {
//            self->nowPlayingMovies = [movies results];
//            for (QTResult *movie in self->nowPlayingMovies) {
//                movie.coverData = [movieDBAPI getCoverFrom: movie.posterPath];
//            }
//            if (self->requestDone && !self->requestError) {
//                dispatch_async(dispatch_get_main_queue(), ^(void){
//                    //Run UI Updates
//                    [self.tableView setHidden:NO];
//                    [self.tableView reloadData];
//                });
//            } else {
//                self->requestDone = YES;
//            }
//        } else {
//            dispatch_async(dispatch_get_main_queue(), ^(void){
//                [self showErrorAlert:error];
//            });
//            self->requestError = YES;
//        }
//    }];
//
//    [movieDBAPI getPopularMovies: ^(QTMovies *movies, NSError *error){
//        if (error == nil) {
//            self->popularMovies = [movies results];
//            for (QTResult *movie in self->popularMovies) {
//                movie.coverData = [movieDBAPI getCoverFrom: movie.posterPath];
//            }
//            if (self->requestDone && !self->requestError) {
//                dispatch_async(dispatch_get_main_queue(), ^(void){
//                    //Run UI Updates
//                    [self.tableView setHidden:NO];
//                    [self.tableView reloadData];
//                });
//            } else {
//                self->requestDone = YES;
//            }
//        } else {
//            dispatch_async(dispatch_get_main_queue(), ^(void){
//                [self showErrorAlert:error];
//            });
//            self->requestError = YES;
//        }
//    }];
//}


@end
