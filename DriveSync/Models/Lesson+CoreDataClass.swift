import Foundation
import CoreData

@objc(Lesson)
public class Lesson: NSManagedObject {
    @NSManaged public var studentID: String?
    @NSManaged public var lessonType: String?
    @NSManaged public var startTime: Date?
    @NSManaged public var duration: Int16
    @NSManaged public var location: String?
    @NSManaged public var notes: String?
    @NSManaged public var status: String?
}