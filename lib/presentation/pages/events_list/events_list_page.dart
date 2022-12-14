import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:sportly/presentation/pages/events_list/events_list_page_action.f.dart';
import 'package:sportly/presentation/pages/events_list/events_list_page_cubit.dart';
import 'package:sportly/presentation/pages/events_list/events_list_page_state.f.dart';
import 'package:sportly/presentation/routing/main_router.gr.dart';
import 'package:sportly/presentation/theme/app_colors.dart';
import 'package:sportly/presentation/theme/app_dimens.dart';
import 'package:sportly/presentation/theme/app_typo.dart';
import 'package:sportly/presentation/widgets/sportly_card.dart';
import 'package:sportly/presentation/widgets/sportly_divider.dart';
import 'package:sportly/presentation/widgets/sportly_error.dart';
import 'package:sportly/presentation/widgets/sportly_loader.dart';
import 'package:sportly/utils/extensions/date_time_extension.dart';

class EventsListPage extends HookWidget {
  const EventsListPage({
    Key? key,
    required this.teamId,
    required this.date,
  }) : super(key: key);

  final int teamId;
  final DateTime date;

  @override
  Widget build(BuildContext context) {
    final cubit = useCubit<EventsListPageCubit>();
    final state = useCubitBuilder(cubit);

    useActionListener<EventsListPageAction>(cubit, (action) {
      action.whenOrNull(
        showLoader: context.loaderOverlay.show,
        hideLoader: context.loaderOverlay.hide,
      );
    });

    useEffect(
      () {
        cubit.init(teamId, date);
      },
      [],
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      floatingActionButton: state.when(
        loading: () => const SizedBox.shrink(),
        idle: (_) => FloatingActionButton(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.neutral,
          child: const Icon(Icons.add_rounded),
          onPressed: () {
            context.router.push(
              CreateEventPageRoute(teamId: teamId, date: date),
            );
          },
        ),
        error: () => const SizedBox.shrink(),
      ),
      body: state.map(
        loading: (_) => const SportlyLoader(),
        idle: (state) => _Idle(
          cubit: cubit,
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
  }) : super(key: key);

  final EventsListPageCubit cubit;
  final EventsListPageStateIdle state;

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
                  state.events[0].date.formatEEEEMMMdd(),
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
                                const _PopupMenuButton(),
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

class _PopupMenuButton extends StatelessWidget {
  const _PopupMenuButton({
    Key? key,
  }) : super(key: key);

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
            'Edit event',
            style: AppTypo.bodySmall,
          ),
          onTap: () => context.router.push(
            EditEventPageRoute(date: DateTime.now(), teamId: 1),
          ),
        ),
        PopupMenuItem(
          child: Text(
            'Delete event',
            style: AppTypo.bodySmall.copyWith(
              color: AppColors.danger,
            ),
          ),
          onTap: () {},
        ),
      ],
      child: const Icon(
        Icons.more_vert_rounded,
      ),
    );
  }
}
