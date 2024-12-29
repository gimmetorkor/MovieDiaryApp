import Foundation
import GRDB

class DatabaseManager {
    var dbPath: String = ""
    var dbResourcePath: String = ""
    var config = Configuration()
    let fileManager = FileManager.default
    static let shared = DatabaseManager()
    
    func connect2DB() {
        do {
            dbPath = try fileManager
                .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                .appendingPathComponent("moviedatabse.db")
                .path
            if !fileManager.fileExists(atPath: dbPath) {
                dbResourcePath = Bundle.main.path(forResource: "moviedatabse", ofType: "db")!
                try fileManager.copyItem(atPath: dbResourcePath, toPath: dbPath)
            }
        } catch {
            print("An error has occurred")
        }
    }
    
    func getMovieListFromDiary() -> [MovieDiary] {
        var movieList: [MovieDiary] = [MovieDiary]()
        
        do {
            let dbQueue = try DatabaseQueue(path: dbPath, configuration: config)
            
            try dbQueue.inDatabase { db in
                let rows = try Row.fetchCursor(db, sql: "SELECT * FROM diary")
                while let row = try rows.next() {
                    movieList.append(MovieDiary(diaryTitle: row["diaryTitle"], diaryImg: row["diaryImg"], diaryMovieYear: row["diaryMvYear"], diaryNote: row["diaryNote"], diaryDate: row["diaryDate"]))
                }
            }
        } catch {
            print(error.localizedDescription)
        }
        return movieList
    }
    
    func saveMovieToDiary(with diary: DiaryModel) -> Bool {
        do {
            let dbQueue = try DatabaseQueue(path: dbPath, configuration: config)
            try dbQueue.write { db in
                try db.execute(sql: "INSERT INTO diary (diaryTitle, diaryImg, diaryMvYear, diaryNote, diaryDate) VALUES (?, ?, ?, ?, ?)", arguments: [diary.movie?.title, diary.movie?.image, diary.movie?.releaseDate, diary.record, diary.date])
            }
            return true
        } catch {
            // Handle the error here
            print("Error writing to the database: \(error)")
            return false
        }
    }
    
//    func deleteMovieToDiary(with diary: DiaryModel) -> Bool {
//        do {
//            let dbQueue = try DatabaseQueue(path: dbPath, configuration: config)
//            try? dbQueue.write { db in
//                try db.execute(sql: "DELETE FROM diary WHERE diaryTitle = ?", arguments: [diary.movie?.title, diary.movie?.image, diary.movie?.releaseDate, diary.record, diary.date])
//
//            }
//            return true
//        } catch {
//            // Handle the error here
//            print("Error writing to the database: \(error)")
//            return false
//        }
//    }
}
