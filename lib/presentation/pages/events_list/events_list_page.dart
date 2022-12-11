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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SportlyCard(
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
                ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  text: state.events[index].date.formatHHMM(),
                                  style: AppTypo.bodySmall.copyWith(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: ' ' + state.events[index].title,
                                      style: AppTypo.bodyMedium.copyWith(
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (state.events[index].description != null) ...[
                                const Gap(AppDimens.xxsm),
                                Text(
                                  state.events[index].description!,
                                  style: AppTypo.labelLarge,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ]
                            ],
                          ),
                        ),
                        _PopupMenuButton(index: index),
                      ],
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Column(
                      children: const [
                        Gap(AppDimens.md),
                        SportlyDivider(),
                        Gap(AppDimens.md),
                      ],
                    );
                  },
                  itemCount: state.events.length,
                ),
                const Gap(AppDimens.xsm),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PopupMenuButton extends StatelessWidget {
  const _PopupMenuButton({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

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
          onTap: () {},
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
