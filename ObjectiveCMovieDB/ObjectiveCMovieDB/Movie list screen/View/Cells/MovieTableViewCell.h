//
//  MovieTableViewCell.h
//  ObjectiveCMovieDB
//
//  Created by Pedro Lopes on 16/03/20.
//  Copyright © 2020 Rafael Ferreira. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QTMovies.h"

NS_ASSUME_NONNULL_BEGIN

@interface MovieTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *movieCover;
@property (weak, nonatomic) IBOutlet UILabel *movieTitle;
@property (weak, nonatomic) IBOutlet UILabel *movieDescription;
@property (weak, nonatomic) IBOutlet UILabel *movieRating;

- (void) configure: (QTResult *) movie;

@end

NS_ASSUME_NONNULL_END
