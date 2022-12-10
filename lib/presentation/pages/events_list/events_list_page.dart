import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:sportly/presentation/pages/events_list/events_list_page_action.f.dart';
import 'package:sportly/presentation/pages/events_list/events_list_page_cubit.dart';
import 'package:sportly/presentation/pages/events_list/events_list_page_state.f.dart';
import 'package:sportly/presentation/theme/app_colors.dart';
import 'package:sportly/presentation/theme/app_dimens.dart';
import 'package:sportly/presentation/theme/app_typo.dart';
import 'package:sportly/presentation/widgets/sportly_card.dart';
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
          RichText(
            text: TextSpan(
              text: ' ' + state.events[0].date.formatEEEEMMMdd(),
              style: AppTypo.bodySmall.copyWith(
                fontWeight: FontWeight.w600,
                fontFamily: 'Montserrat',
              ),
              children: [
                TextSpan(
                  text: ' events',
                  style: AppTypo.bodySmall.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          const Gap(AppDimens.sm),
          ListView.separated(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return SportlyCard(
                content: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${state.events[index].date.formatHHMM()}: ${state.events[index].title}',
                            style: AppTypo.bodySmall,
                          ),
                          if (state.events[index].description != null) ...[
                            const Gap(AppDimens.xxsm),
                            Text(
                              state.events[index].description!,
                              style: AppTypo.labelMedium,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ]
                        ],
                      ),
                    ),
                    _PopupMenuButton(index: index),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const Gap(AppDimens.sm);
            },
            itemCount: state.events.length,
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
