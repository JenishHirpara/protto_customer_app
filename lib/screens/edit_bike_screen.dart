import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../providers/bikes.dart';

class EditBikeScreen extends StatefulWidget {
  final Bike bike;

  EditBikeScreen(this.bike);

  @override
  _EditBikeScreenState createState() => _EditBikeScreenState();
}

class _EditBikeScreenState extends State<EditBikeScreen> {
  final _form = GlobalKey<FormState>();
  var dupbike;

  @override
  void initState() {
    dupbike = widget.bike;
    super.initState();
  }

  void _saveForm() {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    Provider.of<Bikes>(context, listen: false).updateBike(dupbike, dupbike.id);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '${widget.bike.brand} ${widget.bike.model}',
          style: GoogleFonts.montserrat(
            color: Color.fromRGBO(241, 93, 36, 1),
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: InkWell(
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Color.fromRGBO(250, 250, 250, 1),
        elevation: 0,
      ),
      body: Form(
        key: _form,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 28, vertical: 10),
          children: <Widget>[
            DropdownButtonFormField(
              value: dupbike.brand,
              decoration: InputDecoration(
                filled: true,
                border: InputBorder.none,
                hintText: 'Brand',
                hintStyle: GoogleFonts.cantataOne(
                  color: Color.fromRGBO(128, 128, 128, 1),
                  fontSize: 14,
                ),
              ),
              items: <String>['Yamaha'].map<DropdownMenuItem>((value) {
                return DropdownMenuItem<String>(
                    child: Text(value), value: value);
              }).toList(),
              validator: (value) {
                if (value == null) {
                  return 'Please provide brand name';
                }
                return null;
              },
              onSaved: (value) {
                dupbike = Bike(
                  id: widget.bike.id,
                  brand: value,
                  model: widget.bike.model,
                  number: widget.bike.number,
                  year: widget.bike.year,
                );
              },
              onChanged: (_) {},
            ),
            SizedBox(height: 10),
            DropdownButtonFormField(
              value: dupbike.model,
              decoration: InputDecoration(
                filled: true,
                border: InputBorder.none,
                hintText: 'Model',
                hintStyle: GoogleFonts.cantataOne(
                  color: Color.fromRGBO(128, 128, 128, 1),
                  fontSize: 14,
                ),
              ),
              items: <String>['FZ'].map<DropdownMenuItem>((value) {
                return DropdownMenuItem<String>(
                    child: Text(value), value: value);
              }).toList(),
              validator: (value) {
                if (value == null) {
                  return 'Please provide model name';
                }
                return null;
              },
              onSaved: (value) {
                dupbike = Bike(
                  id: widget.bike.id,
                  brand: widget.bike.brand,
                  model: value,
                  number: widget.bike.number,
                  year: widget.bike.year,
                );
              },
              onChanged: (_) {},
            ),
            SizedBox(height: 10),
            DropdownButtonFormField(
              value: dupbike.year,
              decoration: InputDecoration(
                filled: true,
                border: InputBorder.none,
                hintText: 'Year',
                hintStyle: GoogleFonts.cantataOne(
                  color: Color.fromRGBO(128, 128, 128, 1),
                  fontSize: 14,
                ),
              ),
              items: <String>['2017'].map<DropdownMenuItem>((value) {
                return DropdownMenuItem<String>(
                    child: Text(value), value: value);
              }).toList(),
              validator: (value) {
                if (value == null) {
                  return 'Please provide year of purchase';
                }
                return null;
              },
              onSaved: (value) {
                dupbike = Bike(
                  id: widget.bike.id,
                  brand: widget.bike.brand,
                  model: widget.bike.model,
                  number: widget.bike.number,
                  year: value,
                );
              },
              onChanged: (_) {},
            ),
            SizedBox(height: 10),
            TextFormField(
              initialValue: dupbike.number,
              decoration: InputDecoration(
                hintText: 'Registration Number',
                hintStyle: GoogleFonts.cantataOne(
                  color: Color.fromRGBO(128, 128, 128, 1),
                  fontSize: 14,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                filled: true,
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please provide year of purchase';
                }
                return null;
              },
              onSaved: (value) {
                dupbike = Bike(
                  id: widget.bike.id,
                  brand: widget.bike.brand,
                  model: widget.bike.model,
                  number: value,
                  year: widget.bike.year,
                );
              },
            ),
            SizedBox(height: 28),
            Container(
              height: 40,
              child: RaisedButton(
                color: Colors.deepOrange,
                textColor: Colors.white,
                child: Text('Edit'),
                onPressed: _saveForm,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
