//
//  Image+CoreDataProperties.swift
//  MovieFlix
//
//  Created by Selladurai on 13/11/21.
//
//

import Foundation
import CoreData


extension Image {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Image> {
        return NSFetchRequest<Image>(entityName: "Image")
    }

    @NSManaged public var blob: Data?
    @NSManaged public var url: String?

}
