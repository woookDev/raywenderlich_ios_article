/// Copyright (c) 2020 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import Foundation
import StoreKit

public enum GreenBarContent {
  // Recipes, non-consumables
  public static let caesarSalad = "com.raywenderlich.GreenBar.recipes.caesar"
  public static let easyPastaSalad = "com.raywenderlich.GreenBar.recipes.easypasta"
  public static let healthyTacoSalad = "com.raywenderlich.GreenBar.recipes.healthytaco"
  public static let tartCherrySalad = "com.raywenderlich.GreenBar.recipes.tartcherrysalad"

  // Coins, consumables
  public static let coins10 = "com.raywenderlich.GreenBar.coins.10"
  public static let coins20 = "com.raywenderlich.GreenBar.coins.20"

  // Subscriptions
  public static let greenTimes = "com.raywenderlich.GreenBar.newsletters.greentimes"
  public static let ketoNews = "com.raywenderlich.GreenBar.newsletters.ketonews"

  public static let recipesPrefix = "com.raywenderlich.GreenBar.recipes"
  public static let subscriptionsPrefix = "com.raywenderlich.GreenBar.newsletters"
  public static let consumablesPrefix = "com.raywenderlich.GreenBar.coins"

  private static let productIdentifiers: Set<ProductIdentifier> = [
    GreenBarContent.caesarSalad,
    GreenBarContent.easyPastaSalad,
    GreenBarContent.healthyTacoSalad,
    GreenBarContent.tartCherrySalad,
    GreenBarContent.greenTimes,
    GreenBarContent.ketoNews,
    GreenBarContent.coins10,
    GreenBarContent.coins20
  ]

  public static let store = IAPHelper(productIds: GreenBarContent.productIdentifiers)

  public static func generateTestRecipes() -> [SKProduct] {
    let product1 = SKProduct()
    product1.setValue("Greek Salad", forKey: "localizedTitle")
    product1.setValue(Decimal(string: "0.99"), forKey: "price")
    product1.setValue(NSLocale.current, forKey: "priceLocale")

    let product2 = SKProduct()
    product2.setValue("Olivier Salad", forKey: "localizedTitle")
    product2.setValue(Decimal(string: "0.99"), forKey: "price")
    product2.setValue(NSLocale.current, forKey: "priceLocale")

    let product3 = SKProduct()
    product3.setValue("Fruit Salad", forKey: "localizedTitle")
    product3.setValue(Decimal(string: "0.99"), forKey: "price")
    product3.setValue(NSLocale.current, forKey: "priceLocale")

    return [product1, product2, product3]
  }

  public static func generateTestConsumables() -> [SKProduct] {
    let product1 = SKProduct()
    product1.setValue("5 Coins", forKey: "localizedTitle")
    product1.setValue(Decimal(string: "1.99"), forKey: "price")
    product1.setValue(NSLocale.current, forKey: "priceLocale")

    let product2 = SKProduct()
    product2.setValue("10 Coins", forKey: "localizedTitle")
    product2.setValue(Decimal(string: "3.99"), forKey: "price")
    product2.setValue(NSLocale.current, forKey: "priceLocale")

    return [product1, product2]
  }
}

func resourceNameForProductIdentifier(_ productIdentifier: String) -> String? {
  return productIdentifier.components(separatedBy: ".").last
}
