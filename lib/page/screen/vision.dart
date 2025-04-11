import 'package:aspis/core/manager.dart';
import 'package:aspis/page/diagnosis_result.dart';
import 'package:aspis/service/ai_service.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class Vision extends StatefulWidget {
  const Vision({super.key});

  @override
  State<Vision> createState() => _VisionState();
}

class _VisionState extends State<Vision> {
  late final CameraController _cameraController;
  bool _initialized = false;
  bool _isQR = false;
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  @override
  void dispose() {
    if (_initialized) _cameraController.dispose();
    super.dispose();
  }

  void _showSnackBar(String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  Future<void> _initialize() async {
    final camera = await availableCameras().then((cameras) => cameras.firstOrNull);
    if (camera == null) {
      _showSnackBar('사용 가능한 카메라가 없습니다.');
      return;
    }
    _cameraController = CameraController(camera, ResolutionPreset.high);
    await _cameraController.initialize();
    setState(() => _initialized = true);
  }

  Future<void> _detectQR() async {
    if (!_cameraController.value.isInitialized) {
      _showSnackBar('카메라에 접근할 수 없습니다.');
      return;
    }
    _showSnackBar('QR 머시기');
  }

  Future<void> _diagnose() async {
    if (_isProcessing) return;
    if (!_cameraController.value.isInitialized) {
      _showSnackBar('카메라에 접근할 수 없습니다.');
      return;
    }
    if (_cameraController.value.isTakingPicture) {
      _showSnackBar('촬영 중 입니다.');
      return;
    }
    setState(() => _isProcessing = true);
    final image = await _cameraController.takePicture();
    final data = await image.readAsBytes();
    final res = await AIService().analyze(data);
    await _cameraController.resumePreview();
    setState(() => _isProcessing = false);
    if (!res.success) {
      _showSnackBar(res.error ?? res.message ?? '제대로 인식되지 않았습니다.');
      return;
    }
    NavigatorManager.navigator.push(
      MaterialPageRoute(
        builder: (context) => DiagnosisResult(
          imageBytes: data,
          response: res
        )
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (!_initialized) Container(width: double.infinity, height: double.infinity, color: Colors.black) else Center(
          child: AspectRatio(
            aspectRatio: 9 / 16,
            child: CameraPreview(_cameraController)
          )
        ),
        Positioned(
          bottom: 103,
          width: MediaQuery.sizeOf(context).width,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 27),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: _isProcessing ? null : () => setState(() => _isQR = !_isQR),
                  child: Container(
                    height: 53,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(width: 5),
                        Text(_isQR
                          ? '네임플레이트 QR를 카메라에 찍어주세요'
                          : '진단이 필요한 부위를 카메라에 찍어주세요',
                          style: TextStyle(fontSize: 10)
                        ),
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(13),
                            gradient: LinearGradient(
                              colors: [
                                Color(0xFF73D1FA),
                                Color(0xFFB46DFF)
                              ]
                            )
                          ),
                          child: Text(_isQR
                            ? 'AI비전모드 전환'
                            : '일반 QR모드 전환',
                            style: TextStyle(fontSize: 12)
                          )
                        ),
                        SizedBox(width: 5)
                      ]
                    )
                  ),
                ),
                const SizedBox(height: 28),
                GestureDetector(
                  onTap: _isQR ? _detectQR : _diagnose,
                  child: Container(
                    width: 65,
                    height: 65,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(32.5)
                    ),
                    child: Center(
                      child: Container(
                        width: 59,
                        height: 59,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black, width: 1),
                          borderRadius: BorderRadius.circular(29.5)
                        )
                      )
                    )
                  )
                )
              ]
            )
          )
        ),
        IgnorePointer(
          ignoring: !_isProcessing,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            color: !_isProcessing
              ? Colors.transparent
              : Color(0x66000000),
            width: double.infinity,
            height: double.infinity,
            child: !_isProcessing
              ? null
              : Center(child: CircularProgressIndicator())
          ),
        )
      ]
    );
  }
}
