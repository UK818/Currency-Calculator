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

class NetworkManager: UIViewController {
	
	var successResponse: SuccessBlock!
	var errorResponse: ErrorBlock!
	var url = "http://data.fixer.io/api/latest?access_key=98171b4e16f57b834202d79ea535c9de"
	
	override func viewDidLoad() {
		
	}
	
	func networkRequest(success: @escaping SuccessBlock, error: @escaping ErrorBlock) {
		AF.request(url, method: .get).responseJSON { response in
			print(response)
		}
	}
	
}
