
import 'package:flutter/material.dart';
import 'package:currency_converter/function/fetchexchangerate.dart';

class CurrencyConverterMaterialPage extends StatelessWidget {
  final TextEditingController textEditingController = TextEditingController();
  final ValueNotifier<String> fromCurrency = ValueNotifier<String>('USD');
  final ValueNotifier<String> toCurrency = ValueNotifier<String>("USD");
  final ValueNotifier<Future<Map<String, dynamic>>?> futureNotifier =
      ValueNotifier(null);
  CurrencyConverterMaterialPage({super.key}) {
    // Initialize with a default conversion future
    futureNotifier.value = convertCurrency(
      amount: textEditingController.text,
      from: fromCurrency.value,
      to: toCurrency.value,
    );
  }
  void _convert() {
    futureNotifier.value = convertCurrency(
      amount: textEditingController.text,
      from: fromCurrency.value,
      to: toCurrency.value,
    );
  }

  // final selectedValue = ValueNotifier<String?>(null);
  Widget currencyDropdown({required ValueNotifier<String> selectedValue}) {
    return ValueListenableBuilder<String>(
      valueListenable: selectedValue,
      builder: (context, value, _) {
        return DropdownButton<String>(
          value: value,
          items:
              [
                    "AED",
                    "AFN",
                    "ALL",
                    "AMD",
                    "ANG",
                    "AOA",
                    "ARS",
                    "AUD",
                    "AWG",
                    "AZN",
                    "BAM",
                    "BBD",
                    "BDT",
                    "BGN",
                    "BHD",
                    "BIF",
                    "BMD",
                    "BND",
                    "BOB",
                    "BRL",
                    "BSD",
                    "BTN",
                    "BWP",
                    "BYN",
                    "BZD",
                    "CAD",
                    "CDF",
                    "CHF",
                    "CLP",
                    "CNY",
                    "COP",
                    "CRC",
                    "CUP",
                    "CVE",
                    "CZK",
                    "DJF",
                    "DKK",
                    "DOP",
                    "DZD",
                    "EGP",
                    "ERN",
                    "ETB",
                    "EUR",
                    "FJD",
                    "FKP",
                    "FOK",
                    "GBP",
                    "GEL",
                    "GGP",
                    "GHS",
                    "GIP",
                    "GMD",
                    "GNF",
                    "GTQ",
                    "GYD",
                    "HKD",
                    "HNL",
                    "HRK",
                    "HTG",
                    "HUF",
                    "IDR",
                    "ILS",
                    "IMP",
                    "INR",
                    "IQD",
                    "IRR",
                    "ISK",
                    "JEP",
                    "JMD",
                    "JOD",
                    "JPY",
                    "KES",
                    "KGS",
                    "KHR",
                    "KID",
                    "KMF",
                    "KRW",
                    "KWD",
                    "KYD",
                    "KZT",
                    "LAK",
                    "LBP",
                    "LKR",
                    "LRD",
                    "LSL",
                    "LYD",
                    "MAD",
                    "MDL",
                    "MGA",
                    "MKD",
                    "MMK",
                    "MNT",
                    "MOP",
                    "MRU",
                    "MUR",
                    "MVR",
                    "MWK",
                    "MXN",
                    "MYR",
                    "MZN",
                    "NAD",
                    "NGN",
                    "NIO",
                    "NOK",
                    "NPR",
                    "NZD",
                    "OMR",
                    "PAB",
                    "PEN",
                    "PGK",
                    "PHP",
                    "PKR",
                    "PLN",
                    "PYG",
                    "QAR",
                    "RON",
                    "RSD",
                    "RUB",
                    "RWF",
                    "SAR",
                    "SBD",
                    "SCR",
                    "SDG",
                    "SEK",
                    "SGD",
                    "SHP",
                    "SLE",
                    "SLL",
                    "SOS",
                    "SRD",
                    "SSP",
                    "STN",
                    "SYP",
                    "SZL",
                    "THB",
                    "TJS",
                    "TMT",
                    "TND",
                    "TOP",
                    "TRY",
                    "TTD",
                    "TVD",
                    "TWD",
                    "TZS",
                    "UAH",
                    "UGX",
                    "USD",
                    "UYU",
                    "UZS",
                    "VES",
                    "VND",
                    "VUV",
                    "WST",
                    "XAF",
                    "XCD",
                    "XCG",
                    "XDR",
                    "XOF",
                    "XPF",
                    "YER",
                    "ZAR",
                    "ZMW",
                    "ZWL",
                  ]
                  .map(
                    (currency) => DropdownMenuItem<String>(
                      value: currency,
                      alignment: AlignmentGeometry.directional(-0.1, 0),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 0),
                        child: Text(currency),
                      ),
                    ),
                  )
                  .toList(),
          onChanged: (newValue) {
            if (newValue != null) {
              selectedValue.value = newValue;
            }
          },
          borderRadius: BorderRadius.circular(10),
          style: TextStyle(fontSize: 14, color: Colors.black),
          hint: Text("Currency"),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double horizontalpadding = screenWidth * 0.1;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 186, 231, 252),
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Currency Converter"),
        backgroundColor: Color.fromARGB(255, 60, 142, 174),
        toolbarHeight: 40,
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "This is text changes",
              style: TextStyle(
                color: Color.fromARGB(255, 91, 189, 227),
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalpadding),
                child: Column(
                  children: [
                    TextField(
                      controller: textEditingController,
                      decoration: InputDecoration(
                        label: const Text("Please Amount"),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        hintText: "Your area of writing",
                        hintStyle: const TextStyle(
                          color: Color.fromRGBO(46, 46, 46, 0.498),
                          // semi-transparent white
                        ),
                        prefixIcon: const Padding(
                          padding: EdgeInsets.only(
                            left: 12.0,
                            top: 3.0,
                          ), // tweak as needed
                          child: Icon(Icons.monetization_on_outlined),
                        ),
                        prefixIconColor: Color.fromARGB(95, 92, 93, 80),
                        filled: true,
                        fillColor: Color.fromARGB(255, 213, 255, 240),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: const Color.fromARGB(255, 132, 222, 255),
                            width: 2,
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("From:"),
                            const SizedBox(width: 5),
                            currencyDropdown(selectedValue: fromCurrency),

                            const SizedBox(width: 20),
                            const Text("To:"),
                            const SizedBox(width: 5),
                            currencyDropdown(selectedValue: toCurrency),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: screenWidth * 0.02),
              child: ElevatedButton(
                onPressed: () {
                  _convert();
                  // child:
                  // Text('Convert');
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(
                    const Color.fromARGB(255, 249, 255, 220),
                  ),
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),

                  // elevation: WidgetStatePropertyAll(3),
                  // shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  //   RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(12.0),
                  //   ),
                  // ),
                  fixedSize: const WidgetStatePropertyAll(Size(120, 40)),
                ),  

                child: const Text("Convert"),
              ),
            ),
            ValueListenableBuilder<Future<Map<String, dynamic>>?>(
              valueListenable: futureNotifier,
              builder: (context, future, _) {
                if (future == null) {
                  return Text('Press convert to start');
                }
                
                return FutureBuilder<Map<String, dynamic>>(
                  future: future,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      final data = snapshot.data!;
                      final result = data['result'] ?? 'N/A';
                      final text = data['text'] ?? '';
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Converted Amount: $result',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8),
                          Text(text),
                        ],
                      );
                    } else {
                      return Text('No data');
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
