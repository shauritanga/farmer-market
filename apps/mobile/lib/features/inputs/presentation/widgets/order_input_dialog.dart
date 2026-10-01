import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:fama/core/widgets/app_button.dart';
import 'package:fama/features/inputs/domain/entities/agro_input.dart';
import 'package:fama/features/inputs/presentation/providers/inputs_provider.dart';
import 'package:fama/l10n/app_localizations.dart';

/// Quantity picker + confirm for ordering an input. The confirm button
/// locks while the request is in flight so a double-tap can't place the
/// same order twice.
class OrderInputDialog extends ConsumerStatefulWidget {
  const OrderInputDialog({super.key, required this.input});

  final AgroInput input;

  @override
  ConsumerState<OrderInputDialog> createState() => _OrderInputDialogState();
}

class _OrderInputDialogState extends ConsumerState<OrderInputDialog> {
  int _quantity = 1;
  bool _submitting = false;
  String? _error;

  int get _maxQuantity {
    final stock = widget.input.stockQuantity;
    if (stock == null) return 99;
    return stock.floor().clamp(1, 99);
  }

  Future<void> _submit() async {
    setState(() {
      _submitting = true;
      _error = null;
    });
    final result = await ref
        .read(createAgroInputOrderUseCaseProvider)
        .call(inputId: widget.input.id, quantity: _quantity.toDouble());
    if (!mounted) return;
    result.when(
      success: (_) {
        ref.invalidate(myInputOrdersProvider);
        ref.invalidate(inputsCatalogProvider);
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.inputsOrderSuccess),
          ),
        );
      },
      failure: (f) => setState(() {
        _submitting = false;
        _error = f.message;
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    final total = widget.input.price * _quantity;

    return AlertDialog(
      title: Text(l10n.inputsOrderTitle(widget.input.name)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${widget.input.currency} ${widget.input.price.toStringAsFixed(0)} / ${widget.input.unit}',
            style: textTheme.bodyMedium,
          ),
          SizedBox(height: 16.h),
          Text(l10n.inputsQuantityLabel, style: textTheme.labelLarge),
          SizedBox(height: 8.h),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: _submitting || _quantity <= 1
                    ? null
                    : () => setState(() => _quantity--),
              ),
              Expanded(
                child: Text(
                  '$_quantity ${widget.input.unit}',
                  textAlign: TextAlign.center,
                  style: textTheme.titleLarge,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: _submitting || _quantity >= _maxQuantity
                    ? null
                    : () => setState(() => _quantity++),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            '${widget.input.currency} ${total.toStringAsFixed(0)}',
            style: textTheme.titleMedium,
          ),
          if (_error != null) ...[
            SizedBox(height: 8.h),
            Text(
              _error!,
              style: textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.error,
              ),
            ),
          ],
        ],
      ),
      actions: [
        TextButton(
          onPressed: _submitting ? null : () => Navigator.of(context).pop(),
          child: Text(l10n.commonCancel),
        ),
        SizedBox(
          width: 140.w,
          child: AppButton(
            label: l10n.commonConfirm,
            isLoading: _submitting,
            onPressed: _submitting ? null : _submit,
          ),
        ),
      ],
    );
  }
}
