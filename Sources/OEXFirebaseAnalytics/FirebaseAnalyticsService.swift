//
//  FirebaseAnalyticsService.swift
//  OpenEdX
//
//  Created by Anton Yarmolenka on 19/02/2024.
//

import Foundation
import OEXFoundation
import FirebaseAnalytics

private let MaxParameterValueCharacters = 100
private let MaxNameValueCharacters = 40

final public class FirebaseAnalyticsService: AnalyticsService {
    
    public init() {}

    public func identify(id: String, username: String?, email: String?) {
        Analytics.setUserID(id)
    }
    
    public func logEvent(_ event: String, parameters: [String: Any]?) {
        guard let name = try? formatFirebaseName(event) else {
            debugLog("Firebase: event name is not supported: \(event)")
            return
        }
        
        Analytics.logEvent(name, parameters: formatParamaters(params: parameters))
    }
    
    public func logScreenEvent(_ event: String, parameters: [String: Any]?) {
        logEvent(event, parameters: parameters)
    }
}

public extension FirebaseAnalyticsService {
    private func formatParamaters(params: [String: Any]?) -> [String: Any] {
        // Firebase only supports String or Number as value for event parameters
        var formattedParams: [String: Any] = [:]
        
        for (key, value) in params ?? [:] {
            if let key = try? formatFirebaseName(key) {
                formattedParams[key] = formatParamValue(value: value)
            }
        }
        
        return formattedParams
    }
    
    private func formatFirebaseName(_ eventName: String) throws -> String {
        let trimmed = eventName.trimmingCharacters(in: .whitespaces)
        do {
            let regex = try NSRegularExpression(pattern: "([^a-zA-Z0-9_])", options: .caseInsensitive)
            let formattedString = regex.stringByReplacingMatches(
                in: trimmed,
                options: .reportProgress,
                range: NSRange(location: 0, length: trimmed.count),
                withTemplate: "_"
            )
            
            // Resize the string to maximum 40 characters if needed
            let range = NSRange(location: 0, length: min(formattedString.count, MaxNameValueCharacters))
            var formattedName = NSString(string: formattedString).substring(with: range)
            
            while formattedName.contains("__") {
                formattedName = formattedName.replace(string: "__", replacement: "_")
            }
            
            return formattedName
            
        } catch {
            debugLog("Could not parse event name for Firebase.")
            throw(error)
        }
    }
    
    private func formatParamValue(value: Any?) -> Any? {
        
        guard var formattedValue = value as? String else { return value}
        
        // Firebase only supports 100 characters for parameter value
        if formattedValue.count > MaxParameterValueCharacters {
            let index = formattedValue.index(formattedValue.startIndex, offsetBy: MaxParameterValueCharacters)
            formattedValue = String(formattedValue[..<index])
        }
        
        return formattedValue
    }
}

public extension String {
    func replace(string: String, replacement: String) -> String {
        return replacingOccurrences(of: string, with: replacement, options: NSString.CompareOptions.literal, range: nil)
    }
}
