//
//  Movie.swift
//  MovieDBViper
//
//  Created Pedro Enrique Sobrosa Lopes on 14/08/19.
//  Copyright © 2019 Pedro. All rights reserved.
//

import UIKit

/// MovieMain Module Entity
struct Movie {
    var id: Int?
    var coverData: Data?
    var title: String?
    var ratings: Double?
    var overview: String?
    var genresIds: [NSNumber]
}
