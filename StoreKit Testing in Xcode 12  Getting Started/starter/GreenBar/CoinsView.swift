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
import StoreKit

struct CoinsView: View {
  @State var balance: Int = UserDefaults.standard.integer(forKey: GreenBarContent.consumablesPrefix)

  @State var products: [SKProduct] = []

  var body: some View {
    NavigationView {
      VStack {
        Image(balance > 0 ? "has-coins" : "no-coins")
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(width: UIScreen.main.bounds.size.width - 50, height: 150, alignment: .top)
          .padding(.init(top: 20, leading: 0, bottom: 0, trailing: 0))

        Text("Coins Balance:")
          .bold()

        Text("\(balance)")
          .bold()

        List {
          Section(header: Text("Buy coins")) {
            ForEach(products, id: \.productIdentifier) { product in
              ProductRow(product: product)
            }
          }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarTitle("Coins")
        .listStyle(GroupedListStyle())
      }
    }.onAppear {
      updateBalance()
      loadProducts()
    }
    .onReceive(NotificationCenter.default.publisher(
    for: Notification.Name.IAPHelperPurchaseNotification)) { _ in updateBalance() }
  }

  func updateBalance() {
    balance = UserDefaults.standard.integer(forKey: GreenBarContent.consumablesPrefix)
  }

  func loadProducts() {
    GreenBarContent.store.requestProducts { success, products in
      DispatchQueue.main.async {
        if success {
          self.products = products?.filter { product -> Bool in
            product.productIdentifier.hasPrefix(GreenBarContent.consumablesPrefix)
          } ?? []
        }
      }
    }
  }
}

struct CoinsView_Previews: PreviewProvider {
  static var previews: some View {
    CoinsView(balance: 150, products: GreenBarContent.generateTestConsumables())
  }
}
