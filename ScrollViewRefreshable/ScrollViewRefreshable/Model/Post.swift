//
//  Post.swift
//  ScrollViewRefreshable
//
//  Created by Abhishek Dogra on 20/09/23.
//

import Foundation

struct Post: Identifiable, Hashable {
    var id = UUID().uuidString
    var imageURL: String
    
}
