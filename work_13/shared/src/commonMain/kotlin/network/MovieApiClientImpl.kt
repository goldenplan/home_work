package com.overinet.network

import com.overinet.MOVIE_LIST_BASE_PATH
import com.overinet.MOVIE_SEARCH_BASE_PATH
import com.overinet.dispachers.AppDispatchers
import com.overinet.model.Movie
import com.overinet.model.MoviesResponse
import io.ktor.client.request.get
import kotlinx.serialization.UnstableDefault

@UnstableDefault
class MovieApiClientImpl(dispatchers: AppDispatchers) : ApiClient(dispatchers), MovieApiClient {
    override suspend fun searchMovieWithoutTimeout(frase: String): MoviesResponse {
        val url = MOVIE_SEARCH_BASE_PATH + "&query=$frase"
        return onNetworkWithoutTimeOut(url) {
            httpClient(true).get<MoviesResponse>(url)
        }
    }

    override suspend fun fetchMovieWithoutTimeout(): MoviesResponse {
        return onNetworkWithoutTimeOut(MOVIE_LIST_BASE_PATH) {
            httpClient(true).get<MoviesResponse>(MOVIE_LIST_BASE_PATH)
        }
    }

    override suspend fun fetchMovieWithTimeout(timeoutInMillis: Long): MoviesResponse {
        return onNetworkWithTimeOut(MOVIE_LIST_BASE_PATH, timeoutInMillis) {
            httpClient(true).get<MoviesResponse>(MOVIE_LIST_BASE_PATH)
        }
    }

}