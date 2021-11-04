enum StatusEnum {
  pending,
  avalaible,
  close_to_expire,
  expired,
}

class Status {
  final StatusEnum id;
  final String title;
  final String img;
  final String navigationName;

  const Status(
    this.id,
    this.title,
    this.img,
    this.navigationName,
  );

  factory Status.pending() => Status(
        StatusEnum.pending,
        "Pendientes",
        "pending.png",
        "/pending",
      );

  factory Status.avalaible() => Status(
        StatusEnum.avalaible,
        "Disponibles",
        "avalaibles.png",
        "/register",
      );

  factory Status.closeToExpire() => Status(
        StatusEnum.close_to_expire,
        "Cerca de caducar",
        "close_to_expire.png",
        "/close_to_expire",
      );

  factory Status.expired() => Status(
        StatusEnum.expired,
        "Caducados",
        "expired.png",
        "/expired",
      );
}
