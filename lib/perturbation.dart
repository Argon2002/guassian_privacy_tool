import 'dart:math';

import 'package:guassian_privacy_tool/gaussian_privacy_tool.dart';
import 'package:guassian_privacy_tool/stats_calc.dart';

class PerturbGaussian {
  final List<Map<String, String>> rows;
  final Map<String, double> sigmas;
  PerturbGaussian(this.rows, this.sigmas);
}

PerturbGaussian perturbGaussian(
  List<Map<String, String>> rows,
  List<String> numericCols, {
  required double alpha,
  int seed = 42,
}) {
  final rng = Random(seed);
  // sigma per column = alpha * std(column)
  final sigmas = <String, double>{};
  for (final c in numericCols) {
    final vals = rows.map((r) => double.parse(r[c]!.trim())).toList();
    sigmas[c] = alpha * stdSample(vals);
  }

  final out = <Map<String, String>>[];
  for (final r in rows) {
    final rr = Map<String, String>.from(r);
    for (final c in numericCols) {
      final x = double.parse(rr[c]!.trim());
      final n = gaussianGenerator(rng, std: sigmas[c]!);
      rr[c] = (x + n).toStringAsFixed(6);
    }
    out.add(rr);
  }

  return PerturbGaussian(out, sigmas);
}
