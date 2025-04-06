import UserNotifications

class NotificationService {
    
    static let shared = NotificationService()
    
    private init() {}
    
    func requestNotificationPermission(completion: @escaping (Bool) -> Void) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            DispatchQueue.main.async {
                completion(granted)
            }
        }
    }
    
    func scheduleLessonReminder(lesson: Lesson, hoursBefore: Int) {
        let content = UNMutableNotificationContent()
        content.title = "Upcoming Driving Lesson"
        content.body = "You have a \(lesson.lessonType) lesson in \(hoursBefore) hours"
        content.sound = .default
        
        let triggerDate = Calendar.current.date(byAdding: .hour, value: -hoursBefore, to: lesson.startTime)!
        let trigger = UNCalendarNotificationTrigger(
            dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], 
                                                         from: triggerDate),
            repeats: false
        )
        
        let request = UNNotificationRequest(
            identifier: "lesson-\(lesson.objectID.uriRepresentation().absoluteString)",
            content: content,
            trigger: trigger
        )
        
        UNUserNotificationCenter.current().add(request)
    }
    
    func scheduleBDEProgressNotification(student: Student, daysRemaining: Int) {
        let content = UNMutableNotificationContent()
        content.title = "BDE Deadline Approaching"
        content.body = "\(student.name) has \(daysRemaining) days to complete in-car lessons"
        content.sound = .default
        
        let triggerDate = Calendar.current.date(byAdding: .day, value: -daysRemaining, to: student.bdeCompletionDate)!
        let trigger = UNCalendarNotificationTrigger(
            dateMatching: Calendar.current.dateComponents([.year, .month, .day], 
                                                         from: triggerDate),
            repeats: false
        )
        
        let request = UNNotificationRequest(
            identifier: "bde-\(student.objectID.uriRepresentation().absoluteString)",
            content: content,
            trigger: trigger
        )
        
        UNUserNotificationCenter.current().add(request)
    }
    
    func cancelNotification(for identifier: String) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [identifier])
    }
}