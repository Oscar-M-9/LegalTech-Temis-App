// To parse this JSON data, do
//
//     final taskProceso = taskProcesoFromJson(jsonString);

import 'dart:convert';

TaskProceso taskProcesoFromJson(String str) =>
    TaskProceso.fromJson(json.decode(str));

String taskProcesoToJson(TaskProceso data) => json.encode(data.toJson());

class TaskProceso {
  final List<GroupStage>? workFlowTaskExpediente;
  final List<GroupStage>? groupStages;
  final int? estadoFlujoCount;
  final int? sumAll;
  final int? sumAllCheck;
  final List<GroupStage>? stageCountEnProgreso;
  final int? taskFlujoFinalizado;
  final int? taskFinalizado;
  final List<TaskExpediente>? taskExpediente;

  TaskProceso({
    this.workFlowTaskExpediente,
    this.groupStages,
    this.estadoFlujoCount,
    this.sumAll,
    this.sumAllCheck,
    this.stageCountEnProgreso,
    this.taskFlujoFinalizado,
    this.taskFinalizado,
    this.taskExpediente,
  });

  TaskProceso copyWith({
    List<GroupStage>? workFlowTaskExpediente,
    List<GroupStage>? groupStages,
    int? estadoFlujoCount,
    int? sumAll,
    int? sumAllCheck,
    List<GroupStage>? stageCountEnProgreso,
    int? taskFlujoFinalizado,
    int? taskFinalizado,
    List<TaskExpediente>? taskExpediente,
  }) =>
      TaskProceso(
        workFlowTaskExpediente:
            workFlowTaskExpediente ?? this.workFlowTaskExpediente,
        groupStages: groupStages ?? this.groupStages,
        estadoFlujoCount: estadoFlujoCount ?? this.estadoFlujoCount,
        sumAll: sumAll ?? this.sumAll,
        sumAllCheck: sumAllCheck ?? this.sumAllCheck,
        stageCountEnProgreso: stageCountEnProgreso ?? this.stageCountEnProgreso,
        taskFlujoFinalizado: taskFlujoFinalizado ?? this.taskFlujoFinalizado,
        taskFinalizado: taskFinalizado ?? this.taskFinalizado,
        taskExpediente: taskExpediente ?? this.taskExpediente,
      );

  factory TaskProceso.fromJson(Map<String, dynamic> json) => TaskProceso(
        workFlowTaskExpediente: json["workFlowTaskExpediente"] == null
            ? []
            : List<GroupStage>.from(json["workFlowTaskExpediente"]!
                .map((x) => GroupStage.fromJson(x))),
        groupStages: json["groupStages"] == null
            ? []
            : List<GroupStage>.from(
                json["groupStages"]!.map((x) => GroupStage.fromJson(x))),
        estadoFlujoCount: json["estadoFlujoCount"],
        sumAll: json["sumAll"],
        sumAllCheck: json["sumAllCheck"],
        stageCountEnProgreso: json["stageCountEnProgreso"] == null
            ? []
            : List<GroupStage>.from(json["stageCountEnProgreso"]!
                .map((x) => GroupStage.fromJson(x))),
        taskFlujoFinalizado: json["TaskFlujoFinalizado"],
        taskFinalizado: json["TaskFinalizado"],
        taskExpediente: json["taskExpediente"] == null
            ? []
            : List<TaskExpediente>.from(
                json["taskExpediente"]!.map((x) => TaskExpediente.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "workFlowTaskExpediente": workFlowTaskExpediente == null
            ? []
            : List<dynamic>.from(
                workFlowTaskExpediente!.map((x) => x.toJson())),
        "groupStages": groupStages == null
            ? []
            : List<dynamic>.from(groupStages!.map((x) => x.toJson())),
        "estadoFlujoCount": estadoFlujoCount,
        "sumAll": sumAll,
        "sumAllCheck": sumAllCheck,
        "stageCountEnProgreso": stageCountEnProgreso == null
            ? []
            : List<dynamic>.from(stageCountEnProgreso!.map((x) => x.toJson())),
        "TaskFlujoFinalizado": taskFlujoFinalizado,
        "TaskFinalizado": taskFinalizado,
        "taskExpediente": taskExpediente == null
            ? []
            : List<dynamic>.from(taskExpediente!.map((x) => x.toJson())),
      };
}

class GroupStage {
  final int? id;
  final int? idWorkflow;
  final int? idWorkflowStage;
  final int? idWorkflowTask;
  final int? idExp;
  final String? nombreEtapa;
  final String? nombreFlujo;
  final String? nombre;
  final String? descripcion;
  final int? diasDuracion;
  final int? diasAntesVenc;
  final DateTime? fechaLimite;
  final DateTime? fechaAlerta;
  final dynamic fechaFinalizada;
  final dynamic attachedFiles;
  final String? estado;
  final String? prioridad;
  final String? codeUser;
  final String? codeCompany;
  final dynamic metadata;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  GroupStage({
    this.id,
    this.idWorkflow,
    this.idWorkflowStage,
    this.idWorkflowTask,
    this.idExp,
    this.nombreEtapa,
    this.nombreFlujo,
    this.nombre,
    this.descripcion,
    this.diasDuracion,
    this.diasAntesVenc,
    this.fechaLimite,
    this.fechaAlerta,
    this.fechaFinalizada,
    this.attachedFiles,
    this.estado,
    this.prioridad,
    this.codeUser,
    this.codeCompany,
    this.metadata,
    this.createdAt,
    this.updatedAt,
  });

  GroupStage copyWith({
    int? id,
    int? idWorkflow,
    int? idWorkflowStage,
    int? idWorkflowTask,
    int? idExp,
    String? nombreEtapa,
    String? nombreFlujo,
    String? nombre,
    String? descripcion,
    int? diasDuracion,
    int? diasAntesVenc,
    DateTime? fechaLimite,
    DateTime? fechaAlerta,
    dynamic fechaFinalizada,
    dynamic attachedFiles,
    String? estado,
    String? prioridad,
    String? codeUser,
    String? codeCompany,
    dynamic metadata,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      GroupStage(
        id: id ?? this.id,
        idWorkflow: idWorkflow ?? this.idWorkflow,
        idWorkflowStage: idWorkflowStage ?? this.idWorkflowStage,
        idWorkflowTask: idWorkflowTask ?? this.idWorkflowTask,
        idExp: idExp ?? this.idExp,
        nombreEtapa: nombreEtapa ?? this.nombreEtapa,
        nombreFlujo: nombreFlujo ?? this.nombreFlujo,
        nombre: nombre ?? this.nombre,
        descripcion: descripcion ?? this.descripcion,
        diasDuracion: diasDuracion ?? this.diasDuracion,
        diasAntesVenc: diasAntesVenc ?? this.diasAntesVenc,
        fechaLimite: fechaLimite ?? this.fechaLimite,
        fechaAlerta: fechaAlerta ?? this.fechaAlerta,
        fechaFinalizada: fechaFinalizada ?? this.fechaFinalizada,
        attachedFiles: attachedFiles ?? this.attachedFiles,
        estado: estado ?? this.estado,
        prioridad: prioridad ?? this.prioridad,
        codeUser: codeUser ?? this.codeUser,
        codeCompany: codeCompany ?? this.codeCompany,
        metadata: metadata ?? this.metadata,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory GroupStage.fromJson(Map<String, dynamic> json) => GroupStage(
        id: json["id"],
        idWorkflow: json["id_workflow"],
        idWorkflowStage: json["id_workflow_stage"],
        idWorkflowTask: json["id_workflow_task"],
        idExp: json["id_exp"],
        nombreEtapa: json["nombre_etapa"],
        nombreFlujo: json["nombre_flujo"],
        nombre: json["nombre"],
        descripcion: json["descripcion"],
        diasDuracion: json["dias_duracion"],
        diasAntesVenc: json["dias_antes_venc"],
        fechaLimite: json["fecha_limite"] == null
            ? null
            : DateTime.parse(json["fecha_limite"]),
        fechaAlerta: json["fecha_alerta"] == null
            ? null
            : DateTime.parse(json["fecha_alerta"]),
        fechaFinalizada: json["fecha_finalizada"],
        attachedFiles: json["attached_files"],
        estado: json["estado"],
        prioridad: json["prioridad"],
        codeUser: json["code_user"],
        codeCompany: json["code_company"],
        metadata: json["metadata"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_workflow": idWorkflow,
        "id_workflow_stage": idWorkflowStage,
        "id_workflow_task": idWorkflowTask,
        "id_exp": idExp,
        "nombre_etapa": nombreEtapa,
        "nombre_flujo": nombreFlujo,
        "nombre": nombre,
        "descripcion": descripcion,
        "dias_duracion": diasDuracion,
        "dias_antes_venc": diasAntesVenc,
        "fecha_limite":
            "${fechaLimite!.year.toString().padLeft(4, '0')}-${fechaLimite!.month.toString().padLeft(2, '0')}-${fechaLimite!.day.toString().padLeft(2, '0')}",
        "fecha_alerta":
            "${fechaAlerta!.year.toString().padLeft(4, '0')}-${fechaAlerta!.month.toString().padLeft(2, '0')}-${fechaAlerta!.day.toString().padLeft(2, '0')}",
        "fecha_finalizada": fechaFinalizada,
        "attached_files": attachedFiles,
        "estado": estado,
        "prioridad": prioridad,
        "code_user": codeUser,
        "code_company": codeCompany,
        "metadata": metadata,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class TaskExpediente {
  final int? id;
  final String? flujoActivo;
  final dynamic idTareaFlujo;
  final dynamic etapaFlujo;
  final dynamic transicionFlujo;
  final dynamic dataFlujo;
  final int? idExp;
  final String? nombre;
  final String? descripcion;
  final String? prioridad;
  final String? estado;
  final DateTime? fechaLimite;
  final DateTime? fechaAlerta;
  final dynamic fechaFinalizada;
  final String? codeUser;
  final String? codeCompany;
  final dynamic metadata;
  final dynamic createdAt;
  final dynamic updatedAt;

  TaskExpediente({
    this.id,
    this.flujoActivo,
    this.idTareaFlujo,
    this.etapaFlujo,
    this.transicionFlujo,
    this.dataFlujo,
    this.idExp,
    this.nombre,
    this.descripcion,
    this.prioridad,
    this.estado,
    this.fechaLimite,
    this.fechaAlerta,
    this.fechaFinalizada,
    this.codeUser,
    this.codeCompany,
    this.metadata,
    this.createdAt,
    this.updatedAt,
  });

  TaskExpediente copyWith({
    int? id,
    String? flujoActivo,
    dynamic idTareaFlujo,
    dynamic etapaFlujo,
    dynamic transicionFlujo,
    dynamic dataFlujo,
    int? idExp,
    String? nombre,
    String? descripcion,
    String? prioridad,
    String? estado,
    DateTime? fechaLimite,
    DateTime? fechaAlerta,
    dynamic fechaFinalizada,
    String? codeUser,
    String? codeCompany,
    dynamic metadata,
    dynamic createdAt,
    dynamic updatedAt,
  }) =>
      TaskExpediente(
        id: id ?? this.id,
        flujoActivo: flujoActivo ?? this.flujoActivo,
        idTareaFlujo: idTareaFlujo ?? this.idTareaFlujo,
        etapaFlujo: etapaFlujo ?? this.etapaFlujo,
        transicionFlujo: transicionFlujo ?? this.transicionFlujo,
        dataFlujo: dataFlujo ?? this.dataFlujo,
        idExp: idExp ?? this.idExp,
        nombre: nombre ?? this.nombre,
        descripcion: descripcion ?? this.descripcion,
        prioridad: prioridad ?? this.prioridad,
        estado: estado ?? this.estado,
        fechaLimite: fechaLimite ?? this.fechaLimite,
        fechaAlerta: fechaAlerta ?? this.fechaAlerta,
        fechaFinalizada: fechaFinalizada ?? this.fechaFinalizada,
        codeUser: codeUser ?? this.codeUser,
        codeCompany: codeCompany ?? this.codeCompany,
        metadata: metadata ?? this.metadata,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory TaskExpediente.fromJson(Map<String, dynamic> json) => TaskExpediente(
        id: json["id"],
        flujoActivo: json["flujo_activo"],
        idTareaFlujo: json["id_tarea_flujo"],
        etapaFlujo: json["etapa_flujo"],
        transicionFlujo: json["transicion_flujo"],
        dataFlujo: json["data_flujo"],
        idExp: json["id_exp"],
        nombre: json["nombre"],
        descripcion: json["descripcion"],
        prioridad: json["prioridad"],
        estado: json["estado"],
        fechaLimite: json["fecha_limite"] == null
            ? null
            : DateTime.parse(json["fecha_limite"]),
        fechaAlerta: json["fecha_alerta"] == null
            ? null
            : DateTime.parse(json["fecha_alerta"]),
        fechaFinalizada: json["fecha_finalizada"],
        codeUser: json["code_user"],
        codeCompany: json["code_company"],
        metadata: json["metadata"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "flujo_activo": flujoActivo,
        "id_tarea_flujo": idTareaFlujo,
        "etapa_flujo": etapaFlujo,
        "transicion_flujo": transicionFlujo,
        "data_flujo": dataFlujo,
        "id_exp": idExp,
        "nombre": nombre,
        "descripcion": descripcion,
        "prioridad": prioridad,
        "estado": estado,
        "fecha_limite":
            "${fechaLimite!.year.toString().padLeft(4, '0')}-${fechaLimite!.month.toString().padLeft(2, '0')}-${fechaLimite!.day.toString().padLeft(2, '0')}",
        "fecha_alerta":
            "${fechaAlerta!.year.toString().padLeft(4, '0')}-${fechaAlerta!.month.toString().padLeft(2, '0')}-${fechaAlerta!.day.toString().padLeft(2, '0')}",
        "fecha_finalizada": fechaFinalizada,
        "code_user": codeUser,
        "code_company": codeCompany,
        "metadata": metadata,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
