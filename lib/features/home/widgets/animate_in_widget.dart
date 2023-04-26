import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smart_chef_app/features/footer/footer.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

final isShownProvider = StateProvider.family<bool, Key>((_, __) => false);

const kAnimateInDuration = Duration(milliseconds: 300);
const kAnimateInCurve = Curves.easeInOut;
const kDelay = Duration(milliseconds: 500);

class AnimateIn extends HookConsumerWidget {
  final ValueKey uKey;
  final Widget child;
  final Duration duration;
  final Curve curve;
  final Offset? offset;
  final Duration delay;

  const AnimateIn({
    required this.uKey,
    required this.child,
    this.duration = kAnimateInDuration,
    this.curve = kAnimateInCurve,
    this.offset,
    this.delay = kDelay,
  }) : super(key: uKey);

  @override
  Widget build(BuildContext context, ref) {
    final isShown = ref.watch(isShownProvider(uKey));
    final isMounted = useIsMounted();

    useEffect(
      () {
        if (!ref.read(isShownProvider(uKey))) {
          Future.delayed(delay, () {
            if (isMounted()) {
              ref.read(isShownProvider(uKey).notifier).state = true;
            }
          });
        }
        return null;
      },
      [],
    );

    return AnimatedOpacity(
      duration: duration,
      opacity: isShown ? 1 : 0,
      curve: curve,
      child: AnimatedContainer(
        duration: duration,
        curve: curve,
        transform: Matrix4.translationValues(
          isShown ? 0 : offset!.dx,
          isShown ? 0 : offset!.dy,
          0,
        ).ifW(offset != null),
        child: child,
      ),
    );
  }
}
