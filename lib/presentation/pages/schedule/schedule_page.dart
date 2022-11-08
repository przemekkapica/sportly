import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sportly/presentation/theme/app_colors.dart';
import 'package:sportly/presentation/theme/app_dimens.dart';
import 'package:sportly/presentation/theme/app_typo.dart';
import 'package:sportly/utils/extensions/date_time_extension.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _initMockEvents(context);

    return Scaffold(
      body: MonthView(
        headerBuilder: (date) {
          return Container(
            color: AppColors.background,
            child: Padding(
              padding: const EdgeInsets.all(AppDimens.sm),
              child: Center(
                child: Text(
                  date.formatMMMMYY(),
                  style: AppTypo.bodySmall.copyWith(color: AppColors.primary),
                ),
              ),
            ),
          );
        },
        cellBuilder: (date, events, isToday, isInMonth) {
          return Container(
            color: isInMonth ? AppColors.neutral : AppColors.additional2,
            child: Padding(
              padding: const EdgeInsets.all(AppDimens.xxxsm),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(AppDimens.xxxsm),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isToday ? AppColors.primary : Colors.transparent,
                    ),
                    child: Center(
                      child: Text(
                        date.day.toString(),
                        style: AppTypo.labelSmall.copyWith(
                          color:
                              isToday ? AppColors.neutral : AppColors.secondary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const Gap(AppDimens.xxsm),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: events
                            .map(
                              (event) => Column(
                                children: [
                                  Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: isInMonth
                                          ? event.color
                                          : AppColors.secondary,
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(AppDimens.xxxsm),
                                      ),
                                    ),
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.all(AppDimens.xxxsm),
                                      child: Text(
                                        event.title,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: AppTypo.labelSmall
                                            .copyWith(color: AppColors.neutral),
                                      ),
                                    ),
                                  ),
                                  const Gap(AppDimens.xxxsm),
                                ],
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
        onCellTap: (events, date) {
          // Implement callback when user taps on a cell.
          print(events);
        },
      ),
    );
  }

  void _initMockEvents(BuildContext context) {
    var event1 = CalendarEventData(
      date: DateTime(2022, 11, 10, 9, 30),
      title: 'Meeting',
      color: AppColors.primary,
    );
    var event2 = CalendarEventData(
      date: DateTime(2022, 11, 10),
      title: 'Training',
      color: AppColors.primary,
    );
    var event3 = CalendarEventData(
      date: DateTime(2022, 11, 10),
      title: 'Match',
      color: AppColors.danger,
    );
    var event4 = CalendarEventData(
      date: DateTime(2022, 11, 10),
      title: 'Meeting',
      color: AppColors.primary,
    );

    CalendarControllerProvider.of(context).controller.add(event1);
    CalendarControllerProvider.of(context).controller.add(event2);
    CalendarControllerProvider.of(context).controller.add(event3);
    CalendarControllerProvider.of(context).controller.add(event4);
    CalendarControllerProvider.of(context).controller.add(event1);
    CalendarControllerProvider.of(context).controller.add(event2);
    CalendarControllerProvider.of(context).controller.add(event3);
    CalendarControllerProvider.of(context).controller.add(event4);

    event1 = CalendarEventData(
      date: DateTime(2022, 11, 14, 9, 30),
      title: 'Meeting',
      color: AppColors.primary,
    );
    event2 = CalendarEventData(
      date: DateTime(2022, 12, 1),
      title: 'Training',
      color: AppColors.team1,
    );
    event3 = CalendarEventData(
      date: DateTime(2022, 11, 16),
      title: 'Long match name',
      color: AppColors.danger,
    );
    event4 = CalendarEventData(
      date: DateTime(2022, 11, 20),
      title: 'Meeting',
      color: AppColors.primary,
    );

    CalendarControllerProvider.of(context).controller.add(event1);
    CalendarControllerProvider.of(context).controller.add(event2);
    CalendarControllerProvider.of(context).controller.add(event3);
    CalendarControllerProvider.of(context).controller.add(event4);
  }
}
