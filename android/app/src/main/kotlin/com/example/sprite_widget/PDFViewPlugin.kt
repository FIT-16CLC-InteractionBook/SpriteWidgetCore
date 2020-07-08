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
                doAsync {
                    try {
                        val input: InputStream = URL("https://ncu.rcnpv.com.tw/Uploads/20131231103232738561744.pdf").openStream()
                        pdfView.fromStream(input).load()
                    } catch (e: IOException) {
                        e.printStackTrace()
                    }
                }.execute()
//                  pdfChildView
//                pdfChildView.rootView.pdfViewPublish.pdfUrl = call.arguments
            }
            "changePage" -> {
//                let nextPage = PDFChildView.rootView.pdfViewPublish.pdfView?.document?.page(at: call.arguments as! Int);
//                PDFChildView.rootView.pdfViewPublish.pdfView?.go(to: nextPage!);
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