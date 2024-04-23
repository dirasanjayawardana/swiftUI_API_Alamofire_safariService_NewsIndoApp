//
//  DateUtility.swift
//  NewsIndo
//
//  Created by MACBOOK PRO on 23/04/24.
//

import Foundation

struct DateUtility {
    
    static func formatDateToRelativeString(dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.locale = Locale(identifier: "id_ID") // Menetapkan locale untuk memastikan format diterapkan secara konsisten
        dateFormatter.timeZone = TimeZone.current // Menetapkan zona waktu saat ini

        guard let date = dateFormatter.date(from: dateString) else {
            return "Invalid date" // Mengembalikan pesan kesalahan jika konversi gagal
        }

        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .short // Menggunakan gaya singkat untuk unit waktu
        let relativeDate = formatter.localizedString(for: date, relativeTo: Date())
        
        return relativeDate
    }
    
}
