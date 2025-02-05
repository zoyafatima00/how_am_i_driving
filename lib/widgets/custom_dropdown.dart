import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:how_am_i_driving/utils/color_resources.dart';

class CustomDropdown extends StatefulWidget {
  final String hintText;
  final TextEditingController controllerValue;
  final List<String> dropdownItems;
  final String? selectedValue;
  final void Function(String?)? onChanged;

  const CustomDropdown({
    super.key,
    required this.hintText,
    required this.controllerValue,
    required this.dropdownItems,
    this.selectedValue,
    this.onChanged,
  });

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  String? _selectedItem;

  @override
  void initState() {
    super.initState();
    // Initialize _selectedItem, default to the first item in dropdownItems if nothing is selected
    _selectedItem = widget.selectedValue ?? widget.dropdownItems[0];
    widget.controllerValue.text = _selectedItem!;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 6.h),
      child: Container(
        height: 60.0.h,
        padding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 11.h),
        decoration: BoxDecoration(
          color: AppColors.TextFIELD_BACKGROUND_COLOR,
          borderRadius: BorderRadius.all(Radius.circular(23.r)),
        ),
        child: DropdownButton<String>(
          value: _selectedItem,
          isExpanded: true,
          icon: Icon(
            Icons.arrow_drop_down,
            color: Colors.black.withOpacity(0.5),
          ),
          iconSize: 24,
          elevation: 16,
          style: TextStyle(
            color: _selectedItem == widget.hintText
                ? AppColors.TextFIELD_EYE_COLOR // Hint color is gray
                : Colors.black, // Black for selected items
            fontSize: 12.sp,
          ),
          onChanged: (String? newValue) {
            setState(() {
              _selectedItem = newValue!;
              widget.controllerValue.text = newValue;
            });
            if (widget.onChanged != null) {
              widget.onChanged!(newValue);
            }
          },
          underline: Container(),
          items: widget.dropdownItems
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: TextStyle(color: Colors.black, fontSize: 14.sp),
              ),
            );
          }).toList(),
          hint: Text(
            widget.hintText,
            style: TextStyle(
                color: Colors.black.withOpacity(0.5), fontSize: 14.sp),
          ),
        ),
      ),
    );
  }
}
