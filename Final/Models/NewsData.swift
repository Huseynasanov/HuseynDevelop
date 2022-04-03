//
//  NewsData.swift
//  Final
//
//  Created by Huseyn Hasanov on 28.03.22.
//

import Foundation
struct NewsData : Codable {
    let articles: [articles]?
}
struct articles: Codable{
    var topic,title,media,published_date,author,excerpt,summary,link,_id,twitter_account : String?
}
