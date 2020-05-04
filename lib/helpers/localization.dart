import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show SynchronousFuture;

class AppLocalizations {
  AppLocalizations(this.locale);

  final Locale locale;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'yesterday': 'yesterday',
      'today': 'today',
      'time': 'time',
      'items': 'items',
      'pleaseSelectCorrectMaterial': 'please select correct material',
      'pleaseSelectCorrectQuantity': 'please select correct quantity',
      'quantity': 'quantity',
      'unit': 'unit',
      'save': 'save',
      'material': 'material',
      'materialsUsedOn': 'materials used on',
      'addMaterialEntry': 'add material entry',
      'pleaseSelectCorrectProject': 'please select correct project',
      'project': 'project',
      'entries': 'entries',
      'workstep': 'workstep',
      'from': 'from',
      'to': 'to',
      'numberOfHours' : 'Number of hours',
      'pleaseEnterAQuantity': 'please enter a quantity',
      'additionalNotes': 'additional notes',
      'addTimeEntry': 'add time entry',
      'pickDate': 'pick date',
      'createReport': 'create report',
      'pleaseInputCorrectHour': 'please input a correct hour',
      'pleaseSelectADate': 'please select a date',
      'workingTimeOn': 'working time on',
      'logOut': 'Log Out',
      'saveAndAddMore': 'save and add more',
      'confirm': 'confirm',
      'logIn': 'Log In',
      'timeEntry': 'time entry',
      'materialEntry': 'material entry',
      'report': 'report',
      'startTimeEndTime': 'Start time should be less than end time',
      'thisWeek': 'this week',
      'privacy': 'see privacy',
      'item': 'item',
      'reports': 'reports',
      'entry': 'entry',
      'startTimeBiggerEndTime': 'start time should be bigger than end time',
      'sureToExit': 'sure to exit',
      'changesWithoutSaving': 'changes without saving',
      'no': 'no',
      'yes': 'yes',
      'deleteReport': 'delete report',
      'sureToDelete': 'sure to delete',
      'changeLanguage': 'Change language',
      'english': 'english',
      'german': 'german',
      'french': 'french',
      'cancel': 'cancel',
      'pleaseSelectCorrectCustomer': 'please select correct customer',
      'pleaseInputCorrectProjectName': 'please input correct projectName',
      'createMaterial': 'create material',
      'materialName': 'materialName',
      'createProject': 'create project',
      'customer': 'customer',
      'projectName': 'project name',
      'close': 'close',
      'addProject': 'Add Project',
      'addMaterial': 'Add Material',
      'email': 'Email',
      'emptyEmail': 'Email can not be empty',
      'username': 'Username',
      'emptyUsername': 'Username can not be empty',
      'password': 'Password',
      'emptyPassword': 'Password can not be empty'
    },
    'de': {
      'yesterday': 'Gestern',
      'today': 'Heute',
      'time': 'Arbeitszeit',
      'items': 'Artikel',
      'pleaseSelectCorrectMaterial':
          'Bitte wählen Sie das richtige Material aus',
      'pleaseSelectCorrectQuantity': 'Bitte wählen Sie eine korrekte Menge aus',
      'quantity': 'Menge',
      'unit': 'Einheit',
      'save': 'speichern',
      'material': "Material",
      'materialsUsedOn': "Material verwendet am",
      'addMaterialEntry': "Materialeintrag hinzufügen",
      'pleaseSelectCorrectProject': "Bitte wähle das richtige Projekt aus",
      'project': 'Projekt',
      'entries': "Einträge",
      'workstep': "Arbeitsschritt",
      'from': 'von',
      'to': 'bis',
      'numberOfHours' : 'Anzahl Stunden',
      'pleaseEnterAQuantity': 'Bitte geben Sie eine Menge ein',
      'additionalNotes': 'Zusätzliche Bemerkungen',
      'addTimeEntry': 'Zeiteintrag hinzufügen',
      'pickDate': 'Datum auswählen',
      'createReport': 'Bericht erstellen',
      'pleaseInputCorrectHour': 'Bitte geben Sie eine korrekte Uhrzeit ein',
      'pleaseSelectADate': 'Bitte wählen Sie ein Datum',
      'workingTimeOn': 'Arbeitszeit am',
      'logOut': 'Abmelden',
      'saveAndAddMore': 'Speichern und weiteren Eintrag erstellen',
      'confirm': 'bestätigen',
      'logIn': 'Anmelden',
      'timeEntry': 'Arbeitszeit',
      'materialEntry': 'Materialeintrag',
      'report': 'Arbeitsbericht',
      'startTimeEndTime': 'Startzeit sollte kleiner als Endzeit sein',
      'thisWeek': 'Diese Woche',
      'privacy': 'Siehe Datenschutz',
      'item': 'Artikel',
      'reports': 'Berichte',
      'entry': 'Eintrag',
      'startTimeBiggerEndTime':
          'Die Startzeit sollte größer als die Endzeit sein',
      'sureToExit': 'sicher zum Verlassen',
      'changesWithoutSaving': 'Änderungen ohne Speichern',
      'no': 'nein',
      'yes': 'Ja',
      'deleteReport': 'Bericht löschen',
      'sureToDelete': 'Sind Sie sicher zu löschen',
      'changeLanguage': 'Sprache ändern',
      'english': 'Englisch',
      'german': 'Deutsch',
      'french': 'Französisch',
      'cancel': 'Abbrechen',
      'pleaseSelectCorrectCustomer': 'bitte wählen Sie den richtigen Kunden',
      'pleaseInputCorrectProjectName':
          'bitte geben Sie den richtigen Projektnamen ein',
      'createMaterial': 'Material erstellen',
      'materialName': 'Materialname',
      'createProject': 'Projekt erstellen',
      'customer': 'Kunde',
      'projectName': 'Projektname',
      'close': 'schließen',
      'addProject': 'Projekt hinzufügen',
      'addMaterial': 'Material hinzufügen',
      'email': 'Email',
      'emptyEmail': 'Email kann nicht leer sein',
      'username': 'Benutzername',
      'emptyUsername': 'Benutzername kann nicht leer sein',
      'password': 'Password',
      'emptyPassword': 'Password kann nicht leer sein'
    },
    'fr': {
      'yesterday': 'hier',
      'today': 'aujourd\'hui',
      'time': 'temps',
      'items': 'articles',
      'pleaseSelectCorrectMaterial': 'veuillez sélectionner le bon matériel',
      'pleaseSelectCorrectQuantity':
          'veuillez sélectionner la quantité correcte',
      'quantity': 'quantité',
      'unit': 'unité',
      'save': 'enregistrer',
      'material': 'matériel',
      'materialsUsedOn': 'matériaux utilisés sur',
      'addMaterialEntry': 'ajouter une entrée de matériel',
      'pleaseSelectCorrectProject': 'Veuillez sélectionnez le bon projet',
      'project': 'projet',
      'entries': 'entrées',
      'workstep': 'phase de travail',
      'from': 'de',
      'to': 'à',
      'numberOfHours' : 'Nombre d\'heures',
      'pleaseEnterAQuantity': 'veuillez saisir une quantité',
      'additionalNotes': 'Notes complémentaires',
      'addTimeEntry': 'ajouter une saisie de temps',
      'pickDate': 'choisir la date',
      'createReport': 'créer un rapport',
      'pleaseInputCorrectHour': 'Veuillez saisir l\'heure correcte',
      'pleaseSelectADate': 'veuillez sélectionner une date',
      'workingTimeOn': 'durée de travail du',
      'logOut': 'Déconnecter',
      'saveAndAddMore': 'enregistrer et nouveau',
      'confirm': 'confirmez',
      'logIn': 'Se connecter',
      'timeEntry': 'saisie de temps',
      'materialEntry': 'saisie de matériel',
      'report': 'rapport',
      'startTimeEndTime':
          'heure de départ doit être inférieure qu\' heure de fin',
      'thisWeek': 'cette semaine',
      'privacy': 'voir protection des données',
      'item': 'article',
      'reports': 'rapports',
      'entry': 'entrée',
      'startTimeBiggerEndTime':
          'heure de depart doit être suppérieure qu\' heure de fin',
      'sureToExit': 'Est-ce que vous êtes sûr de quitter ?',
      'changesWithoutSaving': 'changements sans enregistrer',
      'no': 'non',
      'yes': 'oui',
      'deleteReport': 'supprimer rapport',
      'sureToDelete': 'est-ce que vous êtes sûr de quitter ?',
      'changeLanguage': 'Changer la langue',
      'english': 'anglais',
      'german': 'allemand',
      'french': 'français',
      'cancel': 'annuler',
      'pleaseSelectCorrectCustomer': 'veuillez saisir le client correct',
      'pleaseInputCorrectProjectName':
          'veuillez saisir le nom de projet correct',
      'createMaterial': 'créer matériel',
      'materialName': 'nom du matériel',
      'createProject': 'créer projet',
      'customer': 'client',
      'projectName': 'nom du projet',
      'close': 'fermer',
      'addProject': 'ajouter projet',
      'addMaterial': 'ajouter matériel',
      'email': 'Email',
      'emptyEmail': 'Email ne peut pas être vide',
      'username': 'Nom d''utilisateur',
      'emptyUsername': 'Nom d''utilisateur ne peut pas être vide',
      'password': 'Mot de passe',
      'emptyPassword': 'Mot de passe ne peut pas être vide'
    },
  };

  String get yesterday {
    return _localizedValues[locale.languageCode]['yesterday'];
  }

  String get today {
    return _localizedValues[locale.languageCode]['today'];
  }

  String get pickDate {
    return _localizedValues[locale.languageCode]['pickDate'];
  }

  String get time {
    return _localizedValues[locale.languageCode]['time'];
  }

  String get material {
    return _localizedValues[locale.languageCode]['material'];
  }

  String get item {
    return _localizedValues[locale.languageCode]['item'];
  }

  String get items {
    return _localizedValues[locale.languageCode]['items'];
  }

  String get pleaseSelectCorrectMaterial {
    return _localizedValues[locale.languageCode]['pleaseSelectCorrectMaterial'];
  }

  String get pleaseSelectCorrectQuantity {
    return _localizedValues[locale.languageCode]['pleaseSelectCorrectQuantity'];
  }

  String get quantity {
    return _localizedValues[locale.languageCode]['quantity'];
  }

  String get unit {
    return _localizedValues[locale.languageCode]['unit'];
  }

  String get save {
    return _localizedValues[locale.languageCode]['save'];
  }

  String get workingTimeOn {
    return _localizedValues[locale.languageCode]['workingTimeOn'];
  }

  String get materialsUsedOn {
    return _localizedValues[locale.languageCode]['materialsUsedOn'];
  }

  String get addMaterialEntry {
    return _localizedValues[locale.languageCode]['addMaterialEntry'];
  }

  String get pleaseSelectCorrectProject {
    return _localizedValues[locale.languageCode]['pleaseSelectCorrectProject'];
  }

  String get project {
    return _localizedValues[locale.languageCode]['project'];
  }

  String get entries {
    return _localizedValues[locale.languageCode]['entries'];
  }

  String get entry {
    return _localizedValues[locale.languageCode]['entry'];
  }

  String get workstep {
    return _localizedValues[locale.languageCode]['workstep'];
  }

  String get from {
    return _localizedValues[locale.languageCode]['from'];
  }

  String get to {
    return _localizedValues[locale.languageCode]['to'];
  }

  String get numberOfHours {
    return _localizedValues[locale.languageCode]['numberOfHours'];
  }

  String get pleaseEnterAQuantity {
    return _localizedValues[locale.languageCode]['pleaseEnterAQuantity'];
  }

  String get additionalNotes {
    return _localizedValues[locale.languageCode]['additionalNotes'];
  }

  String get addTimeEntry {
    return _localizedValues[locale.languageCode]['addTimeEntry'];
  }

  String get createReport {
    return _localizedValues[locale.languageCode]['createReport'];
  }

  String get pleaseSelectADate {
    return _localizedValues[locale.languageCode]['pleaseSelectADate'];
  }

  String get logOut {
    return _localizedValues[locale.languageCode]['logOut'];
  }

  String get saveAndAddMore {
    return _localizedValues[locale.languageCode]['saveAndAddMore'];
  }

  String get confirm {
    return _localizedValues[locale.languageCode]['confirm'];
  }

  String get logIn {
    return _localizedValues[locale.languageCode]['logIn'];
  }

  String get timeEntry {
    return _localizedValues[locale.languageCode]['timeEntry'];
  }

  String get materialEntry {
    return _localizedValues[locale.languageCode]['materialEntry'];
  }

  String get report {
    return _localizedValues[locale.languageCode]['report'];
  }

  String get reports {
    return _localizedValues[locale.languageCode]['reports'];
  }

  String get startTimeEndTime {
    return _localizedValues[locale.languageCode]['startTimeEndTime'];
  }

  String get thisWeek {
    return _localizedValues[locale.languageCode]['thisWeek'];
  }

  String get privacy {
    return _localizedValues[locale.languageCode]['privacy'];
  }

  String get startTimeBiggerEndTime {
    return _localizedValues[locale.languageCode]['startTimeBiggerEndTime'];
  }

  String get pleaseInputCorrectHour {
    return _localizedValues[locale.languageCode]['pleaseInputCorrectHour'];
  }

  String get sureToExit {
    return _localizedValues[locale.languageCode]['sureToExit'];
  }

  String get changesWithoutSaving {
    return _localizedValues[locale.languageCode]['changesWithoutSaving'];
  }

  String get no {
    return _localizedValues[locale.languageCode]['no'];
  }

  String get yes {
    return _localizedValues[locale.languageCode]['yes'];
  }

  String get deleteReport {
    return _localizedValues[locale.languageCode]['deleteReport'];
  }

  String get sureToDelete {
    return _localizedValues[locale.languageCode]['sureToDelete'];
  }

  String get cancel {
    return _localizedValues[locale.languageCode]['cancel'];
  }

  String get pleaseSelectCorrectCustomer {
    return _localizedValues[locale.languageCode]['pleaseSelectCorrectCustomer'];
  }

  String get pleaseInputCorrectProjectName {
    return _localizedValues[locale.languageCode]
        ['pleaseInputCorrectProjectName'];
  }

  String get createMaterial {
    return _localizedValues[locale.languageCode]['createMaterial'];
  }

  String get materialName {
    return _localizedValues[locale.languageCode]['materialName'];
  }

  String get createProject {
    return _localizedValues[locale.languageCode]['createProject'];
  }

  String get customer {
    return _localizedValues[locale.languageCode]['customer'];
  }

  String get projectName {
    return _localizedValues[locale.languageCode]['projectName'];
  }

  String get changeLanguage {
    return _localizedValues[locale.languageCode]['changeLanguage'];
  }

  String get english {
    return _localizedValues[locale.languageCode]['english'];
  }

  String get german {
    return _localizedValues[locale.languageCode]['german'];
  }

  String get french {
    return _localizedValues[locale.languageCode]['french'];
  }

  String get close {
    return _localizedValues[locale.languageCode]['close'];
  }

  String get addProject {
    return _localizedValues[locale.languageCode]['addProject'];
  }

  String get addMaterial {
    return _localizedValues[locale.languageCode]['addMaterial'];
  }

  String get email {
    return _localizedValues[locale.languageCode]['email'];
  }

  String get emptyEmail {
    return _localizedValues[locale.languageCode]['emptyEmail'];
  }

    String get username {
    return _localizedValues[locale.languageCode]['username'];
  }

  String get emptyUsername {
    return _localizedValues[locale.languageCode]['emptyUsername'];
  }

  String get password {
    return _localizedValues[locale.languageCode]['password'];
  }

  String get emptyPassword {
    return _localizedValues[locale.languageCode]['emptyPassword'];
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      ['en', 'de', 'fr'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) {
    // Returning a SynchronousFuture here because an async "load" operation
    // isn't needed to produce an instance of AppLocalizations.
    return SynchronousFuture<AppLocalizations>(AppLocalizations(locale));
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}

class FallbackCupertinoLocalisationsDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const FallbackCupertinoLocalisationsDelegate();

  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<CupertinoLocalizations> load(Locale locale) =>
      DefaultCupertinoLocalizations.load(locale);

  @override
  bool shouldReload(FallbackCupertinoLocalisationsDelegate old) => false;
}
