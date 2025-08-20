import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locally/core/configs/theme/app_colors.dart';
import 'package:locally/presentation/auth/bloc/age_selection_cubit.dart';
import 'package:locally/presentation/auth/bloc/ages_display_cubit.dart';
import 'package:locally/presentation/auth/bloc/ages_display_states.dart';

class Ages extends StatelessWidget {
  const Ages({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2.5,
      child: BlocBuilder<AgesDisplayCubit, AgesDisplayState>(
        builder: (context, state) {
          if (state is AgesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AgesLoaded) {
            return _buildAgesList(context, state.ages);
          } else if (state is AgesLoadFailure) {
            return Center(child: Text(state.message));
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  Widget _buildAgesList(
      BuildContext context,
      List<QueryDocumentSnapshot<Map<String, dynamic>>> ages,
      ) {
    final selectedAge = context.watch<AgeSelectionCubit>().state;

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      physics: const BouncingScrollPhysics(),
      itemCount: ages.length,
      separatorBuilder: (_, __) => const SizedBox(height: 20),
      itemBuilder: (context, index) {
        final data = ages[index].data();
        final dynamic rawValue = data['value'];
        final String value = rawValue?.toString() ?? 'Unknown';

        final bool isSelected = selectedAge == value;

        return GestureDetector(
          onTap: () {
            context.read<AgeSelectionCubit>().selectAge(value);
            Navigator.pop(context);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.primary.withOpacity(0.2)
                  : AppColors.secondBackground,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected ? AppColors.primary : Colors.transparent,
                width: 1.5,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 18,
                    color: isSelected ? AppColors.primary : AppColors.text,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
