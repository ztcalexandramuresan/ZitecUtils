//
//  Logger.swift
//  
//
//  Created by alexandra.muresan on 21.06.2023.
//

import Foundation
import CocoaLumberjackSwift

final class Logger {

    // MARK: - Public properties

    static let shared = Logger()

    // MARK: - Private properties

    private let fileLogger = DDFileLogger()
    private var logFileDataArray: [Data] {
        let logFilePaths = fileLogger.logFileManager.sortedLogFilePaths
        var logFileDataArray = [Data]()
        for logFilePath in logFilePaths {
            let fileURL = URL(fileURLWithPath: logFilePath)
            if let logFileData = try? Data(contentsOf: fileURL, options: .mappedIfSafe) {
                // Insert at front to reverse the order, so that oldest logs appear first.
                logFileDataArray.insert(logFileData, at: 0)
            }
        }
        return logFileDataArray
    }

    // MARK: - Lifecycle

    private init() {
        setupLogger()
    }

    private func setupLogger() {
        DDLog.add(DDOSLogger.sharedInstance)

        fileLogger.rollingFrequency = 60 * 60 * 24 // 24 hours
        fileLogger.logFileManager.maximumNumberOfLogFiles = 7
        DDLog.add(fileLogger)

        DDLogDebug("---- LOGGING STARTED -----")
        DDLogInfo("App Version: \(Bundle.main.releaseVersionNumber ?? "") (\(Bundle.main.buildVersionNumber ?? ""))")
    }

    func logInfo(_ message: String) {
        DDLogInfo(message)
    }

    func logWarning(_ message: String) {
        DDLogWarn(message)
    }

    func logError(_ message: String) {
        DDLogError(message)
    }

    func logAttachmentData() -> Data {
        DDLog.flushLog()
        var data = Data()

        logFileDataArray.forEach { dataFile in
            data.append(dataFile)
        }
        return data
    }
}
