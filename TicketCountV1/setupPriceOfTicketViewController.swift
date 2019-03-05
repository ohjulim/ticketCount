//
//  setupPriceOfTicketViewController.swift
//  TicketCountV1
//
//  Created by Lim Oh Ju on 04/03/2019.
//  Copyright © 2019 ohju. All rights reserved.
//
// [] 프로토콜 배운것 적용하여 프로토콜 세팅
// [] initializeLabels() 함수 완성
// [] 티켓 한장의 가격 역시 ViewController.swift 로 넘어가도록 설정

import UIKit

class setupPriceOfTicketViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()

	}
	
	var priceOfSingleTicket = 4500
	
	@IBAction func close() {
		dismiss(animated: true, completion: nil)
	}
	
	@IBOutlet weak var inputField: UITextField!
	
	func initializeLabels() { //delegate개념? protocol?! 다른 뷰컨트롤러에 있는 것과 통신하기
//		ticketCountLabel.text = "🎟 식권"
//		changeLabel.text = "🤑 거스름돈"
	}

}

extension setupPriceOfTicketViewController: UITextFieldDelegate {
	func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		let oldText = textField.text!
		let stringRange = Range(range, in:oldText)!
		let newText = oldText.replacingCharacters(in: stringRange, with: string)
		
		if let newValue = Int(newText) {
			priceOfSingleTicket = newValue
		} else {
			initializeLabels()
		}
		return true
	}
	
	func textFieldShouldClear(_ textField: UITextField) -> Bool {
		initializeLabels()
		return true
	}
}
