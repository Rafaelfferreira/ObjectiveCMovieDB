//
//  HeaderCell.m
//  ObjectiveCMovieDB
//
//  Created by Rafael Ferreira on 17/03/20.
//  Copyright © 2020 Rafael Ferreira. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HeaderCell.h"

@implementation HeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.movieGenres setHidden: YES];
    [self.activityIndicator setHidden: YES];
}

- (void)configure:(QTResult *)movie {
    self.movieTitle.text = [movie valueForKey:@"title"];
    self.starRating.text = [[NSNumber numberWithDouble: [movie voteAverage]] stringValue];
    if ([UIImage imageWithData: movie.coverData] != nil) {
        self.moviePoster.image = [UIImage imageWithData: movie.coverData];
    } else {
        self.moviePoster.image = [UIImage imageNamed:@"noCover"];
    }
    self.moviePoster.layer.cornerRadius = 10;
    self.movieGenres.text = [movie valueForKey:@"genresString"];
    if(self.movieGenres != nil) {
        [self.movieGenres setHidden: NO];
        [self.activityIndicator setHidden: YES];
    }
}

@end
