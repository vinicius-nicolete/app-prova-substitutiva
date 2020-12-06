import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'model/Historico.dart';

void main() async{

  //Registrar o Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/principal',
    routes: {
      '/principal': (context) => TelaPrincipal(),
      '/cadastro': (context) => TelaCadastro(),
    },
  ));
}

//
// TELA PRINCIPAL
//
class TelaPrincipal extends StatefulWidget {
  @override
  _TelaPrincipalState createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {

  var db = FirebaseFirestore.instance;


  List<Historico> historico = List();

  
  StreamSubscription<QuerySnapshot> ouvidor;

  @override
  void initState(){
    super.initState();

    ouvidor?.cancel();

    ouvidor = db.collection("historico").snapshots().listen( (res) {

      setState(() {
        historico = res.docs.map((e) => Historico.fromMap(e.data(), e.id)).toList();
      });

    });


  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Historico de cálculos de Ingredientes"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),


      body: StreamBuilder<QuerySnapshot>(

        stream: db.collection("historico").snapshots(),
        builder: (context,snapshot){

          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Center(child: Text("Erro ao conectar no Firebase"));
            case ConnectionState.waiting:  
              return Center(child: CircularProgressIndicator());
            default: return ListView.builder(
                itemCount: historico.length,
                itemBuilder: (context,index){
                  
                  return Container(
                    margin: EdgeInsets.all(10),
                    child: Row(
                      
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Column(
                            children: [
                            Text('Alcatra: ${historico[index].alcatra} KG', style: TextStyle(fontSize: 24)),
                            Text('Picanha:   ${historico[index].picanha} KG', style: TextStyle(fontSize: 24)),
                            Text('Contrafilé:   ${historico[index].contrafile} KG', style: TextStyle(fontSize: 24)),
                            Text('Pernil:   ${historico[index].pernil} KG', style: TextStyle(fontSize: 24)),
                            Text('Lombo:   ${historico[index].lombo} KG', style: TextStyle(fontSize: 24)),
                            Text('Coxinha:   ${historico[index].coxinha} KG', style: TextStyle(fontSize: 24)),
                            Text('Asa:   ${historico[index].asa} KG', style: TextStyle(fontSize: 24)),
                            Text('Linguiça:   ${historico[index].linguica} KG', style: TextStyle(fontSize: 24)),
                            Text('Arroz:   ${historico[index].arroz} KG', style: TextStyle(fontSize: 24)),
                            Text('Vinagrete:   ${historico[index].vinagrete} KG', style: TextStyle(fontSize: 24)),
                            Text('Farofa:   ${historico[index].farofa} KG', style: TextStyle(fontSize: 24)),                                                    
                            IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: (){

                              
                              db.collection("historico").doc(historico[index].id).delete();

                            },
                          ),
                          ],),
                        ),
                      ],
                    ),
                    
                    

              

                  );

                }
            );

          }
        }

      ),



      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        elevation: 0,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, "/cadastro", arguments: null);
        },
      ),
      backgroundColor: Colors.white,
    );
  }
}

//
// TELA CADASTRO
//
class TelaCadastro extends StatefulWidget {
  @override
  _TelaCadastroState createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {
  var txtHomem = TextEditingController();
  var txtCrianca = TextEditingController();
  var txtMulher = TextEditingController();
 
  bool boolCoxinha = false;
  bool boolAsa = false;
  bool boolArroz = false;
  bool boolLombo = false;
  bool boolPernil = false;
  bool boolContrafile = false;
  bool boolPicanha = false;
  bool boolAlcatra = false;
  bool boolVinagrete = false;
  bool boolFarofa = false;
  bool boolLinguica = false;
  double totalCarne;
  

  var db = FirebaseFirestore.instance;



  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro Ingredientes"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
              child: Container(
            padding: EdgeInsets.all(50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [

              TextField(
                controller: txtHomem,

                style:
                    TextStyle(color: Colors.brown, fontWeight: FontWeight.w300),
                decoration: InputDecoration(
                  labelText: "Quantidade Homem",
                ),
              ),
              SizedBox(
                height: 20,
              ),

                TextField(
                controller: txtMulher,
                style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.w300),
                decoration: InputDecoration(
                  labelText: "Quantidade Mulher",
                ),
              ),
              SizedBox(
                height: 20,
              ),

                TextField(
                controller: txtCrianca,
                style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.w300),
                decoration: InputDecoration(
                  labelText: "Quantidade Criança",
                ),
              ),
              SizedBox(
                height: 20,
              ),

            CheckboxListTile(
              value: boolAlcatra,
              title: Text("Alcatra"),
              onChanged: (bool value){
                setState(() {
                  boolAlcatra = value;
                });
              },
            ),

               CheckboxListTile(
              value: boolPicanha,
              title: Text("Picanha"),
              onChanged: (bool value){
                setState(() {
                  boolPicanha = value;
                });
              },
            ),
              CheckboxListTile(
              value: boolContrafile,
              title: Text("Contrafilé"),
              onChanged: (bool value){
                setState(() {
                  boolContrafile = value;
                });
              },
            ),
              CheckboxListTile(
              value: boolPernil,
              title: Text("Pernil"),
              onChanged: (bool value){
                setState(() {
                  boolPernil = value;
                });
              },
            ),
            
              CheckboxListTile(
              value: boolLombo,
              title: Text("Lombo"),
              onChanged: (bool value){
                setState(() {
                  boolLombo = value;
                });
              },
            ),

              CheckboxListTile(
              value: boolCoxinha,
              title: Text("Coxinha"),
              onChanged: (bool value){
                setState(() {
                  boolCoxinha = value;
                });
              },
            ),
              CheckboxListTile(
              value: boolAsa,
              title: Text("Asa"),
              onChanged: (bool value){
                setState(() {
                  boolAsa = value;
                });
              },
            ),
            CheckboxListTile(
              value: boolLinguica,
              title: Text("Linguiça"),
              onChanged: (bool value){
                setState(() {
                  boolLinguica = value;
                });
              },
            ),
            CheckboxListTile(
              value: boolArroz,
              title: Text("Arroz"),
              onChanged: (bool value){
                setState(() {
                  boolArroz = value;
                });
              },
            ),
              CheckboxListTile(
              value: boolVinagrete,
              title: Text("Vinagrete"),
              onChanged: (bool value){
                setState(() {
                  boolVinagrete = value;
                });
              },
            ),
             CheckboxListTile(
              value: boolFarofa,
              title: Text("Farofa"),
              onChanged: (bool value){
                setState(() {
                  boolFarofa = value;
                });
              },
            ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 150,
                    child: RaisedButton(
                      color: Colors.blue,
                      child: Text("salvar",style: TextStyle(color: Colors.white, fontSize: 20)),
                      
                      onPressed: () async{
                        
                      int qtdhomem = int.parse(txtHomem.text);
                      int qtdmulher = int.parse(txtMulher.text);
                      int qtdcrianca = int.parse(txtCrianca.text);                   

                      double totalCarneAlcatra;
                      double totalCarnePicanha;
                      double totalContrafile;
                      double totalPernil;
                      double totalLombo;
                      double totalCoxinha;
                      double totalAsa;
                      double totalLinguica;
                      double totalArroz;
                      double totalVinagrete;
                      double totalFarofa;


                      if(boolAlcatra == true){
                      totalCarneAlcatra = (qtdhomem * 0.400) + (qtdmulher * 0.300) +  (qtdcrianca * 0.200) ; 
                      }
                      else{
                        totalCarneAlcatra = 0;
                      }
                      if(boolPicanha == true){
                      totalCarnePicanha = qtdhomem * 0.400 + qtdmulher * 0.300 +  qtdcrianca * 0.200 ; 
                      }
                      else{
                        totalCarnePicanha = 0;
                      }                      
                      if(boolContrafile == true){
                      totalContrafile = qtdhomem * 0.400 + qtdmulher * 0.300 +  qtdcrianca * 0.200 ; 
                      }
                      else{
                        totalContrafile = 0;
                      }                                            
                      if(boolPernil == true){
                      totalPernil = qtdhomem * 0.400 + qtdmulher * 0.300 +  qtdcrianca * 0.200 ; 
                      }
                      else{
                        totalPernil = 0;
                      }                      
                      if(boolLombo == true){
                      totalLombo = qtdhomem * 0.400 + qtdmulher * 0.300 +  qtdcrianca * 0.200 ; 
                      }
                      else{
                        totalLombo = 0;
                      }                                             
                      if(boolCoxinha == true){
                      totalCoxinha = qtdhomem * 0.400 + qtdmulher * 0.300 +  qtdcrianca * 0.200 ; 
                      }
                      else{
                        totalCoxinha = 0;
                      }                                            
                      if(boolAsa == true){
                      totalAsa = qtdhomem * 0.400 + qtdmulher * 0.300 +  qtdcrianca * 0.200 ; 
                      }
                      else{
                        totalAsa = 0;
                      }                                            
                      if(boolLinguica == true){
                      totalLinguica = qtdhomem * 0.400 + qtdmulher * 0.300 +  qtdcrianca * 0.200 ; 
                      }
                      else{
                        totalLinguica = 0;
                      }                                            
                      if(boolArroz == true){
                      totalArroz = qtdhomem * 0.060 + qtdmulher * 0.020 +  qtdcrianca * 0.010 ; 
                      }
                      else{
                        totalArroz = 0;
                      }                                            
                      if(boolVinagrete == true){
                      totalVinagrete = qtdhomem * 0.060 + qtdmulher * 0.020 +  qtdcrianca * 0.010  ; 
                      }
                      else{
                        totalVinagrete = 0;
                      }                                            
                      if(boolFarofa == true){
                      totalFarofa = qtdhomem * 0.060 + qtdmulher * 0.020 +  qtdcrianca * 0.010  ; 
                      }
                      else{
                        totalFarofa = 0;
                      }                                            

                       await db.collection("historico").add(
                        {
                              "alcatra": totalCarneAlcatra.toStringAsFixed(3),
                              "picanha": totalCarnePicanha.toStringAsFixed(3),
                              "contrafile": totalContrafile.toStringAsFixed(3),
                              "pernil": totalPernil.toStringAsFixed(3),
                              "lombo": totalLombo.toStringAsFixed(3),
                              "coxinha": totalCoxinha.toStringAsFixed(3),
                              "asa": totalAsa.toStringAsFixed(3),
                              "linguica": totalLinguica.toStringAsFixed(3),
                              "arroz": totalArroz.toStringAsFixed(3),
                              "vinagrete": totalVinagrete.toStringAsFixed(3),
                              "farofa": totalFarofa.toStringAsFixed(3),
                        }
                        );
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  SizedBox(
                    width: 150,
                    child: RaisedButton(
                      color: Colors.blue,
                      child: Text("cancelar",
                          style: TextStyle(color: Colors.white, fontSize: 20)),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ])),
      ),
      backgroundColor: Colors.white,
    );
  }
}
