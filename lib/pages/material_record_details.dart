import 'package:flutter/material.dart';
import 'package:tracksite/components/components.dart';
import 'package:tracksite/containers/containers.dart';
import 'package:tracksite/helpers/helpers.dart';
import 'package:tracksite/models/models.dart';
import 'package:tracksite/services/services.dart';
import 'package:tracksite/styles/styles.dart';

class MaterialRecordDetailsPage extends StatefulWidget {
  final Function(MaterialRecord) onSave;
  final Function(MaterialRecord) onSaveAndContinue;
  final MaterialRecord materialRecord;

  MaterialRecordDetailsPage(
      this.onSave, this.onSaveAndContinue, this.materialRecord)
      : super(key: Keys.materialRecordDetailsPage);

  @override
  MaterialRecordDetailsPageState createState() =>
      MaterialRecordDetailsPageState();
}

class MaterialRecordDetailsPageState extends State<MaterialRecordDetailsPage> {
  Map _errors;

  @override
  void initState() {
    super.initState();

    _errors = new Map();
    _errors['materialName'] =
        widget.materialRecord.materialName?.isEmpty ?? true;
    _errors['quantity'] = widget.materialRecord.quantity == null;
  }

  Future _handleOnAddButtonPress() async {
    await showDialog(
      context: context,
      builder: (context) => NewMaterialDialog(),
    );

    setState(() {
      _errors.update('materialName',
          (e) => widget.materialRecord.materialName?.isEmpty ?? true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppHeader(
          title: AppLocalizations.of(context).materialEntry,
        ),
        body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                CustomTypeAheadField(
                  id: 'materialName',
                  text: widget.materialRecord.materialName,
                  service: MaterialService().getListByName,
                  hintText: AppLocalizations.of(context).material,
                  errorText:
                      AppLocalizations.of(context).pleaseSelectCorrectMaterial,
                  prefixIcon: Icons.assignment,
                  suggestionWidget: (material) =>
                      ListTile(title: Text(material.name)),
                  addButton: MaterialModel(
                      id: AppLocalizations.of(context).addMaterial),
                  onAddButtonPress: _handleOnAddButtonPress,
                  onSuggestionSelected: (material) {
                    widget.materialRecord.materialId = material.id;
                    widget.materialRecord.materialName = material.name;
                    widget.materialRecord.unit = material.unit;
                  },
                  errors: _errors,
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Flexible(
                        child: CustomInputField(
                          id: 'quantity',
                          hintText: AppLocalizations.of(context).quantity,
                          initialValue:
                              widget.materialRecord.quantity?.toString(),
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: true),
                          onChanged: (value) {
                            setState(() {
                              String cleanedDecimalQuantity = value.toString().replaceAll(',', '.');
                              widget.materialRecord.quantity = double.tryParse(cleanedDecimalQuantity);
                            });
                          },
                          prefixIcon: Icons.layers,
                          errorText: AppLocalizations.of(context)
                              .pleaseSelectCorrectQuantity,
                          errors: _errors,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Divider(),
                      ),
                      Expanded(
                        child: Container(
                          decoration: Styles().getInputBox,
                          child: Padding(
                            padding: EdgeInsets.all(2),
                            child: ListTile(
                              leading: Icon(
                                Icons.category,
                                color: Theme.of(context).primaryColor,
                              ),
                              title: Text(widget.materialRecord.unit ??
                                  Formatter.upperFirstLetter(
                                      AppLocalizations.of(context).unit)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: BottomButtonsDetailsPage(
          disabled: _errors.containsValue(true),
          onTapTop: () => widget.onSaveAndContinue(widget.materialRecord),
          onTapBottom: () => widget.onSave(widget.materialRecord),
        ),
        resizeToAvoidBottomInset: false,
      ),
    );
  }
}
