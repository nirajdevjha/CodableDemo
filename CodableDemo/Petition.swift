//
//  Petition.swift
//  CodableDemo
//
//  Created by Niraj Jha on 02/04/19.
//  Copyright © 2019 Niraj Jha. All rights reserved.
//

import Foundation

struct Petition: Codable {
    var title: String
    var body: String
    var signatureCount: Int
}

