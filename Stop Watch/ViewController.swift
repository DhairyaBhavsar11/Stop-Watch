//
//  ViewController.swift
//  Stop Watch
//
//  Created by dhairya bhavsar on 2022-05-13.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var minuteLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var startButton: UIButton!
    
    var hours = 0
    var minutes = 0
    var seconds = 0
    
    var lappedTimes:[String] = []
    
    var timer = Timer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func resetTimer(){
        hours = 0
        minutes = 0
        seconds = 0
        lappedTimes = []
        timer.invalidate()
        secondLabel.text = "00"
        minuteLabel.text = "00"
        hourLabel.text = "00"
        startButton.isHidden = false
        tableView.reloadData()
        
    }

    @IBAction func start(_ sender: UIButton) {
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(count), userInfo: nil, repeats: true)
        startButton.isHidden = true
    }
    @objc fileprivate func count() {
        seconds += 1
        if seconds == 60 {
            minutes += 1
            seconds = 0
        }
        
        if minutes == 60 {
            minutes = 0
            seconds = 0
            hours += 1
        }
        
        if hours == 24 {
            resetTimer()
        }
        secondLabel.text = "\(seconds)"
        minuteLabel.text = minutes == 0 ? "00" : "\(minutes)"
        hourLabel.text = hours == 0 ? "00" : "\(hours)"
        
    }
    
    
    @IBAction func lap(_ sender: UIButton) {
        let currentTime = "\(hours):\(minutes):\(seconds)"
        lappedTimes.append(currentTime)
        
        let indexPath = IndexPath(row: lappedTimes.count - 1, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    @IBAction func pause(_ sender: UIButton) {
        timer.invalidate()
        startButton.isHidden = false
    }
    
    @IBAction func reset(_ sender: UIButton) {
        resetTimer()
    }
    
    
    
    
    
}

extension ViewController : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lappedTimes.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "lapCell", for: indexPath)
        cell.textLabel?.text = lappedTimes[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            lappedTimes.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

