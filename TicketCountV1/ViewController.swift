//
//  ViewController.swift
//  TicketCountV1
//
//  Created by Lim Oh Ju on 06/02/2019.
//  Copyright © 2019 ohju. All rights reserved.
//
//  V1: 식권으로만 계산가능.
//  V2: 계산하기 버튼을 누르지 않아도 실시간으로 계산 결과 확인.
//  V3: 식권을 줄여 현금을 더 내는 시나리오 대응.
//  V4: 사용자가 식권값을 설정하여 다른 회사에서도 사용 가능.
//  V5: 디자인 적용.

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
	
	let ticketPrice = 4500 //식권 가격
	@IBOutlet weak var inputField: UITextField! //사용자 입력 값
	@IBOutlet weak var ticketCountLabel: UILabel!
	@IBOutlet weak var changeLabel: UILabel!
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		inputField.becomeFirstResponder()
		initializeLabels()
	}
	
	func initializeLabels() {
		ticketCountLabel.text = "🎟 식권"
		changeLabel.text = "🤑 거스름돈"
	}
	
	func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		
		let oldText = textField.text!
		let stringRange = Range(range, in:oldText)!
		let newText = oldText.replacingCharacters(in: stringRange,
																							with: string)
		let ticketCount:Int
		if let orderValue = Int(newText) {
			if orderValue % ticketPrice == 0 { // 나눗셈이 딱 떨어지면(주문가격이 식권가격의 배수일 경우)
				ticketCount = orderValue / ticketPrice // 나눗셈의 몫이 곧 필요한 식권 수 이고,
			} else { // 나눗셈이 딱 떨어지지않으면 나눗셈의 몫에 1을 더한 값이 필요한 최소 식권 수.
				ticketCount = orderValue / ticketPrice + 1
			}
			let change = (ticketPrice * ticketCount) - orderValue
			
			if orderValue == ticketPrice {
				ticketCountLabel.text = "🎟 \(ticketCount)장 내세요"
				changeLabel.text = "👌 거스름돈 없어요"
			} else if orderValue % ticketPrice == 0 {
				ticketCountLabel.text = "🎟 \(ticketCount)장 내세요"
				changeLabel.text = "👌 거스름돈 없어요"
			} else {
				ticketCountLabel.text = "🎟 \(ticketCount)장 내고"
				changeLabel.text = "🤑 \(change)원 받으세요"
			}
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

