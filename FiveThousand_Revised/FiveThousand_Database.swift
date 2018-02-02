 //
//  FiveThousand_Database.swift
//  FiveThousand_Revised
//
//  Created by Derek Morefield on 1/4/18.
//  Copyright © 2018 Derek Morefield. All rights reserved.
//

import Foundation
import SQLite

class DataBaseFiveThousand {
    
    private let highscores = Table("highscores")
    private let id = Expression<Int64>("id")
    private let name = Expression<String?>("name")
    private let playerturns = Expression<Int64>("playerturns")
    private let gamescore = Expression<Int64>("gamescore")
    
    static let instance = DataBaseFiveThousand()
    private let db: Connection?
    
    //am i supposed to make this private?
    private init() {
        
        print("Initializing")
        let path = NSSearchPathForDirectoriesInDomains(
            .documentDirectory, .userDomainMask, true
            ).first!
        
        do {
            db = try Connection("\(path)/FiveThousand.sqlite3")
            createTable()
            print ("DB CREATED")
        } catch {
            db = nil
            print ("Unable to open database")
        }
    }
    
    func createTable() {
        do {
            try db!.run(highscores.create(ifNotExists: true) { table in
                table.column(id, primaryKey: true)
                table.column(name)
                table.column(playerturns)
                table.column(gamescore)
            })
        } catch {
            print("Unable to create table")
        }
    }
    
    //This function was previously named addContact --> Renaming to addEntry
    func addEntry(cname: String, cplayerturns : Int64 , cgamescore : Int64) -> Int64? {
        do {
            let insert = highscores.insert(name <- cname, playerturns <- cplayerturns, gamescore <- cgamescore)
            let id = try db!.run(insert)
            print ("entry success")
            
            return id
        } catch {
            print("Insert failed")
            return nil
        }
    }
    
    
    //This function was previously named addContact --> Renaming to getHighscores
    func getHighScores() -> [Player] {
        var highscore_list = [Player]()
        
        //order the results from turns and gamescore DESC
//        let orderQuery = highscores.order(playerturns.asc , gamescore.asc)
        
        do {
            for highscore in try db!.prepare(self.highscores.order(playerturns.asc, gamescore.asc)) {
                highscore_list.append(Player(
                    id: highscore[id],
                    name: highscore[name]!,
                    playerTurns: highscore[playerturns] ,
                    gameScore: highscore[gamescore]))
            }
        } catch {
            print("Select failed")
        }
        
        return highscore_list
    }
    

    
    //This function was previously named addContact --> Renaming to deleteHighscore
    func deleteHighScore(cid: Int64) -> Bool {
        do {
            let highscore = highscores.filter(id == cid)
            try db!.run(highscore.delete())
            return true
        } catch {
            
            print("Delete failed")
        }
        return false
    }
    
    //This function was previously named addContact --> Renaming to updateHighScore
    func updateHighScore(cid:Int64, newContact: Player) -> Bool {
        let highscore = highscores.filter(id == cid)
        do {
            let update = highscore.update([
                name <- newContact.name,
                //phone <- newContact.phone,
                //address <- newContact.address
                ])
            if try db!.run(update) > 0 {
                return true
            }
        } catch {
            print("Update failed: \(error)")
        }
        
        return false
    }
    
    private static var database : DataBaseFiveThousand = {
        let my_database = DataBaseFiveThousand()
        return my_database }()
    
    //Singleton to share the single instance DB
    class func shared() -> DataBaseFiveThousand {
        return  database
    }
    
    
    //Blow up the records in the DB
    func destroy() {
        do {
            for highscore in try db!.prepare(self.highscores) {
                let index = highscore[id]
                if deleteHighScore(cid: index) {
                    print ("Record Deleted")
                }
                else {
                    print ("Unable to remove")
                }
            }
        } catch {
            print("Select row failed")
        }
    }
}
