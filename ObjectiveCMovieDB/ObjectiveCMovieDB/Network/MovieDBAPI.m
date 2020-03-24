//
//  MovieDBAPI.m
//  ObjectiveCMovieDB
//
//  Created by Pedro Lopes on 18/03/20.
//  Copyright © 2020 Rafael Ferreira. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MovieDBAPI.h"

@implementation MovieDBAPI

- (id)init {
    self.apiKey = @"ad28148852ee2cbbb8766d7babbf7c5e";
    return self;
}

- (void) getMoviesFromURL: (NSURL *) url completionHandler:(void(^)(QTMovies * _Nullable movies, NSError * _Nullable error))completionHandler {
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL: url
              completionHandler:^(NSData *data,
                                  NSURLResponse *response,
                                  NSError *error) {
        if (error == nil) {
            NSError *error;
            QTMovies *movies = [QTMovies fromData:data error:&error];
            completionHandler(movies, nil);
        } else {
            completionHandler(nil,error);
        }
                

      }] resume];
}

- (void)getNowPlayingMovies: (NSInteger) page completionHandler:(void (^)(QTMovies * _Nullable, NSError * _Nullable))completionHandler {
    [self getMoviesFromURL:[NSURL URLWithString: [NSString stringWithFormat:@"%@%@%@%@", @"https://api.themoviedb.org/3/movie/now_playing?api_key=", self.apiKey, @"&language=en-US&page=",[NSString stringWithFormat: @"%ld", (long)page]]] completionHandler:^(QTMovies *movies, NSError *error) {
        completionHandler(movies, error);
    }];
}

- (void)getPopularMovies:(void (^)(QTMovies * _Nullable, NSError * _Nullable))completionHandler {
    [self getMoviesFromURL:[NSURL URLWithString: [NSString stringWithFormat:@"%@%@%@", @"https://api.themoviedb.org/3/movie/popular?api_key=", self.apiKey, @"&language=en-US&page=1"]] completionHandler:^(QTMovies *movies, NSError *error) {
        completionHandler(movies, error);
    }];
}

- (void) getMovieGenres: (QTResult *_Nonnull) movie completionHandler:(void(^_Nullable)(NSArray * _Nullable genres, NSError * _Nullable error))completionHandler {
    
    __block NSSet *genreIDS = [NSSet setWithArray: [movie valueForKey:@"genreIDS"]];
    __block NSArray *genresDictionary = [NSArray alloc];
    __block NSMutableArray *genres = [[NSMutableArray alloc] init];
    
    NSURL *url = [NSURL URLWithString: [NSString stringWithFormat: @"%@%@%@",  @"https://api.themoviedb.org/3/genre/movie/list?api_key=",self.apiKey, @"&language=en-US"]];
    
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL: url
              completionHandler:^(NSData * data,
                                  NSURLResponse * response,
                                  NSError * error) {
        if (error == nil) {
            NSError *error;
            @try {
                NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData: data options:NSJSONReadingAllowFragments error: &error];
                genresDictionary = [jsonData valueForKeyPath:@"genres"];
            } @catch (NSException *exception) {
                error = [NSError errorWithDomain:@"JSONSerialization" code:-1 userInfo:@{ @"exception": exception }];
            }
            
            
            for (NSDictionary *genre in genresDictionary) {
                if ([genreIDS containsObject:[genre valueForKey:@"id"]]) {
                    [genres addObject: [genre valueForKey:@"name"]];
                }
            }
            completionHandler(genres, error);
        } else {
            completionHandler(nil, error);
        }
    }] resume];
}


- (NSData * _Nullable) getCoverFrom: (NSString * _Nullable) coverPath {
    if (coverPath == nil) {
        return nil;
    } else {
        NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", @"https://image.tmdb.org/t/p/w500", coverPath]];
        if (url == nil) {
            return nil;
        } else {
            return [NSData dataWithContentsOfURL:url];
        }
    }
}

- (void)search:(NSString *)text completionHandler:(void (^)(QTMovies * _Nullable, NSError * _Nullable))completionHandler {
    NSString * stringToSearch = [text stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    [self getMoviesFromURL:[NSURL URLWithString: [NSString stringWithFormat:@"%@%@%@%@%@", @"https://api.themoviedb.org/3/search/movie?api_key=", self.apiKey, @"&language=en-US&query=", stringToSearch, @"&page=1&include_adult=false"]] completionHandler:^(QTMovies *movies, NSError *error) {
        completionHandler(movies, error);
    }];
}

@end
