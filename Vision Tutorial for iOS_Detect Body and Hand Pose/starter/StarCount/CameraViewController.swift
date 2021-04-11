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

import AVFoundation
import UIKit
import Vision

extension CameraViewController: AVCaptureVideoDataOutputSampleBufferDelegate {
  func captureOutput(_ output: AVCaptureOutput,
                     didOutput sampleBuffer: CMSampleBuffer,
                     from connection: AVCaptureConnection
  ) {
    
  }
}

final class CameraViewController: UIViewController {
  
  private var cameraFeedSession: AVCaptureSession?
  
  private let handPoseRequest: VNDetectHumanHandPoseRequest = {
    // 1
    let request = VNDetectHumanHandPoseRequest()
    
    // 2
    request.maximumHandCount = 2
    return request
  }()
  
  private let videoDataOutputQueue = DispatchQueue(
    label: "CameraFeedOutput",
    qos: .userInteractive
  )
  
  // 1
  override func loadView() {
    view = CameraPreview()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    do {
      // 1
      if cameraFeedSession == nil {
        // 2
        try setupAVSession()
        // 3
        cameraView.previewLayer.session = cameraFeedSession
        cameraView.previewLayer.videoGravity = .resizeAspectFill
      }
      
      cameraFeedSession?.startRunning()
    } catch {
      print(error.localizedDescription)
    }
  }
  
  // 5
  override func viewWillDisappear(_ animated: Bool) {
    cameraFeedSession?.stopRunning()
    super.viewWillDisappear(animated)
  }
  
  func setupAVSession() throws {
    // 1
    guard let videoDevice = AVCaptureDevice.default(
            .builtInWideAngleCamera,
            for: .video,
            position: .front
    ) else {
      throw AppError.captureSessionSetup(reason: "Could not find a front facing camera")
    }
    
    // 2
    guard let deviceInput = try? AVCaptureDeviceInput(device: videoDevice) else {
      throw AppError.captureSessionSetup(reason: "Could not create video device input")
    }
    
    // 3
    let session = AVCaptureSession()
    session.beginConfiguration()
    session.sessionPreset = AVCaptureSession.Preset.high
    
    // 4
    guard session.canAddInput(deviceInput) else {
      throw AppError.captureSessionSetup(
        reason: "Could not add video device input to the session"
      )
    }
    session.addInput(deviceInput)
    
    // 5
    let dataOutput = AVCaptureVideoDataOutput()
    if session.canAddOutput(dataOutput) {
      session.addOutput(dataOutput)
      dataOutput.alwaysDiscardsLateVideoFrames = true
      dataOutput.setSampleBufferDelegate(self, queue: videoDataOutputQueue)
    } else {
      throw AppError.captureSessionSetup(reason: "Could not add video data output to the session")
    }
    
    // 6
    session.commitConfiguration()
    cameraFeedSession = session
  }
  
  // 2
  private var cameraView: CameraPreview { view as! CameraPreview }
}
