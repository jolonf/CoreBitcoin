import Foundation

public struct BlockMessage {
    /// Block version information (note, this is signed)
    public let version: Int32
    /// The hash value of the previous block this particular block references
    public let prevBlock: Data
    /// The reference to a Merkle tree collection which is a hash of all transactions related to this block
    public let merkleRoot: Data
    /// A Unix timestamp recording when this block was created (Currently limited to dates before the year 2106!)
    public let timestamp: UInt32
    /// The calculated difficulty target being used for this block
    public let bits: UInt32
    /// The nonce used to generate this block… to allow variations of the header and compute different hashes
    public let nonce: UInt32
    /// Number of transaction entries
    public let transactionCount: VarInt
    /// Block transactions, in format of "tx" command
    public let transactions: [Transaction]

    public func serialized() -> Data {
        var data = Data()
        data += version
        data += prevBlock
        data += merkleRoot
        data += timestamp
        data += bits
        data += nonce
        data += transactionCount.serialized()
        for transaction in transactions {
            data += transaction.serialized()
        }
        return data
    }

    public static func deserialize(_ data: Data) -> BlockMessage {
        let byteStream = ByteStream(data)
        return deserialize(byteStream)
    }

    static func deserialize(_ byteStream: ByteStream) -> BlockMessage {
        let version = byteStream.read(Int32.self)
        let prevBlock = byteStream.read(Data.self, count: 32)
        let merkleRoot = byteStream.read(Data.self, count: 32)
        let timestamp = byteStream.read(UInt32.self)
        let bits = byteStream.read(UInt32.self)
        let nonce = byteStream.read(UInt32.self)
        let transactionCount = byteStream.read(VarInt.self)
        var transactions = [Transaction]()
        for _ in 0..<transactionCount.underlyingValue {
            transactions.append(Transaction.deserialize(byteStream))
        }
        return BlockMessage(version: version, prevBlock: prevBlock, merkleRoot: merkleRoot, timestamp: timestamp, bits: bits, nonce: nonce, transactionCount: transactionCount, transactions: transactions)
    }

    public func computeMerkleRoot() -> Data {
        var hashes = transactions.map { (tx) -> Data in tx.txHash }

        while hashes.count > 1 {
            if hashes.count % 2 != 0 {
                let last = hashes.last!
                hashes.append(last)
            }

            for i in 0..<(hashes.count / 2) {
                let left = hashes[2 * i]
                let right = hashes[2 * i + 1]

                var parent = Data()
                parent.append(left)
                parent.append(right)

                hashes[i] = Crypto.sha256sha256(parent)
            }
            hashes = Array(hashes.prefix(upTo: hashes.count / 2))
        }

        return hashes[0]
    }
}
