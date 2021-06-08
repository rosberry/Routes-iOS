//
//  Copyright © 2020 Rosberry. All rights reserved.
//

import Foundation

public class MailParameters {

    public var subject: String = ""
    public var body: String = ""
    public var toRecipients: [String] = []

    public var mailURL: URL? {
        var components = URLComponents(string: "mailto:")
        var queryItems = toRecipients.map { toRecipient in
            URLQueryItem(name: "to", value: toRecipient)
        }

        let subjectItem = URLQueryItem(name: "subject", value: subject)
        queryItems.append(subjectItem)

        let bodyItem = URLQueryItem(name: "body", value: body)
        queryItems.append(bodyItem)

        components?.queryItems = queryItems
        return components?.url
    }

    public init() {}
}

public final class RichMailParameters: MailParameters {

    public var ccRecipients: [String] = []
    public var bccRecipients: [String] = []
    public var isHTML: Bool = false
    public var attachments: [Attachment] = []
    public var preferredSendingEmailAddress: String = ""
}

public final class Attachment {

    public var data: Data
    public var mimeType: String
    public var filename: String

    public init(data: Data, mimeType: String, filename: String) {
        self.data = data
        self.mimeType = mimeType
        self.filename = filename
    }
}
