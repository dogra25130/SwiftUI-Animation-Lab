//
//  Note.swift
//  Notes Watch App
//
//  Created by Abhishek Dogra on 10/06/23.
//

import Foundation
struct Note: Codable, Identifiable {
    let id: UUID
    let text: String
}
