import 'package:rive/rive.dart';

class RiveModel {
  final String action, src, artBoard, stateMachineName;
  late String? label = '';
  late SMITrigger? statusTrigger;
  late SMIBool? statusBool;
  final KindSetting? kindSetting;

  RiveModel(
      {this.kindSetting,
      required this.action,
      this.label,
      required this.src,
      required this.artBoard,
      required this.stateMachineName,
      this.statusTrigger,
      this.statusBool});

  set setStatusTrigger(SMITrigger state) {
    statusTrigger = state;
  }

  set setStatusBool(SMIBool state) {
    statusBool = state;
  }
}

class RiveUtils {
  static SMITrigger getRiveTrigger(Artboard artBoard, String action,
      {required String stateMachineName}) {
    StateMachineController? controller =
        StateMachineController.fromArtboard(artBoard, stateMachineName);

    artBoard.addController(controller!);

    return controller.findSMI(action);
  }

  static SMIBool getRiveBool(Artboard artBoard, String action,
      {required String stateMachineName}) {
    StateMachineController? controller =
        StateMachineController.fromArtboard(artBoard, stateMachineName);

    artBoard.addController(controller!);

    return controller.findSMI(action);
  }

  static void changeSMITriggerState(SMITrigger input) {
    input.change(true);
  }

  static void changeSMIBoolState(SMIBool input) {
    input.change(input.value);
  }

  // Light And Dark Animation
  static RiveModel lightOrDarkModel = RiveModel(
      action: 'IsPressed',
      src: 'assets/rives/switch_button_day&night.riv',
      artBoard: 'New Artboard',
      stateMachineName: 'State Machine 1');

  // LogOut Animation
  static RiveModel logOut = RiveModel(
      action: 'click',
      src: 'assets/rives/icons.riv',
      artBoard: 'EXIT',
      stateMachineName: 'state_machine');

// Pigeon Animation
  static RiveModel pigeonModel = RiveModel(
      action: 'hover',
      src: 'assets/rives/pigeons.riv',
      artBoard: 'New Artboard',
      stateMachineName: 'State Machine 1');

// Review Animation
  static RiveModel reviewModel = RiveModel(
      action: 'click',
      src: 'assets/rives/review_button.riv',
      artBoard: 'Publish Button',
      stateMachineName: 'State Machine 1');

// AddToCart Animation
  static RiveModel addToCartModel = RiveModel(
      action: 'add',
      src: 'assets/rives/add_to_cart.riv',
      artBoard: 'Added to Cart',
      stateMachineName: 'State Machine 1');

// Bottom Animation Icons
  static List<RiveModel> bottomModel = [
    RiveModel(
        src: 'assets/rives/animated_icon_set_-_1_color.riv',
        artBoard: "SEARCH",
        stateMachineName: "SEARCH_Interactivity",
        label: 'Explore',
        action: 'click'),
    RiveModel(
        src: 'assets/rives/heart.riv',
        artBoard: 'hert Effect',
        stateMachineName: 'switch',
        label: 'Saved',
        action: 'click'),
    RiveModel(
        src: 'assets/rives/animated_icon_set_-_1_color.riv',
        artBoard: "BELL",
        stateMachineName: "BELL_Interactivity",
        label: 'Notifications',
        action: 'click'),
    RiveModel(
        src: 'assets/rives/animated_icon_set_-_1_color.riv',
        artBoard: "USER",
        stateMachineName: "USER_Interactivity",
        label: 'Profile',
        action: 'click'),
  ];

//   Profile Animation Icons
  static List<RiveModel> profileIcons = [
    RiveModel(
        src: 'assets/rives/animated_icons_pack_1.riv',
        artBoard: 'EMPOLYEE  ICON',
        stateMachineName: "USER",
        label: 'Edit Account',
        action: 'click',
        kindSetting: KindSetting.account),
    RiveModel(
        src: 'assets/rives/animated_icons_pack_1.riv',
        artBoard: "LOCATION ICON",
        stateMachineName: "LOCATION",
        label: 'My Locations',
        action: 'click',
        kindSetting: KindSetting.account),
    RiveModel(
        src: 'assets/rives/icon_my_order.riv',
        artBoard: "archive-box",
        stateMachineName: "State Machine 1",
        label: 'My Orders',
        action: 'click',
        kindSetting: KindSetting.account),
    RiveModel(
        src: 'assets/rives/animated_icons_pack_1.riv',
        artBoard: 'WALLET  ICON',
        stateMachineName: "WALLET",
        label: 'Payment Methods',
        action: 'click',
        kindSetting: KindSetting.account),
    RiveModel(
        src: 'assets/rives/icons.riv',
        artBoard: "LIKE/STAR",
        stateMachineName: "STAR_Interactivity",
        label: 'My Reviews',
        action: 'click',
        kindSetting: KindSetting.account),
    RiveModel(
        src: 'assets/rives/animated_icons_pack_1.riv',
        artBoard: "GLOBE ICON",
        stateMachineName: "GLOBEL",
        label: 'About Us',
        action: 'click',
        kindSetting: KindSetting.general),
    RiveModel(
        src: 'assets/rives/icon_data.riv',
        artBoard: "COINS",
        stateMachineName: "COINS_Interactivity",
        label: 'Data Usage',
        action: 'click',
        kindSetting: KindSetting.general)
  ];
}

enum KindSetting { account, general }
