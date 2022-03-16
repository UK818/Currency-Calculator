//
//  Network.swift
//  Currency Converter
//
//  Created by mac on 28/01/2022.
//

import Foundation
import Alamofire
import SwiftyJSON

typealias SuccessBlock = (JSON) -> Void
typealias ErrorBlock = (Error) -> Void

class NetworkManager {
	
	static var shared = NetworkManager()
	
	var successResponse: SuccessBlock!
	var errorResponse: ErrorBlock!
	
	init() {
		
	}
	
	func networkRequest(url: String, successCompletion: @escaping SuccessBlock, errorCompletion: @escaping ErrorBlock) {
		AF.request(url, method: .get).responseJSON { response in
			if let error = response.error {
				errorCompletion(error)
			} else {
				if let responseData = response.data {
					let json = JSON(responseData)
					successCompletion(json)
				}
			}
		}
	}
	
}
