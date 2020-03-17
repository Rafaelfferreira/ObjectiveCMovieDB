//
//  MovieDetailViewController.m
//  ObjectiveCMovieDB
//
//  Created by Rafael Ferreira on 17/03/20.
//  Copyright © 2020 Rafael Ferreira. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MovieDetailViewController.h"

@interface MovieDetailViewController ()

@end

@implementation MovieDetailViewController

- (void)viewWillAppear:(BOOL)animated {
    //Precisa substituir o texto de back por um botao mesmo
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"TESTE" style:UIBarButtonItemStylePlain target:self action: @selector(Back)];
    self.navigationItem.leftBarButtonItem = backButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.movieDetailTableView setDelegate: self];
    [self.movieDetailTableView setDataSource: self];
    
}
- (IBAction)Back {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"TA ENTRANDO AQUI OU NAO");
    int cellIdentifier = indexPath.row;
    if (cellIdentifier == 2) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"Description"];
        return cell;
    }
    
    return [tableView dequeueReusableCellWithIdentifier:@"Overview"];
    
}

@end
