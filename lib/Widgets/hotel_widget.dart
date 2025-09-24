import 'package:flutter/cupertino.dart';
import "package:cloud_functions/cloud_functions.dart";

class HotelSearchPage extends StatefulWidget {
  const HotelSearchPage({super.key});

  @override
  State<HotelSearchPage> createState() => _HotelSearchPageState();
}

class _HotelSearchPageState extends State<HotelSearchPage> {
  final TextEditingController _cityController = TextEditingController();
  DateTime _checkinDate = DateTime.now().add(const Duration(days: 3));
  DateTime _checkoutDate = DateTime.now().add(const Duration(days: 6));
  int _adults = 2;

  List hotels = [];

  Future<String?> _getCityId(String cityName) async {
    final callable = FirebaseFunctions.instance.httpsCallable('searchCityId');
    final result = await callable.call({"city": cityName});

    if (result.data != null && result.data is List && result.data.length > 0) {
      return result.data[0]["dest_id"];
    }
    return null;
  }

  Future<void> _searchHotels() async {
    final city = _cityController.text.trim();
    if (city.isEmpty) return;

    final destId = await _getCityId(city);
    if (destId == null) {
      setState(() => hotels = []);
      return;
    }

    final callable = FirebaseFunctions.instance.httpsCallable('searchHotels');
    final result = await callable.call({
      "destId": destId,
      "checkinDate": _checkinDate.toIso8601String().split("T").first,
      "checkoutDate": _checkoutDate.toIso8601String().split("T").first,
      "adults": _adults.toString(),
    });

    setState(() {
      hotels = result.data["result"] ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text("Hotel Search"),
      ),
      child: SafeArea(
        child: Column(
          children: [
            // поле для города
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: CupertinoSearchTextField(
                controller: _cityController,
                placeholder: "Enter city",
                onSubmitted: (_) => _searchHotels(),
              ),
            ),

            // даты
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      const Text("Check-in"),
                      CupertinoButton(
                        onPressed: () => _pickDate(true),
                        child: Text(
                          "${_checkinDate.toLocal()}".split(" ")[0],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      const Text("Check-out"),
                      CupertinoButton(
                        onPressed: () => _pickDate(false),
                        child: Text(
                          "${_checkoutDate.toLocal()}".split(" ")[0],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // количество гостей
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Adults: "),
                CupertinoButton(
                  onPressed: _pickAdults,
                  child: Text("$_adults"),
                ),
              ],
            ),

            // кнопка поиска
            CupertinoButton.filled(
              onPressed: _searchHotels,
              child: const Text("Search Hotels"),
            ),

            const SizedBox(height: 12),

            // список отелей
            Expanded(
              child: hotels.isEmpty
                  ? const Center(child: Text("No results"))
                  : ListView.builder(
                itemCount: hotels.length,
                itemBuilder: (context, index) {
                  final hotel = hotels[index];
                  return Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: CupertinoColors.systemGrey6,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          hotel["hotel_name"] ?? "Unknown",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          hotel["address"] ?? "",
                          style: const TextStyle(
                            fontSize: 14,
                            color: CupertinoColors.systemGrey,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  // 📅 выбор даты
  void _pickDate(bool isCheckin) {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => SizedBox(
        height: 300,
        child: CupertinoDatePicker(
          mode: CupertinoDatePickerMode.date,
          initialDateTime: isCheckin ? _checkinDate : _checkoutDate,
          onDateTimeChanged: (val) {
            setState(() {
              if (isCheckin) {
                _checkinDate = val;
              } else {
                _checkoutDate = val;
              }
            });
          },
        ),
      ),
    );
  }

  // 👥 выбор гостей
  void _pickAdults() {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => SizedBox(
        height: 200,
        child: CupertinoPicker(
          itemExtent: 40,
          scrollController:
          FixedExtentScrollController(initialItem: _adults - 1),
          onSelectedItemChanged: (index) {
            setState(() {
              _adults = index + 1;
            });
          },
          children: List.generate(10, (i) => Text("${i + 1}")),
        ),
      ),
    );
  }
}
