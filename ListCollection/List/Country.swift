//  Created by Keith Harrison https://useyourloaf.com
//  Copyright © 2020 Keith Harrison. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without
//  modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright
//  notice, this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright
//  notice, this list of conditions and the following disclaimer in the
//  documentation and/or other materials provided with the distribution.
//
//  3. Neither the name of the copyright holder nor the names of its
//  contributors may be used to endorse or promote products derived from
//  this software without specific prior written permission.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
//  AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
//  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
//  ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
//  LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
//  CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
//  SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
//  INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
//  CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
//  ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
//  POSSIBILITY OF SUCH DAMAGE.

import Foundation

struct Country: Hashable {
    var name: String
    var capital: String?
    var continent: String
    var currency: String?
    var area: Double
    var population: Int
    var visited: Bool

    var formattedPopulation: String {
        NumberFormatter.localizedString(from: population as NSNumber, number: .decimal)
    }

    var formattedArea: String {
        NumberFormatter.localizedString(from: area as NSNumber, number: .decimal)
    }

    init(name: String, capital: String? = nil, continent: String, currency: String? = nil, area: Double = 0, population: Int = 0, visited: Bool = false) {
        self.name = name
        self.capital = capital
        self.continent = continent
        self.currency = currency
        self.area = area
        self.population = population
        self.visited = visited
    }
}

// MARK: - Codable
extension Country: Codable {
    enum CodingKeys: String, CodingKey {
        case name = "countryName"
        case capital
        case continent = "continentName"
        case currency = "currencyCode"
        case area = "areaInSqKm"
        case population
        case visited
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        capital = try values.decodeIfPresent(String.self, forKey: .capital)
        continent = try values.decode(String.self, forKey: .continent)
        currency = try values.decodeIfPresent(String.self, forKey: .currency)

        let areaString = try values.decode(String.self, forKey: .area)
        let popString = try values.decode(String.self, forKey: .population)

        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale(identifier: "en-US")
        if let areaNumber = numberFormatter.number(from: areaString) {
            area = areaNumber.doubleValue
        } else {
            throw DecodingError.dataCorruptedError(forKey: .area, in: values, debugDescription: "Expected a double, got [\(areaString)]")
        }

        if let popNumber = numberFormatter.number(from: popString) {
            population = popNumber.intValue
        } else {
            throw DecodingError.dataCorruptedError(forKey: .population, in: values, debugDescription: "Expected an Int, got \(popString)")
        }

        visited = try values.decodeIfPresent(Bool.self, forKey: .visited) ?? false
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(capital, forKey: .capital)
        try container.encode(continent, forKey: .continent)
        try container.encode(currency, forKey: .currency)

        let numberFormatter = NumberFormatter()
        let areaString = numberFormatter.string(from: NSNumber(value: area))
        let popString = numberFormatter.string(from: NSNumber(value: population))
        try container.encode(areaString, forKey: .area)
        try container.encode(popString, forKey: .population)

        try container.encode(visited, forKey: .visited)
    }
}

struct CountryInfo: Codable {
    var geonames: [Country]
}
