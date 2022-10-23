//
//  Model.swift
//  AvitoTest
//
//  Created by Мария Ганеева on 23.10.2022.
//

import UIKit

// MARK: - Welcome
struct Welcome: Codable {
    var company: Company
}

// MARK: - Company
struct Company: Codable {
    let name: String
    var employees: [Employee]
}

// MARK: - Employee
struct Employee: Codable {
    let name, phoneNumber: String
    var skills: [String]

    enum CodingKeys: String, CodingKey {
        case name
        case phoneNumber = "phone_number"
        case skills
    }
}
