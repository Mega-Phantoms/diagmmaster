import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:researchapp/ui/widgets.dart';

class AwarennessPage extends StatefulWidget {
  const AwarennessPage({Key? key}) : super(key: key);

  @override
  State<AwarennessPage> createState() => _AwarennessPageState();
}

class _AwarennessPageState extends State<AwarennessPage> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBarr,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Awareness Programs",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
                Card(
                  elevation: 7,
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    height: height / 5,
                    width: width,
                    color: Color.fromARGB(255, 125, 174, 112),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Menstrual Cycle Awareness',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ),
                          Text(
                              'Measures to be taken during and for the menstrual cycle. Making young girls to be educated about the process before hand'),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Color.fromARGB(255, 73, 73, 73),
                                ),
                                onPressed: () {},
                                child: Text(
                                  'ENROLL NOW',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                          )
                        ]),
                  ),
                ),
                Card(
                  elevation: 7,
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    height: height / 5,
                    width: width,
                    color: Color.fromARGB(255, 125, 174, 112),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Menstrual Cycle Awareness',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Text(
                              'Lovhsh jkenm hvjk sdvhjknm aknm, saiklnf avlna uhk usjbkdn ugisdhn sgdjivks sdgvjklsd sdgkjv shdvk dksfnv kdsj'),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Color.fromARGB(255, 73, 73, 73),
                                ),
                                onPressed: () {},
                                child: Text(
                                  'ENROLL NOW',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                          )
                        ]),
                  ),
                ),
                Card(
                  elevation: 7,
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    height: height / 5,
                    width: width,
                    color: Color.fromARGB(255, 125, 174, 112),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Menstrual Cycle Awareness',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Text(
                              'Lovhsh jkenm hvjk sdvhjknm aknm, saiklnf avlna uhk usjbkdn ugisdhn sgdjivks sdgvjklsd sdgkjv shdvk dksfnv kdsj'),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Color.fromARGB(255, 73, 73, 73),
                                ),
                                onPressed: () {},
                                child: Text(
                                  'ENROLL NOW',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                          )
                        ]),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
