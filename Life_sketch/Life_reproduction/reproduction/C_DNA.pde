/**
CLASS DNA 0.0.3
*/

Table CODE_DNA_REF  ;
char [] nucleotide_char ;
void load_nucleotide_table(String path) {
  CODE_DNA_REF = loadTable(path, "header") ;
  nucleotide_char = new char[CODE_DNA_REF.getRowCount()] ;
  for(int i = 0 ; i < nucleotide_char.length ; i++) {
    TableRow row = CODE_DNA_REF.getRow(i) ;
    String char_ref = row.getString("char") ;
    nucleotide_char[i] = char_ref.charAt(0) ;
  }
}



class DNA {
  ArrayList<Nucleotide> sequence = new ArrayList<Nucleotide>() ;

  DNA(String data) {
    char [] array_char = data.toCharArray() ;
    for(int i = 0 ; i < array_char.length ; i++) {
      build_sequence(array_char[i]) ;
    }
  }
  
  Nucleotide nucleotide ;
  void build_sequence(char c) {
    Nucleotide [] nucleotide  = new Nucleotide [4] ;
    for(int i = 0 ; i < nucleotide.length ; i++) {
      nucleotide [i] = translate(nucleotide, c)[i] ;
      sequence.add(nucleotide[i]) ;
    }
  }
  
  
  char [] get_sequence() {
    char [] seq = new char[sequence.size()] ;
    for (int i = 0 ; i < sequence.size() ; i++) {
      Nucleotide n = (Nucleotide) sequence.get(i) ;
      seq[i] = n.nac ;
    }
    return seq ;
  }
}




/**
Translate char to Nucleotide
*/
Nucleotide [] translate(Nucleotide [] n, char c) {
  for(int i = 0 ; i < nucleotide_char.length ; i++) {
    if(c == nucleotide_char[i]) {
      write_sequence(n, i) ;
      break ;
    } else {
      for(int j = 0 ; j < n.length ; j++) {
        n [j] = code('X') ;
      }
    }
  }
  return n ;
}

void write_sequence(Nucleotide [] n, int row_id) {
  TableRow row = CODE_DNA_REF.getRow(row_id) ;
  String ref_sequence = row.getString("code") ;
  String [] sequence = ref_sequence.split("") ;
  for(int i = 0 ; i < sequence.length ; i++) {
    n[i] = code(sequence[i].charAt(0)) ;
  }
}


Nucleotide code(char nac) {
  // nac : nucleic acid code from IUPAC
  if(nac == 'A' || nac == 'a') return new Adenine() ;
  else if(nac == 'C' || nac == 'c') return new Cytosine() ;
  else if(nac == 'G' || nac == 'g') return new Guanine() ;
  else if(nac == 'T' || nac == 't') return new Thymine() ;
  else return new Masked() ;
  
}




/**
NUCLEOTIDE
*/
class Nucleotide {
  // nac : nucleic acid code from IUPAC
  char nac  ; 
}


class Guanine extends Nucleotide {
  Guanine () {
    this.nac = 'G' ;
  }
}

class Cytosine extends Nucleotide {
  Cytosine () {
    this.nac = 'C' ;
  }
}

class Adenine extends Nucleotide {
  Adenine () {
    this.nac = 'A' ;
  }
}

class Thymine extends Nucleotide {
  Thymine () {
    this.nac = 'T' ;
  }
}


class Masked extends Nucleotide {
  Masked() {
    this.nac = 'X' ;
  }
}