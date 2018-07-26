//
//  ImageDownload_IC_EXT.swift
//  KurkowskiSeth_CE5
//
//  Created by Seth Kurkowski on 10/16/17.
//  Copyright © 2017 Seth Kurkowski. All rights reserved.
//

import Foundation
import UIKit

extension ImageCollection_VC {
    
    //Download all the images in the imageDict and save them to the dataModelDict
    func downloadImages() {
        for section in imageDict {
            for team in section.value {
                if let validURL = URL(string: team.value) {
                    do {
                        let imageData = try Data(contentsOf: validURL)
                        let savedImage = UIImage(data: imageData)
                        dataModelDict[section.key]?.append(DataModel(image: savedImage!, title: team.key))
                    }
                    catch {
                        print(error.localizedDescription)
                        assertionFailure()
                    }
                }
            }
        }
    }
}
