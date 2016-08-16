import Foundation

class Message {
    var to: String
    var subject: String
    
    init(to: String, subject: String) {
        self.to = to
        self.subject = subject
    }
}

class MessageLogger {
    var messages = [Message]()
    
    func logMessage(msg: Message) {
        messages.append(msg)
    }
    
    func processMessages(callback: Message -> Void) {
        for msg in messages {
            callback(msg)
        }
    }
}

var logger = MessageLogger()

var message = Message(to: "Joe", subject: "Hello")
logger.logMessage(message)

message.to = "Bob"
message.subject = "Free for dinner?"
logger.logMessage(message)

logger.processMessages { (msg) in
    print("Message - To: \(msg.to) Subject: \(msg.subject)")
}
