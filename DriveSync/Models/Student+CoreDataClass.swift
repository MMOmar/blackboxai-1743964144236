import Foundation
import CoreData

@objc(Student)
public class Student: NSManagedObject {
    @NSManaged public var name: String?
    @NSManaged public var licenseNumber: String?
    @NSManaged public var licenseDate: Date?
    @NSManaged public var bdeCompletionDate: Date?
    @NSManaged public var email: String?
    @NSManaged public var address: String?
    @NSManaged public var school: String?
    @NSManaged public var parentContact: String?
    @NSManaged public var parentEmail: String?
    @NSManaged public var licensePhoto: Data?
}