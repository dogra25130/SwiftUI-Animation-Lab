//
//  Movie.swift
//  CarouselMovies
//
//  Created by Abhishek Dogra on 22/10/23.
//

import Foundation
struct Movie: Identifiable {
    let id = UUID().uuidString
    var description: String
    var artwork: String
    let title: String
}
var movies: [Movie] = [
    Movie(description: "Jackson Pollock was a pioneer of abstract expressionism, known for his energetic and chaotic artworks that captured raw emotions.", artwork: "1", title: "Jackson Pollock"),
    Movie(description: "Frida Kahlo's art is a surreal exploration of identity, pain, and resilience, often featuring vibrant and iconic characters from her imagination.", artwork: "2", title: "Frida Kahlo"),
    Movie(description: "Vincent van Gogh's paintings are a testament to his creativity and imagination, with each stroke telling a unique story.", artwork: "3", title: "Vincent van Gogh"),
    Movie(description: "Paero Samiko's abstract artworks challenge traditional norms, using bold shapes and forms to convey primal energy and emotion.", artwork: "4", title: "Paero Samiko"),
    Movie(description: "Georgia O'Keeffe's elegant artworks depict the serene beauty of nature through stunning landscapes and close-ups of flowers.", artwork: "5", title: "Georgia O'Keeffe"),
    Movie(description: "Rofaro Sokimo's art tells a thrilling narrative of a skilled archer in the heart of the Marvel Universe, combining action and heroism.", artwork: "6", title: "Rofaro Sokimo"),
]
