import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:sportly/presentation/gen/local_keys.g.dart';
import 'package:sportly/presentation/theme/app_colors.dart';
import 'package:sportly/presentation/theme/app_dimens.dart';
import 'package:sportly/presentation/theme/app_typo.dart';
import 'package:sportly/presentation/widgets/form/sportly_dropdown.dart';
import 'package:sportly/presentation/widgets/form/sportly_radio_button.dart';
import 'package:sportly/presentation/widgets/form/sportly_text_input.dart';
import 'package:sportly/presentation/widgets/scroll_or_fit_bottom.dart';
import 'package:sportly/presentation/widgets/sportly_button.dart';
import 'package:sportly/presentation/widgets/sportly_card.dart';

enum TeamType { professional, amateur }

const List<String> disciplines = <String>[
  'Football',
  'Basketball',
  'Tennis',
  'Handball'
];

class CreateTeamPage extends HookWidget {
  const CreateTeamPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final teamType = useState(TeamType.professional);
    final scrollController = useScrollController();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.all(AppDimens.pagePadding),
        child: ScrollOrFitBottom(
          controller: scrollController,
          scrollableContent: [
            Form(
              key: formKey,
              child: Column(
                children: [
                  SportlyCard(
                    padding: const EdgeInsets.symmetric(
                      vertical: AppDimens.big,
                      horizontal: AppDimens.sm,
                    ),
                    borderColor: AppColors.secondary.withAlpha(80),
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          LocaleKeys.create_team_team_type.tr(),
                          style: AppTypo.bodySmall,
                        ),
                        const Gap(AppDimens.sm),
                        Row(
                          children: <Widget>[
                            SportlyRadioButton(
                              value: TeamType.professional,
                              groupValue: teamType.value,
                              label: LocaleKeys.create_team_professional.tr(),
                              onChanged: (TeamType? value) {
                                if (value != null) {
                                  teamType.value = value;
                                }
                              },
                            ),
                            const Gap(AppDimens.xbig),
                            SportlyRadioButton(
                              value: TeamType.amateur,
                              groupValue: teamType.value,
                              label: LocaleKeys.create_team_amateur.tr(),
                              onChanged: (TeamType? value) {
                                if (value != null) {
                                  teamType.value = value;
                                }
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Gap(AppDimens.md),
                  SportlyTextInput(
                    label: LocaleKeys.create_team_team_name.tr(),
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return LocaleKeys.create_team_team_name_error.tr();
                      }
                      return null;
                    },
                  ),
                  const Gap(AppDimens.md),
                  SportlyTextInput(
                    label: LocaleKeys.create_team_team_name.tr(),
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return LocaleKeys.create_team_team_name_error.tr();
                      }
                      return null;
                    },
                  ),
                  const Gap(AppDimens.md),
                  SportlyTextInput(
                    label: LocaleKeys.create_team_team_name.tr(),
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return LocaleKeys.create_team_team_name_error.tr();
                      }
                      return null;
                    },
                  ),
                  const Gap(AppDimens.md),
                  SportlyTextInput(
                    label: LocaleKeys.create_team_location.tr(),
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return LocaleKeys.create_team_location_error.tr();
                      }
                      return null;
                    },
                  ),
                  const Gap(AppDimens.md),
                  SportlyTextInput(
                    label: LocaleKeys.create_team_organization_name.tr(),
                    textInputAction: TextInputAction.done,
                    validator: (_) => null,
                  ),
                  const Gap(AppDimens.md),
                  SportlyDropdown(
                    hintText: LocaleKeys.create_team_discipline.tr(),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return LocaleKeys.create_team_discipline_error.tr();
                      }
                      return null;
                    },
                    items: disciplines
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: AppTypo.bodySmall,
                        ),
                      );
                    }).toList(),
                  ),
                  const Gap(AppDimens.xbig),
                ],
              ),
            ),
          ],
          bottomContent: SportlyButton.solid(
            onTap: () {
              if (formKey.currentState!.validate()) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Processing Data')),
                );
              }
            },
            label: LocaleKeys.create_team_button_label.tr(),
          ),
        ),
      ),
    );
  }
}
