
import 'package:flutter/material.dart';
import 'package:smartnote/utils/theme/theme.dart';

class ActionChipsRowItem<T> {
  final T value;
  final String label;

  ActionChipsRowItem(this.value, this.label);
}

class ActionChipsRow<T> extends StatefulWidget {
  ActionChipsRow({
    required this.items,
    required this.onSelected,
    required this.selected,
  });

  final List<ActionChipsRowItem<T?>> items;
  final void Function(T? selectedData) onSelected;
  final T? selected;

  @override
  _ActionChipsRowState createState() => _ActionChipsRowState<T>();
}

class _ActionChipsRowState<T> extends State<ActionChipsRow<T>> {
  List<Widget> _buildActionChips() {
    var chips = widget.items.map((item) {
      return Padding(
        padding: const EdgeInsets.all(CustomSpacing.small),
        child: ActionChip(
          label: Text(
            item.label,
            style: TextStyle(
              color: item.value == widget.selected ? Colors.white : null,
              fontWeight: item.value == widget.selected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          padding: const EdgeInsets.all(10),
          backgroundColor: item.value == widget.selected ? Theme.of(context).primaryColor : null,
          onPressed: () => widget.onSelected(item.value),
        ),
      );
    }).toList();

    return [SizedBox(width: CustomSpacing.medium), ...chips];
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      color: theme.colorScheme.background,
      padding: EdgeInsets.all(CustomSpacing.small),
      alignment: Alignment.centerLeft,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(children: _buildActionChips()),
      )
      //     : IntrinsicHeight(
      //   child: Wrap(
      //     // mainAxisAlignment: MainAxisAlignment.start,
      //     // crossAxisAlignment: CrossAxisAlignment.center,
      //     children: _buildActionChips(),
      //   ),
      // ),
    );
  }
}
