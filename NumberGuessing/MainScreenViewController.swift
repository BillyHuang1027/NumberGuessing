//
//  MainScreenViewController.swift
//  NumberGuessing
//
//  Created by 黃昌齊 on 2021/3/24.
//

import UIKit

class MainScreenViewController: UIViewController {
    
    var score = 0
    var round = 1
    var targetValue = 0
    var currentValue = 0
    
    @IBOutlet weak var inputNumberTextField: UITextField!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startNewRound()
    }
    
    //按下 Hit Me 按鈕
    @IBAction func hitMeButton(_ sender: UIButton) {
        
        view.endEditing(true) //鍵盤自動收回
        
        //驗證是否有輸入數字
        if let currentValueText = inputNumberTextField.text,
           let currentValue = Int(currentValueText) {
            
            //大於 100 或小於 1
            if currentValue > 100 || currentValue < 1 {
                let title = "Warning!"
                let message =
                    "Invalid number.\nPlease enter again!"
                let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                
                let action = UIAlertAction(title: "OK", style: .default, handler: { action in self.startNewRound() })
                
                alert.addAction(action)
                present(alert, animated: true, completion: nil)
            }
            //輸入 1~100 範圍內數字
            else {
                let difference = abs(targetValue - currentValue)
                let points = 100 - difference
                
                round += 1
                score += points
                
                let title: String
                
                if difference == 0 {
                    title = "Perfect!"
                }
                else if difference < 5 {
                    title = "You almost have it!"
                }
                else if difference < 10 {
                    title = "Nice!"
                }
                else {
                    title = "Not even close~~"
                }
                
                let message =
                    "The target value is \(targetValue).\nYou scored \(points) points!"
                
                let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                
                let action = UIAlertAction(title: "OK", style: .default, handler: { action in self.startNewRound() })
                
                alert.addAction(action)
                present(alert, animated: true, completion: nil)
            }
        }
        inputNumberTextField.text = "" //每一回合結束後自動清除數字
    }
    
    //重新開始按鈕
    @IBAction func RestartButton(_ sender: UIButton) {
        round = 1
        score = 0
        startNewRound()
    }
    
    //開始新一回合
    func startNewRound() {
        targetValue = Int.random(in: 1...100)
        updateLabel()
    }
    
    //更新分數與回合數的 Label
    func updateLabel() {
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }

}
