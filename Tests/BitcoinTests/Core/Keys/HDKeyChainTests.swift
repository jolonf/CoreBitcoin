import XCTest
@testable import Bitcoin

class HDKeyChainTests: XCTestCase {
    func testHDKeychain() {
        let seed = Data(hex: "000102030405060708090a0b0c0d0e0f")!

        let keychain = HDKeychain(seed: seed, network: .mainnet)
        let privateKey = try! keychain.derivedKey(path: "m")

        XCTAssertEqual(privateKey.extendedPublicKey().extended(), "xpub661MyMwAqRbcFtXgS5sYJABqqG9YLmC4Q1Rdap9gSE8NqtwybGhePY2gZ29ESFjqJoCu1Rupje8YtGqsefD265TMg7usUDFdp6W1EGMcet8")
        XCTAssertEqual(privateKey.extended(), "xprv9s21ZrQH143K3QTDL4LXw2F7HEK3wJUD2nW2nRk4stbPy6cq3jPPqjiChkVvvNKmPGJxWUtg6LnF5kejMRNNU3TGtRBeJgk33yuGBxrMPHi")

        // m/0'
        let m0prv = try! keychain.derivedKey(path: "m/0'")
        XCTAssertEqual(m0prv.extendedPublicKey().extended(), "xpub68Gmy5EdvgibQVfPdqkBBCHxA5htiqg55crXYuXoQRKfDBFA1WEjWgP6LHhwBZeNK1VTsfTFUHCdrfp1bgwQ9xv5ski8PX9rL2dZXvgGDnw")
        XCTAssertEqual(m0prv.extended(), "xprv9uHRZZhk6KAJC1avXpDAp4MDc3sQKNxDiPvvkX8Br5ngLNv1TxvUxt4cV1rGL5hj6KCesnDYUhd7oWgT11eZG7XnxHrnYeSvkzY7d2bhkJ7")

        // m/0'/1
        let m01prv = try! keychain.derivedKey(path: "m/0'/1")
        XCTAssertEqual(m01prv.extendedPublicKey().extended(), "xpub6ASuArnXKPbfEwhqN6e3mwBcDTgzisQN1wXN9BJcM47sSikHjJf3UFHKkNAWbWMiGj7Wf5uMash7SyYq527Hqck2AxYysAA7xmALppuCkwQ")
        XCTAssertEqual(m01prv.extended(), "xprv9wTYmMFdV23N2TdNG573QoEsfRrWKQgWeibmLntzniatZvR9BmLnvSxqu53Kw1UmYPxLgboyZQaXwTCg8MSY3H2EU4pWcQDnRnrVA1xe8fs")

        // m/0'/1/2'
        let m012prv = try! keychain.derivedKey(path: "m/0'/1/2'")
        XCTAssertEqual(m012prv.extendedPublicKey().extended(), "xpub6D4BDPcP2GT577Vvch3R8wDkScZWzQzMMUm3PWbmWvVJrZwQY4VUNgqFJPMM3No2dFDFGTsxxpG5uJh7n7epu4trkrX7x7DogT5Uv6fcLW5")
        XCTAssertEqual(m012prv.extended(), "xprv9z4pot5VBttmtdRTWfWQmoH1taj2axGVzFqSb8C9xaxKymcFzXBDptWmT7FwuEzG3ryjH4ktypQSAewRiNMjANTtpgP4mLTj34bhnZX7UiM")

        // m/0'/1/2'/2
        let m0122prv = try! keychain.derivedKey(path: "m/0'/1/2'/2")
        XCTAssertEqual(m0122prv.extendedPublicKey().extended(), "xpub6FHa3pjLCk84BayeJxFW2SP4XRrFd1JYnxeLeU8EqN3vDfZmbqBqaGJAyiLjTAwm6ZLRQUMv1ZACTj37sR62cfN7fe5JnJ7dh8zL4fiyLHV")
        XCTAssertEqual(m0122prv.extended(), "xprvA2JDeKCSNNZky6uBCviVfJSKyQ1mDYahRjijr5idH2WwLsEd4Hsb2Tyh8RfQMuPh7f7RtyzTtdrbdqqsunu5Mm3wDvUAKRHSC34sJ7in334")
    }
}
