import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/business_logics/bloc/register/register_page_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';

import '../../../../business_logics/bloc/register/register_page_bloc.dart';
import '../../../../business_logics/bloc/register/register_page_state.dart';
import '../../../utilities/color_constant.dart';

class GradeTextFieldWidget extends StatelessWidget {
  const GradeTextFieldWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RegisterPageBloc registerPageBloc =
        BlocProvider.of<RegisterPageBloc>(context);

    return BlocBuilder<RegisterPageBloc, RegisterPageState>(
      builder: (context, state) {
        return Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: const [
                    Icon(
                      PhosphorIcons.graduation_cap_fill,
                    ),
                    Text(
                      'Grade:',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Container(
              decoration: BoxDecoration(
                color: ColorConstant.kWhiteColor.withOpacity(0.4),
                border: Border.all(
                  color: ColorConstant.kBlackColor.withOpacity(0.6),
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton2(
                  isExpanded: true,
                  alignment: Alignment.center,
                  hint: Text(
                    'Select grade',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                  items: registerPageBloc.items
                      .map((item) => DropdownMenuItem<String>(
                            value: item,
                            alignment: Alignment.center,
                            child: Text(
                              item,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ))
                      .toList(),
                  value: state.selectedGrade,
                  onChanged: (value) {
                    registerPageBloc.add(GradeChangeEvent(grade: value ?? ''));
                  },
                  buttonHeight: 40,
                  buttonWidth: 200,
                  itemHeight: 40,
                  dropdownMaxHeight: 200,
                  searchController: registerPageBloc.gradeTextEditingController,
                  searchInnerWidgetHeight: 50,
                  searchInnerWidget: Container(
                    height: 50,
                    padding: const EdgeInsets.only(
                      top: 8,
                      bottom: 4,
                      right: 8,
                      left: 8,
                    ),
                    child: TextFormField(
                      expands: true,
                      maxLines: null,
                      controller: registerPageBloc.gradeTextEditingController,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 8,
                        ),
                        hintText: 'Search for an item...',
                        hintStyle: const TextStyle(fontSize: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  searchMatchFn: (item, searchValue) {
                    return (item.value.toString().contains(searchValue));
                  },
                  onMenuStateChange: (isOpen) {
                    if (!isOpen) {
                      registerPageBloc.gradeTextEditingController.clear();
                    }
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
