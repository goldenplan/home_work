package com.overinet.network

import com.overinet.model.MoviesResponse

interface MovieApiClient {
    suspend fun searchMovieWithoutTimeout(frase: String): MoviesResponse
    suspend fun fetchMovieWithoutTimeout(): MoviesResponse
    suspend fun fetchMovieWithTimeout(timeoutInMillis: Long = 10 * 1000): MoviesResponse
}