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

class ViewController: UIViewController {
    
    let priceOfSingleTicket = 4500 // 식권 가격
    
    @IBOutlet weak var inputField: UITextField! //사용자 입력 값
    @IBOutlet weak var ticketCountLabel: UILabel!
    @IBOutlet weak var changeLabel: UILabel!
    
    // 총 결제 금액
    var totalAmount: Int = 0 {
        didSet {
            calculate(with: totalAmount)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeLabels()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        inputField.becomeFirstResponder()
    }
    
    // 초기화
    func initializeLabels() {
        ticketCountLabel.text = "🎟 식권"
        changeLabel.text = "🤑 거스름돈"
    }
    
    // 식권 갯수와 잔돈을 계산해주는 로직
    func calculate(with value: Int) {
        let numberOfTickets: Int = (value - 1) / priceOfSingleTicket + 1
        let change = (priceOfSingleTicket * numberOfTickets) - value
        
        ticketCountLabel.text = change == 0 ? "🎟 \(numberOfTickets)장 내세요" : "🎟 \(numberOfTickets)장 내고"
        changeLabel.text = change == 0 ? "👌 거스름돈 없어요" : "🤑 \(change)원 받으세요"
    }
}

extension ViewController: UITextFieldDelegate {
	func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		let oldText = textField.text!
		let stringRange = Range(range, in:oldText)!
		let newText = oldText.replacingCharacters(in: stringRange, with: string)
        
        if let newValue = Int(newText) {
            totalAmount = newValue
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

