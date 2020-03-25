//
//  MovieTableViewCell.m
//  ObjectiveCMovieDB
//
//  Created by Pedro Lopes on 16/03/20.
//  Copyright © 2020 Rafael Ferreira. All rights reserved.
//

#import "MovieTableViewCell.h"

@implementation MovieTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) configure: (QTResult *) movie {
    if ([UIImage imageWithData:movie.coverData] != nil) {
        self.movieCover.image = [UIImage imageWithData:movie.coverData];
    } else {
        self.movieCover.image = [UIImage imageNamed:@"noCover"];
    }
    
    self.movieTitle.text = [movie title];
    self.movieDescription.text = [movie overview];
    self.movieRating.text = [[NSNumber numberWithDouble: [movie voteAverage]] stringValue];
    self.movieCover.layer.cornerRadius = 10;
}

@end
