import Foundation
import SnapKit

class MainScreenModel {
    
    func processDate(string: String, fromFormat: String = "ddMMyyyy", toFormat: String = "dd MMMM yyyy") -> String? {
        let formatter = DateFormatter()

        formatter.dateFormat = fromFormat
        guard let date = formatter.date(from: string) else { return nil }

        formatter.dateFormat = toFormat
        return formatter.string(from: date)
    }
}

extension CGFloat {
    func toRadians() -> CGFloat {
        return self * CGFloat(Double.pi) / 5
    }
}
