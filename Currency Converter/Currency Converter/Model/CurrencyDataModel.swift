//
//  CurrencyDataModel.swift
//  Currency Converter
//
//  Created by mac on 28/01/2022.
//

import Foundation
import SwiftyJSON

struct CurrencyData: Codable {
	let success: Bool?
	let timestamp: Int?
	let base: String?
	let date: String?
	let rates: [String: JSON]?
	
	init(json: JSON) {
		success = json["success"].boolValue
		timestamp = json["timestamp"].intValue
		base = json["base"].stringValue
		date = json["date"].stringValue
		rates = json["rates"].dictionaryValue
	}
}
