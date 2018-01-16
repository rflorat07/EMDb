//
//  MovieManaged+Mapping.swift
//  EMDb
//
//  Created by Roger Florat on 15/01/18.
//  Copyright © 2018 Roger Florat. All rights reserved.
//

import Foundation

extension MovieManaged {
    
    func mappedObject() -> Movie {
        return Movie(id: self.id, title: self.title, order: Int(self.order), summary: self.summary, image: self.image, category: self.category, director: self.director)
    }
    
}
