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
    _movieTitle.text = [movie title];
    _movieDescription.text = [movie overview];
    _movieRating.text = [[NSNumber numberWithDouble: [movie voteAverage]] stringValue];
    _movieCover.layer.cornerRadius = 10;
}

@end
