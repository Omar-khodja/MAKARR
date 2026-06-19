import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:makarr/feature/Report_Problem/presentation/controler/locarion_provider.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

class LocationComponent extends ConsumerWidget {
  const LocationComponent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
       MapboxMap mapboxMap;

    final location = ref.watch(locationNotifierProvider);
    return location.when(
      data: (data) => Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(data["formatted"] ?? 'Current location'),
          ),
            const SizedBox(height: 12),
            if(data.isNotEmpty)
          SizedBox(
            width: double.infinity,
            height: 250,

            child: ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(12),
              child: MapWidget(
                onMapCreated: (controller) async {
                  final lat = location.value!["lat"];
                  final lng = location.value!["lng"];
                  mapboxMap = controller;
                  mapboxMap.setCamera(
                    CameraOptions(
                      center: Point(coordinates: Position(lng, lat)),
                      zoom: 12.0,
                    ),
                  );
                  await mapboxMap.location.updateSettings(
                    LocationComponentSettings(
                      enabled: true,
                      pulsingEnabled: true,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      error: (error, stackTrace) => Center (child: Text(error.toString()),),
      loading: () => const Center(child: CircularProgressIndicator(),),
    );
  }
}
