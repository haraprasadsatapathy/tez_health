import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import '../../../config/dependency_injection.dart';
import '../../../domain/repository/tez_repository.dart';
import '../../../theme/app_colors.dart';
import '../../cubit/product/product_bloc.dart';
import '../../cubit/product/product_event.dart';
import '../../cubit/product/product_state.dart';
import '../../../models/product_variant.dart';
import '../../../models/product.dart';

class ProductDetailsScreen extends StatefulWidget {
  final String productId;

  const ProductDetailsScreen({super.key, required this.productId});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class  _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int _selectedVariantIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductBloc(getIt<TezRepository>())
        ..add(FetchProductByIdEvent(widget.productId)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Product Details'),
        ),
        body: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProductLoaded) {
              final product = state.product;
              final selectedVariant = product.variants.isNotEmpty
                  ? product.variants[_selectedVariantIndex]
                  : null;

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Image
                    AspectRatio(
                      aspectRatio: 16 / 9,
                      child: CachedNetworkImage(
                        imageUrl: product.imageUrl,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          color: AppColors.gray100,
                          child: const Center(child: CircularProgressIndicator()),
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: AppColors.gray100,
                          child: const Icon(Icons.image, size: 50),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Product Name
                          Text(
                            product.name,
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          const SizedBox(height: 14),

                          // Price Section (moved here)
                          if (selectedVariant != null) ...[
                            Row(
                              children: [
                                Text(
                                  '₹ ${selectedVariant.discountPrice.toStringAsFixed(0)}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(
                                        color: AppColors.tezBlue,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                const SizedBox(width: 10),
                                if (selectedVariant.price > selectedVariant.discountPrice)
                                  Text(
                                    '₹ ${selectedVariant.price.toStringAsFixed(0)}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(
                                          decoration: TextDecoration.lineThrough,
                                          color: AppColors.gray500,
                                        ),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 16),
                          ],

                          // Variants Selection (without label)
                          if (product.variants.isNotEmpty) ...[
                            // Horizontal Scrollable Variants
                            SizedBox(
                              height: 50,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: product.variants.length,
                                itemBuilder: (context, index) {
                                  final variant = product.variants[index];
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 12),
                                    child: _VariantOption(
                                      variant: variant,
                                      isSelected: _selectedVariantIndex == index,
                                      onTap: () {
                                        setState(() {
                                          _selectedVariantIndex = index;
                                        });
                                      },
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 16),
                          ],

                          // Book Button
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                context.push('/book-now/${widget.productId}');
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                                child: Text('Book Now', style: TextStyle(fontSize: 16)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Service Details Section
                    _ServiceDetailsSection(description: product.description),

                    // Related Services Section
                    if (state.relatedProducts.isNotEmpty)
                      _RelatedServicesSection(
                        relatedProducts: state.relatedProducts,
                      ),
                  ],
                ),
              );
            } else if (state is ProductError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(state.message),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        context
                            .read<ProductBloc>()
                            .add(FetchProductByIdEvent(widget.productId));
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class _VariantOption extends StatelessWidget {
  final ProductVariant variant;
  final bool isSelected;
  final VoidCallback onTap;

  const _VariantOption({
    required this.variant,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: AppColors.tezBlue,
            width: isSelected ? 2.5 : 1.5,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            variant.variantName,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.tezBlue,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
          ),
        ),
      ),
    );
  }
}

class _ServiceDetailsSection extends StatefulWidget {
  final String description;

  const _ServiceDetailsSection({required this.description});

  @override
  State<_ServiceDetailsSection> createState() => _ServiceDetailsSectionState();
}

class _ServiceDetailsSectionState extends State<_ServiceDetailsSection> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: Colors.grey[600],
          height: 1.5,
        );
    final headerStyle = Theme.of(context).textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.bold,
        );

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.grey.shade200),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Service Details Header
          Text('Service Details', style: headerStyle),
          const SizedBox(height: 8),
          Text(
            "Tez Health's Mild Breathing Discomfort Treatment at Home begins with a certified nurse visiting the patient's home to examine breathing status, assess symptoms, and check overall condition. The nurse then connects with Tez Health's in-house doctor through an online consultation, who reviews the assessment, identifies possible causes, and guides the appropriate treatment—ensuring safe, timely, and doctor-supervised care while the patient breathes easier at home.",
            style: textStyle,
            maxLines: _isExpanded ? null : 4,
            overflow: _isExpanded ? null : TextOverflow.ellipsis,
          ),

          // Expanded Content
          if (_isExpanded) ...[
            const SizedBox(height: 16),
            Text('Who Needs This Service?', style: headerStyle),
            const SizedBox(height: 8),
            Text('This service is suitable for:', style: textStyle),
            const SizedBox(height: 8),
            _buildBulletItem('Individuals with mild shortness of breath.', textStyle),
            _buildBulletItem('Patients experiencing chest tightness or wheezing', textStyle),
            _buildBulletItem('People with asthma and breathing issues due to underlying conditions.', textStyle),
            _buildBulletItem('Elderly patients needing breathing assessment at home', textStyle),
            _buildBulletItem('Individuals recovering from respiratory infections', textStyle),
            const SizedBox(height: 8),
            Text(
              'Note: Severe breathing difficulty requires immediate emergency care.',
              style: textStyle?.copyWith(fontStyle: FontStyle.italic),
            ),

            const SizedBox(height: 16),
            Text('Procedure – How the Service Works', style: headerStyle),
            const SizedBox(height: 8),
            _buildNumberedItem(1, 'Book the mild breathing discomfort treatment service through Tez Health', textStyle),
            _buildNumberedItem(2, 'Share symptoms and medical history during booking', textStyle),
            _buildNumberedItem(3, 'Our certified nurse visits your home.', textStyle),
            _buildNumberedItem(4, 'Nurse evaluates breathing patterns and oxygen levels and consults with the doctor to guide further care.', textStyle),
            _buildNumberedItem(5, 'Treatment advice, medication, or monitoring will be suggested by the doctor.', textStyle),
            _buildNumberedItem(6, 'Hospital referral is suggested if symptoms worsen', textStyle),
            const SizedBox(height: 8),
            Text(
              'Consent note: A signed consent form is mandatory before the nurse begins the service. Without the signed consent, the service cannot be provided.',
              style: textStyle,
            ),

            const SizedBox(height: 16),
            Text('How to Be Ready for the Service', style: headerStyle),
            const SizedBox(height: 8),
            Text('To help the nurse assess your condition effectively:', style: textStyle),
            const SizedBox(height: 8),
            _buildBulletItem('Note when breathing discomfort started', textStyle),
            _buildBulletItem('Keep inhalers or respiratory medications nearby', textStyle),
            _buildBulletItem('Share history of asthma or allergies if any', textStyle),
            _buildBulletItem('Keep previous medical reports if available', textStyle),
            _buildBulletItem('Ensure a well-ventilated space for examination', textStyle),

            const SizedBox(height: 16),
            Text('What Is Not Included', style: headerStyle),
            const SizedBox(height: 8),
            _buildBulletItem('Emergency or critical respiratory care', textStyle),
            _buildBulletItem('Oxygen therapy or nebulization unless prescribed separately', textStyle),
            _buildBulletItem('Hospital admission or ICU care', textStyle),
            _buildBulletItem('Specialist pulmonology consultation unless referred', textStyle),

            const SizedBox(height: 16),
            Text('Benefits of Mild Breathing Discomfort Treatment at Home', style: headerStyle),
            const SizedBox(height: 8),
            _buildBulletItem('Early assessment of breathing issues', textStyle),
            _buildBulletItem('No hospital waiting time', textStyle),
            _buildBulletItem('Reduced anxiety during symptoms', textStyle),
            _buildBulletItem('Comfortable care for elderly patients', textStyle),
            _buildBulletItem('Personalized medical guidance', textStyle),

            const SizedBox(height: 16),
            Text('Why Choose Tez Health for Breathing Discomfort Treatment?', style: headerStyle),
            const SizedBox(height: 8),
            Text('1. Certified & Experienced In-House Nurses', style: textStyle?.copyWith(fontWeight: FontWeight.bold)),
            Text('Tez Health provides certified in-house nurses with 3+ years of experience, professionally handling home-based medical procedures.', style: textStyle),
            const SizedBox(height: 8),
            Text('2. Vaccinated & BLS-Certified Nurses', style: textStyle?.copyWith(fontWeight: FontWeight.bold)),
            Text('All Tez Health nurses are fully vaccinated and BLS certified, reducing infection risk and ensuring safe, reliable home care.', style: textStyle),
            const SizedBox(height: 8),
            Text('3. Doctor-Monitored Care', style: textStyle?.copyWith(fontWeight: FontWeight.bold)),
            Text('Every service provided by Tez Health staff nurses is monitored by a qualified doctor, ensuring safety, accuracy, and proper medical oversight throughout the service.', style: textStyle),

            const SizedBox(height: 16),
            Text('Refund Policy', style: headerStyle),
            const SizedBox(height: 8),
            Text(
              "If the service is cancelled before the nurse is dispatched, a refund will be processed as per Tez Health's refund policy. Once the nurse has arrived, refunds may not be applicable.",
              style: textStyle,
            ),
          ],

          const SizedBox(height: 12),

          // View More / View Less button
          GestureDetector(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: Text(
              _isExpanded ? 'View Less' : 'View More',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.tezBlue,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBulletItem(String text, TextStyle? style) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: Colors.grey[600],
                shape: BoxShape.circle,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(child: Text(text, style: style)),
        ],
      ),
    );
  }

  Widget _buildNumberedItem(int number, String text, TextStyle? style) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 20,
            child: Text('$number.', style: style?.copyWith(color: Colors.grey[700])),
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: style)),
        ],
      ),
    );
  }
}

class _RelatedServicesSection extends StatelessWidget {
  final List<Product> relatedProducts;

  const _RelatedServicesSection({
    required this.relatedProducts,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.gray900 : AppColors.gray50,
        border: Border(
          top: BorderSide(color: Colors.grey.shade200),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Related Services:',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: relatedProducts.length,
            itemBuilder: (context, index) {
              final product = relatedProducts[index];
              return _RelatedServiceCard(product: product);
            },
          ),
        ],
      ),
    );
  }
}

class _RelatedServiceCard extends StatelessWidget {
  final Product product;

  const _RelatedServiceCard({required this.product});

  @override
  Widget build(BuildContext context) {
    final firstVariant = product.firstVariant;

    return Card(
      elevation: 2,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          context.pushReplacement('/product-details/${product.productId}');
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: AspectRatio(
                aspectRatio: 1.2,
                child: CachedNetworkImage(
                  imageUrl: product.imageUrl,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: AppColors.gray100,
                    child: const Center(
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: AppColors.gray100,
                    child: const Icon(Icons.image, size: 32, color: AppColors.gray400),
                  ),
                ),
              ),
            ),
            // Product Details
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Name
                    Text(
                      product.name,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    // Price Section
                    if (firstVariant != null)
                      Text(
                        '₹${firstVariant.discountPrice.toStringAsFixed(0)}',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
