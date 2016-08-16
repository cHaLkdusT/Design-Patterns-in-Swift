import Foundation

class Message {
    var to: String
    var subject: String
    
    init(to: String, subject: String) {
        self.to = to
        self.subject = subject
    }
}

class DetailedMessage: Message {
    var from: String
    
    init(to: String, subject: String, from: String) {
        self.from = from
        super.init(to: to, subject: subject)
    }
}

class MessageLogger {
    var messages = [Message]()
    
    func logMessage(msg: Message) {
        if let detailed = msg as? DetailedMessage {
            messages.append(DetailedMessage(to: detailed.to, subject: detailed.subject, from: detailed.from))
        } else {
            messages.append(Message(to: msg.to, subject: msg.subject))
        }
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

logger.logMessage(DetailedMessage(to: "Alice", subject: "Hi!", from: "Joe"))

logger.processMessages { (msg) in
    if let detailed = msg as? DetailedMessage {
        print("Detailed Message - To: \(detailed.to) From: \(detailed.from)"
        + " Subject: \(detailed.subject)")
    } else {
        print("Message - To: \(msg.to) Subject: \(msg.subject)")
    }
}