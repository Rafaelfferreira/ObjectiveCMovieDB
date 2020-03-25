//
//  NowPlayingCollectionViewCell.m
//  ObjectiveCMovieDB
//
//  Created by Pedro Lopes on 25/03/20.
//  Copyright © 2020 Rafael Ferreira. All rights reserved.
//

#import "NowPlayingCollectionViewCell.h"

@implementation NowPlayingCollectionViewCell

- (void) configure: (QTResult *) movie {
    if ([UIImage imageWithData:movie.coverData] != nil) {
        self.poster.image = [UIImage imageWithData:movie.coverData];
    } else {
        self.poster.image = [UIImage imageNamed:@"noCover"];
    }
    
    self.movieTitle.text = [movie title];
    self.ratings.text = [[NSNumber numberWithDouble: [movie voteAverage]] stringValue];
    self.poster.layer.cornerRadius = 10;
}


@end
