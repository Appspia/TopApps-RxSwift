//
//  API+TopApps.swift
//  TopApps
//
//  Created by APPSPIA on 2022/06/14.
//

import Foundation
import Alamofire
import RxSwift

extension Response {
    struct TopApps: Codable {
        let feed: Feed
    }

    struct Feed: Codable {
        let author: Author?
        var entry: [Entry]
        let updated: Rights?
        let rights: Rights?
        let title: Rights?
        let icon: Icon?
        let link: [FeedLink]?
        let id: Feedid?
    }

    struct Author: Codable {
        let name: Rights?
        let uri: URI?
    }

    struct Rights: Codable {
        let label: String?
    }

    struct URI: Codable {
        let label: String?
    }

    struct Entry: Codable {
        let imName: Rights?
        let imImage: [IMImage]?
        let summary: Rights?
        let imPrice: IMPrice?
        let imContentType: IMContentType?
        let rights: Rights?
        let title: Rights?
        let link: [EntryLink]?
        var id: Entryid?
        let imArtist: IMArtist?
        let category: Category?
        let imReleaseDate: IMReleaseDate?
        
        private enum CodingKeys: String, CodingKey {
            case imName = "im:name"
            case imImage = "im:image"
            case summary
            case imPrice = "im:price"
            case imContentType = "im:contentType"
            case rights
            case title
            case link
            case id
            case imArtist = "im:artist"
            case category
            case imReleaseDate = "im:releaseDate"
        }
    }

    struct Category: Codable {
        let attributes: CategoryAttributes?
    }

    struct CategoryAttributes: Codable {
        let imid: String?
        let term: String?
        let scheme: String?
        let label: String?
    }

    struct Entryid: Codable {
        var label: String?
        let attributes: IDAttributes?
    }

    struct IDAttributes: Codable {
        let imid: String?
    }

    struct IMArtist: Codable {
        let label: String?
        let attributes: IMArtistAttributes?
    }

    struct IMArtistAttributes: Codable {
        let href: String?
    }

    struct IMContentType: Codable {
        let attributes: IMContentTypeAttributes?
    }

    struct IMContentTypeAttributes: Codable {
        let term: String?
        let label: String?
    }

    struct IMImage: Codable {
        let label: String?
        let attributes: IMImageAttributes?
    }

    struct IMImageAttributes: Codable {
        let height: String?
    }

    struct IMPrice: Codable {
        let label: String?
        let attributes: IMPriceAttributes?
    }

    struct IMPriceAttributes: Codable {
        let amount: String?
        let currency: String?
    }

    struct IMReleaseDate: Codable {
        let label: String?
        let attributes: Rights?
    }

    struct EntryLink: Codable {
        let attributes: PurpleAttributes?
    }

    struct PurpleAttributes: Codable {
        let rel: String?
        let type: String?
        let href: String?
    }

    struct Icon: Codable {
        let label: String?
    }

    struct Feedid: Codable {
        let label: String?
    }

    struct FeedLink: Codable {
        var attributes: FluffyAttributes?
    }
    
    struct LinkElement: Codable {
        let attributes: FluffyAttributes?
    }

    struct FluffyAttributes: Codable {
        let rel: String?
        let type: String?
        let href: String?
    }

}

extension API {
    func topApps() -> Single<Response.TopApps> {
        let urlString = baseUrl + "/KR/rss/topfreeapplications/limit=100/json"
        let request = AF.request(urlString, method: .get, parameters: nil, headers: commonHeader)
        return rxHttpRequest(request: request).debug()
    }
}


