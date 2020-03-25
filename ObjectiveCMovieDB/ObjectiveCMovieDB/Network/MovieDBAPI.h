//
//  MovieDBAPI.h
//  ObjectiveCMovieDB
//
//  Created by Pedro Lopes on 18/03/20.
//  Copyright © 2020 Rafael Ferreira. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QTMovies.h"

@class MovieDBAPI;

@interface MovieDBAPI : NSObject

@property (nonatomic, copy) NSString * _Nonnull apiKey;
@property NSURLSession * _Nonnull urlSession;
@property NSURLSessionDataTask * _Nullable dataTask;

//- (NSURLSessionDataTask *_Nonnull)dataTaskWithURL:(NSURL *_Nullable)url completionHandler:(void (^_Nullable)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))completionHandler;

- (void) getPopularMovies: (NSInteger) page completionHandler:(void(^_Nullable)(QTMovies * _Nullable movies, NSError * _Nullable error))completionHandler;
- (void) getNowPlayingMovies: (void(^_Nullable)(QTMovies * _Nullable movies, NSError * _Nullable error))completionHandler;
- (void) getMoviesFromURL: (NSURL *_Nonnull) url completionHandler:(void(^_Nullable)(QTMovies * _Nullable movies, NSError * _Nullable error))completionHandler;
- (void) search: (NSString *_Nonnull) text completionHandler:(void (^_Nullable)(QTMovies * _Nullable, NSError * _Nullable, NSString * _Nullable))completionHandler;
- (void) getMovieGenres: (QTResult *_Nonnull) movie completionHandler:(void(^_Nullable)(NSArray * _Nullable genres, NSError * _Nullable error))completionHandler;
- (NSData * _Nullable) getCoverFrom: (NSString * _Nullable) coverPath;

@end
