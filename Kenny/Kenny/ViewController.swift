//
//  ViewController.swift
//  Kenny
//
//  Created by Mobifun Bilişim on 13.12.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highLabel: UILabel!
    @IBOutlet weak var heroImage: UIImageView!
    
    
    var timer = Timer()
    var heroTimer = Timer()
    var count = 10
    var count2 = 10
    var scoreCount = 0
    var highScore = UserDefaults.standard.integer(forKey: "highScore")
   
    override func viewDidLoad() {
        super.viewDidLoad()
        timeLabel.text = "10"
        highLabel.text = "High Score : \(highScore)"
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerFunc), userInfo: nil, repeats: true)
        
        heroImage.isUserInteractionEnabled = true
        heroTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(heroNew), userInfo: nil, repeats: true)
        let gesture = UITapGestureRecognizer(target: self, action: #selector(imageClick))
        heroImage.addGestureRecognizer(gesture)
    }
    
    @objc func timerFunc(){
        count -= 1
        timeLabel.text = "\(count)"
        
        if count <= 0 {
            timeLabel.text = "0"
            timer.invalidate()
            
            if scoreCount > highScore {
                highScore = scoreCount
                UserDefaults.standard.set(highScore, forKey: "highScore")
                updateHighScore()
            }
            
            
            let alert = UIAlertController(title: "Time's over", message: "Do you play again", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "Yes", style: UIAlertAction.Style.default){ (action) in self.restartGame()}
            let noButton = UIAlertAction(title: "No", style: UIAlertAction.Style.default)
            alert.addAction(noButton)
            alert.addAction(okButton)
            self.present(alert, animated: true)
        }
        
    }
    @objc func heroNew(){
        
        let screenWitdh = view.bounds.width
        let screenHeight = view.bounds.width
        let randomX = CGFloat.random(in: 0...(screenWitdh - heroImage.bounds.width))
        let randomY = CGFloat.random(in: 200...(screenHeight - heroImage.bounds.width))
        
        heroImage.frame.origin = CGPoint(x: randomX, y: randomY)
        count2 -= 1
        if count == 0 {
            heroTimer.invalidate()
        }
        
    }
    @objc func imageClick(){
        
        scoreCount += 1
        scoreLabel.text = "Score : \(scoreCount)"
        
            
    }
    
    func restartGame(){
        count = 10
        count2 = 10
        scoreCount = 0
        timeLabel.text = "10"
        heroTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(heroNew), userInfo: nil, repeats: true)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerFunc), userInfo: nil, repeats: true)
        timerFunc()
        heroNew()
        imageClick()
        scoreLabel.text = "Score: 0"
    }
    
    func updateHighScore(){
        highLabel.text = "High Score: \(highScore)"
    }

}

