import Foundation

/// The pong message is sent in response to a ping message.
/// In modern protocol versions, a pong response is generated using a nonce included in the ping.
public struct PongMessage {
    /// nonce from ping
    public let nonce: UInt64

    public func serialized() -> Data {
        var data = Data()
        data += nonce
        return data
    }
}
