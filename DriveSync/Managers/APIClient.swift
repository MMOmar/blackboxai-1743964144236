import Foundation

class APIClient {
    
    static let shared = APIClient()
    
    private init() {}
    
    func sendSMS(to phoneNumber: String, message: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = URL(string: "https://api.twilio.com/2010-04-01/Accounts/YOUR_ACCOUNT_SID/Messages.json")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let parameters = [
            "To": phoneNumber,
            "From": "YOUR_TWILIO_PHONE_NUMBER",
            "Body": message
        ]
        
        request.httpBody = parameters.map { "\($0.key)=\($0.value)" }.joined(separator: "&").data(using: .utf8)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue("Basic \(base64Credentials())", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            completion(.success(()))
        }
        task.resume()
    }
    
    private func base64Credentials() -> String {
        let credentials = "YOUR_ACCOUNT_SID:YOUR_AUTH_TOKEN"
        return Data(credentials.utf8).base64EncodedString()
    }
    
    func sendEmail(to email: String, subject: String, body: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = URL(string: "https://api.sendgrid.com/v3/mail/send")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let emailData: [String: Any] = [
            "personalizations": [[
                "to": [[ "email": email ]]
            ]],
            "subject": subject,
            "content": [[
                "type": "text/plain",
                "value": body
            ]]
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: emailData, options: [])
        request.setValue("Bearer YOUR_SENDGRID_API_KEY", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            completion(.success(()))
        }
        task.resume()
    }
}