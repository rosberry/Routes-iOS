//
//  Copyright © 2020 Rosberry. All rights reserved.
//

import UIKit
import SafariServices

public protocol URLRoute {

    func open(_ url: URL)
    func makeSafari(with url: URL,
                    entersReaderIfAvailable: Bool,
                    dismissButtonStyle: SFSafariViewController.DismissButtonStyle) -> SFSafariViewController
}

public extension URLRoute where Self: Router {

    func open(_ url: URL) {
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }

    func makeSafari(with url: URL,
                    entersReaderIfAvailable: Bool,
                    dismissButtonStyle: SFSafariViewController.DismissButtonStyle) -> SFSafariViewController {
        let configuration = SFSafariViewController.Configuration()
        configuration.entersReaderIfAvailable = entersReaderIfAvailable
        let controller = SFSafariViewController(url: url, configuration: configuration)
        controller.dismissButtonStyle = dismissButtonStyle
        return controller
    }
}
