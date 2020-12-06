class Historico{

  String id;
  String alcatra;
  String arroz;
  String asa;
  String contrafile;
  String coxinha;
  String farofa;
  String linguica;
  String lombo;
  String pernil;
  String picanha;
  String vinagrete;

  Historico(this.id,this.alcatra,this.arroz,this.asa,this.contrafile,this.coxinha,this.farofa,this.linguica,this.lombo,this.pernil,this.picanha,this.vinagrete,);

  Historico.fromMap(Map<String,dynamic>map, String id){
    this.id = id ?? '';
    this.alcatra = map['alcatra'];
    this.arroz = map['arroz'];
    this.asa = map['asa'];
    this.contrafile = map['contrafile'];
    this.coxinha = map['coxinha'];
    this.farofa = map['farofa'];
    this.linguica = map['linguica'];
    this.lombo = map['lombo'];
    this.pernil = map['pernil'];
    this.picanha = map['picanha'];
    this.vinagrete = map['vinagrete'];
  }
}