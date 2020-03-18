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

@property (nonatomic, copy) NSString *apiKey;

- (QTMovies *) getPopularMovies;
- (QTMovies *) getNowPlayingMovies;

@end
