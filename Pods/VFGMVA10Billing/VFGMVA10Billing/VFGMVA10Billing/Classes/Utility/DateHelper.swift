//
//  Helper.swift
//  VFGMVA10Group
//
//  Created by Samet MACİT on 6.12.2019.
//  Copyright © 2019 Vodafone. All rights reserved.
//

import Foundation

public class DateHelper {
    public static func getDateIntervalFromISO8601Date(startDate: String,
                                                      endDate: String,
                                                      dateFormatString: String =
                                                        "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ",
                                                      format: String = "dd MMM") -> String {
        guard let start = changeDateStringFormat(dateString: startDate,
                                                 format: format,
                                                 dateFormatString: dateFormatString) else { return "" }
        guard let end = changeDateStringFormat(dateString: endDate,
                                               format: format,
                                               dateFormatString: dateFormatString) else { return "- \(start)" }
        return "\(start) - \(end)"
    }

    public static func getDayFromISO8601Date(dateString: String,
                                             dateFormatString: String = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ") -> String {
        guard let date = changeDateStringFormat(dateString: dateString,
                                                format: "dd",
                                                dateFormatString: dateFormatString) else { return "" }
        return date
    }

    public static func getMonthFromISO8601Date(dateString: String,
                                               dateFormatString: String = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ") -> String {
        guard let date = changeDateStringFormat(dateString: dateString,
                                                format: "MMMM",
                                                dateFormatString: dateFormatString) else { return "" }
        return date
    }

    public static func getMonthShortNameFromISO8601Date(dateString: String,
                                                        dateFormatString: String =
        "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ") -> String {
        guard let date = changeDateStringFormat(dateString: dateString,
                                                format: "MMM",
                                                dateFormatString: dateFormatString) else { return "" }
        return date
    }

    public static func getMonthIdFromISO8601Date(dateString: String,
                                                 dateFormatString: String = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ") -> Int {
        guard let date = changeDateStringFormat(dateString: dateString,
                                                format: "MM",
                                                dateFormatString: dateFormatString) else { return 0 }
        return Int(date) ?? 0
    }

    public static func getYearFromISO8601Date(dateString: String,
                                              dateFormatString: String = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ") -> String {
        guard let date = changeDateStringFormat(dateString: dateString,
                                                format: "yyyy",
                                                dateFormatString: dateFormatString) else { return "" }
        return date
    }

    public static func getDayWithSuffixFromISO8601Date(dateString: String,
                                                       dateFormatString: String =
        "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormatString
        guard let date = dateFormatter.date(from: dateString) else {
            return ""
        }
        guard let dateString = changeDateStringFormat(dateString: dateString,
                                                      format: "dd",
                                                      dateFormatString: dateFormatString) else { return "" }
        return "\(dateString)\(daySuffix(date: date))"
    }

    public static func getFormattedDate(paymentDate: String,
                                        dateFormatString: String,
                                        localizedKey: String) -> String {
        let day = DateHelper.getDayFromISO8601Date(dateString: paymentDate,
                                                   dateFormatString: dateFormatString)
        let month = DateHelper.getMonthIdFromISO8601Date(dateString: paymentDate,
                                                         dateFormatString: dateFormatString)
        let year = DateHelper.getYearFromISO8601Date(dateString: paymentDate,
                                                     dateFormatString: dateFormatString)
        let twoDigitYear = (Int(year) ?? 0)%100
        let localized = localizedKey.localized(bundle: Bundle.mva10Billing)

        return String(format: localized, "\(day)"+"/"+"\(month)"+"/"+"\(twoDigitYear)")
    }

    public static func daySuffix(date: Date) -> String {
        let calendar = Calendar.current
        let components = (calendar as NSCalendar).components(.day, from: date)
        let dayOfMonth = components.day
        switch dayOfMonth {
        case 1, 21, 31:
            return "st"
        case 2, 22:
            return "nd"
        case 3, 23:
            return "rd"
        default:
            return "th"
        }
    }

    public static func changeDateStringFormat(dateString: String,
                                              format: String,
                                              dateFormatString: String = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ") -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormatString
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = format
            return dateFormatter.string(from: date)
        }
        return nil
    }

    public static func getStringFromDate(date: Date, dateFormat: String = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        return formatter.string(from: date)
    }

    public static func getDateFromString(dateString: String,
                                         format: String = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        if let date = dateFormatter.date(from: dateString) {
            return date
        }
        return nil
    }
}
