package com.overinet

expect fun platformName(): String

class Greeting {

    fun greeting(): String = "Hello, ${platformName()}"
}
