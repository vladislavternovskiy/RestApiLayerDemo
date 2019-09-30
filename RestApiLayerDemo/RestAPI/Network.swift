import Moya
import Result

protocol Network {
    
    func request(target: RestAPI) -> Single<Response>
}

class DefaultNetwork: Network {
    
    var provider = MoyaProvider<RestAPI>(endpointClosure: { target in
        return Endpoint(url: target.url,
                        sampleResponseClosure: { .networkResponse(200, target.sampleData) },
                        method: target.method,
                        task: target.task,
                        httpHeaderFields: target.headers)
    }, plugins: [NetworkLoggerPlugin(verbose: true, cURL: true)])
}

extension DefaultNetwork {
    
    func request(target: RestAPI) -> Single<Response> {
        return provider.rx.request(target)
    }
}

