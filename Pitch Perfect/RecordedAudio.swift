//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Christian D. Zuniga on 5/17/15.
//  Copyright (c) 2015 ZTechnology.com. All rights reserved.
//

import Foundation

class RecordedAudio  {
    var filePathUrl: NSURL!
    var title: String!
    
    init(filePathUrl: NSURL, title: String){
        self.filePathUrl = filePathUrl
        self.title = title
    }
}