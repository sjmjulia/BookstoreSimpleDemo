//
//  BookViewController.swift
//  BookstoreSimpleDemo
//
//  Created by ShenJiamei on 5/26/17.
//  Copyright © 2017 REINS. All rights reserved.
//

import UIKit

class BookViewController: UIViewController {
    
    var book: Book?
    var bookDelegate: BookDelegate?

    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var authorField: UITextField!
    @IBOutlet weak var publisherField: UITextField!
    @IBOutlet weak var priceField: UITextField!
    
    
    @IBAction func submitClick(_ sender: UIButton) {
        let b = Book()
        var url = HttpHelper.addBookUrl
        if book?.id != nil {
            b.id = self.book?.id
            url = HttpHelper.updateBookUrl
        }
        b.author = authorField.text
        b.title = titleField.text
        b.price = Double(priceField.text!)
        b.publisher = publisherField.text
        HttpHelper.requestPOSTURL( url, params: b.toJSON() as [String : AnyObject]?, success: {
            (JSONResponse) -> Void in
            self.bookDelegate?.reloadBookData()
            _ = self.navigationController?.popViewController(animated: true)
            
        }) {
            (error) -> Void in
            print("Error: \(error)")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.book != nil {
            self.titleField.text = book?.title
            self.authorField.text = book?.author
            self.priceField.text = String(format: "%.1f", (book?.price)!)
            self.publisherField.text = book?.publisher
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
