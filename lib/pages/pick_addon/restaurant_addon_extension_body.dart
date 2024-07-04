// part of 'restaurant_addon.dart';
//
// Widget restaurantAddonBody(BuildContext context) {
//   final restaurantAddonBloc = context.read<RestaurantAddonBloc>();
//   return SizedBox(
//     height: 1330,
//     child: Column(
//       children: [
//         Expanded(
//           flex: 3,
//           child: Column(
//             children: [
//               const Padding(
//                 padding: EdgeInsets.fromLTRB(24, 24, 24, 0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     CustomText(
//                         content: 'Variation',
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold),
//                     CustomText(
//                       content: 'Required',
//                       color: AppColor.globalPink,
//                     )
//                   ],
//                 ),
//               ),
//               Expanded(
//                 child: BlocBuilder<RestaurantAddonBloc, RestaurantAddonState>(
//                   buildWhen: (previous, current) =>
//                       current is RestaurantAddonPickSizeState ||
//                       current is RestaurantAddonLoadingSuccessState,
//                   builder: (context, state) {
//                     switch (state.runtimeType) {
//                       case RestaurantAddonLoadingSuccessState:
//                         final success =
//                             state as RestaurantAddonLoadingSuccessState;
//                         return ListView.separated(
//                           physics: const NeverScrollableScrollPhysics(),
//                           itemCount: success.addons.length,
//                           itemBuilder: (BuildContext context, int index) {
//                             return RadioListTile.adaptive(
//                               secondary: CustomText(
//                                   content:
//                                       '\$${success.addons[index].sizePrice}'),
//                               title: CustomText(
//                                   content: success.addons[index].size),
//                               activeColor: AppColor.globalPink,
//                               value: success.addons[index].type,
//                               groupValue: restaurantAddonBloc.turnOn,
//                               onChanged: (value) {
//                                 restaurantAddonBloc.add(
//                                     RestaurantAddonPickSizeEvent(
//                                         turnOn: value!, index: index));
//                               },
//                             );
//                           },
//                           separatorBuilder: (BuildContext context, int index) {
//                             return Divider(color: Colors.grey[300]);
//                           },
//                         );
//                     }
//                     return ListView.separated(
//                       physics: const NeverScrollableScrollPhysics(),
//                       itemCount: addons.length,
//                       itemBuilder: (BuildContext context, int index) {
//                         return RadioListTile.adaptive(
//                           secondary: CustomText(
//                               content: '\$${addons[index].sizePrice}'),
//                           title: CustomText(content: addons[index].size),
//                           activeColor: AppColor.globalPink,
//                           value: addons[index].type,
//                           groupValue: restaurantAddonBloc.turnOn,
//                           onChanged: (value) {
//                             restaurantAddonBloc.add(
//                                 RestaurantAddonPickSizeEvent(
//                                     turnOn: value!, index: index));
//                           },
//                         );
//                       },
//                       separatorBuilder: (BuildContext context, int index) {
//                         return Divider(color: Colors.grey[300]);
//                       },
//                     );
//                   },
//                 ),
//               )
//             ],
//           ),
//         ),
//         const Padding(
//           padding: EdgeInsets.only(top: 24),
//           child: Divider(
//             thickness: 8,
//             color: AppColor.dividerGrey,
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.all(24),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const CustomText(
//                   content: 'Quantity',
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold),
//               Padding(
//                 padding: const EdgeInsets.only(top: 20, bottom: 15),
//                 child: Container(
//                   height: 54,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     border: Border.all(color: Colors.grey.shade300),
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       IconButton(
//                           onPressed: () {
//                             if (restaurantAddonBloc.quantity > 1) {
//                               restaurantAddonBloc
//                                   .add(RestaurantAddonDecreaseQuantityEvent());
//                             } else {
//                               null;
//                             }
//                           },
//                           icon: const Icon(Icons.remove)),
//                       BlocBuilder<RestaurantAddonBloc, RestaurantAddonState>(
//                         buildWhen: (previous, current) =>
//                             current is RestaurantAddonCountState ||
//                             current is RestaurantAddonLoadingSuccessState,
//                         builder: (context, state) {
//                           return CustomText(
//                               content: '${restaurantAddonBloc.quantity}'
//                                   .padLeft(2, '0'));
//                         },
//                       ),
//                       IconButton(
//                           onPressed: () {
//                             restaurantAddonBloc
//                                 .add(RestaurantAddonIncreaseQuantityEvent());
//                           },
//                           icon: const Icon(Icons.add))
//                     ],
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//         const Divider(
//           thickness: 8,
//           color: AppColor.dividerGrey,
//         ),
//         Expanded(
//           flex: 2,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Padding(
//                 padding: EdgeInsets.only(left: 24, top: 24),
//                 child: CustomText(
//                     content: 'Extra Sauce',
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold),
//               ),
//               Expanded(
//                 child: ListView.builder(
//                     itemCount: addons.length,
//                     physics: const NeverScrollableScrollPhysics(),
//                     itemBuilder: (context, index) {
//                       return BlocBuilder<RestaurantAddonBloc,
//                           RestaurantAddonState>(
//                         buildWhen: (previous, current) =>
//                             current is RestaurantAddonPickToppingState ||
//                             current is RestaurantAddonLoadingSuccessState,
//                         builder: (context, state) {
//                           return CheckboxListTile.adaptive(
//                             checkColor: Colors.white,
//                             activeColor: AppColor.globalPink,
//                             controlAffinity: ListTileControlAffinity.leading,
//                             secondary: CustomText(
//                                 content: '+\$${addons[index].addonPrice}',
//                                 color: Colors.grey),
//                             title: CustomText(
//                                 content: addons[index].addonName,
//                                 color: Colors.grey),
//                             value: addons[index].like,
//                             onChanged: (bool? value) {
//                               restaurantAddonBloc.add(
//                                   RestaurantAddonPickToppingEvent(
//                                       index: index, like: value!));
//                             },
//                           );
//                         },
//                       );
//                     }),
//               ),
//             ],
//           ),
//         ),
//         const Padding(
//           padding: EdgeInsets.only(top: 24),
//           child: Divider(
//             thickness: 8,
//             color: AppColor.dividerGrey,
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const CustomText(
//                   content: 'Instructions',
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold),
//               const SizedBox(height: 20),
//               const CustomText(
//                   content: 'Let us know if you have specific things in\nmind',
//                   color: Colors.grey),
//               Padding(
//                 padding: const EdgeInsets.only(top: 24),
//                 child: CustomTextField(
//                   floatingLabelColor: Colors.grey,
//                   labelColor: Colors.grey,
//                   labelText: 'e.g. less spices, no mayo etc',
//                   activeValidate: true,
//                   borderColor: Colors.grey.shade300,
//                   onChanged: (value) {
//                     restaurantAddonBloc
//                         .add(RestaurantAddonNoteEvent(note: value));
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//         const Divider(
//           thickness: 8,
//           color: AppColor.dividerGrey,
//         ),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 24),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Padding(
//                   padding: EdgeInsets.only(top: 24),
//                   child: CustomText(
//                       content: 'If the product is not available',
//                       fontWeight: FontWeight.bold)),
//               Padding(
//                   padding: const EdgeInsets.only(top: 24, bottom: 60),
//                   child: DropdownButtonFormField(
//                     iconEnabledColor: Colors.grey.shade400,
//                     borderRadius: BorderRadius.circular(20),
//                     hint: CustomText(
//                         content: 'Remove it from my order',
//                         color: Colors.grey.shade400),
//                     dropdownColor: Colors.white,
//                     decoration: InputDecoration(
//                         enabledBorder: OutlineInputBorder(
//                             borderSide: BorderSide(color: Colors.grey.shade400),
//                             borderRadius: BorderRadius.circular(16)),
//                         focusedBorder: OutlineInputBorder(
//                             borderSide: BorderSide(color: Colors.grey.shade400),
//                             borderRadius: BorderRadius.circular(16)),
//                         contentPadding: const EdgeInsets.symmetric(
//                             horizontal: 24, vertical: 16),
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(20))),
//                     items: const [
//                       DropdownMenuItem(
//                           value: 'Remove it from my order',
//                           child: CustomText(
//                               content: 'Remove it from my order',
//                               fontSize: 16,
//                               fontWeight: FontWeight.w400,
//                               color: Colors.grey)),
//                       DropdownMenuItem(
//                           value: '', child: CustomText(content: ''))
//                     ],
//                     onChanged: (value) {},
//                   )),
//               Padding(
//                 padding: const EdgeInsets.only(bottom: 30),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Expanded(
//                       child: BlocBuilder<RestaurantAddonBloc,
//                           RestaurantAddonState>(
//                         builder: (context, state) {
//                           return CustomText(
//                               content: '\$${restaurantAddonBloc.totalPrice}',
//                               fontSize: 28,
//                               fontWeight: FontWeight.bold);
//                         },
//                       ),
//                     ),
//                     Expanded(
//                       child: CustomButton(
//                           onPressed: () {
//                             restaurantAddonBloc.add(
//                                 RestaurantAddonNavigateToCartEvent(
//                                     context: context));
//                           },
//                           content: 'Add To Cart',
//                           color: AppColor.globalPink),
//                     )
//                   ],
//                 ),
//               )
//             ],
//           ),
//         )
//       ],
//     ),
//   );
// }
