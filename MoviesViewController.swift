//
//  MoviesViewController.swift
//  flixster
//
//  Created by Mamadou A. Balde on 2/25/19.
//  Copyright © 2019 MamadouABalde. All rights reserved.
//

import UIKit
import AlamofireImage
class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate { //step 1: Creating UITableViewDataSource and UITableViewDelegate
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var movies = [[String:Any]]() // create movies as an array of dictionary
    override func viewDidLoad() {
        super.viewDidLoad()
        // step 3: getting the data
        tableView.dataSource = self
        tableView.delegate = self
        
        print("Hello")
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                self.movies = dataDictionary["results"] as! [[String:Any]] //how movies will access the data inside the dictionary by casting as an array of dictionary;
                
                
                self.tableView.reloadData()
                
                print(dataDictionary) //print the data (list of movies) in the console
                
                // TODO: Get the array of movies
                // TODO: Store the movies in a property to use elsewhere
                // TODO: Reload your table view data
                
            }
        }
        task.resume()
        // Do any additional setup after loading the view.
    }
    //Step 2: creating the 2 functions
    func tableView(_ _tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count //50 rows
    }
    func tableView(_ _tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        //let cell = UITableViewCell()
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
        
        let movie = movies[indexPath.row]
        let title = movie["title"] as! String
        let synopsis = movie["overview"] as! String
        
        
        cell.titleLabel.text = title
        //cell.textLabel!.text = title
        //cell.textLabel?.text = "row: \(indexPath.row)"
        cell.synopsisLabel.text = synopsis
        
        //Get the URL from the API
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: baseUrl + posterPath)
        
        cell.posterView.af_setImage(withURL: posterUrl!)
        
        
        return cell
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
