// To parse this JSON data, do
//
//     final detalleProcesoJudicial = detalleProcesoJudicialFromJson(jsonString);

import 'dart:convert';

DetalleProcesoJudicial detalleProcesoJudicialFromJson(String str) =>
    DetalleProcesoJudicial.fromJson(json.decode(str));

String detalleProcesoJudicialToJson(DetalleProcesoJudicial data) =>
    json.encode(data.toJson());

class DetalleProcesoJudicial {
  final String? id;
  final List<DetalleProcesoJudicialDatum>? data;
  final Movements? movements;
  final List<Notify>? notify;
  final List<Comment>? comments;
  final List<GroupStage>? workFlowTaskExpediente;
  final List<GroupStage>? groupStages;
  final int? estadoFlujoCount;
  final int? sumAll;
  final int? sumAllCheck;
  final List<GroupStage>? stageCountEnProgreso;
  final List<Suggestion>? suggestion;
  final int? taskFlujoFinalizado;
  final int? taskFinalizado;

  DetalleProcesoJudicial({
    this.id,
    this.data,
    this.movements,
    this.notify,
    this.comments,
    this.workFlowTaskExpediente,
    this.groupStages,
    this.estadoFlujoCount,
    this.sumAll,
    this.sumAllCheck,
    this.stageCountEnProgreso,
    this.suggestion,
    this.taskFlujoFinalizado,
    this.taskFinalizado,
  });

  DetalleProcesoJudicial copyWith({
    String? id,
    List<DetalleProcesoJudicialDatum>? data,
    Movements? movements,
    List<Notify>? notify,
    List<Comment>? comments,
    List<GroupStage>? workFlowTaskExpediente,
    List<GroupStage>? groupStages,
    int? estadoFlujoCount,
    int? sumAll,
    int? sumAllCheck,
    List<GroupStage>? stageCountEnProgreso,
    List<Suggestion>? suggestion,
    int? taskFlujoFinalizado,
    int? taskFinalizado,
  }) =>
      DetalleProcesoJudicial(
        id: id ?? this.id,
        data: data ?? this.data,
        movements: movements ?? this.movements,
        notify: notify ?? this.notify,
        comments: comments ?? this.comments,
        workFlowTaskExpediente:
            workFlowTaskExpediente ?? this.workFlowTaskExpediente,
        groupStages: groupStages ?? this.groupStages,
        estadoFlujoCount: estadoFlujoCount ?? this.estadoFlujoCount,
        sumAll: sumAll ?? this.sumAll,
        sumAllCheck: sumAllCheck ?? this.sumAllCheck,
        stageCountEnProgreso: stageCountEnProgreso ?? this.stageCountEnProgreso,
        suggestion: suggestion ?? this.suggestion,
        taskFlujoFinalizado: taskFlujoFinalizado ?? this.taskFlujoFinalizado,
        taskFinalizado: taskFinalizado ?? this.taskFinalizado,
      );

  factory DetalleProcesoJudicial.fromJson(Map<String, dynamic> json) =>
      DetalleProcesoJudicial(
        id: json["id"],
        data: json["data"] == null
            ? []
            : List<DetalleProcesoJudicialDatum>.from(json["data"]!
                .map((x) => DetalleProcesoJudicialDatum.fromJson(x))),
        movements: json["movements"] == null
            ? null
            : Movements.fromJson(json["movements"]),
        notify: json["notify"] == null
            ? []
            : List<Notify>.from(json["notify"]!.map((x) => Notify.fromJson(x))),
        comments: json["comments"] == null
            ? []
            : List<Comment>.from(
                json["comments"]!.map((x) => Comment.fromJson(x))),
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
        suggestion: json["suggestion"] == null
            ? []
            : List<Suggestion>.from(
                json["suggestion"]!.map((x) => Suggestion.fromJson(x))),
        taskFlujoFinalizado: json["TaskFlujoFinalizado"],
        taskFinalizado: json["TaskFinalizado"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "movements": movements?.toJson(),
        "notify": notify == null
            ? []
            : List<dynamic>.from(notify!.map((x) => x.toJson())),
        "comments": comments == null
            ? []
            : List<dynamic>.from(comments!.map((x) => x.toJson())),
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
        "suggestion": suggestion == null
            ? []
            : List<dynamic>.from(suggestion!.map((x) => x.toJson())),
        "TaskFlujoFinalizado": taskFlujoFinalizado,
        "TaskFinalizado": taskFinalizado,
      };
}

class Comment {
  final int? id;
  final String? comment;
  final String? codeUser;
  final String? codeCompany;
  final int? idExp;
  final int? idUser;
  final int? idFollowUp;
  final int? idNotify;
  final DateTime? date;
  final String? type;
  final dynamic metadata;
  final dynamic createdAt;
  final dynamic updatedAt;

  Comment({
    this.id,
    this.comment,
    this.codeUser,
    this.codeCompany,
    this.idExp,
    this.idUser,
    this.idFollowUp,
    this.idNotify,
    this.date,
    this.type,
    this.metadata,
    this.createdAt,
    this.updatedAt,
  });

  Comment copyWith({
    int? id,
    String? comment,
    String? codeUser,
    String? codeCompany,
    int? idExp,
    int? idUser,
    int? idFollowUp,
    int? idNotify,
    DateTime? date,
    String? type,
    dynamic metadata,
    dynamic createdAt,
    dynamic updatedAt,
  }) =>
      Comment(
        id: id ?? this.id,
        comment: comment ?? this.comment,
        codeUser: codeUser ?? this.codeUser,
        codeCompany: codeCompany ?? this.codeCompany,
        idExp: idExp ?? this.idExp,
        idUser: idUser ?? this.idUser,
        idFollowUp: idFollowUp ?? this.idFollowUp,
        idNotify: idNotify ?? this.idNotify,
        date: date ?? this.date,
        type: type ?? this.type,
        metadata: metadata ?? this.metadata,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json["id"],
        comment: json["comment"],
        codeUser: json["code_user"]!,
        codeCompany: json["code_company"]!,
        idExp: json["id_exp"],
        idUser: json["id_user"],
        idFollowUp: json["id_follow_up"],
        idNotify: json["id_notify"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        type: json["type"],
        metadata: json["metadata"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "comment": comment,
        "code_user": codeUser,
        "code_company": codeCompany,
        "id_exp": idExp,
        "id_user": idUser,
        "id_follow_up": idFollowUp,
        "id_notify": idNotify,
        "date": date?.toIso8601String(),
        "type": type,
        "metadata": metadata,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

class DetalleProcesoJudicialDatum {
  final int? id;
  final String? nExpediente;
  final String? materia;
  final String? proceso;
  final String? lawyerResponsible;
  final String? estado;
  final String? sumilla;
  final DateTime? dateInitial;
  final dynamic updateDate;
  final String? oJurisdicional;
  final String? dJudicial;
  final String? juez;
  final String? observacion;
  final String? especialidad;
  final String? eProcesal;
  final dynamic dateConclusion;
  final String? ubicacion;
  final String? motivoConclusion;
  final dynamic name;
  final dynamic lastName;
  final String? nameCompany;
  final String? typeContact;
  final String? ruc;
  final String? email;
  final String? phone;
  final DateTime? fechaIngreso;
  final dynamic fechaResolucion;

  DetalleProcesoJudicialDatum({
    this.id,
    this.nExpediente,
    this.materia,
    this.proceso,
    this.lawyerResponsible,
    this.estado,
    this.sumilla,
    this.dateInitial,
    this.updateDate,
    this.oJurisdicional,
    this.dJudicial,
    this.juez,
    this.observacion,
    this.especialidad,
    this.eProcesal,
    this.dateConclusion,
    this.ubicacion,
    this.motivoConclusion,
    this.name,
    this.lastName,
    this.nameCompany,
    this.typeContact,
    this.ruc,
    this.email,
    this.phone,
    this.fechaIngreso,
    this.fechaResolucion,
  });

  DetalleProcesoJudicialDatum copyWith({
    int? id,
    String? nExpediente,
    String? materia,
    String? proceso,
    String? lawyerResponsible,
    String? estado,
    String? sumilla,
    DateTime? dateInitial,
    dynamic updateDate,
    String? oJurisdicional,
    String? dJudicial,
    String? juez,
    String? observacion,
    String? especialidad,
    String? eProcesal,
    dynamic dateConclusion,
    String? ubicacion,
    String? motivoConclusion,
    dynamic name,
    dynamic lastName,
    String? nameCompany,
    String? typeContact,
    String? ruc,
    String? email,
    String? phone,
    DateTime? fechaIngreso,
    dynamic fechaResolucion,
  }) =>
      DetalleProcesoJudicialDatum(
        id: id ?? this.id,
        nExpediente: nExpediente ?? this.nExpediente,
        materia: materia ?? this.materia,
        proceso: proceso ?? this.proceso,
        lawyerResponsible: lawyerResponsible ?? this.lawyerResponsible,
        estado: estado ?? this.estado,
        sumilla: sumilla ?? this.sumilla,
        dateInitial: dateInitial ?? this.dateInitial,
        updateDate: updateDate ?? this.updateDate,
        oJurisdicional: oJurisdicional ?? this.oJurisdicional,
        dJudicial: dJudicial ?? this.dJudicial,
        juez: juez ?? this.juez,
        observacion: observacion ?? this.observacion,
        especialidad: especialidad ?? this.especialidad,
        eProcesal: eProcesal ?? this.eProcesal,
        dateConclusion: dateConclusion ?? this.dateConclusion,
        ubicacion: ubicacion ?? this.ubicacion,
        motivoConclusion: motivoConclusion ?? this.motivoConclusion,
        name: name ?? this.name,
        lastName: lastName ?? this.lastName,
        nameCompany: nameCompany ?? this.nameCompany,
        typeContact: typeContact ?? this.typeContact,
        ruc: ruc ?? this.ruc,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        fechaIngreso: fechaIngreso ?? this.fechaIngreso,
        fechaResolucion: fechaResolucion ?? this.fechaResolucion,
      );

  factory DetalleProcesoJudicialDatum.fromJson(Map<String, dynamic> json) =>
      DetalleProcesoJudicialDatum(
        id: json["id"],
        nExpediente: json["n_expediente"]!,
        materia: json["materia"],
        proceso: json["proceso"],
        lawyerResponsible: json["lawyer_responsible"],
        estado: json["estado"],
        sumilla: json["sumilla"],
        dateInitial: json["date_initial"] == null
            ? null
            : DateTime.parse(json["date_initial"]),
        updateDate: json["update_date"],
        oJurisdicional: json["o_jurisdicional"],
        dJudicial: json["d_judicial"],
        juez: json["juez"],
        observacion: json["observacion"],
        especialidad: json["especialidad"],
        eProcesal: json["e_procesal"],
        dateConclusion: json["date_conclusion"],
        ubicacion: json["ubicacion"],
        motivoConclusion: json["motivo_conclusion"],
        name: json["name"],
        lastName: json["last_name"],
        nameCompany: json["name_company"],
        typeContact: json["type_contact"],
        ruc: json["ruc"],
        email: json["email"],
        phone: json["phone"],
        fechaIngreso: json["fecha_ingreso"] == null
            ? null
            : DateTime.parse(json["fecha_ingreso"]),
        fechaResolucion: json["fecha_resolucion"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "n_expediente": nExpediente,
        "materia": materia,
        "proceso": proceso,
        "lawyer_responsible": lawyerResponsible,
        "estado": estado,
        "sumilla": sumilla,
        "date_initial":
            "${dateInitial!.year.toString().padLeft(4, '0')}-${dateInitial!.month.toString().padLeft(2, '0')}-${dateInitial!.day.toString().padLeft(2, '0')}",
        "update_date": updateDate,
        "o_jurisdicional": oJurisdicional,
        "d_judicial": dJudicial,
        "juez": juez,
        "observacion": observacion,
        "especialidad": especialidad,
        "e_procesal": eProcesal,
        "date_conclusion": dateConclusion,
        "ubicacion": ubicacion,
        "motivo_conclusion": motivoConclusion,
        "name": name,
        "last_name": lastName,
        "name_company": nameCompany,
        "type_contact": typeContact,
        "ruc": ruc,
        "email": email,
        "phone": phone,
        "fecha_ingreso": fechaIngreso?.toIso8601String(),
        "fecha_resolucion": fechaResolucion,
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
        codeUser: json["code_user"]!,
        codeCompany: json["code_company"]!,
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

class Movements {
  final int? currentPage;
  final List<MovementsDatum>? data;
  final String? firstPageUrl;
  final int? from;
  final int? lastPage;
  final String? lastPageUrl;
  final List<Link>? links;
  final String? nextPageUrl;
  final String? path;
  final int? perPage;
  final dynamic prevPageUrl;
  final int? to;
  final int? total;

  Movements({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  Movements copyWith({
    int? currentPage,
    List<MovementsDatum>? data,
    String? firstPageUrl,
    int? from,
    int? lastPage,
    String? lastPageUrl,
    List<Link>? links,
    String? nextPageUrl,
    String? path,
    int? perPage,
    dynamic prevPageUrl,
    int? to,
    int? total,
  }) =>
      Movements(
        currentPage: currentPage ?? this.currentPage,
        data: data ?? this.data,
        firstPageUrl: firstPageUrl ?? this.firstPageUrl,
        from: from ?? this.from,
        lastPage: lastPage ?? this.lastPage,
        lastPageUrl: lastPageUrl ?? this.lastPageUrl,
        links: links ?? this.links,
        nextPageUrl: nextPageUrl ?? this.nextPageUrl,
        path: path ?? this.path,
        perPage: perPage ?? this.perPage,
        prevPageUrl: prevPageUrl ?? this.prevPageUrl,
        to: to ?? this.to,
        total: total ?? this.total,
      );

  factory Movements.fromJson(Map<String, dynamic> json) => Movements(
        currentPage: json["current_page"],
        data: json["data"] == null
            ? []
            : List<MovementsDatum>.from(
                json["data"]!.map((x) => MovementsDatum.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: json["links"] == null
            ? []
            : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": links == null
            ? []
            : List<dynamic>.from(links!.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}

class MovementsDatum {
  final int? id;
  final int? nSeguimiento;
  final DateTime? fechaIngreso;
  final DateTime? fechaResolucion;
  final String? resolucion;
  final String? typeNotificacion;
  final String? acto;
  final int? folios;
  final int? fojas;
  final DateTime? proveido;
  final String? obsSumilla;
  final String? descripcion;
  final String? file;
  final String? noti;
  final String? abogVirtual;
  final String? uTipo;
  final String? uTitle;
  final DateTime? uDate;
  final String? uDescripcion;
  final String? metadata;
  final dynamic documento;
  final String? video;
  final String? codeCompany;
  final String? codeUser;
  final DateTime? updateDate;
  final int? idExp;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  MovementsDatum({
    this.id,
    this.nSeguimiento,
    this.fechaIngreso,
    this.fechaResolucion,
    this.resolucion,
    this.typeNotificacion,
    this.acto,
    this.folios,
    this.fojas,
    this.proveido,
    this.obsSumilla,
    this.descripcion,
    this.file,
    this.noti,
    this.abogVirtual,
    this.uTipo,
    this.uTitle,
    this.uDate,
    this.uDescripcion,
    this.metadata,
    this.documento,
    this.video,
    this.codeCompany,
    this.codeUser,
    this.updateDate,
    this.idExp,
    this.createdAt,
    this.updatedAt,
  });

  MovementsDatum copyWith({
    int? id,
    int? nSeguimiento,
    DateTime? fechaIngreso,
    DateTime? fechaResolucion,
    String? resolucion,
    String? typeNotificacion,
    String? acto,
    int? folios,
    int? fojas,
    DateTime? proveido,
    String? obsSumilla,
    String? descripcion,
    String? file,
    String? noti,
    String? abogVirtual,
    String? uTipo,
    String? uTitle,
    DateTime? uDate,
    String? uDescripcion,
    String? metadata,
    dynamic documento,
    String? video,
    String? codeCompany,
    String? codeUser,
    DateTime? updateDate,
    int? idExp,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      MovementsDatum(
        id: id ?? this.id,
        nSeguimiento: nSeguimiento ?? this.nSeguimiento,
        fechaIngreso: fechaIngreso ?? this.fechaIngreso,
        fechaResolucion: fechaResolucion ?? this.fechaResolucion,
        resolucion: resolucion ?? this.resolucion,
        typeNotificacion: typeNotificacion ?? this.typeNotificacion,
        acto: acto ?? this.acto,
        folios: folios ?? this.folios,
        fojas: fojas ?? this.fojas,
        proveido: proveido ?? this.proveido,
        obsSumilla: obsSumilla ?? this.obsSumilla,
        descripcion: descripcion ?? this.descripcion,
        file: file ?? this.file,
        noti: noti ?? this.noti,
        abogVirtual: abogVirtual ?? this.abogVirtual,
        uTipo: uTipo ?? this.uTipo,
        uTitle: uTitle ?? this.uTitle,
        uDate: uDate ?? this.uDate,
        uDescripcion: uDescripcion ?? this.uDescripcion,
        metadata: metadata ?? this.metadata,
        documento: documento ?? this.documento,
        video: video ?? this.video,
        codeCompany: codeCompany ?? this.codeCompany,
        codeUser: codeUser ?? this.codeUser,
        updateDate: updateDate ?? this.updateDate,
        idExp: idExp ?? this.idExp,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory MovementsDatum.fromJson(Map<String, dynamic> json) => MovementsDatum(
        id: json["id"],
        nSeguimiento: json["n_seguimiento"],
        fechaIngreso: json["fecha_ingreso"] == null
            ? null
            : DateTime.parse(json["fecha_ingreso"]),
        fechaResolucion: json["fecha_resolucion"] == null
            ? null
            : DateTime.parse(json["fecha_resolucion"]),
        resolucion: json["resolucion"],
        typeNotificacion: json["type_notificacion"],
        acto: json["acto"],
        folios: json["folios"],
        fojas: json["fojas"],
        proveido:
            json["proveido"] == null ? null : DateTime.parse(json["proveido"]),
        obsSumilla: json["obs_sumilla"],
        descripcion: json["descripcion"],
        file: json["file"],
        noti: json["noti"],
        abogVirtual: json["abog_virtual"],
        uTipo: json["u_tipo"],
        uTitle: json["u_title"],
        uDate: json["u_date"] == null ? null : DateTime.parse(json["u_date"]),
        uDescripcion: json["u_descripcion"],
        metadata: json["metadata"],
        documento: json["documento"],
        video: json["video"],
        codeCompany: json["code_company"]!,
        codeUser: json["code_user"]!,
        updateDate: json["update_date"] == null
            ? null
            : DateTime.parse(json["update_date"]),
        idExp: json["id_exp"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "n_seguimiento": nSeguimiento,
        "fecha_ingreso": fechaIngreso?.toIso8601String(),
        "fecha_resolucion":
            "${fechaResolucion!.year.toString().padLeft(4, '0')}-${fechaResolucion!.month.toString().padLeft(2, '0')}-${fechaResolucion!.day.toString().padLeft(2, '0')}",
        "resolucion": resolucion,
        "type_notificacion": typeNotificacion,
        "acto": acto,
        "folios": folios,
        "fojas": fojas,
        "proveido":
            "${proveido!.year.toString().padLeft(4, '0')}-${proveido!.month.toString().padLeft(2, '0')}-${proveido!.day.toString().padLeft(2, '0')}",
        "obs_sumilla": obsSumilla,
        "descripcion": descripcion,
        "file": file,
        "noti": noti,
        "abog_virtual": abogVirtual,
        "u_tipo": uTipo,
        "u_title": uTitle,
        "u_date":
            "${uDate!.year.toString().padLeft(4, '0')}-${uDate!.month.toString().padLeft(2, '0')}-${uDate!.day.toString().padLeft(2, '0')}",
        "u_descripcion": uDescripcion,
        "metadata": metadata,
        "documento": documento,
        "video": video,
        "code_company": codeCompany,
        "code_user": codeUser,
        "update_date":
            "${updateDate!.year.toString().padLeft(4, '0')}-${updateDate!.month.toString().padLeft(2, '0')}-${updateDate!.day.toString().padLeft(2, '0')}",
        "id_exp": idExp,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class Link {
  final String? url;
  final String? label;
  final bool? active;

  Link({
    this.url,
    this.label,
    this.active,
  });

  Link copyWith({
    String? url,
    String? label,
    bool? active,
  }) =>
      Link(
        url: url ?? this.url,
        label: label ?? this.label,
        active: active ?? this.active,
      );

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
      };
}

class Notify {
  final int? id;
  final String? name;
  final String? destinatario;
  final DateTime? fechaEnvio;
  final String? anexos;
  final String? formaEntrega;
  final String? abogVirtual;
  final dynamic metadata;
  final dynamic codeCompany;
  final dynamic codeUser;
  final int? idExp;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Notify({
    this.id,
    this.name,
    this.destinatario,
    this.fechaEnvio,
    this.anexos,
    this.formaEntrega,
    this.abogVirtual,
    this.metadata,
    this.codeCompany,
    this.codeUser,
    this.idExp,
    this.createdAt,
    this.updatedAt,
  });

  Notify copyWith({
    int? id,
    String? name,
    String? destinatario,
    DateTime? fechaEnvio,
    String? anexos,
    String? formaEntrega,
    String? abogVirtual,
    dynamic metadata,
    dynamic codeCompany,
    dynamic codeUser,
    int? idExp,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Notify(
        id: id ?? this.id,
        name: name ?? this.name,
        destinatario: destinatario ?? this.destinatario,
        fechaEnvio: fechaEnvio ?? this.fechaEnvio,
        anexos: anexos ?? this.anexos,
        formaEntrega: formaEntrega ?? this.formaEntrega,
        abogVirtual: abogVirtual ?? this.abogVirtual,
        metadata: metadata ?? this.metadata,
        codeCompany: codeCompany ?? this.codeCompany,
        codeUser: codeUser ?? this.codeUser,
        idExp: idExp ?? this.idExp,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Notify.fromJson(Map<String, dynamic> json) => Notify(
        id: json["id"],
        name: json["name"],
        destinatario: json["destinatario"]!,
        fechaEnvio: json["fecha_envio"] == null
            ? null
            : DateTime.parse(json["fecha_envio"]),
        anexos: json["anexos"],
        formaEntrega: json["forma_entrega"]!,
        abogVirtual: json["abog_virtual"]!,
        metadata: json["metadata"],
        codeCompany: json["code_company"],
        codeUser: json["code_user"],
        idExp: json["id_exp"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "destinatario": destinatario,
        "fecha_envio": fechaEnvio?.toIso8601String(),
        "anexos": anexos,
        "forma_entrega": formaEntrega,
        "abog_virtual": abogVirtual,
        "metadata": metadata,
        "code_company": codeCompany,
        "code_user": codeUser,
        "id_exp": idExp,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class Suggestion {
  final int? id;
  final int? idMovi;
  final int? idExp;
  final String? codeExp;
  final String? chatUser;
  final String? prompt;
  final String? entidad;
  final dynamic estado;
  final String? codeUser;
  final String? codeCompany;
  final dynamic metadata;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Suggestion({
    this.id,
    this.idMovi,
    this.idExp,
    this.codeExp,
    this.chatUser,
    this.prompt,
    this.entidad,
    this.estado,
    this.codeUser,
    this.codeCompany,
    this.metadata,
    this.createdAt,
    this.updatedAt,
  });

  Suggestion copyWith({
    int? id,
    int? idMovi,
    int? idExp,
    String? codeExp,
    String? chatUser,
    String? prompt,
    String? entidad,
    dynamic estado,
    String? codeUser,
    String? codeCompany,
    dynamic metadata,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Suggestion(
        id: id ?? this.id,
        idMovi: idMovi ?? this.idMovi,
        idExp: idExp ?? this.idExp,
        codeExp: codeExp ?? this.codeExp,
        chatUser: chatUser ?? this.chatUser,
        prompt: prompt ?? this.prompt,
        entidad: entidad ?? this.entidad,
        estado: estado ?? this.estado,
        codeUser: codeUser ?? this.codeUser,
        codeCompany: codeCompany ?? this.codeCompany,
        metadata: metadata ?? this.metadata,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Suggestion.fromJson(Map<String, dynamic> json) => Suggestion(
        id: json["id"],
        idMovi: json["id_movi"],
        idExp: json["id_exp"],
        codeExp: json["code_exp"]!,
        chatUser: json["chat_user"]!,
        prompt: json["prompt"],
        entidad: json["entidad"]!,
        estado: json["estado"],
        codeUser: json["code_user"]!,
        codeCompany: json["code_company"]!,
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
        "id_movi": idMovi,
        "id_exp": idExp,
        "code_exp": codeExp,
        "chat_user": chatUser,
        "prompt": prompt,
        "entidad": entidad,
        "estado": estado,
        "code_user": codeUser,
        "code_company": codeCompany,
        "metadata": metadata,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
