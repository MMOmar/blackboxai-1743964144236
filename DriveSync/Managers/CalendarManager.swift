import EventKit
import Foundation

class CalendarManager {
    static let shared = CalendarManager()
    private let eventStore = EKEventStore()
    
    private init() {}
    
    func requestCalendarAccess(completion: @escaping (Bool) -> Void) {
        eventStore.requestAccess(to: .event) { granted, error in
            DispatchQueue.main.async {
                completion(granted)
            }
        }
    }
    
    func saveLessonToCalendar(lesson: Lesson) throws {
        guard EKEventStore.authorizationStatus(for: .event) == .authorized else {
            throw CalendarError.notAuthorized
        }
        
        let event = EKEvent(eventStore: eventStore)
        event.title = "Driving Lesson - \(lesson.lessonType)"
        event.startDate = lesson.startTime
        event.endDate = lesson.startTime.addingTimeInterval(Double(lesson.duration) * 3600)
        event.calendar = eventStore.defaultCalendarForNewEvents
        
        try eventStore.save(event, span: .thisEvent)
    }
    
    func removeLessonFromCalendar(lesson: Lesson) throws {
        guard EKEventStore.authorizationStatus(for: .event) == .authorized else {
            throw CalendarError.notAuthorized
        }
        
        let predicate = eventStore.predicateForEvents(
            withStart: lesson.startTime,
            end: lesson.startTime.addingTimeInterval(Double(lesson.duration) * 3600),
            calendars: nil
        )
        
        let events = eventStore.events(matching: predicate)
        for event in events {
            try eventStore.remove(event, span: .thisEvent)
        }
    }
    
    enum CalendarError: Error {
        case notAuthorized
        case eventNotFound
    }
}