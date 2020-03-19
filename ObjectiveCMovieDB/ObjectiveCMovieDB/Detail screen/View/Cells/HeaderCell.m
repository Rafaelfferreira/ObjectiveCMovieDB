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
}

- (void)configure:(QTResult *)movie {
    self.movieTitle.text = [movie valueForKey:@"title"];
    self.starRating.text = [[NSNumber numberWithDouble: [movie voteAverage]] stringValue];
    self.moviePoster.image = [UIImage imageWithData: movie.coverData];
    self.moviePoster.layer.cornerRadius = 10;
}

@end
