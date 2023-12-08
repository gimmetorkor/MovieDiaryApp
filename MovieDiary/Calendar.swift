//
//  Calendar.swift
//  MovieDiary
//
//  Created by imyourtk on 1/11/2566 BE.
//

import UIKit


class Calendar: UIViewController {

    @IBAction func today(_ sender: Any) {
        let display = calendar.date

            // Update the datepicker on the main thread
            DispatchQueue.main.async {
                self.calendar.date = display
            }
    }
    
    @IBOutlet weak var calendar: UIDatePicker!{
        didSet {
                calendar.frame = CGRect(x: 0, y: 0, width: 360, height: 600)
            }
    }

    @IBAction func calender(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        self.selectedDate = calendar.date

        
    }
    
    @IBAction func unwindToCalendar(_ segue: UIStoryboardSegue) {
        // Handle any additional actions upon unwinding to the Calendar view controller
    }

    
    var selectedDate = Date()  // Declare selectedDate as an optional Date

      

    override func viewDidLoad() {
        super.viewDidLoad()
              
        tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.yellow], for: .normal)

        // Set the delegate for UIDatePicker
//        calendar.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
    }

//    @objc func datePickerValueChanged(sender: UIDatePicker) {
//        selectedDate = sender.date // Update selectedDate when the date picker value changes
//        print("Selected date: \(selectedDate!)")
//    }
      
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "date" {
            let vc = segue.destination as! MovieViewController

            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let dateString = dateFormatter.string(from: selectedDate)

            vc.dateDiary = dateString
        }
    }




  }
