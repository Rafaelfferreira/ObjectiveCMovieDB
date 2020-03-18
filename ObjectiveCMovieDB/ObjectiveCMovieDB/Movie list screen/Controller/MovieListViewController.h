//
//  ViewController.h
//  ObjectiveCMovieDB
//
//  Created by Rafael Ferreira on 16/03/20.
//  Copyright © 2020 Rafael Ferreira. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSInteger rowSelected;
@end

