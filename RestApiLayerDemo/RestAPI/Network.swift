import Moya
import RxSwift

protocol RequestSpecification: TargetType {
    associatedtype ModelDTO: Codable
    
    var absoluteURLString: String { get }
}

protocol Network {
    
    func request<Spec: RequestSpecification>(specification: Spec) -> Single<Spec.ModelDTO>
}

struct DefaultNetwork: Network {
    
    func request<Spec: RequestSpecification>(specification: Spec) -> Single<Spec.ModelDTO> {
        let provider: MoyaProvider<Spec> = makeProvider()
        
        return provider.rx.request(specification).map(Spec.ModelDTO.self)
    }
    
    private func makeProvider<Spec: RequestSpecification>() -> MoyaProvider<Spec> {
        return MoyaProvider<Spec>(endpointClosure: makeEndpoint, plugins: [NetworkLoggerPlugin()])
    }
    
    private func makeEndpoint<Spec: RequestSpecification>(for specification: Spec) -> Endpoint {
        return Endpoint(url: specification.absoluteURLString,
                        sampleResponseClosure: { .networkResponse(200, specification.sampleData) },
                        method: specification.method,
                        task: specification.task,
                        httpHeaderFields: specification.headers)
    }
}
