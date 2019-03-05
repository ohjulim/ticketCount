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
//
//	[v] 식권 몇장사용 버튼 만들기: 증,감 버튼
//	[v] 증감 버튼 눌렀을 때 작동하는지 print 함수로 확인
//	[] disable 작동 코딩
//		[] 인풋박스 입력됐을 때, 식권 값이 2 이상일 때 빼기버튼 활성화
//		[] 식권 값이 1이하일 때 빼기버튼 비활성화
//		[] 빼기버튼이 눌렸을 때 더하기버튼 활성화
//		[] 더하기버튼을 계속 눌러서 식권 값이 처음 나온 값이 됐을 때 더하기버튼 비활성화
//	[v] 증감버튼을 사용하기 전에 임의의 배열 안에 식권 장수 별 잔돈값을 넣어두고,
//	[v] 증감 버튼으로 배열의 값을 왔다갔다 보여주기
//  [v] 식권값 설정 페이지 스토리보드에 만들어 연결하기

import UIKit

class ViewController: UIViewController {
    
    let priceOfSingleTicket = 4500 // 식권 가격
	
		var cashes: [Int] = [] // 현금 계산을 위해 totalAmount를 기준으로 식권 한장씩 뺄때마다의 값들을 이 배열에 차례로 저장.
		var cash = 0
		var buttonCount = 0 // 식권빼기 버튼을 누른 횟수 == 식권더하기 버튼을 누를 수 있는 횟수.... 메타포가 어려워서 이해하기 어렵게됐다.
		var lastIndexOfArray = 0 // cashes 배열의 마지막 인덱스 번호
    
    @IBOutlet weak var inputField: UITextField! //사용자 입력 값
    @IBOutlet weak var ticketCountLabel: UILabel!
    @IBOutlet weak var changeLabel: UILabel!
		@IBAction func minusOneTicket(_ sender: Any) {
			print("minus button pressed")
			print("buttonCount: \(buttonCount)")
			minusButton(with: totalAmount)
		}
		@IBAction func plusOneTicket(_ sender: Any) {
			print("plus button pressed")
			print("buttonCount: \(buttonCount)")
			plusButton(with: totalAmount)
		}
	
    // 총 결제 금액
    var totalAmount: Int = 0 {
        didSet {
            calculate(with: totalAmount)
						makeArray(with: totalAmount)
						print("lastIndexOfArray is \(lastIndexOfArray)")
						print(cashes)
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
				buttonCount = 0
    }
    
    // 식권 갯수와 잔돈을 계산해주는 로직
    func calculate(with value: Int) {
        let numberOfTickets: Int = (value - 1) / priceOfSingleTicket + 1
        let change = (priceOfSingleTicket * numberOfTickets) - value
        
        ticketCountLabel.text = change == 0 ? "🎟 \(numberOfTickets)장 내세요" : "🎟 \(numberOfTickets)장 내고"
        changeLabel.text = change == 0 ? "👌 거스름돈 없어요" : "🤑 \(change)원 받으세요"
			
    }
	
		// 현금 계산을 위한 배열 만드는 로직
		func makeArray(with value: Int) {
				let numberOfTickets: Int = (value - 1) / priceOfSingleTicket + 1
				cashes = []
				for i in 0...numberOfTickets-1 {
						cash = value - (priceOfSingleTicket * numberOfTickets) + (priceOfSingleTicket * i)
						cashes.append(cash)
				}
				lastIndexOfArray = numberOfTickets - 1
		}
	
		func minusButton(with value: Int) {
				let numberOfTickets: Int = (value - 1) / priceOfSingleTicket + 1
				if buttonCount < lastIndexOfArray {
						buttonCount += 1
						ticketCountLabel.text = cashes[buttonCount] == 0 ? "🎟 \(numberOfTickets-buttonCount)장 내세요" : "🎟 \(numberOfTickets-buttonCount)장 내고"
						changeLabel.text = cashes[buttonCount] == 0 ? "👌 거스름돈 없어요" : "💵 \(cashes[buttonCount])원 더 내세요"
				} else if buttonCount == lastIndexOfArray {
						print("더이상 뺄 식권 수가 없어요. 한 장은 내셔야죠.")
				}
				print("버튼 눌린 횟수: \(buttonCount)")
				print(cashes[buttonCount])
		}
	
	func plusButton(with value: Int) {
				let numberOfTickets: Int = ((value - 1) / priceOfSingleTicket + 1)

				if buttonCount == 0 { // 버튼 비활성에 대해 설정을 아직 못해서 이렇게 하고 있는 것임.
					print("현금을 사용하지 않는 상태입니다.")
					
				} else if buttonCount > 0 {
					buttonCount -= 1
					print("식권을 한장 더 냅니다.")
					if buttonCount == 0 { // *다시* 식권으로만 계산하는 모드가 됐을 때. 다른말로, 더이상 식권을 낼 수 없는 상황
						ticketCountLabel.text = cashes[buttonCount] == 0 ? "🎟 \(numberOfTickets-buttonCount)장 내세요" : "🎟 \(numberOfTickets-buttonCount)장 내고"
						changeLabel.text = cashes[buttonCount] == 0 ? "👌 거스름돈 없어요" : "🤑 \(abs(cashes[buttonCount]))원 받으세요"
					} else {
						ticketCountLabel.text = cashes[buttonCount] == 0 ? "🎟 \(numberOfTickets-buttonCount)장 내세요" : "🎟 \(numberOfTickets-buttonCount)장 내고"
						changeLabel.text = cashes[buttonCount] == 0 ? "👌 거스름돈 없어요" : "💵 \(cashes[buttonCount])원 더 내세요"
					}
				}

				print("버튼 눌린 횟수: \(buttonCount)")
				print(cashes[buttonCount])
			
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

