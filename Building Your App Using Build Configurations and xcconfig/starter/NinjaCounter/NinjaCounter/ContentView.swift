/// Copyright (c) 2021 Razeware LLC
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

struct ContentView: View {
  @State var hatchlings: [Hatchling] = []
  @State private var tag: String = ""

  var body: some View {
    NavigationView {
      VStack {
        List(hatchlings, id: \.id) { ninja in
          HStack {
            Text(ninja.tag)

            Spacer()

            Text("Hatch time")
              .font(.footnote)
              .foregroundColor(.green)

            Text(formatDate(ninja.date))
          }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationBarTitle("Ninja Counter")
        .navigationBarItems(trailing:
          Button("Clear") {
            hatchlings = []
            UserDefaultsHelper.clearRecords()
          })


        VStack {
          Divider()
          HStack {
            Text("Tag:")
              .padding(.leading)
              .foregroundColor(Color("rw-dark"))
            TextField("Leonardo", text: $tag)
              .textFieldStyle(RoundedBorderTextFieldStyle())
              .padding(.trailing)
          }
          .padding(.top)

          Button("+ Hatchling") {
            recordHatchling()
          }
          .padding(.bottom)
          .font(.largeTitle)
        }
      }
    }
    .onAppear(perform: loadProducts)
    .accentColor(Color("rw-green"))
  }


  func loadProducts() {
    hatchlings = UserDefaultsHelper.getRecords()
  }

  func recordHatchling() {
    var hatchling = Hatchling(tag: tag, date: Date())
    if hatchling.tag.isEmpty {
      let newTag = String(hatchling.id.uuidString.suffix(6))
      hatchling.tag = newTag
    }
    hatchlings.append(hatchling)
    UserDefaultsHelper.persistRecords(hatchlings)
  }

  func formatDate(_ date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MM/dd HH:mm:SS"
    return dateFormatter.string(from: date)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView(hatchlings: Hatchling.generatePreviewHatchlings())
  }
}
