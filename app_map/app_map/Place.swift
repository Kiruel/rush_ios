//
//  Place.swift
//  app_map
//
//  Created by swift on 21/12/14.
//  Copyright (c) 2014 swift. All rights reserved.
//

import UIKit

class Place: NSObject {
    
    var title_: String
    var subTitle_: String
    var lat_: Double
    var lon_: Double
    var city_: String
    var adresse_: String
    var country_: String
    
    init (titlePinAnnotation title: String, subTitleAnnotation subTitle:String, latitude lat: Double, longitude lon: Double, cityAnnotation city: String, adresseAnnotation adresse: String, countryAnnotation country: String) {
        //        super.init()
        title_ = title
        subTitle_ = subTitle
        lat_ = lat
        lon_ = lon
        city_ = city
        adresse_ = adresse
        country_ = country
    }
}