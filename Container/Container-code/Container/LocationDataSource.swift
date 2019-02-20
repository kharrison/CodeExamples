//
//  LocationDataSource.swift
//  Container
//
//  Created by Keith Harrison http://useyourloaf.com
//  Copyright (c) 2017 Keith Harrison. All rights reserved.
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

import UIKit

final class LocationDataSource: NSObject {

    private let tableView: UITableView
    private var locations = [Location]()

    init(tableView: UITableView, from path: String) {
        self.tableView = tableView
        super.init()
        readFromPlist(name: path)
        tableView.dataSource = self
        tableView.reloadData()
    }

    func locationAtIndexPath(_ indexPath: IndexPath) -> Location? {
        return indexPath.row < locations.count ? locations[indexPath.row] : nil
    }

    private func readFromPlist(name: String) {
        guard let items = NSArray(contentsOfFile: name) as? [Dictionary<String,String>] else {
            return
        }
        for item in items {
            if let location = Location(dictionary: item) {
                locations.append(location)
            }
        }
    }
}

extension LocationDataSource: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LocationCell.reuseIdentifier, for: indexPath)
        configure(cell: cell, indexPath: indexPath)
        return cell
    }

    private func configure(cell: UITableViewCell, indexPath: IndexPath) {
        if let cell = cell as? LocationCell {
            let object = locations[indexPath.row]
            cell.configure(object: object)
        }
    }
}

