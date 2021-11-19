//
//  ImageDAO.swift
//  MovieFlix
//
//  Created by Selladurai on 13/11/21.
//

import Foundation
import CoreData
import UIKit

class ImageDAO {
    private let container: NSPersistentContainer!

    static let shared = ImageDAO()
    
    init() {
        self.container = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    }

    private func saveContext() {
        try? container.viewContext.save()
    }
    
    private func insert<T>(_ type: T.Type, into context: NSManagedObjectContext) -> T? {
        return NSEntityDescription.insertNewObject(forEntityName: String(describing: T.self), into: context) as? T
    }
    
    func makeExternallyStoredImage(_ bitmap: UIImage, url: String?) -> Image? {
        let image = insert(Image.self, into: container.viewContext)
        image?.blob = bitmap.toData() as Data?
        image?.url = url
        saveContext()
        return image
    }
    
    func externallyStoredImage(by url: String) -> Image? {
        let fetchRequest = NSFetchRequest<Image>(entityName: "Image")
        fetchRequest.predicate = NSPredicate(format: "url == %@", url)
        return (try? container.viewContext.fetch(fetchRequest))?.last
    }
}
