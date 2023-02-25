import 'package:flutter/material.dart';
import 'package:flutter_application_1/business_logics/bloc/register/register_page_bloc.dart';
import 'package:flutter_application_1/business_logics/bloc/register/register_page_event.dart';
import 'package:flutter_application_1/business_logics/bloc/register/register_page_state.dart';
import 'package:flutter_application_1/presentation/utilities/color_constant.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContinueButtonWidget extends StatelessWidget {
  const ContinueButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 1,
          color: ColorConstant.kBlackColor.withOpacity(0.5),
        ),
        Container(
          alignment: Alignment.center,
          color: ColorConstant.kBlackColor.withOpacity(0.1),
          height: 70,
          child: BlocBuilder<RegisterPageBloc, RegisterPageState>(
            builder: (context, state) {
              return InkWell(
                onTap: () {
                  if (state.fullNameErrorMsg.isEmpty) {
                    BlocProvider.of<RegisterPageBloc>(context)
                        .add(ContinueButtonEvent(buildContext: context));
                  }
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 60),
                  decoration: BoxDecoration(
                    color: state.fullNameErrorMsg.isEmpty
                        ? const Color.fromARGB(255, 255, 161, 79)
                        : ColorConstant.kOrangeColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: state.fullNameErrorMsg.isEmpty
                            ? ColorConstant.kOrangeColor
                            : ColorConstant.kOrangeColor.withOpacity(0.3),
                        width: 1.5),
                  ),
                  child: const Text(
                    'CONTINUE',
                    style: TextStyle(
                      color: ColorConstant.kWhiteColor,
                      fontSize: 18,
                      letterSpacing: 3,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
