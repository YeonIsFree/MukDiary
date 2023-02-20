//
//  temporaryData.swift
//  MukDiary
//
//  Created by Seryun Chun on 2023/02/20.
//

import Foundation

class tmpData {
    let tmpTitle: String
    let tmpContent: String
    let tmpDate: Date
    
    init(tmpTitle: String, tmpContent: String) {
        self.tmpTitle = tmpTitle
        self.tmpContent = tmpContent
        self.tmpDate = Date()
    }
}

var tmpDataArray = [
    tmpData(tmpTitle: "제목 -1", tmpContent: "임시 데이터 -1"),
    tmpData(tmpTitle: "제목 -2", tmpContent: "임시 데이터 -2"),
    tmpData(tmpTitle: "제목 -3", tmpContent: "임시 데이터 -3")
]
