package com.mathrecall.mathrecall

import android.app.Activity
import android.content.Intent
import android.net.Uri
import android.provider.OpenableColumns
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.File

class MainActivity : FlutterActivity() {
    private val channelName = "mathrecall/backup"
    private val requestImport = 4101
    private val requestSave = 4102

    private var pendingResult: MethodChannel.Result? = null
    private var pendingSaveSource: String? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channelName)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "importBackup" -> {
                        if (pendingResult != null) {
                            result.error("busy", "已有文件操作正在进行", null)
                            return@setMethodCallHandler
                        }
                        pendingResult = result
                        val intent = Intent(Intent.ACTION_OPEN_DOCUMENT).apply {
                            addCategory(Intent.CATEGORY_OPENABLE)
                            type = "application/zip"
                            putExtra(
                                Intent.EXTRA_MIME_TYPES,
                                arrayOf(
                                    "application/zip",
                                    "application/x-zip-compressed",
                                    "application/octet-stream",
                                ),
                            )
                            addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
                        }
                        startActivityForResult(intent, requestImport)
                    }

                    "saveBackup" -> {
                        if (pendingResult != null) {
                            result.error("busy", "已有文件操作正在进行", null)
                            return@setMethodCallHandler
                        }
                        val sourcePath = call.argument<String>("sourcePath")
                        val fileName = call.argument<String>("fileName")
                        if (sourcePath == null || fileName == null) {
                            result.error("bad_args", "缺少文件路径", null)
                            return@setMethodCallHandler
                        }
                        pendingResult = result
                        pendingSaveSource = sourcePath
                        val intent = Intent(Intent.ACTION_CREATE_DOCUMENT).apply {
                            addCategory(Intent.CATEGORY_OPENABLE)
                            type = "application/zip"
                            putExtra(Intent.EXTRA_TITLE, fileName)
                        }
                        startActivityForResult(intent, requestSave)
                    }

                    else -> result.notImplemented()
                }
            }
    }

    @Deprecated("Deprecated in Java")
    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        val result = pendingResult ?: return
        pendingResult = null

        if (requestCode == requestImport) {
            if (resultCode != Activity.RESULT_OK || data?.data == null) {
                result.success(null)
                return
            }
            try {
                val uri = data.data!!
                val name = queryDisplayName(uri) ?: "backup.zip"
                val importsDir = File(cacheDir, "imports").apply { mkdirs() }
                val target = File(
                    importsDir,
                    "import-${System.currentTimeMillis()}-$name",
                )
                contentResolver.openInputStream(uri)?.use { input ->
                    target.outputStream().use { output -> input.copyTo(output) }
                } ?: throw IllegalStateException("无法打开文件")
                result.success(target.absolutePath)
            } catch (error: Exception) {
                result.error("import_failed", error.message, null)
            }
        } else if (requestCode == requestSave) {
            val sourcePath = pendingSaveSource
            pendingSaveSource = null
            if (resultCode != Activity.RESULT_OK || data?.data == null || sourcePath == null) {
                result.success(false)
                return
            }
            try {
                contentResolver.openOutputStream(data.data!!)?.use { output ->
                    File(sourcePath).inputStream().use { input ->
                        input.copyTo(output)
                    }
                } ?: throw IllegalStateException("无法写入文件")
                result.success(true)
            } catch (error: Exception) {
                result.error("save_failed", error.message, null)
            }
        }
    }

    private fun queryDisplayName(uri: Uri): String? {
        contentResolver.query(uri, null, null, null, null)?.use { cursor ->
            val index = cursor.getColumnIndex(OpenableColumns.DISPLAY_NAME)
            if (cursor.moveToFirst() && index >= 0) {
                return cursor.getString(index)
            }
        }
        return null
    }
}
