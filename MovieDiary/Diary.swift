//
//  Diary.swift
//  MovieDiary
//
//  Created by imyourtk on 1/12/2566 BE.
//

import UIKit

struct DiaryModel: Codable {
    let date: String
    let movie: Movie?
    let record: String
}

class Diary: UIViewController {

    
    var selectedMovie: Movie?
    var dateDiary: String = ""
    var diary: [DiaryModel] = []
    
    @IBOutlet weak var showDate: UILabel!
    
    @IBOutlet weak var imgMovie: UIImageView!
    
    @IBOutlet weak var movieName: UILabel!
    
    @IBOutlet weak var movieYear: UILabel!
    
    @IBOutlet weak var director: UILabel!
    
    @IBOutlet weak var moviePrecis: UITextView!
    
    @IBOutlet weak var record: UITextView!
    
    @IBOutlet weak var btnSave: UIButton!
    
    @IBAction func btnSave(_ sender: Any){
        guard let recordText = record.text, !recordText.isEmpty else {
            // แสดงแจ้งเตือนหาก record ว่างเปล่า
            let alertController = UIAlertController(title: "กรุณาใส่ข้อความ", message: nil, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "ตกลง", style: .default, handler: nil)
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
            return
        }
        
        let newDiary = DiaryModel(date: dateDiary, movie: selectedMovie, record: recordText)
        // แสดงแจ้งเตือนบันทึกสำเร็จ
        if DatabaseManager.shared.saveMovieToDiary(with: newDiary) {
            let alertController = UIAlertController(title: "บันทึกสำเร็จ", message: nil, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "ตกลง", style: .default) { [weak self] _ in
                self?.performSegue(withIdentifier: "unwindToCalendarSegue", sender: nil)
    //            print()
            }

            alertController.addAction(okAction)

            present(alertController, animated: true, completion: nil)
        } else {
            let alertController = UIAlertController(title: "บันทึกไม่สำเร็จ", message: nil, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "ตกลง", style: .destructive) { [weak self] _ in
                
                self?.performSegue(withIdentifier: "unwindToCalendarSegue", sender: nil)
            }
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
        }
    }

    
    func showImg(){
        if let movie = selectedMovie {
            imgMovie.image = UIImage(named: movie.image)
        } else {
            imgMovie.image = UIImage(named: "defaultImage")
        }
    }
    
    func showDetail() {
        if let movie = selectedMovie {
            movieName.text = movie.title
            movieYear.text = "(\(movie.releaseDate))"
            moviePrecis.text = movie.precis
            director.text = movie.director
        }
        else {
            let alertController = UIAlertController(title: "ไม่พบข้อมูลหนัง", message: "กรุณาเลือกหนังใหม่", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "ตกลง", style: .default, handler: nil)
                    alertController.addAction(okAction)

                    // แสดง UIAlertController
                    present(alertController, animated: true, completion: nil)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showDate.text = dateDiary
        
        showImg()
        showDetail()

        navigationItem
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        print("Preparing for segue with identifier: \(segue.identifier ?? "No identifier")")
//
//        if let viewController = segue.destination as? ViewController {
//            viewController.diary = diary
//            print("Data successfully passed to ViewController")
//        } else {
//            print("Segue destination is not ViewController")
//            print("Segue destination: \(segue.destination)")
//        }
//    }


}
