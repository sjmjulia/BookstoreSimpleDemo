//
//  TableViewController.swift
//  BookstoreSimpleDemo
//
//  Created by ShenJiamei on 5/22/17.
//  Copyright © 2017 REINS. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var books : [Book] = []
    var isUpdate:Bool = false
    var selectedBookIndex:Int?
    
    @IBAction func createBookClick(_ sender: Any) {
        self.isUpdate = false
        self.performSegue(withIdentifier: "bookSegue", sender: nil)
    }
    
    func reloadData() {
        HttpHelper.requestGETURL( HttpHelper.getBooksUrl, success: {
            (JSONResponse) -> Void in
            var blist: [Book] = []
            let res = JSONResponse["books"] as! [[String: Any]]
            for case let item in res{
                let b = Book(id: item["id"] as! Int, title: item["title"] as! String, author: item["author"] as! String, publisher: item["publisher"] as! String, price: item["price"] as! Double)
                blist.append(b)
            }
            self.books = blist
            self.tableView.reloadData()
            
        }) {
            (error) -> Void in
            print("Error: \(error)")
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.reloadData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.isUpdate = true
        selectedBookIndex = indexPath.row
        self.performSegue(withIdentifier: "bookSegue", sender: nil)
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! TableViewCell
        cell.nameLabel?.text = books[indexPath.row].title
        cell.uid = books[indexPath.row].id
        return cell
    }
    
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            HttpHelper.requestDELETEURL( HttpHelper.deleteBookUrl, params: String(books[indexPath.row].id!),
                    success: { (Response) in
                                        print(Response)
                        self.reloadData()
            },
                                      failure: { (err) in
                                        print(err)
            })
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationController = segue.destination as! BookViewController
        destinationController.bookDelegate = self
        if self.isUpdate {
            destinationController.book = self.books[self.selectedBookIndex!]
        }
    }
    
    
}

extension TableViewController: BookDelegate {
    func reloadBookData(){
        self.reloadData()
    }
}
