import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tracksite/components/components.dart';
import 'package:tracksite/helpers/helpers.dart';
import 'package:tracksite/models/models.dart';
import 'package:tracksite/styles/styles.dart';

class MaterialRecordsPage extends StatefulWidget {
  final Function onTapMaterialRecord;
  final Function onTapDeleteMaterialRecord;
  final DateTime date;
  final List<MaterialRecord> materialRecords;
  final int quantityMaterialRecords;

  MaterialRecordsPage(
    this.onTapMaterialRecord,
    this.onTapDeleteMaterialRecord,
    this.date,
    this.materialRecords,
    this.quantityMaterialRecords,
  ) : super(key: Keys.timeRecordsPage);

  @override
  _MaterialRecordsPageState createState() => new _MaterialRecordsPageState();
}

class _MaterialRecordsPageState extends State<MaterialRecordsPage> {
  bool _deleteMode;

  @override
  void initState() {
    super.initState();

    _deleteMode = false;
  }

  ListView _buildListMaterialRecordsView() {
    return ListView.builder(
      itemCount: widget.materialRecords.length,
      itemBuilder: (BuildContext context, int index) {
        final materialRecord = widget.materialRecords[index];

        return Row(
          children: <Widget>[
            _deleteMode
                ? IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      widget.onTapDeleteMaterialRecord(materialRecord);
                    },
                  )
                : null,
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  decoration: Styles().getInputBoxNoBorder,
                  child: ListTile(
                    onTap: () {
                      widget.onTapMaterialRecord(materialRecord);
                      Navigator.of(context)
                          .pushNamed(Routes.materialRecordDetails);
                    },
                    leading: Icon(
                      Icons.build,
                      color: Theme.of(context).primaryColor,
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          materialRecord.materialName,
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Text(
                            "${materialRecord.quantity} ${materialRecord.unit}")
                      ],
                    ),
                    trailing: Icon(
                      Icons.arrow_right,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ),
            ),
          ].where(notNull).toList(),
        );
      },
    );
  }

  void handleEditModeTap() {
    setState(() {
      _deleteMode = !_deleteMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppHeader(
          title: AppLocalizations.of(context).material,
          action: IconButton(
            icon: Icon(
              _deleteMode ? Icons.check : Icons.edit,
              color: Colors.red,
            ),
            onPressed: handleEditModeTap,
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.0),
                      border: new Border.all(color: Colors.grey, width: 0.5)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 15, left: 15),
                        child: Text(
                            "${Formatter.upperFirstLetter(AppLocalizations.of(context).materialsUsedOn)} ${new DateFormat('EEEE, dd MMMM y', Localizations.localeOf(context).toString()).format(widget.date)}"),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Text(
                          "${widget.quantityMaterialRecords} ${widget.quantityMaterialRecords == 1 ? AppLocalizations.of(context).item : AppLocalizations.of(context).items}",
                          style: TextStyle(fontSize: 38),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: _buildListMaterialRecordsView(),
              )
            ],
          ),
        ),
        floatingActionButton: ButtonTheme(
          minWidth: MediaQuery.of(context).size.width - 40,
          buttonColor: Styles().getButtonColor,
          shape: Styles().getButtonThemeShape,
          child: RaisedButton(
            onPressed: () {
              widget.onTapMaterialRecord(new MaterialRecord());
              Navigator.of(context).pushNamed(Routes.materialRecordDetails);
            },
            child: Text(
              AppLocalizations.of(context).addMaterialEntry.toUpperCase(),
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        resizeToAvoidBottomPadding: false,
      ),
    );
  }
}
