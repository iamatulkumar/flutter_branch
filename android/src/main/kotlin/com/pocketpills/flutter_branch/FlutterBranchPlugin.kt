package com.pocketpills.flutter_branch

import com.pocketpills.flutter_branch.src.*
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar

const val DEBUG_NAME = "FlutterBranchIo"
const val INTENT_EXTRA_DATA = "DATA"

class FlutterBranchPlugin(private var registrar: Registrar): MethodCallHandler {

  companion object {
    private const val MESSAGE_CHANNEL: String = "flutter_branch_io/message"
    private const val EVENT_CHANNEL: String = "flutter_branch_io/event"
    private const val GENERATED_LINK_CHANNEL: String = "flutter_branch_io/generated_link"

    private var generatedLinkStreamHandler: GeneratedLinkStreamHandler? = null
    private var deepLinkStreamHandler: DeepLinkStreamHandler? = null

    private lateinit var eventChannel: EventChannel
    private lateinit var generatedLinkChannel: EventChannel

    @JvmStatic
    fun registerWith(registrar: Registrar) {
      if (registrar.activity() == null) return

      val instance = FlutterBranchPlugin(registrar)

      val messageChannel = MethodChannel(registrar.messenger(), MESSAGE_CHANNEL)
      messageChannel.setMethodCallHandler(instance)

      eventChannel = EventChannel(registrar.messenger(), EVENT_CHANNEL)
      this.deepLinkStreamHandler = this.deepLinkStreamHandler ?: DeepLinkStreamHandler()
      eventChannel.setStreamHandler(this.deepLinkStreamHandler)

      generatedLinkChannel = EventChannel(registrar.messenger(), GENERATED_LINK_CHANNEL)
      this.generatedLinkStreamHandler = this.generatedLinkStreamHandler ?: GeneratedLinkStreamHandler()
      generatedLinkChannel.setStreamHandler(this.generatedLinkStreamHandler)
    }
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    when{
      call.method == "initBranchIO"->{
        setUpBranchIo(registrar, deepLinkStreamHandler, result)
        result.success("")
      }
      else->{
        result.notImplemented()
      }
    }
  }
}
