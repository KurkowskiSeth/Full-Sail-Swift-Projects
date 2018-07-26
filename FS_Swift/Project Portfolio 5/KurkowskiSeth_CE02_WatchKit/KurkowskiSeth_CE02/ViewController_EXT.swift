//
//  ViewController_EXT.swift
//  KurkowskiSeth_CE02
//
//  Created by Seth Kurkowski on 3/13/18.
//  Copyright © 2018 Seth Kurkowski. All rights reserved.
//

import UIKit
extension ViewController {
    func createDataModel() -> [Profile] {
        var profiles: [Profile] = []
        
        //1
        profiles.append(Profile.init(_name: "Josephine", _description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. A condimentum vitae sapien pellentesque. Feugiat in ante metus dictum at tempor commodo. Suspendisse ultrices gravida dictum fusce.", _image: "noun_156405_cc"))
        //2
        profiles.append(Profile.init(_name: "Matthew", _description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. A condimentum vitae sapien pellentesque. Feugiat in ante metus dictum at tempor commodo. Suspendisse ultrices gravida dictum fusce.", _image: "noun_188957_cc"))
        //3
        profiles.append(Profile.init(_name: "Ernest", _description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. A condimentum vitae sapien pellentesque. Feugiat in ante metus dictum at tempor commodo. Suspendisse ultrices gravida dictum fusce.", _image: "noun_252144_cc"))
        //4
        profiles.append(Profile.init(_name: "Chad", _description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. A condimentum vitae sapien pellentesque. Feugiat in ante metus dictum at tempor commodo. Suspendisse ultrices gravida dictum fusce.", _image: "noun_389730_cc"))
        //5
        profiles.append(Profile.init(_name: "Andrew", _description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. A condimentum vitae sapien pellentesque. Feugiat in ante metus dictum at tempor commodo. Suspendisse ultrices gravida dictum fusce.", _image: "noun_516111_cc"))
        //6
        profiles.append(Profile.init(_name: "Mary", _description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. A condimentum vitae sapien pellentesque. Feugiat in ante metus dictum at tempor commodo. Suspendisse ultrices gravida dictum fusce.", _image: "noun_626602_cc"))
        //7
        profiles.append(Profile.init(_name: "Nellie", _description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. A condimentum vitae sapien pellentesque. Feugiat in ante metus dictum at tempor commodo. Suspendisse ultrices gravida dictum fusce.", _image: "noun_654079_cc"))
        //8
        profiles.append(Profile.init(_name: "Jenny", _description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. A condimentum vitae sapien pellentesque. Feugiat in ante metus dictum at tempor commodo. Suspendisse ultrices gravida dictum fusce.", _image: "noun_796558_cc"))
        //9
        profiles.append(Profile.init(_name: "Roy", _description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. A condimentum vitae sapien pellentesque. Feugiat in ante metus dictum at tempor commodo. Suspendisse ultrices gravida dictum fusce.", _image: "noun_1053967_cc"))
        //10
        profiles.append(Profile.init(_name: "Brandy", _description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. A condimentum vitae sapien pellentesque. Feugiat in ante metus dictum at tempor commodo. Suspendisse ultrices gravida dictum fusce.", _image: "noun_1529612_cc"))
        
        return profiles
    }
}
