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

import UIKit
import Vision
import AVFoundation
import SafariServices

class ViewController: UIViewController {
  // MARK: - Private Variables
  var captureSession = AVCaptureSession()

  // TODO: Make VNDetectBarcodesRequest variable

  // MARK: - Override Functions
  override func viewDidLoad() {
    super.viewDidLoad()
    checkPermissions()
    setupCameraLiveView()
  }
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    // TODO: Stop Session
  }
}


extension ViewController {
  // MARK: - Camera
  private func checkPermissions() {
    switch AVCaptureDevice.authorizationStatus(for: .video) {
      // 1
    case .notDetermined:
      AVCaptureDevice.requestAccess(for: .video) { [self] granted in
        if !granted {
          showPermissionsAlert()
        }
      }
      
      // 2
    case .denied, .restricted:
      showPermissionsAlert()
      
      // 3
    default:
      return
    }
  }

  private func setupCameraLiveView() {
    // TODO: Setup captureSession
    
    captureSession.sessionPreset = .hd1280x720

    // TODO: Add input
    
    // 1
    let videoDevice = AVCaptureDevice.default(
      .builtInWideAngleCamera,
      for: .video,
      position: .back
    )

    // TODO: Add output

    configurePreviewLayer()

    // TODO: Run session
  }

  // MARK: - Vision
  func processClassification(_ request: VNRequest) {
    // TODO: Main logic
  }

  // MARK: - Handler
  func observationHandler(payload: String?) {
    // TODO: Open it in Safari
  }
}


// MARK: - AVCaptureDelegation
extension ViewController: AVCaptureVideoDataOutputSampleBufferDelegate {
  func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
    // TODO: Live Vision
  }
}


// MARK: - Helper
extension ViewController {
  private func configurePreviewLayer() {
    let cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
    cameraPreviewLayer.videoGravity = .resizeAspectFill
    cameraPreviewLayer.connection?.videoOrientation = .portrait
    cameraPreviewLayer.frame = view.frame
    view.layer.insertSublayer(cameraPreviewLayer, at: 0)
  }

  private func showAlert(withTitle title: String, message: String) {
    DispatchQueue.main.async {
      let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
      alertController.addAction(UIAlertAction(title: "OK", style: .default))
      self.present(alertController, animated: true)
    }
  }

  private func showPermissionsAlert() {
    showAlert(
      withTitle: "Camera Permissions",
      message: "Please open Settings and grant permission for this app to use your camera.")
  }
}


// MARK: - SafariViewControllerDelegate
extension ViewController: SFSafariViewControllerDelegate {
  func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
    captureSession.startRunning()
  }
}
