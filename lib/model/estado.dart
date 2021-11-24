class Estado {
  final String uf;
  final String nome;

  const Estado(this.uf, this.nome);

  factory Estado.fromJson(Map<String, Object?> json) {
    return Estado(
      json['uf'] as String,
      json['nome'] as String,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'uf': uf,
      'nome': nome,
    };
  }

  @override
  String toString() {    
    return '${nome} - ${uf}';
  }


  static List<Estado> values = [
        
    const Estado('AC', 'Acre'),	
    Estado('AL', 'Alagoas'),
    Estado('AM', 'Amazonas'),
    Estado('AP', 'Amapá'),
    Estado('BA', 'Bahia'),
    Estado('CE', 'Ceará'),
    Estado('DF', 'Distrito Federal'),
    Estado('ES', 'Espírito Santo'),
    Estado('GO', 'Goiás'),
    Estado('MA', 'Maranhão'),
    Estado('MG', 'Minas Gerais'),
    Estado('MS', 'Mato Grosso do Sul'),
    Estado('MT', 'Mato Grosso'),
    Estado('PA', 'Pará'),
    Estado('PB', 'Paraíba'),
    Estado('PE', 'Pernambuco'),
    Estado('PI', 'Piauí'),
    Estado('PR', 'Paraná'),
    Estado('RJ', 'Rio de Janeiro'),
    Estado('RN', 'Rio Grande do Norte'),
    Estado('RO', 'Rondônia'),
    Estado('RR', 'Roraima'),
    Estado('RS', 'Rio Grande do Sul'),
    Estado('SC', 'Santa Catarina'),
    Estado('SE', 'Sergipe'),
    Estado('SP', 'São Paulo'),
    Estado('TO', 'Tocantins')];
}
