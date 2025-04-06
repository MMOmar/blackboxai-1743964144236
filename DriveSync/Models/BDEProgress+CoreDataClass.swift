import Foundation
import CoreData

@objc(BDEProgress)
public class BDEProgress: NSManagedObject {
    @NSManaged public var inClassHours: Int16
    @NSManaged public var inCarHours: Int16
    @NSManaged public var selfPacedHours: Int16
    @NSManaged public var deadlineDate: Date?
    
    public var totalHoursCompleted: Int {
        return Int(inClassHours) + Int(inCarHours) + Int(selfPacedHours)
    }
    
    public var hoursRemaining: Int {
        return 40 - totalHoursCompleted
    }
}