//
//  Copyright © 2020 Rosberry. All rights reserved.
//

import Foundation
import MobileCoreServices
import UIKit

public class PickerOptions {
    public var sourceType: UIImagePickerController.SourceType = .photoLibrary
    public var mediaTypes: [String] {
        return UIImagePickerController.availableMediaTypes(for: sourceType) ?? []
    }

    public var allowsEditing: Bool = false
    public var showsCameraControls: Bool = true

    public var cameraDevice: UIImagePickerController.CameraDevice = .rear
    public var cameraFlashMode: UIImagePickerController.CameraFlashMode = .auto

    public var cameraOverlayView: UIView? = nil
    public var cameraViewTransform: CGAffineTransform = .identity

    public init() {}
}

public class ImagePickerOptions: PickerOptions {
    override public var mediaTypes: [String] {
        return [kUTTypeImage as String]
    }

    public var imageExportPreset: UIImagePickerController.ImageURLExportPreset = .compatible
}

public class VideoPickerOptions: PickerOptions {
    override public var mediaTypes: [String] {
        return [kUTTypeMovie as String]
    }

    public var videoMaximumDuration: TimeInterval = 600.0
    public var videoQuality: UIImagePickerController.QualityType = .typeHigh
}
