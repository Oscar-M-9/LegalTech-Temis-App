import 'package:legaltech_temis/core/models/proceso_indecopi_model.dart';
import 'package:legaltech_temis/core/models/proceso_judicial_model.dart';
import 'package:legaltech_temis/core/models/proceso_sinoe_model.dart';
import 'package:legaltech_temis/core/models/proceso_suprema_model.dart';

class CombinedDataProcesos {
  final List<Expediente> expedienteJudicial;
  final List<ExpedienteSuprema> expedienteSuprema;
  final List<ExpedienteIndecopi> expedienteIndecopi;
  final List<ExpedienteSinoe> expedienteSinoe;
  final int totalExpedientes;

  CombinedDataProcesos({
    this.totalExpedientes = 0,
    required this.expedienteJudicial,
    required this.expedienteSuprema,
    required this.expedienteIndecopi,
    required this.expedienteSinoe,
  });
}
