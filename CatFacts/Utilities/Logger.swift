import os

func log(_ errorMessage: String,
         fileName: String = #file,
         lineNumber: Int = #line,
         columnNumber: Int = #column) {
    let logger = Logger()
    logger.log(
        """
        Error: \(errorMessage)
        File Name: \(fileName)
        Line Number: \(lineNumber)
        Column Number: \(columnNumber)
        """
    )
}
