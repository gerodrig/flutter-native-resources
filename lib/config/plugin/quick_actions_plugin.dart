import 'package:miscellanous/config/config.dart';
import 'package:quick_actions/quick_actions.dart';

class QuickActionsPlugin {
  static registerActions() {
    const QuickActions quickActions = QuickActions();

    quickActions.initialize((type) {
      switch (type) {
        case 'biometric':
          router.push('/biometric');
          break;
        case 'compass':
          router.push('/compass');
          break;
        case 'pokemons':
          //got to minnccino pokemon id
          router.push('/pokemons');
          break;
        case 'pikachu':
          router.push('/pokemons/25');
          break;
        default:
      }
    });

    quickActions.setShortcutItems(<ShortcutItem>[
      const ShortcutItem(
        type: 'biometric',
        localizedTitle: 'Biometric',
        icon: 'finger',
      ),
      const ShortcutItem(
        type: 'compass',
        localizedTitle: 'Compass',
        icon: 'compass',
      ),
      const ShortcutItem(
        type: 'pokemons',
        localizedTitle: 'Pokemons',
        icon: 'pokemons',
      ),
      const ShortcutItem(
        type: 'pikachu',
        localizedTitle: 'Pikachu',
        icon: 'charmander',
      ),
    ]);
  }
}
