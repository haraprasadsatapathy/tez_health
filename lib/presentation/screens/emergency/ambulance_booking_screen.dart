import 'package:flutter/material.dart';
import 'package:tez_health/presentation/widgets/custom_app_bar.dart';
import 'package:tez_health/theme/app_theme.dart';
import 'package:tez_health/utils/constants.dart';

class AmbulanceBookingScreen extends StatefulWidget {
  const AmbulanceBookingScreen({super.key});

  @override
  State<AmbulanceBookingScreen> createState() => _AmbulanceBookingScreenState();
}

class _AmbulanceBookingScreenState extends State<AmbulanceBookingScreen> {
  String _selectedType = AppConstants.ambulanceBLS;
  final _pickupController = TextEditingController();
  final _dropController = TextEditingController();
  final _patientNameController = TextEditingController();
  final _contactController = TextEditingController();
  final _notesController = TextEditingController();

  @override
  void dispose() {
    _pickupController.dispose();
    _dropController.dispose();
    _patientNameController.dispose();
    _contactController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Book Ambulance',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Ambulance Type Selection
            Text(
              'Select Ambulance Type',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            _buildTypeSelector(
              AppConstants.ambulanceBLS,
              'Basic Life Support',
              Icons.local_hospital,
            ),
            const SizedBox(height: 8),
            _buildTypeSelector(
              AppConstants.ambulanceALS,
              'Advanced Life Support (ICU)',
              Icons.emergency_outlined,
            ),
            const SizedBox(height: 8),
            _buildTypeSelector(
              AppConstants.ambulanceMortuary,
              'Mortuary Van',
              Icons.directions_car,
            ),
            const SizedBox(height: 24),

            // Location Details
            Text(
              'Location Details',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _pickupController,
              decoration: const InputDecoration(
                labelText: 'Pickup Location',
                hintText: 'Enter pickup address',
                prefixIcon: Icon(Icons.my_location),
                suffixIcon: Icon(Icons.gps_fixed),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _dropController,
              decoration: const InputDecoration(
                labelText: 'Drop Location',
                hintText: 'Enter drop address',
                prefixIcon: Icon(Icons.location_on),
              ),
            ),
            const SizedBox(height: 24),

            // Patient Details
            Text(
              'Patient Details',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _patientNameController,
              decoration: const InputDecoration(
                labelText: 'Patient Name',
                hintText: 'Enter patient name',
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _contactController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Contact Number',
                hintText: 'Enter contact number',
                prefixIcon: Icon(Icons.phone),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _notesController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Additional Notes (Optional)',
                hintText: 'Any special requirements or conditions',
                prefixIcon: Icon(Icons.note),
              ),
            ),
            const SizedBox(height: 32),

            // Book Button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _bookAmbulance,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.alertRed,
                ),
                child: const Text(
                  'Book Ambulance',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTypeSelector(String type, String label, IconData icon) {
    final isSelected = _selectedType == type;
    return InkWell(
      onTap: () {
        setState(() {
          _selectedType = type;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? AppTheme.alertRed.withValues(alpha: 0.1)
              : Colors.transparent,
          border: Border.all(
            color: isSelected ? AppTheme.alertRed : AppTheme.mediumGrey.withValues(alpha: 0.3),
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? AppTheme.alertRed : AppTheme.mediumGrey,
              size: 28,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  color: isSelected ? AppTheme.alertRed : Colors.black,
                ),
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check_circle,
                color: AppTheme.alertRed,
              ),
          ],
        ),
      ),
    );
  }

  void _bookAmbulance() {
    // TODO: Implement booking logic with BLoC
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Booking ambulance...'),
        backgroundColor: AppTheme.successGreen,
      ),
    );
  }
}
