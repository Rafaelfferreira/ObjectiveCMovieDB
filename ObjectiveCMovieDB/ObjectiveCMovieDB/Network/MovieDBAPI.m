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

//- (NSData *) getDataFromURL: (NSURL *) url {
//    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
//    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
//    [NSURLConnection sendAsynchronousRequest:urlRequest queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
//      if (error) {
//        //NSLog(@"Error,%@", [error localizedDescription]);
//      }
//      else {
//        //NSLog(@"%@", [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding]);
//      }
//    }];
//}
//
//- (QTMovies *) getNowPlayingMovies {
//
//}
//
//- (QTMovies *) getPopularMovies {
//
//}

@end
