//
//  Copyright © 2020 Rosberry. All rights reserved.
//

import UIKit
import MessageUI

public protocol MailRoute {

    func canSendMail() -> Bool
    func show(with parameters: RichMailParameters) -> MFMailComposeViewController?
    func showMailApp(with parameters: MailParameters)
}

public extension MailRoute where Self: Router {

    func canSendMail() -> Bool {
        MFMailComposeViewController.canSendMail()
    }

    func show(with parameters: RichMailParameters) -> MFMailComposeViewController? {
        guard canSendMail() else {
            return nil
        }
        let controller = MFMailComposeViewController()

        controller.setSubject(parameters.subject)
        controller.setToRecipients(parameters.toRecipients)
        controller.setCcRecipients(parameters.ccRecipients)
        controller.setBccRecipients(parameters.bccRecipients)
        controller.setMessageBody(parameters.body, isHTML: parameters.isHTML)
        for attachment in parameters.attachments {
            controller.addAttachmentData(attachment.data, mimeType: attachment.mimeType, fileName: attachment.filename)
        }
        controller.setPreferredSendingEmailAddress(parameters.preferredSendingEmailAddress)

        controller.present(controller, animated: true, completion: nil)
        return controller
    }

    func showMailApp(with parameters: MailParameters) {
        guard let url = parameters.mailURL else {
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
