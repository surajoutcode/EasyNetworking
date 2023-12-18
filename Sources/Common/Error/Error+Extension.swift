import Foundation

public extension Error {
    func toDomainError() -> DomainError {
        switch (self as Error) {
        case DataTransferError.networkFailure(let networkError):
            switch networkError {
            case NetworkError.error(_, let data):
                if let errorData = data {
                    let errorMessage = String(data: errorData, encoding: .utf8) ?? ""
                    if errorMessage.lowercased().contains("invalid signature") {
                        return .userSessionExpired
                    } else {
                        return .error(String(data: errorData, encoding: .utf8) ?? "")
                    }
                }
                return networkError.toDomainError()
            default:
                return networkError.toDomainError()
            }
        case DataTransferError.resolvedNetworkFailure(let error):
            return error.toDomainError()
        case DataTransferError.parsing(let error):
            return error.toDomainError()
        case NetworkError.notConnected:
            return .noInternetConnection
        case NetworkError.cancelled:
            return .ignorable
        case NetworkError.genericMessage(let message):
            return .error(message)
        case NetworkError.generic(let error):
            return .error(error.localizedDescription)
        default:
            if let domainError = self as? DomainError {
                return domainError
            } else {
                return .contactCustomerSupport
            }
        }
    }
}

