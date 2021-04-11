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

struct HistogramLevels {
	var red: [UInt]
	var green: [UInt]
	var blue: [UInt]
	var alpha: [UInt]
}

struct HistogramLine: View {
	var channel: [UInt]
	var color: Color
	var proxy: GeometryProxy
	var maxValue: UInt

	func xForBin(_ bin: Int, proxy: GeometryProxy) -> CGFloat {
		let widthOfBin = proxy.size.width / CGFloat(channel.count)
		return CGFloat(bin) * widthOfBin
	}

	func yForCount(_ count: UInt, proxy: GeometryProxy) -> CGFloat {
		let heightOfLevel = proxy.size.height / CGFloat(maxValue)
		return proxy.size.height - CGFloat(count) * heightOfLevel
	}

	var body: some View {
		Path { path in
			for bin in 0..<channel.count {
				let newPoint = CGPoint(
					x: xForBin(bin, proxy: proxy),
					y: yForCount(channel[bin], proxy: proxy)
				)
				if bin == 0 {
					path.move(to: newPoint)
				} else {
					path.addLine(to: newPoint)
				}
			}
		}.stroke(color)
	}
}

struct HistogramView: View {
	var histogram: HistogramLevels

	var binCount: Int {
		histogram.red.count
	}

	var body: some View {
		GeometryReader { proxy in
			HistogramLine(
				channel: histogram.red,
				color: Color.red,
				proxy: proxy,
				maxValue: histogram.red.max() ?? 1
			)
			HistogramLine(
				channel: histogram.green,
				color: Color.green,
				proxy: proxy,
				maxValue: histogram.green.max() ?? 1
			)
			HistogramLine(
				channel: histogram.blue,
				color: Color.blue,
				proxy: proxy,
				maxValue: histogram.blue.max() ?? 1
			)
		}
	}
}

struct HistogramView_Previews: PreviewProvider {
	static var previews: some View {
		HistogramView(
			histogram: HistogramLevels(
				red: [0, 1, 2, 3, 4],
				green: [3, 4, 4, 6, 7],
				blue: [10, 9, 8, 7, 6],
				alpha: [2, 8, 4, 6, 5]
			)
		)
		.frame(width: 375, height: 275)
		.border(Color.gray)
	}
}
