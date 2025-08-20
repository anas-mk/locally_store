import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locally/common/bloc/button/button_state.dart';
import 'package:locally/common/bloc/button/button_state_cubit.dart';
import 'package:locally/common/helper/bottomsheet/app_bottomsheet.dart';
import 'package:locally/core/configs/theme/app_colors.dart';
import 'package:locally/data/auth/models/user_creation_req.dart';
import 'package:locally/domain/auth/usecases/siginup.dart';
import 'package:locally/presentation/auth/bloc/age_selection_cubit.dart';
import 'package:locally/presentation/auth/bloc/ages_display_cubit.dart';
import 'package:locally/presentation/auth/bloc/gender_selection_cubit.dart';
import 'package:locally/presentation/auth/pages/signin.dart';
import 'package:locally/presentation/auth/widgets/ages.dart';
import '../../../common/widgets/appbar/app_bar.dart';
import '../../../common/widgets/button/basic_reactive_button.dart';

class GenderAndAgeSelectionPage extends StatelessWidget {
  final UserCreationReq userCreationReq;

  const GenderAndAgeSelectionPage({required this.userCreationReq, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppbar(),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => GenderSelectionCubit()),
          BlocProvider(create: (context) => AgeSelectionCubit()),
          BlocProvider(create: (context) => AgesDisplayCubit()),
          BlocProvider(create: (context) => ButtonStateCubit()),
        ],
        child: BlocListener<ButtonStateCubit, ButtonState>(
          listener: (context, state) {
            if (state is ButtonSuccessState) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const SigninPage()),
              );
            } else if (state is ButtonFailureState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage.toString()),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            }
          },
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 30,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Tell us about yourself',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: AppColors.text,
                        ),
                      ),
                      const SizedBox(height: 30),
                      _genders(),
                      const SizedBox(height: 30),
                      const Text(
                        'How old are you?',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: AppColors.text,
                        ),
                      ),
                      const SizedBox(height: 30),
                      _age(),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
              Builder(builder: (context) => _finishButton(context)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _genders() {
    return BlocBuilder<GenderSelectionCubit, int>(
      builder: (context, selectedIndex) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _genderTile(context, 1, 'Men', selectedIndex),
            const SizedBox(width: 20),
            _genderTile(context, 2, 'Women', selectedIndex),
          ],
        );
      },
    );
  }

  Widget _genderTile(
    BuildContext context,
    int genderIndex,
    String gender,
    int selectedIndex,
  ) {
    final isSelected = selectedIndex == genderIndex;

    return Expanded(
      child: GestureDetector(
        onTap:
            () =>
                context.read<GenderSelectionCubit>().selectGender(genderIndex),
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : AppColors.secondBackground,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Center(
            child: Text(
              gender,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: isSelected ? Colors.white : AppColors.text,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _age() {
    return BlocBuilder<AgeSelectionCubit, String>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            AppBottomSheet.display(
              context,
              MultiBlocProvider(
                providers: [
                  BlocProvider.value(value: context.read<AgeSelectionCubit>()),
                  BlocProvider.value(
                    value: context.read<AgesDisplayCubit>()..displayAges(),
                  ),
                ],
                child: const Ages(),
              ),
            );
          },
          child: Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: AppColors.secondBackground,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  state.isEmpty ? 'Select age' : state,
                  style: TextStyle(
                    color: state.isEmpty ? Colors.grey : AppColors.text,
                    fontSize: 16,
                  ),
                ),
                const Icon(
                    Icons.keyboard_arrow_down,
                  color: AppColors.text,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _finishButton(BuildContext context) {
    return Container(
      height: 70,
      color: AppColors.background,
      child: Center(
        child: BasicReactiveButton(
          title: 'Finish',
          onPressed: () {
            final gender = context.read<GenderSelectionCubit>().selectedIndex;
            final age = context.read<AgeSelectionCubit>().selectedAge;

            if (gender == 0 || age.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Please select gender and age'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
              return;
            }

            userCreationReq.gender = gender;
            userCreationReq.age = age;

            context.read<ButtonStateCubit>().execute(
              usecase: SignupUseCase(),
              params: userCreationReq,
            );
          },
        ),
      ),
    );
  }
}
