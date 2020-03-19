//
//  DescriptionCell.h
//  ObjectiveCMovieDB
//
//  Created by Rafael Ferreira on 17/03/20.
//  Copyright © 2020 Rafael Ferreira. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QTMovies.h"

#ifndef DescriptionCell_h
#define DescriptionCell_h

@interface DescriptionCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *descriptionText;


- (void) configure: (QTResult *) movie;

@end

#endif /* DescriptionCell_h */
