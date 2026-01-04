import 'package:flutter/material.dart';
import 'package:makarr/core/data/algeria_cites.dart';

class CustomDropbox extends StatefulWidget {
  const CustomDropbox({super.key, required this.onChange});
  final void Function(String w, String b) onChange;

  @override
  State<CustomDropbox> createState() => _CustomDropboxState();
}

class _CustomDropboxState extends State<CustomDropbox> {
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
      children: [
        DropdownButtonFormField<String>(
          initialValue: selectedWilaya,
          hint: const Text("Select Wilaya"),
          decoration: const InputDecoration(label: Text("Select Wilaya")),
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
            });
            widget.onChange(selectedWilaya, selectedBladya);
          },
        ),
        const SizedBox(height: 20),
        DropdownButtonFormField<String>(
          initialValue: selectedBladya,
          hint: const Text("Select Bladya"),
          decoration: const InputDecoration(label: Text("Select Bladya")),
          items: bladia
              .map(
                (item) =>
                    DropdownMenuItem<String>(value: item, child: Text(item)),
              )
              .toList(),
          onChanged: (value) {
            setState(() {
              selectedBladya = value!;
            });
            widget.onChange(selectedWilaya, selectedBladya);
          },
        ),
      ],
    );
  }
}
