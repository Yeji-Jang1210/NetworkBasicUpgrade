//
//  Model.swift
//  NetworkBasicUpgrade
//
//  Created by 장예지 on 6/5/24.
//

import Foundation

struct MovieData: Codable {
    let boxOfficeResult: BoxOfficeResult
}
struct BoxOfficeResult:Codable {
    let dailyBoxOfficeList: [BoxOffice]
}

struct BoxOffice: Codable {
    let rank: String
    let movieNm: String
    let openDt: String
}
