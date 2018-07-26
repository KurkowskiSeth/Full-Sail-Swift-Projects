//
//  DetailViewController.swift
//  KurkowskiSeth_CE04
//
//  Created by Seth Kurkowski on 3/18/18.
//  Copyright © 2018 Seth Kurkowski. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var dateCreatedLbl: UILabel!
    @IBOutlet weak var categoryLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    
    var itemImage: UIImage? = nil
    var itemTitle: String = ""
    var dateCreated: String = ""
    var category: String = ""
    var itemDescription: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imageView.image = itemImage
        titleLbl.text = itemTitle
        dateCreatedLbl.text = dateCreated
        categoryLbl.text = category
        descriptionLbl.text = itemDescription
    }

}
