package com.example.demo

import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.EventChannel
import java.util.logging.StreamHandler

class MainActivity: FlutterActivity() {
  private val CHANNEL = "stop.watch.channel"
  private val EVENT_CHANNEL = "stop.watch.event.channel"

  override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
    super.configureFlutterEngine(flutterEngine)

    EventChannel(flutterEngine.dartExecutor.binaryMessenger, EVENT_CHANNEL).setStreamHandler(object: EventChannel.StreamHandler, StreamHandler() {
      override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
          events?.success(5)
      }

      override fun onCancel(arguments: Any?) {
      }
  })
  
    MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
      call, result ->
      if (call.method=="startTimer"){
        val timer = getTimerValue()
        result.success(timer)
        }else if(call.method=="resetTimer"){
          timerInitial = 0
          result.success(timerInitial)
        }
    }
  }
private fun getTimerValue(): Int {
    timerInitial = timerInitial + 1
    return timerInitial
  }

 /* private fun onListenTimer(events : EventChannel.EventSink?) {
    val timer = object: CountDownTimer(20000, 1000) {
      override fun onTick(millisUntilFinished: Long) {
        events?.success(millisUntilFinished)
      }

      override fun onFinish() {}
    }
    timer.start()
  }*/
}
