import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ScheduleCallbackScreen extends StatefulWidget {
  final String productId;
  final String productName;

  const ScheduleCallbackScreen({
    super.key,
    required this.productId,
    required this.productName,
  });

  @override
  State<ScheduleCallbackScreen> createState() => _ScheduleCallbackScreenState();
}

class _ScheduleCallbackScreenState extends State<ScheduleCallbackScreen> {

  // ======== CONTROLLERS ========
  final _formKey        = GlobalKey<FormState>();
  final _nameController     = TextEditingController();
  final _mobileController   = TextEditingController();
  final _locationController = TextEditingController();
  DateTime? _selectedDate;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _mobileController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  // ======== FORMAT DATE ========
  String _formatDate(DateTime date) {
    final months = ['Jan','Feb','Mar','Apr','May','Jun',
      'Jul','Aug','Sep','Oct','Nov','Dec'];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  // ======== DATE PICKER ========
  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  // ======== API CALL ========
  Future<void> _submitForm() async {

    // Check form valid
    if (!_formKey.currentState!.validate()) return;

    // Check date selected
    if (_selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('⚠️ Please select a date!'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() => _isLoading = true); // Show loader

    try {
      // ========= API POST REQUEST =========
      final response = await http.post(
        Uri.parse('https://your-api.com/schedule-callback'), // 👈 CHANGE THIS URL
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'product_id'    : widget.productId,
          'product_name'  : widget.productName,
          'name'          : _nameController.text,
          'mobile'        : _mobileController.text,
          'location'      : _locationController.text,
          'preferred_date': '${_selectedDate!.year}-${_selectedDate!.month}-${_selectedDate!.day}',
        }),
      );
      // ====================================

      setState(() => _isLoading = false); // Hide loader

      if (response.statusCode == 200 || response.statusCode == 201) {
        // ✅ SUCCESS
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('✅ Callback Scheduled Successfully!'),
            backgroundColor: Colors.green,
          ),
        );
        Future.delayed(const Duration(seconds: 2), () {
          if (context.mounted) Navigator.pop(context);
        });

      } else {
        // ❌ FAILED
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('❌ Failed! Code: ${response.statusCode}'),
            backgroundColor: Colors.red,
          ),
        );
      }

    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('❌ Error: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // ======== UI ========
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Schedule Callback'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // ===== TITLE =====
              const Text('Request a Callback',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Fill in your details and our experts will call you back within 2 hours.',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 20),

              // ===== NAME =====
              const Text('Name',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
              const SizedBox(height: 6),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: 'Enter your full name',
                  prefixIcon: const Icon(Icons.person_outline),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '⚠️ Name is required';
                  }
                  if (value.length < 3) {
                    return '⚠️ Name min 3 characters';
                  }
                  if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                    return '⚠️ Name only letters allowed';
                  }
                  return null; // ✅ valid
                },
              ),
              const SizedBox(height: 14),

              // ===== SERVICE =====
              const Text('Service',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blue.shade100),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.medical_services_outlined, color: Colors.blue),
                    const SizedBox(width: 12),
                    Text(widget.productName,
                        style: const TextStyle(fontSize: 15)),
                  ],
                ),
              ),
              const SizedBox(height: 14),

              // ===== DATE =====
              const Text('Preferred Date',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
              const SizedBox(height: 6),
              GestureDetector(
                onTap: _selectDate,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade400),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.calendar_today_outlined,
                          color: Colors.grey.shade600),
                      const SizedBox(width: 12),
                      Text(
                        _selectedDate == null
                            ? 'Select a date'
                            : _formatDate(_selectedDate!),
                        style: TextStyle(
                          fontSize: 15,
                          color: _selectedDate == null
                              ? Colors.grey
                              : Colors.black,
                        ),
                      ),
                      const Spacer(),
                      Icon(Icons.arrow_drop_down,
                          color: Colors.grey.shade600),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 14),

              // ===== MOBILE =====
              const Text('Mobile Number',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
              const SizedBox(height: 6),
              TextFormField(
                controller: _mobileController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: 'Enter your mobile number',
                  prefixIcon: const Icon(Icons.phone_outlined),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '⚠️ Mobile is required';
                  }
                  if (value.length != 10) {
                    return '⚠️ Mobile must be 10 digits';
                  }
                  if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                    return '⚠️ Only numbers allowed';
                  }
                  if (!value.startsWith('6') &&
                      !value.startsWith('7') &&
                      !value.startsWith('8') &&
                      !value.startsWith('9')) {
                    return '⚠️ Enter valid Indian mobile number';
                  }
                  return null; // ✅ valid
                },
              ),
              const SizedBox(height: 14),

              // ===== LOCATION =====
              const Text('Location',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
              const SizedBox(height: 6),
              TextFormField(
                controller: _locationController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Enter your complete address',
                  prefixIcon: const Padding(
                    padding: EdgeInsets.only(bottom: 40),
                    child: Icon(Icons.location_on_outlined),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '⚠️ Location is required';
                  }
                  if (value.length < 10) {
                    return '⚠️ Enter complete address (min 10 characters)';
                  }
                  return null; // ✅ valid
                },
              ),
              const SizedBox(height: 24),

              // ===== BUTTON =====
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: _isLoading ? null : _submitForm, // 👈 CALLS API
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('Schedule Callback',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      )),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}