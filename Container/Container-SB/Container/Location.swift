//
//  Location.swift
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

import CoreLocation

/// A structure representing the location of a point on
/// the map.

struct Location {

    /// The name of the location.

    let name: String

    /// The latitude of the location in degrees.

    let latitude: CLLocationDegrees

    /// The longitude of the location in degrees.

    let longitude: CLLocationDegrees

    /// A read-only `CLLocationCoordinate2D` value for the
    /// geographic coordinate of the location.

    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2DMake(latitude, longitude)
    }
}

extension Location {

    /// A failable initializer that builds a `Location` from
    /// a dictionary of String keys and values. The dictionary
    /// must contain at least "name", "latitude" and "longitude"
    /// items.
    ///
    /// The values must all be `String` and the `latitude`
    /// and `longitude` must convert to a `CLLocationDegrees`
    /// value (Double) and specify a valid coordinate. A valid
    /// latitude is from -90 to +90 and a valid longitude is 
    /// from -180 to +180.
    ///
    /// - Parameter dictionary: A dictionary containing the
    ///   details to initialize the location.
    ///
    /// - Returns: A `Location` structure or `nil` if the
    ///   dictionary was invalid,

    init?(dictionary: Dictionary<String,String>) {
        guard let name = dictionary["name"],
            let latitudeItem = dictionary["latitude"],
            let latitude = CLLocationDegrees(latitudeItem),
            let longitudeItem = dictionary["longitude"],
            let longitude = CLLocationDegrees(longitudeItem) else {
                return nil
        }

        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        if !CLLocationCoordinate2DIsValid(coordinate) {
            return nil
        }
    }
}
