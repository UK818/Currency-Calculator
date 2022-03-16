//
//  ViewController.swift
//  Currency Converter
//
//  Created by mac on 16/01/2022.
//

import UIKit
import DropDown
import Charts
import SwiftyJSON

class ViewController: UIViewController {
	@IBOutlet weak var currencyConvertedFrom: UIView!
	@IBOutlet weak var currencyImg: UIImageView!
	@IBOutlet weak var currencyLabel: UILabel!
	@IBOutlet weak var currency1: UILabel!
	
	@IBOutlet weak var currencyConvertedTo: UIView!
	@IBOutlet weak var currency2Img: UIImageView!
	@IBOutlet weak var currency2Label: UILabel!
	@IBOutlet weak var currency2: UILabel!
	
	@IBOutlet weak var chart: LineChartView!
	
	let dropDown1 = DropDown()
	let dropDown2 = DropDown()
	let currencies = ["EUR", "CAD", "NGN", "USD"]
	let currImages = ["coloncurrencysign.circle.fill", "pencil.and.outline", "coloncurrencysign.circle.fill", "pencil.and.outline"]
	
	var currencyData: [CurrencyData]!
	var dates = [String]()
	var currenciesDict: [String: JSON] = [:]
	
	var url = "http://data.fixer.io/api/latest?access_key=98171b4e16f57b834202d79ea535c9de"
	
	override func viewDidLoad() {
		super.viewDidLoad()
		dropDown1Setup()
		dropDown2Setup()
		
		networkCall()
		
		customizeChart(dataPoints: days, values: prices.map{ Double($0) })
	}
	
	private func networkCall() {
		NetworkManager.shared.networkRequest(url: url) { response in
			self.jsonResponseHandler(response)
//			print("Response \(response)")
		} errorCompletion: { error in
			print("Error \(error)")
		}
	}
	
	func jsonResponseHandler(_ json: JSON) {
		let data = CurrencyData(json: json)
		print(currencyData ?? [])
		for curr in json["rates"] {
			currenciesDict[curr.0] = curr.1
		}
	}

	@IBAction func dropDownBtn(_ sender: Any) {
		dropDown1.show()
	}
	@IBAction func dropDownBtn2(_ sender: Any) {
		dropDown2.show()
	}
	@IBAction func ThirtyDaysBtn(_ sender: Any) {
//		chart.xAxis.axisMaximum = 30
	}
	@IBAction func ninetyDaysBtn(_ sender: Any) {
//		chart.xAxis.axisMaximum = 90
	}
	
	private func dropDown1Setup() {
		dropDown1.anchorView = currencyConvertedFrom
		dropDown1.dataSource = ["USD", "EUR"]
		dropDown1.selectionAction = { [unowned self] (index: Int, item: String) in
			currencyLabel.text = item
			currency1.text = item
			currencyImg.image = UIImage(systemName: currImages[index])
			
		}
		dropDown1.bottomOffset = CGPoint(x: 0, y:(dropDown1.anchorView?.plainView.bounds.height)!)
	}
	
	private func dropDown2Setup() {
		dropDown2.anchorView = currencyConvertedTo
		dropDown2.dataSource = currencies
		dropDown2.selectionAction = { [unowned self] (index: Int, item: String) in
			currency2Label.text = item
			currency2.text = item
			currency2Img.image = UIImage(systemName: currImages[index])
			
		}
		dropDown2.bottomOffset = CGPoint(x: 0, y:(dropDown2.anchorView?.plainView.bounds.height)!)
	}
	
	func customizeChart(dataPoints: [String], values: [Double]) {
		
		var dataEntries: [ChartDataEntry] = []
		
		for i in 0..<dataPoints.count {
			let dataEntry = ChartDataEntry(x: Double(i), y: Double(values[i]))
			dataEntries.append(dataEntry)
		}
		
		let lineChartDataSet = LineChartDataSet(entries: dataEntries, label: "")
		lineChartDataSet.mode = .cubicBezier
		lineChartDataSet.drawCirclesEnabled = false
		lineChartDataSet.drawHorizontalHighlightIndicatorEnabled = false
		lineChartDataSet.drawValuesEnabled = false
		lineChartDataSet.drawFilledEnabled = true
		
		let lineChartData = LineChartData(dataSet: lineChartDataSet)
		chart.data = lineChartData
		chart.doubleTapToZoomEnabled = false
		chart.xAxis.drawGridLinesEnabled = false
		chart.xAxis.drawAxisLineEnabled = false
		chart.xAxis.labelPosition = .bottom
		chart.xAxis.axisMaximum = 30
		
		chart.leftAxis.drawGridLinesEnabled = false
		chart.leftAxis.drawAxisLineEnabled = false
		chart.leftAxis.drawLabelsEnabled = false
		
		chart.rightAxis.drawGridLinesEnabled = false
		chart.rightAxis.drawAxisLineEnabled = false
		chart.rightAxis.drawLabelsEnabled = false
		
		chart.legend.enabled = false
	  }

}
