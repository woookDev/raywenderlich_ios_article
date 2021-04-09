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

import SwiftUI

struct RecipeView: View {
  @State private var showingDoneAlert = false
  @State private var showingNoEnoughCoinsAlert = false
  var title: String
  var productDescription: String

  var body: some View {
    ScrollView {
      Text("\(productDescription)")
        .padding(EdgeInsets.init(top: 0, leading: 10, bottom: 0, trailing: 10))
        .multilineTextAlignment(.center)

      Image("recipe")
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(
          width: UIScreen.main.bounds.size.width - 10,
          height: UIScreen.main.bounds.size.height - 150,
          alignment: .center)
        .navigationTitle("\(title) Recipe")
        .navigationBarItems(trailing: Button("Give 5 Coins") { giveCoins() }
        .alert(isPresented: $showingDoneAlert) {
          Alert(
            title: Text("Thank you!"),
            message: Text("You have given the author 5 coins!"),
            dismissButton: .default(Text("Dismiss")))
        })
    }
    .alert(isPresented: $showingNoEnoughCoinsAlert) {
      Alert(
        title: Text("No enough coins"),
        message: Text("You don't have enough coins, please purchase more coins"),
        dismissButton: .default(Text("Dismiss")))
    }
  }

  func giveCoins() {
    let balance = UserDefaults.standard.integer(forKey: GreenBarContent.consumablesPrefix)

    if balance >= 5 {
      UserDefaults.standard.set(balance - 5, forKey: GreenBarContent.consumablesPrefix)

      showingDoneAlert.toggle()
    } else {
      showingNoEnoughCoinsAlert.toggle()
    }
  }
}

struct RecipeView_Previews: PreviewProvider {
  static var previews: some View {
    RecipeView(title: "Salad", productDescription: "Tomatoes, cucumbers, bell peppers and cheese!")
  }
}
