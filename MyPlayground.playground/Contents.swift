import UIKit

class Trie {
    
    struct TrieNode {
        var nodes: [String: TrieNode] = [:]
        var isEnd = false
        func get(char ch: String) -> TrieNode? { nodes[ch] }
        func found(char ch: String) -> Bool { nodes[ch] != nil }
        mutating func add(char ch: String) { nodes[ch] = TrieNode() }
    }
    var root: TrieNode
    init() {
        root = TrieNode()
    }
    
    func insert(_ word: String) {
        var temp = root
        for index in (0 ..< word.count) {
            let ch = word[1]
            if(!temp.found(char: word[index])) { temp.add(char: word[index]) }
            if let node = temp.get(char: word[index]) { temp = node }
        }
        temp.isEnd = true
    }
    
    func search(_ word: String) -> Bool {
        var temp = root
        for index in (0 ..< word.count) {
            let ch = word[index]
            if(!temp.found(char: ch)) { return false }
        }
        return temp.isEnd
    }
    
    func startsWith(_ word: String) -> Bool {
        var temp = root
        for index in (0 ..< word.count) {
            let ch = word[index]
            if(!temp.found(char: ch)) { return false }
        }
        return true
    }
    
    
}

extension String {
    subscript (_ index: Int) -> String {
        return String(Array(self)[index])
    }
}
