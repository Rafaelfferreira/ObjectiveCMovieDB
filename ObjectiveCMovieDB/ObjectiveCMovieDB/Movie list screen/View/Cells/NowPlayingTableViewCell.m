//
//  NowPlayingTableViewCell.m
//  ObjectiveCMovieDB
//
//  Created by Pedro Lopes on 25/03/20.
//  Copyright © 2020 Rafael Ferreira. All rights reserved.
//

#import "NowPlayingTableViewCell.h"
#import "NowPlayingCollectionViewCell.h"

@implementation NowPlayingTableViewCell {
    NSMutableArray *movies;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) configure: (NSMutableArray *) movies {
    self->movies = movies;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    if (movies.count > 0) {
        [self.collectionView reloadData];
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return movies.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"nowPlayingMovieCell";
    
    NowPlayingCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        return [[UICollectionViewCell alloc] init];
    }
    
    [cell configure:[movies objectAtIndex: [indexPath row]]];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.movieListViewController.rowSelected = indexPath.row;
    self.movieListViewController.sectionSelected = 0;
    [self.movieListViewController performSegueWithIdentifier:@"movieDetailsSegue" sender: self.movieListViewController];
}


@end
