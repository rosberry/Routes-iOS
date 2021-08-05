//
//  Copyright © 2020 Rosberry. All rights reserved.
//

import UIKit

public final class ShareParameters {

    public var activityItems: [Any]
    public var applicationActivities: [UIActivity]?
    public var excludedActivityTypes: [UIActivity.ActivityType]?
    public var sourceView: UIView?
    public var sourceRect: CGRect = .zero
    public var barButtonItem: UIBarButtonItem?

    public init(activityItems: [Any]) {
        self.activityItems = activityItems
    }
}

public protocol ShareRoute {

    func show(with parameters: ShareParameters, completion: ((Bool) -> Void)?)
}

public extension ShareRoute where Self: Router {

    func show(with parameters: ShareParameters, completion: ((Bool) -> Void)?) {
        let activityViewController = UIActivityViewController(activityItems: parameters.activityItems,
                                                              applicationActivities: parameters.applicationActivities)
        activityViewController.popoverPresentationController?.sourceView = parameters.sourceView
        activityViewController.popoverPresentationController?.sourceRect = parameters.sourceRect
        activityViewController.popoverPresentationController?.barButtonItem = parameters.barButtonItem
        activityViewController.excludedActivityTypes = parameters.excludedActivityTypes
        activityViewController.completionWithItemsHandler = { _, completed, _, _ in
            completion?(completed)
        }
        topViewController?.present(activityViewController, animated: true, completion: nil)
    }
}
