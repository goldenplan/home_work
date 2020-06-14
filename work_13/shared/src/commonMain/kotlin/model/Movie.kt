package com.overinet.model

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

@Serializable
data class Movie(
    @SerialName("popularity")
    val popularity: Float,
    @SerialName("vote_count")
    val voteCount: Int,
    @SerialName("video")
    val video: Boolean,
    @SerialName("poster_path")
    val posterPath: String? = null,
    @SerialName("id")
    val id: Int,
    @SerialName("adult")
    val adult: Boolean,
    @SerialName("backdrop_path")
    val backdropPath: String? = null,
    @SerialName("original_language")
    val originalLanguage: String,
    @SerialName("original_title")
    val originalTitle: String,
    @SerialName("genre_ids")
    val genreIds: List<String>,
    @SerialName("title")
    val title: String,
    @SerialName("vote_average")
    val voteAverage: Float? = null,
    @SerialName("overview")
    val overview: String,
    @SerialName("release_date")
    val releaseDate: String? = null
)