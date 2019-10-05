import Moya
import RxSwift

protocol RequestSpecification: TargetType {
    associatedtype ModelDTO: Codable
    
    var absoluteURLString: String { get }
}

protocol Network {
    
    func request<Spec: RequestSpecification>(specification: Spec) -> Single<Spec.ModelDTO>
}

class DefaultNetwork: Network {
    
    func request<Spec: RequestSpecification>(specification: Spec) -> Single<Spec.ModelDTO> {
        let provider: MoyaProvider<Spec> = createProvider()
        
        return provider.rx.request(specification).map(Spec.ModelDTO.self)
    }
    
    private func createProvider<Spec: RequestSpecification>() -> MoyaProvider<Spec> {
        return MoyaProvider<Spec>(endpointClosure: { target in
            return Endpoint(url: target.absoluteURLString,
                            sampleResponseClosure: { .networkResponse(200, target.sampleData) },
                            method: target.method,
                            task: target.task,
                            httpHeaderFields: target.headers)
        }, plugins: [NetworkLoggerPlugin()])
    }
}
