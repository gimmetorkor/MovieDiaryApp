//
//  ViewController.swift
//  MovieDiary
//
//  Created by imyourtk on 1/11/2566 BE.
//

import UIKit

class MovieDiaryViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    //    var diary:[Diary]=[]
    
    @IBOutlet weak var tableView: UITableView!

//    @IBAction func unwindToDiary(_ segue: UIStoryboardSegue) {
//        // Handle any additional actions upon unwinding to the Calendar view controller
//    }
    
    
    var movieListFromDiary: [MovieDiary] = []
    
    
//    private var diary: [loadDiary] = []
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.yellow], for: .normal)
        DatabaseManager.shared.connect2DB()
        setUpTableView()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        movieListFromDiary = DatabaseManager.shared.getMovieListFromDiary()
        tableView.reloadData()
    }
    
    func setUpTableView() {
        tableView.backgroundColor = .black
        tableView.register(UINib(nibName: "DiaryTableViewCell", bundle: nil), forCellReuseIdentifier: "diaryCell")
        tableView.rowHeight=200
        tableView.separatorColor = .white
        tableView.separatorInset = .init(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieListFromDiary.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "diaryCell", for: indexPath) as! DiaryTableViewCell

        // Configure the cell...
        cell.configureCell(
            name: movieListFromDiary[indexPath.row].diaryTitle,
            image: movieListFromDiary[indexPath.row].diaryImg,
            year: movieListFromDiary[indexPath.row].diaryMovieYear,
            note: movieListFromDiary[indexPath.row].diaryNote,
            date: movieListFromDiary[indexPath.row].diaryDate
        )

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(movieListFromDiary[indexPath.row])
        
    }
    
}

