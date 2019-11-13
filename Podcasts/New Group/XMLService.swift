//
//  XMLService.swift
//  Podcasts
//
//  Created by Joe Farrell on 12/11/18.
//  Copyright © 2018 Joe Farrell. All rights reserved.
//

import Foundation

class XMLService: NSObject, XMLParserDelegate {
    
    var xmlparser: XMLParser!
    var currentElement = ""
    var foundCharacters = ""
    var currentData = [String:String]()
    var parsedData = [[String:String]]()
    var isHeader = true
    
    /**
     Primary driver of the XMLService class. Initializes XMLParser object, sets delegate, and sets callback.
     - Parameters:
         - feedURL: URL of XML feed to be parsed
         - completion: callback function taking boolean returning void
    */
    func startParsingXML(feedURL: URL, completion: @escaping ((Bool) -> Void)) {
        xmlparser = XMLParser(contentsOf: feedURL)
        xmlparser?.delegate = self
        
        if let flag = xmlparser?.parse() {
            parsedData.append(currentData)
            completion(flag)
        }
    }
    
    // MARK: - XMLParserDelegate methods
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        currentElement = elementName
        
        if currentElement == "item" {
            if !isHeader {
                parsedData.append(currentData)
            }
            
            isHeader = false
        }
    }
    
    /**
     Internal XML parsing for (hopefully) standardized podcast RSS feeds.
     - Parameters:
        - parser: XMLParser object
        - string:
     
     - ToDo: Must strip out invalid tags because this is extraordinarily dangerous. Should also add safeguards to ensure this doesn't come crashing down as soon as someone screws up their stupidly handwritten RSS feed.
    */
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if !isHeader {
            if currentElement == "title" || currentElement == "link" || currentElement == "description" || currentElement == "description" || currentElement == "pubDate" || currentElement == "enclosure" || currentElement == "itunes:author" || currentElement == "itunes:subtitle" || currentElement == "itunes:duration" {
                foundCharacters += string
            }
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if !foundCharacters.isEmpty {
            foundCharacters = foundCharacters.trimmingCharacters(in: .whitespacesAndNewlines)
            currentData[currentElement] = foundCharacters
            foundCharacters = ""
        }
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        print("None")
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print("parseErrorOccurred: \(parseError)")
    }
    
}
