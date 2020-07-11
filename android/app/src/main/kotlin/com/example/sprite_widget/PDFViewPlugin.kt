package com.example.sprite_widget

import android.annotation.SuppressLint
import android.content.Context
import android.net.Uri
import android.os.AsyncTask
import com.github.barteksc.pdfviewer.PDFView
import io.flutter.Log
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.platform.PlatformView
import java.io.File
import java.io.IOException
import java.io.InputStream
import java.net.URL


class PDFViewPlugin internal constructor(
        private val context: Context,
        private val methodChannel: MethodChannel,
        private val id: Int,
        private val args: Any?) : PlatformView, MethodChannel.MethodCallHandler {

    private var pdfView: PDFView = PDFView(context, null)


    init {
        this.methodChannel.setMethodCallHandler(this)
    }

    override  fun onMethodCall(methodCall: MethodCall,
                     result: MethodChannel.Result) {
        when (methodCall.method) {
            "initializePDF" -> {
                var pdfFile = new File(methodCall.arguments as String);
                pdfView.fromFile(pdfFile).swipeHorizontal(true).autoSpacing(true).load()
//                doAsync {
//                    try {
//                        const pdfFile = new File(methodCall.arguments as String);
//                        pdfView.fromFile(pdfFile).swipeHorizontal(true).autoSpacing(true).load()
//                    } catch (e: IOException) {
//                        e.printStackTrace()
//                    }
//                }.execute()
//                  pdfChildView
//                pdfChildView.rootView.pdfViewPublish.pdfUrl = call.arguments
            }
            "changePage" -> {
                pdfView.jumpTo(methodCall.arguments as Int, true);
            }
            else -> result.notImplemented()
        }
    }

    override fun getView(): PDFView {
        Log.i("cac2", this.pdfView.pageCount.toString())
        return this.pdfView
    }

    override fun dispose() {
        TODO("Not yet implemented")
    }
}

class doAsync(val handler: () -> Unit) : AsyncTask<Void, Void, Void>() {
    override fun doInBackground(vararg params: Void?): Void? {
        handler()
        return null
    }
}