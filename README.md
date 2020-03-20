[![Build Status](https://travis-ci.com/fabricetiennette/Reciplease.svg?branch=master)](https://travis-ci.com/fabricetiennette/Reciplease)   [![codecov](https://codecov.io/gh/fabricetiennette/Reciplease/branch/master/graph/badge.svg)](https://codecov.io/gh/fabricetiennette/Reciplease)

# Reciplease
🍽 Find and save a recipe with reciplease app

<img src="./Pictures/Search.png" width="200" height="450">&nbsp; &nbsp; <img src="./Pictures/Recipe.png" width="200" height="450">&nbsp; &nbsp; <img src="./Pictures/Details.png" width="200" height="450">&nbsp; &nbsp; &nbsp; <img src="./Pictures/Favorites.png" width="200" height="450"> 

## 🍕 About
Reciplease is the app thats will help you cook nice plats in your everyday life. It will let you enter your ingredients left in your fridge and search for recipes. Recipes that you can save in your app favorite page and have access offline.

I had to build an app with two pages for [Openclassrooms](https://openclassrooms.com/).

## 💻 Requirements
Reciplease is written in Swift 5 and supports iOS 13.0+. Built with Xcode 11.

## 🍀 Architecture
I decided to deal with this app with a [MVVM](https://medium.com/better-programming/mvvm-in-ios-from-net-perspective-580eb7f4f129) with [Coordinator](http://khanlou.com/2015/01/the-coordinator/) architectural pattern.

## 🛠 Dependencies
As activity indicator i use [NVActivityIndicatorView](https://github.com/ninjaprox/NVActivityIndicatorView), for a better Swift Style [SwiftLint](https://github.com/realm/SwiftLint), to save recipe for offline use [CoreData](https://developer.apple.com/documentation/coredata) and [Alamofire](https://github.com/Alamofire/Alamofire) for an elegant HTTP Networking in Swift.
I use [CocoaPods](https://cocoapods.org) as dependency manager.

## 🕵️‍♂️ How to test 
### Clone the project

Run `git@github.com:fabricetiennette/Reciplease.git` 

### Install dependencies

Run `pod install`

### Workspace

Open `Reciplease.xcworkspace`

Build & Run 🔥
