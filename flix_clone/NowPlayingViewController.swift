//
//  NowPlayingViewController.swift
//  flix_clone
//
//  Created by Justin Lee on 1/29/18.
//  Copyright © 2018 Justin Lee. All rights reserved.
//

import UIKit
import AlamofireImage
import Reachability


class NowPlayingViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    var movies: [Movie] = []
    var refreshControl: UIRefreshControl!
    var boolean = false
    
    
   

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.isHidden = true
        activityIndicator.startAnimating()
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(NowPlayingViewController.didPullToRefresh(_:)), for: .valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        tableView.dataSource = self
        fetchMovies()
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
            self.activityIndicator.stopAnimating()
            let reachability = Reachability()!
            
            if(reachability.connection == .none){
                print("yo")
                self.tableView.isHidden = false
                let alertController = UIAlertController(title: "Cannot get movies", message: "The Internet connection appears to be offline", preferredStyle: .actionSheet)
                let tryAgainAction = UIAlertAction(title: "Try Again", style: .default) { (action) in
                    //if(self.reachabilityChanged()==1){
                      //  print("hello")
                    let reachabilityAgain = Reachability()
                    if(reachabilityAgain?.connection != .none){
                        self.viewDidLoad()
                        //self.fetchMovies()
                        //self.boolean = true
                    }
                    
                }
                alertController.addAction(tryAgainAction)
                
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel){ (action) in
                }
                alertController.addAction(cancelAction)
                self.present(alertController, animated: true){
                    
                }
            }
            else {
                //print("yes")
                self.tableView.isHidden = false
            }
        })
        }
    
    override func viewWillAppear(_ animated: Bool) {
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
 
    func didPullToRefresh(_ refreshControl: UIRefreshControl) {
        //activityIndicator.startAnimating()
        //JJHUD.showLoading()
        fetchMovies()
        //JJHUD.hide()
        //activityIndicator.hide()
        
    }
    
    func reachabilityChanged() -> intmax_t {
        
        let reachability = Reachability()
        
        
        if(reachability?.connection != .none){
            return 1
        }
        else{
            return 2
        }
        
        
        
    }
    
   
        
        
    
    func fetchMovies() {
        MovieApiManager().nowPlayingMovies { (movies: [Movie]?, error: Error?) in
            if let movies = movies {
                self.movies = movies
                self.tableView.reloadData()
            }
        }
        self.refreshControl.endRefreshing()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        
        cell.movie = movies[indexPath.row]
       
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        let cell = sender as! UITableViewCell
        if let indexPath = tableView.indexPath(for: cell){
            let movie = movies[indexPath.row]
            let detailViewController = segue.destination as! DetailViewController
            detailViewController.movie = movie
            
        }
        
    }
    

        
        
        

        


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
    

  


