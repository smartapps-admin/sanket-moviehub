
import UIKit

class LandingVC: UIViewController {
    var countdownTimer: Timer?
        var count = 2
    @IBOutlet weak var countdownLabel: UILabel!
    
    @IBOutlet weak var watchBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        startCountdown()
        self.countdownLabel.text = "3"
    }
    
    @IBAction func onClickWatch(_ sender: Any) {

    }
    func startCountdown() {
            countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateCountdown), userInfo: nil, repeats: true)
        }
    @objc func updateCountdown() {
            if count > 0 {
                countdownLabel.text = "\(count)"
                count -= 1
            } else {
                countdownTimer?.invalidate()
                countdownLabel.text = "Movie!"
                self.watchBtn.isHidden = false
                
            }
        }
 
}
