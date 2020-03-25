//
//  NowPlayingTableViewCell.h
//  ObjectiveCMovieDB
//
//  Created by Pedro Lopes on 25/03/20.
//  Copyright © 2020 Rafael Ferreira. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieListViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface NowPlayingTableViewCell : UITableViewCell <UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) MovieListViewController *movieListViewController;

- (void) configure: (NSMutableArray *) movies;

@end

NS_ASSUME_NONNULL_END
