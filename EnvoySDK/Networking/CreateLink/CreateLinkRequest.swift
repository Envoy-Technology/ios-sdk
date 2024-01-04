import Foundation

public struct CreateLinkRequest: Codable {
    let autoplay: Bool?
    let contentSetting: ContentSetting
    let lifespanAfterClick: LifespanAfterClick?
    let openQuota: Int?
    let extra: String?
    let title: String?
    let sharerId: String
    let isSandbox: Bool?
    let labels: [Label]?

    public init(autoplay: Bool?, contentSetting: ContentSetting, lifespanAfterClick: LifespanAfterClick?, openQuota: Int?, extra: String?, title: String?, sharerId: String, isSandbox: Bool?, labels: [Label]?) {
        self.autoplay = autoplay
        self.contentSetting = contentSetting
        self.lifespanAfterClick = lifespanAfterClick
        self.openQuota = openQuota
        self.extra = extra
        self.title = title
        self.sharerId = sharerId
        self.isSandbox = isSandbox
        self.labels = labels
    }
    
    // Define the Common structure
    public struct Common: Codable {
        let source: String
        let sourceIsRedirect: Bool?
        let poster: String?

        public init(source: String, sourceIsRedirect: Bool?, poster: String?) {
            self.source = source
            self.sourceIsRedirect = sourceIsRedirect
            self.poster = poster
        }
    }

    // Define the ContentProtection structure
    public struct ContentProtection: Codable {
        let media: Common

        public init(media: Common) {
            self.media = media
        }
    }

    // Define the ContentSetting structure
    public struct ContentSetting: Codable {
        let contentType: String
        let contentName: String
        let contentDescription: String
        let common: Common
        let timeLimit: Int?
        let timeStart: Int?
        let availableFrom: String?
        let availableTo: String?
        let videoOrientation: Int?
        let previewTitle: String?
        let previewDescription: String?
        let previewImage: String?
        let isSandbox: Bool?
        let mandatoryEmail: Bool?
        let modalTitle: String?
        let buttonText: String?
        let contentProtection: ContentProtection?

        public init(contentType: String, contentName: String, contentDescription: String, common: Common, timeLimit: Int?, timeStart: Int?, availableFrom: String?, availableTo: String?, videoOrientation: Int?, previewTitle: String?, previewDescription: String?, previewImage: String?, isSandbox: Bool?, mandatoryEmail: Bool?, modalTitle: String?, buttonText: String?, contentProtection: ContentProtection?) {
            self.contentType = contentType
            self.contentName = contentName
            self.contentDescription = contentDescription
            self.common = common
            self.timeLimit = timeLimit
            self.timeStart = timeStart
            self.availableFrom = availableFrom
            self.availableTo = availableTo
            self.videoOrientation = videoOrientation
            self.previewTitle = previewTitle
            self.previewDescription = previewDescription
            self.previewImage = previewImage
            self.isSandbox = isSandbox
            self.mandatoryEmail = mandatoryEmail
            self.modalTitle = modalTitle
            self.buttonText = buttonText
            self.contentProtection = contentProtection
        }
    }

    // Define the LifespanAfterClick structure
    public struct LifespanAfterClick: Codable {
        let value: Int?
        let unit: String

        public init(value: Int?, unit: String) {
            self.value = value
            self.unit = unit
        }
    }

    // Define the Label structure
    public struct Label: Codable {
        let id: Int?
        let text: String
        let color: String

        public init(id: Int?, text: String, color: String) {
            self.id = id
            self.text = text
            self.color = color
        }
    }

}

