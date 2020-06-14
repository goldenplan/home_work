package com.overinet.presenters

import com.overinet.dispachers.AppDispatchers
import com.overinet.model.Movie
import com.overinet.network.MovieApiClientImpl
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Job
import kotlinx.coroutines.async
import kotlinx.coroutines.launch
import kotlinx.serialization.UnstableDefault
import kotlin.coroutines.CoroutineContext

@UnstableDefault
class MoviePresentation(private val dispatchers: AppDispatchers) :
    CoroutineScope {
    private val dispatcher = dispatchers
    private val job = Job()

    override val coroutineContext: CoroutineContext
        get() = dispatcher.main + job

    val movieApiClient = MovieApiClientImpl(dispatchers)

    fun searchMoviesWithoutTimeout(frase:String, handler: (List<Movie>) -> Unit) {
        launch(dispatchers.main) {
            val response = movieApiClient.searchMovieWithoutTimeout(frase)
            handler.invoke(response.results)
        }
    }

    fun fetchMoviesWithoutTimeout(handler: (List<Movie>) -> Unit) {
        launch(dispatchers.main) {
            val response = movieApiClient.fetchMovieWithoutTimeout()
            handler.invoke(response.results)
        }
    }

    fun fetchUsersAsyncWithoutTimeout(handler: (List<Movie>) -> Unit) {
        launch(dispatchers.main) {
            val responce = async { movieApiClient.fetchMovieWithoutTimeout() }
            handler.invoke(responce.await().results)
        }
    }


    fun fetchUsersWithTimeOut(timeoutInMillis: Long, handler: (List<Movie>) -> Unit) {
        launch(dispatchers.main) {
            val response = movieApiClient.fetchMovieWithTimeout(timeoutInMillis)
            handler.invoke(response.results)
        }
    }


    fun fetchUsersAsyncWithTimeOut(timeoutInMillis: Long, handler: (List<Movie>) -> Unit) {
        launch(dispatchers.main) {
            val response = async(dispatchers.main) { movieApiClient.fetchMovieWithTimeout(timeoutInMillis) }
            handler.invoke(response.await().results)
        }
    }
}