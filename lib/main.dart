import 'package:guassian_privacy_tool/csv_io.dart';
import 'package:guassian_privacy_tool/perturbation.dart';

Future<void> main() async {
  final input = "../../dataset/Salaries_sample_250.csv";
  // ستون‌های عددی پیشنهادی برای Salaries
  final numericCols = <String>[
    'BasePay',
    'OvertimePay',
    'OtherPay',
    'TotalPay',
    'TotalPayBenefits',
  ];

  //noise leves
  final alphas = <double>[0.2, 0.5, 1.0];

  final rows = await readCsvAsMaps(input);
  final headers = rows.isEmpty ? <String>[] : rows.first.keys.toList();

  for (var i = 0; i < alphas.length; i++) {
    final a = alphas[i];
    final res = perturbGaussian(rows, numericCols, alpha: a, seed: 100 + i);
    final outPath =
        'data/level${i + 1}_a${a.toString().replaceAll(".", "_")}.csv';
    await writeMapsAsCsv(outPath, res.rows, headers);
    print('Saved: $outPath  sigmas=${res.sigmas}');
  }
}
