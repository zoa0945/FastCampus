//
//  ViewController.swift
//  Calculator
//
//  Created by Mac on 2021/12/04.
//

/*
 UIStackView
 - 열 또는 행에 뷰들의 묶음을 배치할 수 있는 간소화된 인터페이스
 - 상황에 따라 복잡한 UI를 UIStackView를 사용하여 구성하면 오토레이웃을 사용하지 않아도 간단하게 UI를 구성할 수 있음
 - 속성
    * Axis : 스택뷰의 방향을 설정 (vertical, horizental)
    * Distribution : 스택뷰 안에 들어가는 뷰들의 사이즈를 다양하게 분배
    * Alignment : 스택뷰의 서브뷰들의 정렬 방식
    * Spacing : 값에 따라 스택뷰 안에 들어가있는 뷰들의 간격 설정
 
 IBInspectable
 - CustomView 속성을 storyboard에서 바로 변경 가능
 IBDesignable
 - 변경된 속성이 실시간으로 적용되는 것을 확인 가능
 */

import UIKit

enum Operation {
    case Add
    case Subtract
    case Multiply
    case Divide
    case Unknown
}

class ViewController: UIViewController {

    @IBOutlet weak var numberOutputLabel: UILabel!
    
    // 계산버튼을 누를때마다 numberOutputLabel에 표시되는 문자
    var displayNumber = ""
    // 이전 계산값을 저장 (첫번째 피연산자)
    var firstOperand = ""
    // 새롭게 입력된 값을 저장 (두번째 피연산자)
    var secondOperand = ""
    // 계산의 결과값을 저장
    var result = ""
    // 현재 계산중인 연산자
    var currentOperation: Operation = .Unknown
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func tapNumberButton(_ sender: UIButton) {
        guard let numberValue = sender.title(for: .normal) else { return }
        if self.displayNumber.count < 9 {
            self.displayNumber += numberValue
            self.numberOutputLabel.text = self.displayNumber
        }
    }
    
    @IBAction func tapClearButton(_ sender: UIButton) {
        self.displayNumber = ""
        self.firstOperand = ""
        self.secondOperand = ""
        self.result = ""
        self.currentOperation = .Unknown
        self.numberOutputLabel.text = "0"
    }
    
    @IBAction func tapDotButton(_ sender: UIButton) {
        if self.displayNumber.count < 8, !self.displayNumber.contains(".") {
            self.displayNumber += self.displayNumber.isEmpty ? "0." : "."
            self.numberOutputLabel.text = self.displayNumber
        }
    }
    
    @IBAction func tapDivideButton(_ sender: UIButton) {
        self.operation(.Divide)
    }
    
    @IBAction func tapMultiplyButton(_ sender: UIButton) {
        self.operation(.Multiply)
    }
    
    @IBAction func tapSubtractButton(_ sender: UIButton) {
        self.operation(.Subtract)
    }
    
    @IBAction func tapAddButton(_ sender: UIButton) {
        self.operation(.Add)
    }
    
    @IBAction func tapEqualButton(_ sender: UIButton) {
        self.operation(self.currentOperation)
    }
    
    func operation(_ operation: Operation) {
        if self.currentOperation !=	 .Unknown {
            if !self.displayNumber.isEmpty {
                self.secondOperand = self.displayNumber
                self.displayNumber = ""
                
                guard let firstOperand = Double(self.firstOperand) else { return }
                guard let secondOperand = Double(self.secondOperand) else { return }
                
                switch self.currentOperation {
                case .Add:
                    self.result = "\(firstOperand + secondOperand)"
                    
                case .Subtract:
                    self.result = "\(firstOperand - secondOperand)"
                    
                case .Divide:
                    self.result = "\(firstOperand / secondOperand)"
                    
                case .Multiply:
                    self.result = "\(firstOperand * secondOperand)"
                    
                default:
                    break
                }
                
                if let result = Double(self.result), result.truncatingRemainder(dividingBy: 1) == 0 {
                    self.result = "\(Int(result))"
                }
                
                self.firstOperand = self.result
                self.numberOutputLabel.text = self.result
            }
            
            self.currentOperation = operation
        } else {
            self.firstOperand = self.displayNumber
            self.currentOperation = operation
            self.displayNumber = ""
        }
    }
}

