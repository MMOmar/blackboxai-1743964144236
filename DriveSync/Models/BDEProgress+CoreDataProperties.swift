import Foundation
import CoreData

extension BDEProgress {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BDEProgress> {
        return NSFetchRequest<BDEProgress>(entityName: "BDEProgress")
    }

    @NSManaged public var inClassHours: Int16
    @NSManaged public var inCarHours: Int16
    @NSManaged public var selfPacedHours: Int16
    @NSManaged public var deadlineDate: Date?

}

extension BDEProgress : Identifiable {

}