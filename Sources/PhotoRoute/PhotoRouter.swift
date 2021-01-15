//
//  Copyright © 2020 Rosberry. All rights reserved.
//

import UIKit
import AVFoundation

private class PickerDelegate: NSObject,
                              UIImagePickerControllerDelegate,
                              UINavigationControllerDelegate,
                              UIAdaptivePresentationControllerDelegate {
    private var retainedSelf: PickerDelegate?

    var imageCompletion: ((UIImage?) -> Void)?
    var assetCompletion: ((AVAsset?) -> Void)?

    override init() {
        super.init()
        retainSelf()
    }

    private func retainSelf() {
        retainedSelf = self
    }

    private func releaseSelf() {
        retainedSelf = nil
    }

    // MARK: - UIImagePickerControllerDelegate

    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        picker.dismiss(animated: true)

        if let image = (info[.editedImage] ?? info[.originalImage]) as? UIImage {
            imageCompletion?(image)
        }
        else if let url = info[.mediaURL] as? URL {
            let asset = AVAsset(url: url)
            assetCompletion?(asset)
        }
        else {
            imageCompletion?(nil)
            assetCompletion?(nil)
        }

        releaseSelf()
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)

        imageCompletion?(nil)
        assetCompletion?(nil)

        releaseSelf()
    }

    // MARK: - UIAdaptivePresentationControllerDelegate

    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        imageCompletion?(nil)
        assetCompletion?(nil)
        releaseSelf()
    }
}

public protocol PhotoRoute {
    @discardableResult
    func showImagePicker(with options: ImagePickerOptions, completion: @escaping (UIImage?) -> Void) -> UIImagePickerController

    @discardableResult
    func showVideoPicker(with options: VideoPickerOptions, completion: @escaping (AVAsset?) -> Void) -> UIImagePickerController
}

public extension PhotoRoute where Self: Router {
    @discardableResult
    func showImagePicker(with options: ImagePickerOptions = .init(), completion: @escaping (UIImage?) -> Void) -> UIImagePickerController {
        let imagePickerController = makeImagePicker(with: options)
        imagePickerController.imageExportPreset = options.imageExportPreset

        show(imagePickerController) { (delegate: PickerDelegate) in
            delegate.imageCompletion = completion
        }
        return imagePickerController
    }

    @discardableResult
    func showVideoPicker(with options: VideoPickerOptions = .init(), completion: @escaping (AVAsset?) -> Void) -> UIImagePickerController {
        let imagePickerController = makeImagePicker(with: options)
        imagePickerController.videoMaximumDuration = options.videoMaximumDuration
        imagePickerController.videoQuality = options.videoQuality

        show(imagePickerController) { (delegate: PickerDelegate) in
            delegate.assetCompletion = completion
        }
        return imagePickerController
    }

    // MARK: - Private

    private func makeImagePicker(with options: PickerOptions) -> UIImagePickerController {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = options.sourceType
        imagePickerController.mediaTypes = options.mediaTypes
        imagePickerController.allowsEditing = options.allowsEditing

        if options.sourceType == .camera {
            imagePickerController.showsCameraControls = options.showsCameraControls
            imagePickerController.cameraDevice = options.cameraDevice
            imagePickerController.cameraFlashMode = options.cameraFlashMode
            imagePickerController.cameraOverlayView = options.cameraOverlayView
            imagePickerController.cameraViewTransform = options.cameraViewTransform
        }

        return imagePickerController
    }

    private func show(_ imagePickerController: UIImagePickerController, configurationHandler: (PickerDelegate) -> Void) {
        let delegate = PickerDelegate()
        configurationHandler(delegate)

        imagePickerController.delegate = delegate
        imagePickerController.presentationController?.delegate = delegate
        viewController?.present(imagePickerController, animated: true)
    }
}
