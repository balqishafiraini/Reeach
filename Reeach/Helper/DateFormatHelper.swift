//
//  DateFormatHelper.swift
//  Reeach
//
//  Created by William Chrisandy on 06/10/22.
//

import Foundation

class DateFormatHelper {
    static func createDurationString(_ duration: Double) -> String {
        let hour = Int(duration/3600)
        let minute = Int(duration/60) % 60
        var durationString = ""
        if(hour > 0) {
            durationString += "\(hour)h "
        }
        if(minute > 0) {
            durationString += "\(minute)m"
        }
        
        return durationString
    }
    
    static func getPartOfDayString(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH"
        let hour = dateFormatter.string(from: date)
        if hour <= "06" {
            return "Night"
        }
        else if hour <= "12" {
            return "Morning"
        }
        else if hour <= "18" {
            return "Afternoon"
        }
        else if hour <= "22" {
            return "Evening"
        }
        else {
            return "Night"
        }
    }
    
    static func getHHmmss(from totalSecond: Int) -> String {
        let hour = totalSecond / 3600
        let minute = (totalSecond % 3600) / 60
        let second = totalSecond % 60
        
        return String(format: "%.2d:%.2d:%.2d", hour, minute, second)
    }
    
    static func getHHmm(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH.mm"
        return dateFormatter.string(from:date)
    }
    
    static func getHourString(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "H"
        return dateFormatter.string(from: date)
    }
    
    static func getNameOfDay(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from:date)
    }
    
    static func getDayOfMonth(from date: Date) -> Int {
        let format = DateFormatter()
        format.dateFormat = "dd"
        return Int(format.string(from: date)) ?? 0
    }
    
    static func getMonth(from date: Date) -> Int {
        let format = DateFormatter()
        format.dateFormat = "MM"
        return Int(format.string(from: date)) ?? 0
    }
    
    static func getYear(from date: Date) -> Int {
        let format = DateFormatter()
        format.dateFormat = "yyyy"
        return Int(format.string(from: date)) ?? 0
    }
    
    static func getDayAndMonthString(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd"
        return dateFormatter.string(from:date)
    }
    
    static func getLongString(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter.string(from: date)
    }
    
    static func getFullString(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
    
    static func getyyyyMMdd(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    }
    
    static func getStartDate(of date: Date) -> Date {
        let calendar = Calendar.current
        return calendar.startOfDay(for: date)
    }
    
    static func dateDifferences(between olderDate: Date, and newerDate: Date) -> Int {
        let calendar = Calendar.current

        let date1 = getStartDate(of: olderDate)
        let date2 = getStartDate(of: newerDate)

        let components = calendar.dateComponents([.day], from: date1, to: date2)

        return components.day ?? 0
        
        /*
         let dayOfOlderDate = getDayOfMonth(from: olderDate)
         let monthOfOlderDate = getMonth(from: olderDate)
         let yearOfOlderDate = getYear(from: olderDate)
         
         let dayOfNewerDate = getDayOfMonth(from: newerDate)
         let monthOfNewerDate = getMonth(from: newerDate)
         let yearOfNewerDate = getYear(from: newerDate)
         
         var result: Int = yearOfNewerDate - yearOfOlderDate + 1
         
         if (monthOfNewerDate > monthOfOlderDate || (monthOfNewerDate == monthOfOlderDate && dayOfNewerDate > dayOfOlderDate)) {
             result -= 1
         }
         
         return result
         */
    }
    
    static func getMinuteDifferences(between startDate: Date, and endDate: Date) -> Int {
        return Int(endDate.timeIntervalSince1970 - startDate.timeIntervalSince1970) + 1
    }
}