package com.overinet.work_13

import android.os.Bundle
import android.util.Log
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Button
import android.widget.TextView
import androidx.navigation.fragment.findNavController
import com.overinet.Greeting
import com.overinet.dispachers.AppDispatchersImpl
import com.overinet.network.MovieApiClient
import com.overinet.presenters.MoviePresentation

/**
 * A simple [Fragment] subclass as the default destination in the navigation.
 */
class FirstFragment : Fragment() {

    override fun onCreateView(
            inflater: LayoutInflater, container: ViewGroup?,
            savedInstanceState: Bundle?
    ): View? {
        // Inflate the layout for this fragment
        return inflater.inflate(R.layout.fragment_first, container, false)
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        view.findViewById<Button>(R.id.button_first).setOnClickListener {

            val dispatchers = AppDispatchersImpl()
            val api = MoviePresentation(dispatchers)

            api.searchMoviesWithoutTimeout("123"){
                it.forEach({
                    Log.d("---->", it.title)
                })
            }

//            api.fetchMoviesWithoutTimeout {
//                it.forEach({
//                    Log.d("---->", it.title)
//                })
//            }

//            movieApi.searchFilm("123",{
//
//                it.forEach({
//                    Log.d("---->", it.title)
//                })
//            })
//
//            movieApi.getFilms {
//                Log.d("---->", it.count().toString())
//            }

//            findNavController().navigate(R.id.action_FirstFragment_to_SecondFragment)
        }

        view.findViewById<TextView>(R.id.textview_first).text = Greeting().greeting()
    }
}