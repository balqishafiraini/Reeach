//
//  InflationNetworkModel.swift
//  Reeach
//
//  Created by James Christian Wira on 17/10/22.
//

import Foundation

class InflationNetworkModel: Decodable {
    var inflationData: InflationDetail
    
    required init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
                
        inflationData = try container.decodeIfPresent(InflationDetail.self)!
    }
}

class InflationDetail: Decodable {
    var indicator: InflationIndicator
    var country: Country
    var countryiso3code: String
    var date: String
    var value: Double
    var unit: String
    var obs_status: String
    var decimal: Int
}

class InflationIndicator: Decodable{
    var id: String
    var value: String
}

class Country: Decodable {
    var id: String
    var value: String
}
