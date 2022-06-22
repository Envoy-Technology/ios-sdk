import Foundation

public struct CreateLinkRequest: Codable {
    let userId: String
    let contentConfig: ContentConfig
    let linkPreview: LinkPreview?
    let autoplay: Bool?
    let extra: [String : String]?

    enum CodingKeys: String, CodingKey {
        case userId, contentConfig, autoplay, extra
        case linkPreview = "linkPreviewConf"
    }

    public init(
        userId: String,
        contentConfig: ContentConfig,
        linkPreview: LinkPreview? = nil,
        autoplay: Bool? = nil,
        extra: [String : String]? = nil
    ) {
        self.userId = userId
        self.contentConfig = contentConfig
        self.linkPreview = linkPreview
        self.autoplay = autoplay
        self.extra = extra
    }
}

public struct ContentConfig: Codable {
    let contentType: String
    let contentName: String
    let contentDescription: String
    let contentId: String
    let common: Common

    public init(
        contentType: String,
        contentName: String,
        contentDescription: String,
        contentId: String,
        common: Common
    ) {
        self.contentType = contentType
        self.contentName = contentName
        self.contentDescription = contentDescription
        self.contentId = contentId
        self.common = common
    }

}

public struct Common: Codable {
    let media: Media

    public init(media: Media) {
        self.media = media
    }
}

public struct Media: Codable {
    let source: String
    let poster: String

    public init(
        source: String,
        poster: String
    ) {
        self.source = source
        self.poster = poster
    }
}

public struct LinkPreview: Codable {
    let title: String
    let linkPreviewDescription: String
    let image: String

    enum CodingKeys: String, CodingKey {
        case title
        case linkPreviewDescription = "description"
        case image
    }

    public init(
        title: String,
        linkPreviewDescription: String,
        image: String
    ) {
        self.title = title
        self.linkPreviewDescription = linkPreviewDescription
        self.image = image
    }
}
