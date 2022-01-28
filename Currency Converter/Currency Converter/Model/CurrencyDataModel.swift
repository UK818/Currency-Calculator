//
//  CurrencyDataModel.swift
//  Currency Converter
//
//  Created by mac on 28/01/2022.
//

import Foundation

struct Empty: Codable {
	let success: Bool
	let timestamp: Int
	let base: String
	let date: String
	let rates: [String: Double]
}
