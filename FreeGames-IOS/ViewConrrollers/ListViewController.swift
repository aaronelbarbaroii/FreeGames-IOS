//
//  ViewController.swift
//  FreeGames-IOS
//
//  Created by Mananas on 12/11/25.
//

import UIKit

class ListViewController: UIViewController, UITableViewDataSource, UISearchBarDelegate {

    
    @IBOutlet weak var tableView: UITableView!
    
    var gameList: [Game] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        
        getAllGames()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gameList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameCell", for: indexPath) as! GameViewCell
        let game = gameList[indexPath.row]
        cell.render(game: game)
        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText .isEmpty {
            getAllGames()
        }
        else {
            
        }
    }
    
    func getAllGames() {
        Task {
            gameList = await ServiceApi().getAllGames()
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            let detailVC = segue.destination as! DetailViewController
            let indexPath = tableView.indexPathForSelectedRow!
            let game = gameList[indexPath.row]
            detailVC.game = game
            tableView.deselectRow(at: indexPath, animated: true)
        }
   


}

