/*
 * FICHERO:     dates_utils.dart
 * DESCRIPCIÓN: funciones de tratamiento de fechas
 * CREACIÓN:    29/03/2019
 */
import 'package:flutter/material.dart';
import 'package:bookalo/translations.dart';

const List<String> MONTHS = [
  'jan',
  'feb',
  'mar',
  'apr',
  'may',
  'jun',
  'jul',
  'aug',
  'sep',
  'oct',
  'nov',
  'dec'
];

/*
 * Pre:   date es una fecha y context es el contexto de ejecución actual
 * Post:  ha devuelto la fecha en formato textual en el idioma del sistema,
 *        p.e 17 de abril de 2019 o ayer a las 17:22
 */
String dateToFullString(DateTime date, BuildContext context) {
  Duration distance = DateTime.now().difference(date);
  if (distance.inHours < 24) {
    String today = Translations.of(context).text("today_at");
    String hours = (date.hour < 10 ? '0' : '') + date.hour.toString();
    String minutes = (date.minute < 10 ? '0' : '') + date.minute.toString();
    return today + " " + hours + ":" + minutes;
  }
  if (distance.inHours < 48) {
    String yesterday = Translations.of(context).text("yesterday_at");
    String hours = (date.hour < 10 ? '0' : '') + date.hour.toString();
    String minutes = (date.minute < 10 ? '0' : '') + date.minute.toString();
    return yesterday + " " + hours + ":" + minutes;
  }

  String month = Translations.of(context).text(MONTHS[date.month - 1]);
  return Translations.of(context).text("full_date",
      params: [date.day.toString(), month, date.year.toString()]);
}

/*
 * Pre:   date es una fecha y context es el contexto de ejecución actual
 * Post:  ha devuelto la fecha en formato numérico, p.e. 22/12/2019
 */
String dateToNumbers(DateTime date, BuildContext context) {
  String day = (date.day < 10 ? '0' : '') + date.day.toString();
  String month = (date.month < 10 ? '0' : '') + date.month.toString();
  return Translations.of(context)
      .text("number_date", params: [day, month, date.year.toString()]);
}
