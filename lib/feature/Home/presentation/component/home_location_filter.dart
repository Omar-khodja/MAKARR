import 'package:flutter/material.dart';
import 'package:makarr/core/data/algeria_cites.dart';

class HomeLocationFilter extends StatefulWidget {
  const HomeLocationFilter({super.key,required this.onSelected});
  final void Function(String wilaya , String bladia) onSelected;

  @override
  State<HomeLocationFilter> createState() => _HomeLocationFilterState();
}

class _HomeLocationFilterState extends State<HomeLocationFilter> {
  late List<String> wilaya;
  late List<String> bladia;
  late String selectedWilaya;
  late String selectedBladya;
  @override
  void initState() {
    super.initState();
    wilaya = algeriacites
        .map((e) {
          return (e["wilaya_name"] as String);
        })
        .toSet()
        .toList();
    selectedWilaya = wilaya.first;
    setBaladya();
  }

  void setBaladya() {
    bladia = algeriacites
        .where((value) => value["wilaya_name"] as String == selectedWilaya)
        .map((e) => e["daira_name"] as String)
        .toSet()
        .toList();

    selectedBladya = bladia.first;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: .center,
      crossAxisAlignment: .start,
      mainAxisSize: .min,
      children: [
        DropdownButton(
          value: selectedWilaya,
          items: wilaya.asMap().entries.map((item) {
            return DropdownMenuItem<String>(
              value: item.value,
              child: Text("${item.key + 1} - ${item.value}"),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              selectedWilaya = value!;
              setBaladya();
              widget.onSelected(selectedWilaya,selectedBladya);
            });
          },
        ),
        DropdownButton(
          value: selectedBladya,
          items: bladia
              .map(
                (item) =>
                    DropdownMenuItem<String>(value: item, child: Text(item)),
              )
              .toList(),
          onChanged: (value) {
            setState(() {
              selectedBladya = value!;
              widget.onSelected(selectedWilaya, selectedBladya);
            });
          },
        ),
      ],
    );
  }
}
