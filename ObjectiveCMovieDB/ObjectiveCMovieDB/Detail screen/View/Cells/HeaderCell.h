//
//  HeaderCell.h
//  ObjectiveCMovieDB
//
//  Created by Rafael Ferreira on 17/03/20.
//  Copyright © 2020 Rafael Ferreira. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifndef HeaderCell_h
#define HeaderCell_h

@interface HeaderCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *moviePoster;
@property (weak, nonatomic) IBOutlet UILabel *movieTitle;
@property (weak, nonatomic) IBOutlet UILabel *movieGenres;
@property (weak, nonatomic) IBOutlet UILabel *starRating;



@end

#endif /* HeaderCell_h */
