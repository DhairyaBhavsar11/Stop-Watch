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

    @IBAction func start(_ sender: UIButton) {
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(count), userInfo: nil, repeats: true)
    }
    @objc fileprivate func count() {
        seconds += 1
        if seconds == 60 {
            minutes += 1
            seconds = 0
        }
        secondLabel.text = "\(seconds)"
    }
    
    
    @IBAction func lap(_ sender: UIButton) {
        let currentTime = "\(hours):\(minutes):\(seconds)"
        lappedTimes.append(currentTime)
        
        let indexPath = IndexPath(row: lappedTimes.count - 1, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
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
}

