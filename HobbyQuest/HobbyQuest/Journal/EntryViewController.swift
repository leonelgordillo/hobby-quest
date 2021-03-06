//
//  EntryViewController.swift
//  HobbyQuest
//
//  Created by Monica Tran on 10/19/17.
//  Copyright © 2017 Monica Tran. All rights reserved.
//

import UIKit

protocol EntryViewControllerDelegate {
    func saveNewEntry(desc:String,hobby:String,duration:String,rating:String)
}

class EntryViewController: UIViewController, UITextFieldDelegate {
    
    var delegate: EntryViewControllerDelegate!

    var hobby = ""
    var desc = ""
    
    @IBOutlet var greetingLabel: UILabel!
    @IBOutlet var inputTextField: UITextField!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var durationLabel: UILabel!
    @IBOutlet var durationField: UIDatePicker!
    @IBOutlet weak var littledude: UIImageView!
    @IBOutlet weak var ratingLabel: SpeechBubble!
    @IBOutlet weak var ratingField: CosmosView!
    
    @IBOutlet weak var submitButton: UIButton!
    @IBAction func submitDuration(_ sender: Any) {
        
        durationField.isHidden = true
        submitButton.isHidden = true
        
        let when = DispatchTime.now() + 1
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.ratingLabel.isHidden = false
            self.ratingLabel.text = "How would you rate it?"
        }
        DispatchQueue.main.asyncAfter(deadline: when+1) {
            self.ratingField.isHidden = false
            let animation = AnimationType.from(direction: .bottom, offset: 30.0)
            self.ratingField.animate(animations: [animation])
            self.finishButton.isHidden = false
        }
        
    }
    @IBOutlet weak var finishButton: PMSuperButton!
    @IBAction func finishEntry(_ sender: Any) {
        let d = String(self.durationField.countDownDuration)
        let r = String(self.ratingField.rating)
        self.delegate.saveNewEntry(desc: self.desc, hobby: self.hobby, duration: d, rating: r)
        //self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
        //performSegue(withIdentifier: "entryToJournal", sender: self)
    }
    @IBAction func cancelEntry(_ sender: Any) {
        //self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        greetingLabel.clipsToBounds = true
        descriptionLabel.clipsToBounds = true
        durationLabel.clipsToBounds = true
        submitButton.clipsToBounds = true
        
        greetingLabel.layer.cornerRadius = 15.0
        descriptionLabel.layer.cornerRadius = 15.0
        durationLabel.layer.cornerRadius = 15.0
        submitButton.layer.cornerRadius = 8.0
        
        descriptionLabel.isHidden = true
        durationLabel.isHidden = true
        durationField.isHidden = true
        littledude.isHidden = true
        ratingLabel.isHidden = true
        ratingField.isHidden = true
        finishButton.isHidden = true
        self.view.viewWithTag(1)?.isHidden = true
        
        greetingLabel.text = "Hi there! How is " + hobby + " going?"
        
        inputTextField.delegate = self
        self.inputTextField.becomeFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "entryToJournal") {
            let r = String(self.ratingField.rating)
            let d = String(self.durationField.countDownDuration)
            self.delegate.saveNewEntry(desc: self.desc, hobby: self.hobby, duration: d, rating: r)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        desc = textField.text!
        textField.resignFirstResponder()
        descriptionLabel.isHidden = false
        descriptionLabel.text = desc
        textField.isHidden = true
        
        let when = DispatchTime.now() + 1
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.durationLabel.isHidden = false
            self.littledude.isHidden = false
            self.durationLabel.text = "Sounds fun! How long did you spend on this activity?"
        }
        DispatchQueue.main.asyncAfter(deadline: when+1) {
            self.durationField.isHidden = false
            let animation = AnimationType.from(direction: .bottom, offset: 30.0)
            self.durationField.animate(animations: [animation])
            self.view.viewWithTag(1)?.isHidden = false
        }
        
        return true
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
