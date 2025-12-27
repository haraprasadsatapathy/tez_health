import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tez_health/config/dependency_injection.dart';
import 'package:tez_health/domain/repository/emergency_repository.dart';
import 'package:tez_health/services/location_service.dart';
import 'package:tez_health/theme/app_theme.dart';
import 'package:tez_health/utils/constants.dart';

class SOSButton extends StatefulWidget {
  const SOSButton({super.key});

  @override
  State<SOSButton> createState() => _SOSButtonState();
}

class _SOSButtonState extends State<SOSButton>
    with SingleTickerProviderStateMixin {
  bool _isPressed = false;
  bool _isLoading = false;
  int _countdown = AppConstants.sosCountdownSeconds;
  Timer? _timer;
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  final _locationService = getIt<LocationService>();
  final _emergencyRepository = getIt<EmergencyRepository>();

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pulseController.dispose();
    super.dispose();
  }

  void _onSOSPressed() {
    setState(() {
      _isPressed = true;
      _countdown = AppConstants.sosCountdownSeconds;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _countdown--;
      });

      if (_countdown == 0) {
        timer.cancel();
        _triggerSOS();
      }
    });
  }

  void _onSOSCancelled() {
    _timer?.cancel();
    setState(() {
      _isPressed = false;
      _countdown = AppConstants.sosCountdownSeconds;
    });
  }

  Future<void> _triggerSOS() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Get current location
      final position = await _locationService.getCurrentLocation();

      if (position == null) {
        if (mounted) {
          _showError('Unable to get your location. Please enable location services.');
        }
        return;
      }

      // Trigger SOS
      await _emergencyRepository.triggerSOS(
        latitude: position.latitude,
        longitude: position.longitude,
        message: 'Emergency SOS triggered from app',
      );

      if (mounted) {
        _showSuccess();
      }
    } catch (e) {
      if (mounted) {
        _showError('Failed to send SOS. Please try again.');
      }
    } finally {
      if (mounted) {
        setState(() {
          _isPressed = false;
          _isLoading = false;
          _countdown = AppConstants.sosCountdownSeconds;
        });
      }
    }
  }

  void _showSuccess() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(SuccessMessages.sosTriggered),
        backgroundColor: AppTheme.successGreen,
        duration: Duration(seconds: 3),
      ),
    );
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppTheme.alertRed,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isPressed) {
      return _buildCountdownDialog();
    }

    return ScaleTransition(
      scale: _pulseAnimation,
      child: FloatingActionButton.large(
        onPressed: _isLoading ? null : _onSOSPressed,
        backgroundColor: AppTheme.alertRed,
        elevation: 8,
        child: _isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.emergency,
                    size: 36,
                    color: Colors.white,
                  ),
                  SizedBox(height: 4),
                  Text(
                    'SOS',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildCountdownDialog() {
    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        color: AppTheme.alertRed,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppTheme.alertRed.withValues(alpha: 0.5),
            blurRadius: 20,
            spreadRadius: 10,
          ),
        ],
      ),
      child: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$_countdown',
                  style: const TextStyle(
                    fontSize: 72,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const Text(
                  'Sending SOS...',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: IconButton(
              onPressed: _onSOSCancelled,
              icon: const Icon(
                Icons.close,
                color: Colors.white,
                size: 28,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
