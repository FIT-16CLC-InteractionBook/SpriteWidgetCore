package com.example.sprite_widget

import android.os.Bundle
import android.util.Log
import io.flutter.app.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
//        GeneratedPluginRegistrant.registerWith(this)
        val registrar = this.registrarFor("pdfview")
        val viewFactory = PDFViewFactory(messenger = registrar.messenger())
        registrar.platformViewRegistry().registerViewFactory("pdfview", viewFactory)
    }
}