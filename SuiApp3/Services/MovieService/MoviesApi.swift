//
//  MoviesApi.swift
//  SuiApp3
//
//  Created by Александр Вяткин on 03.10.2021.
//

import Foundation
import Networking

open class MoviesAPI {

    /**
     Movie List
     
     - parameter apiKey: (query) API key
     - parameter page: (query) number of page (optional)
     - parameter apiResponseQueue: The queue on which api response is dispatched.
     - parameter completion: completion handler to receive the data and the error objects
     */
    public func getTrendingMovie(apiKey: String, page: Int? = nil, apiResponseQueue: DispatchQueue = OpenAPIClient.apiResponseQueue, completion: @escaping ((_ data: MovieList?, _ error: Error?) -> Void)) {
        getTrendingMovieWithRequestBuilder(apiKey: apiKey, page: page).execute(apiResponseQueue) { result -> Void in
            switch result {
            case let .success(response):
                completion(response.body, nil)
            case let .failure(error):
                completion(nil, error)
            }
        }
    }

    /**
     Movie List
     - GET /trending/movie/week
     - parameter apiKey: (query) API key
     - parameter page: (query) number of page (optional)
     - returns: RequestBuilder<MovieList>
     */
    private func getTrendingMovieWithRequestBuilder(apiKey: String, page: Int? = nil) -> RequestBuilder<MovieList> {
        let localVariablePath = "/trending/movie/week"
        let localVariableURLString = OpenAPIClient.basePath + localVariablePath
        let localVariableParameters: [String: Any]? = nil

        var localVariableUrlComponents = URLComponents(string: localVariableURLString)
        localVariableUrlComponents?.queryItems = APIHelper.mapValuesToQueryItems([
            "api_key": apiKey.encodeToJSON(),
            "page": page?.encodeToJSON(),
        ])

        let localVariableNillableHeaders: [String: Any?] = [
            :
        ]

        let localVariableHeaderParameters = APIHelper.rejectNilHeaders(localVariableNillableHeaders)

        let localVariableRequestBuilder: RequestBuilder<MovieList>.Type = OpenAPIClient.requestBuilderFactory.getBuilder()

        return localVariableRequestBuilder.init(method: "GET", URLString: (localVariableUrlComponents?.string ?? localVariableURLString), parameters: localVariableParameters, headers: localVariableHeaderParameters)
    }
}
