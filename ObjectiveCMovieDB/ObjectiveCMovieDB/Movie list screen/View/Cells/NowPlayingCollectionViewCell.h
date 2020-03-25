//
//  NowPlayingCollectionViewCell.h
//  ObjectiveCMovieDB
//
//  Created by Pedro Lopes on 25/03/20.
//  Copyright © 2020 Rafael Ferreira. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QTMovies.h"

NS_ASSUME_NONNULL_BEGIN

@interface NowPlayingCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *poster;
@property (weak, nonatomic) IBOutlet UILabel *movieTitle;
@property (weak, nonatomic) IBOutlet UILabel *ratings;

- (void) configure: (QTResult *) movie;

@end

NS_ASSUME_NONNULL_END
