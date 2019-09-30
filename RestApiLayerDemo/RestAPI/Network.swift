import Moya
import Result
import RxSwift

protocol Network {
    
    func request<T: TargetType>(target: T) -> Single<Response>
}

class DefaultNetwork: Network {
    
    func request<T: TargetType>(target: T) -> Single<Response> {
        let provider: MoyaProvider<T> = createProvider()
        
        return provider.rx.request(target)
    }
    
    private func createProvider<T: TargetType>() -> MoyaProvider<T> {
        return MoyaProvider<T>(endpointClosure: { target in
            return Endpoint(url:  target.url,
                            sampleResponseClosure: { .networkResponse(200, target.sampleData) },
                            method: target.method,
                            task: target.task,
                            httpHeaderFields: target.headers)
        }, plugins: [NetworkLoggerPlugin(verbose: true, cURL: true)])
    }
}
