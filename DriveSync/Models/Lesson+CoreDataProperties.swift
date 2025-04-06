import Foundation
import CoreData

extension Lesson {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Lesson> {
        return NSFetchRequest<Lesson>(entityName: "Lesson")
    }

    @NSManaged public var studentID: String?
    @NSManaged public var lessonType: String?
    @NSManaged public var startTime: Date?
    @NSManaged public var duration: Int16
    @NSManaged public var location: String?
    @NSManaged public var notes: String?
    @NSManaged public var status: String?

}

extension Lesson : Identifiable {

}