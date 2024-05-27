import 'dart:async';

import 'package:begara_mobile/feauters/auth/presentation/bloc/location/locations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/Entities/location.dart';

class LocationBar extends StatelessWidget {
  Timer? _debounce;
  final width;
  TextEditingController _controller = TextEditingController();
  final void Function(Location location) getLocation;
  LocationBar({required this.getLocation,required this.width});
  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<LocationBloc, LocationState>(builder: (context, state) {
        return Column(
          children: [
            Container(
              width: width*0.8,
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.location_on_outlined),
                  prefixIconColor: Colors.amber,
                  hintText: 'Address...',
                  border: OutlineInputBorder(),
                ),
                onChanged: (query) {
                  if (_debounce?.isActive ?? false) _debounce!.cancel();
                  _debounce = Timer(const Duration(milliseconds: 300), () {
                    if (query.isNotEmpty) {
                      BlocProvider.of<LocationBloc>(context)
                          .add(SearchEvent(query: query));
                    } else {
                      BlocProvider.of<LocationBloc>(context).add(ClearSearch());
                    }
                  });
                },
              ),
            ),
            if (state is LoadLocations)
              Container(
                constraints: BoxConstraints(
                  maxHeight: 200, // Limit the height of the dropdown
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10.0,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: ListView.separated(
                  itemCount: state.locations.length,
                  separatorBuilder: (context, index) => Divider(height: 1, color: const Color.fromARGB(255, 236, 231, 231)),
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Icon(Icons.location_on_outlined),
                      title: Text(state.locations[index].displayName),
                      onTap: () {
                        _controller.text = state.locations[index].displayName;
                        getLocation(state.locations[index]);
                        print(state.locations[index].displayName);
                        BlocProvider.of<LocationBloc>(context)
                            .add(ClearSearch());
                      },
                      tileColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: index == 0 ? Radius.circular(8.0) : Radius.zero,
                          bottom: index == state.locations.length - 1
                              ? Radius.circular(8.0)
                              : Radius.zero,
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        );
      });
  
  }
}
