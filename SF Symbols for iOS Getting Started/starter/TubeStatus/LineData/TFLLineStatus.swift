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

import Foundation
import SwiftUI

enum TFLLineStatus: Int, CaseIterable {
  case unknown = -1
  case specialService
  case closed
  case suspended
  case partSuspended
  case plannedClosure
  case partClosure
  case severeDelays
  case reducedService
  case busService
  case minorDelays
  case goodService
  case partClosed
  case exitOnly
  case noStepFreeAccess
  case changeOfFrequency
  case diverted
  case notRunning
  case issuesReported
  case noIssues
  case information
  case serviceClosed

  // swiftlint:disable:next cyclomatic_complexity
  func displayName() -> String {
    switch self {
    case .specialService:
      return "Special Service"
    case .closed:
      return "Closed"
    case .suspended:
      return "Suspended"
    case .partSuspended:
      return "Part Suspended"
    case .plannedClosure:
      return "Planned Closure"
    case .partClosure:
      return "Part Closure"
    case .severeDelays:
      return "Severe Delays"
    case .reducedService:
      return "Reduced Service"
    case .busService:
      return "Bus Service"
    case .minorDelays:
      return "Minor Delays"
    case .goodService:
      return "Good Service"
    case .partClosed:
      return "Part Closed"
    case .exitOnly:
      return "Exit Only"
    case .noStepFreeAccess:
      return "No Step Free Access"
    case .changeOfFrequency:
      return "Change of Frequency"
    case .diverted:
      return "Diverted"
    case .notRunning:
      return "Not Running"
    case .issuesReported:
      return "Issues Reported"
    case .noIssues:
      return "No Issues"
    case .information:
      return "Information"
    case .serviceClosed:
      return "Service Closed"
    case .unknown:
      return "Unknown"
    }
  }
}
