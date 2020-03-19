//
//  MovieDetailViewController.h
//  ObjectiveCMovieDB
//
//  Created by Rafael Ferreira on 17/03/20.
//  Copyright © 2020 Rafael Ferreira. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QTMovies.h"
#import "DescriptionCell.h"
#import "HeaderCell.h"

#ifndef MovieDetailViewController_h
#define MovieDetailViewController_h

//Entre os <> estao os protocolos que a view controller deve conformar
@interface MovieDetailViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *movieDetailTableView;
@property QTResult *receivedMovie;


@end

#endif /* MovieDetailViewController_h */
