//
//  Model.swift
//  Learn by Doing
//
//  Created by Abhishek Dogra on 11/06/23.
//

import SwiftUI

struct Card: Identifiable {
  var id = UUID()
  var title: String
  var headline: String
  var imageName: String
  var callToAction: String
  var message: String
  var gradientColors: [Color]
}


let cardData: [Card] = [
  Card(
    title: "SwiftUI",
    headline: "Better apps. Less code.",
    imageName: "developer-no1",
    callToAction: "Design",
    message: "Introducing a modern way to design user interfaces for any Apple devices.",
    gradientColors: [Color("Color01"), Color("Color02")]),
  Card(
    title: "iOS",
    headline: "Dramatic new look.",
    imageName: "developer-no2",
    callToAction: "Discover",
    message: "Get ready for iOS and learn everything about it.",
    gradientColors: [Color("Color03"), Color("Color04")]
  ),
  Card(
    title: "Swift",
    headline: "Everyone can code.",
    imageName: "developer-no3",
    callToAction: "Implement",
    message: "A modern yet powerful programming language that is also easy to learn.",
    gradientColors: [Color("Color05"), Color("Color06")]
  ),
  Card(
    title: "Catalyst",
    headline: "Bring Your iPad App to Mac.",
    imageName: "developer-no4",
    callToAction: "Distribute",
    message: "Now it’s incredibly simple to start building a native Mac app from your iPad app.",
    gradientColors: [Color("Color07"), Color("Color08")]
  ),
  Card(
    title: "Playgrounds",
    headline: "Engaging way to learn coding.",
    imageName: "developer-no5",
    callToAction: "Experiment",
    message: "A new way to create code. On the best device for learning.",
    gradientColors: [Color("Color09"), Color("Color10")]
  ),
  Card(
    title: "Xcode",
    headline: "The best tool you need to build apps.",
    imageName: "developer-no6",
    callToAction: "Develop",
    message: "Bring your ideas to life and build awesome apps for all platforms.",
    gradientColors: [Color("Color11"), Color("Color12")]
  )
]
