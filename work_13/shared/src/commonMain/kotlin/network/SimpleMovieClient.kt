package com.overinet.network

import com.overinet.MOVIE_LIST_BASE_PATH
import com.overinet.MOVIE_SEARCH_BASE_PATH
import com.overinet.model.Movie
import com.overinet.model.MoviesResponse
import io.ktor.client.HttpClient
import io.ktor.client.request.get
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch
import kotlinx.serialization.json.Json
import kotlinx.serialization.json.JsonConfiguration


class SimpleMovieClient{

    companion object{
        var parserConfig = JsonConfiguration(ignoreUnknownKeys = true, isLenient = true)
        val client = HttpClient()
    }

    fun searchFilm(query: String, callback: (List<Movie>) -> Unit) {

        GlobalScope.launch(Dispatchers.Default) {
            val data = client.get<String>(MOVIE_SEARCH_BASE_PATH + "&query=$query")

            val moviesResponse = Json(parserConfig).fromJson(MoviesResponse.serializer(), Json(parserConfig).parseJson(data))

            callback(moviesResponse.results)
        }

    }

    fun getFilms(callback: (List<Movie>) -> Unit)  {


        GlobalScope.launch(Dispatchers.Default) {
            val data = client.get<String>(MOVIE_LIST_BASE_PATH)

            val moviesResponse = Json(parserConfig).fromJson(MoviesResponse.serializer(), Json(parserConfig).parseJson(data))

            callback(moviesResponse.results)
        }
    }
}
