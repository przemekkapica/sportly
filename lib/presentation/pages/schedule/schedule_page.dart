import 'package:auto_route/auto_route.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:sportly/domain/features/teams/models/role.dart';
import 'package:sportly/domain/features/teams/models/team.f.dart';
import 'package:sportly/presentation/pages/schedule/schedule_page_cubit.dart';
import 'package:sportly/presentation/pages/schedule/schedule_page_state.f.dart';
import 'package:sportly/presentation/routing/main_router.gr.dart';
import 'package:sportly/presentation/theme/app_colors.dart';
import 'package:sportly/presentation/theme/app_dimens.dart';
import 'package:sportly/presentation/theme/app_typo.dart';
import 'package:sportly/presentation/widgets/sportly_error.dart';
import 'package:sportly/presentation/widgets/sportly_loader.dart';
import 'package:sportly/utils/extensions/date_time_extension.dart';

class SchedulePage extends HookWidget {
  const SchedulePage({
    Key? key,
    required this.team,
  }) : super(key: key);

  final Team team;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      for (var event
          in CalendarControllerProvider.of(context).controller.events) {
        CalendarControllerProvider.of(context).controller.remove(event);
      }
    });

    final cubit = useCubit<SchedulePageCubit>();
    final state = useCubitBuilder(cubit);

    // useActionListener<SchedulePageAction>(cubit, (action) {
    //   action.whenOrNull(
    //     showLoader: context.loaderOverlay.show,
    //     hideLoader: context.loaderOverlay.hide,
    //   );
    // });

    useEffect(
      () {
        cubit.init(team.id);
      },
    );

    return Scaffold(
      floatingActionButton: state.when(
        loading: () => const SizedBox.shrink(),
        idle: (_) => team.role.isAdminOrAssistant
            ? FloatingActionButton(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.neutral,
                child: const Icon(Icons.add_rounded),
                onPressed: () {
                  context.router.push(
                    CreateEventPageRoute(
                      team: team,
                      date: DateTime.now(),
                      fromMonthView: true,
                    ),
                  );
                },
              )
            : const SizedBox.shrink(),
        error: () => const SizedBox.shrink(),
      ),
      body: state.map(
        idle: (state) => _Idle(
          cubit: cubit,
          state: state,
          team: team,
        ),
        loading: (_) => const SportlyLoader(),
        error: (_) => const SportlyError(),
      ),
    );
  }
}

class _Idle extends HookWidget {
  const _Idle({
    Key? key,
    required this.cubit,
    required this.state,
    required this.team,
  }) : super(key: key);

  final SchedulePageCubit cubit;
  final SchedulePageStateIdle state;
  final Team team;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      CalendarControllerProvider.of(context).controller.addAll(state.events);
    });

    return MonthView(
      headerBuilder: (date) {
        return Container(
          color: AppColors.background,
          child: Padding(
            padding: const EdgeInsets.all(AppDimens.sm),
            child: RichText(
              text: TextSpan(
                text: team.name,
                style: AppTypo.bodySmall.copyWith(
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Montserrat',
                ),
                children: [
                  TextSpan(
                    text: ' - ' + date.formatMMMMYY(),
                    style: AppTypo.bodySmall.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
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
                                        ? AppColors.primary
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
      onPageChange: (date, _) => cubit.refreshEvents(date),
      onCellTap: (calendarEvents, date) {
        if (calendarEvents.isEmpty && team.role.isAdminOrAssistant) {
          context.router.push(
            CreateEventPageRoute(
              team: team,
              date: date.withCurrentTime,
              fromMonthView: true,
            ),
          );
        } else if (calendarEvents.isNotEmpty) {
          context.router.push(
            EventsListPageRoute(
              team: team,
              date: date,
            ),
          );
        }
      },
    );
  }
}
