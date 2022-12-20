import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:sportly/domain/features/schedule/models/day_event.f.dart';
import 'package:sportly/domain/features/teams/models/role.dart';
import 'package:sportly/domain/features/teams/models/team.f.dart';
import 'package:sportly/presentation/gen/local_keys.g.dart';
import 'package:sportly/presentation/pages/events_list/events_list_page_action.f.dart';
import 'package:sportly/presentation/pages/events_list/events_list_page_cubit.dart';
import 'package:sportly/presentation/pages/events_list/events_list_page_state.f.dart';
import 'package:sportly/presentation/routing/main_router.gr.dart';
import 'package:sportly/presentation/theme/app_colors.dart';
import 'package:sportly/presentation/theme/app_dimens.dart';
import 'package:sportly/presentation/theme/app_typo.dart';
import 'package:sportly/presentation/widgets/show_delete_event_dialog.dart';
import 'package:sportly/presentation/widgets/sportly_card.dart';
import 'package:sportly/presentation/widgets/sportly_divider.dart';
import 'package:sportly/presentation/widgets/sportly_error.dart';
import 'package:sportly/presentation/widgets/sportly_loader.dart';
import 'package:sportly/utils/extensions/date_time_extension.dart';

class EventsListPage extends HookWidget {
  const EventsListPage({
    Key? key,
    required this.team,
    required this.date,
  }) : super(key: key);

  final Team team;
  final DateTime date;

  @override
  Widget build(BuildContext context) {
    final cubit = useCubit<EventsListPageCubit>();
    final state = useCubitBuilder(cubit);

    useActionListener<EventsListPageAction>(cubit, (action) {
      action.whenOrNull(
        showLoader: context.loaderOverlay.show,
        hideLoader: context.loaderOverlay.hide,
        deleteSuccess: (popPage) {
          if (popPage) {
            context.router.popUntilRouteWithName(SchedulePageRoute.name);
            context.router.popAndPush(SchedulePageRoute(team: team));
          }
        },
      );
    });

    useEffect(
      () {
        cubit.init(team.id, date);
      },
      [],
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      floatingActionButton: state.when(
        loading: () => const SizedBox.shrink(),
        idle: (_, __) => team.role.isAdminOrAssistant
            ? FloatingActionButton(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.neutral,
                child: const Icon(Icons.add_rounded),
                onPressed: () {
                  context.router.push(
                    CreateEventPageRoute(
                      team: team,
                      date: date.withCurrentTime,
                      fromMonthView: false,
                    ),
                  );
                },
              )
            : const SizedBox.shrink(),
        noEvents: (_) => const SizedBox.shrink(),
        error: () => const SizedBox.shrink(),
      ),
      body: state.map(
        loading: (_) => const SportlyLoader(),
        idle: (state) => _Idle(
          cubit: cubit,
          state: state,
          teamId: team.id,
        ),
        noEvents: (state) => _NoEvents(
          state: state,
        ),
        error: (_) => const SportlyError(),
      ),
    );
  }
}

class _Idle extends StatelessWidget {
  const _Idle({
    Key? key,
    required this.cubit,
    required this.state,
    required this.teamId,
  }) : super(key: key);

  final EventsListPageCubit cubit;
  final EventsListPageStateIdle state;
  final int teamId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDimens.pagePadding),
      child: SportlyCard(
        content: Column(
          children: [
            Row(
              children: [
                const Icon(Icons.calendar_today_rounded),
                const Gap(AppDimens.xsm),
                Text(
                  state.date.formatEEEEMMMdd(),
                  style: AppTypo.bodyLarge.copyWith(
                    fontFamily: 'Montserrat',
                  ),
                ),
              ],
            ),
            const Gap(AppDimens.xbig),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: state.events
                      .map(
                        (event) => Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          text: event.date.formatHHMM(),
                                          style: AppTypo.bodySmall.copyWith(
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.bold,
                                          ),
                                          children: [
                                            TextSpan(
                                              text: ' ' + event.title,
                                              style:
                                                  AppTypo.bodyMedium.copyWith(
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      if (event.description != null) ...[
                                        const Gap(AppDimens.xxsm),
                                        Text(
                                          event.description!,
                                          style: AppTypo.labelLarge,
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ]
                                    ],
                                  ),
                                ),
                                if (event.editable)
                                  _PopupMenuButton(
                                    event: event,
                                    teamId: teamId,
                                    cubit: cubit,
                                  ),
                              ],
                            ),
                            if (state.events.indexOf(event) <
                                state.events.length - 1) ...[
                              const Gap(AppDimens.sm),
                              const SportlyDivider(),
                              const Gap(AppDimens.sm),
                            ]
                          ],
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NoEvents extends StatelessWidget {
  const _NoEvents({
    Key? key,
    required this.state,
  }) : super(key: key);

  final EventsListPageStateNoEvents state;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDimens.pagePadding),
      child: Text(
        LocaleKeys.events_list_no_events
            .tr(args: [state.date.formatEEEEMMMdd()]),
        style: AppTypo.bodyMedium.copyWith(
          fontFamily: 'Montserrat',
        ),
      ),
    );
  }
}

class _PopupMenuButton extends StatelessWidget {
  const _PopupMenuButton({
    Key? key,
    required this.event,
    required this.teamId,
    required this.cubit,
  }) : super(key: key);

  final DayEvent event;
  final int teamId;
  final EventsListPageCubit cubit;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(AppDimens.borderRadius),
        ),
      ),
      itemBuilder: (BuildContext context) => <PopupMenuEntry>[
        PopupMenuItem(
          child: Text(
            LocaleKeys.events_list_update_event.tr(),
            style: AppTypo.bodySmall,
          ),
          onTap: () => context.router.push(
            UpdateEventPageRoute(event: event, teamId: teamId),
          ),
        ),
        PopupMenuItem(
          child: Text(
            LocaleKeys.events_list_delete_event.tr(),
            style: AppTypo.bodySmall.copyWith(
              color: AppColors.danger,
            ),
          ),
          onTap: () => showDeleteEventDialog(
            context,
            event.title,
            () => cubit.deleteEvent(event.id),
          ),
        ),
      ],
      child: const Icon(
        Icons.more_vert_rounded,
      ),
    );
  }
}
