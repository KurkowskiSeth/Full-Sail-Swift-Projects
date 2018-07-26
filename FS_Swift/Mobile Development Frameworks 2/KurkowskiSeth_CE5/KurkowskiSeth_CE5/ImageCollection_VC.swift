//
//  ImageCollection_VC.swift
//  KurkowskiSeth_CE5
//
//  Created by Seth Kurkowski on 10/16/17.
//  Copyright © 2017 Seth Kurkowski. All rights reserved.
//

import UIKit

private let cellRID = "cellID1"
private let headerRID = "headerID1"

class ImageCollection_VC: UICollectionViewController {
    
    //MARK: -Properties
    var imageDict = ["Football": ["Packers": "https://goo.gl/AmfcyU", "Bears": "https://goo.gl/jN5mzD", "Lions": "https://goo.gl/vVZf34", "Giants": "https://goo.gl/yw38e8", "Texans": "https://goo.gl/GGamqZ"], "Baseball": ["Brewers": "https://goo.gl/2bZofk", "Cubs": "https://goo.gl/LDHfAL", "Tigers": "https://goo.gl/7wxY7M", "Yankees": "https://goo.gl/g41w9A", "Astros": "https://goo.gl/TCQNDh"], "Basketball": ["Bucks": "https://goo.gl/KeRUQT", "Bulls": "https://goo.gl/Y8Adpp", "Pistons": "https://goo.gl/89qXWZ", "Lakers": "https://goo.gl/yiDQZ2", "Cavilers": "https://goo.gl/1pgL6L"]]
    var dataModelDict = ["Football": [DataModel](), "Baseball": [DataModel](), "Basketball": [DataModel]()]
    var sections = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Download Images
        downloadImages()
        
    }
    
    // MARK: -UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    //Load Cells and Sections based on the current contents of the dataModelArray.
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellRID, for: indexPath) as! ImageCell
        
        // Configure the cell
        let data = Array(dataModelDict.values)
        cell.imageTitle.text = data[indexPath.section][indexPath.row].title
        cell.cellImage.image = data[indexPath.section][indexPath.row].image
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerRID, for: indexPath) as! HeaderView
        
        switch indexPath.section {
        case 0:
            header.headerLabel.text = Array(dataModelDict.keys)[indexPath.section]
            header.backgroundColor = UIColor.red
            header.removeBtn.tintColor = UIColor.white
            header.removeBtn.tag = 0
        case 1:
            header.headerLabel.text = Array(dataModelDict.keys)[indexPath.section]
            header.backgroundColor = UIColor.white
            header.removeBtn.tintColor = UIColor.black
            header.removeBtn.tag = 1
        case 2:
            header.headerLabel.text = Array(dataModelDict.keys)[indexPath.section]
            header.backgroundColor = UIColor.blue
            header.removeBtn.tintColor = UIColor.white
            header.removeBtn.tag = 2
        default:
            header.headerLabel.text = "Error"
        }
        
        return header
        
    }
    
    //MARK: -Delete Action
    //Remove selected data from dataModelArray and reload data
    @IBAction func removeSection(sender: UIButton) {
        sections -= 1
        let key = Array(dataModelDict.keys)[sender.tag]
        dataModelDict.removeValue(forKey: key)
        self.collectionView?.reloadData()
    }
}
