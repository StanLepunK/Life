/**
GENETIC 0.2.6
* Start June 2016
* @author Stan le Punk
* @see https://github.com/StanLepunK/Digital-Life-Processing/tree/master/GENETIC_SYSTEM
*/











/**
GENOME

*/
class Genome {
  ArrayList <Chromosome> list_chromosome = new ArrayList<Chromosome>() ;
  ArrayList <Info> gene_map = new ArrayList<Info>() ;
  String chromosome_gender_name = "Gender" ;
  int num_gene = 0  ;
  /**
  CONSTRUCTOR
  */

  Genome (String [] chromosome_name, String[] gene_name, Gene [] gene_data_mother, Gene [] gene_data_father) {
    // build variable with all data from mother and father
    build_genome(chromosome_name, gene_name, gene_data_mother, gene_data_father) ;
    // choice the gender of creature DNA, if the random is under .5, the gender is female
    gender_chromosome(random(1)) ; 
    // here we add "1" for the gender chromosome
    num_gene = gene_name.length +1 ;
    // genemap
    write_gene_map() ;
  }

  Genome (String [] chromosome_name, String[] gene_name, Gene [] gene_data_mother, Gene [] gene_data_father, int gender) {
    // build variable with all data from mother and father
    build_genome(chromosome_name, gene_name, gene_data_mother, gene_data_father) ;
    // choice the gender of creature DNA, if the random is under .5, the gender is female
    if(gender < 1) gender = 0 ; else gender = 1 ;
    gender_chromosome(gender) ; 
    // here we add "1" for the gender chromosome
    num_gene = gene_name.length +1 ;
        // genemap
    write_gene_map() ;
  }



  /**
  build Chromosome
  */
  void build_genome(String [] chromosome_name, String[] gene_name, Gene [] gene_data_mother, Gene [] gene_data_father) {
    //preparation
    Zygote [] zygote_data = new Zygote[gene_name.length] ;

    int [] num_gene_by_chromosome = new int[chromosome_name.length] ;
    for(int i = 0 ; i < gene_name.length ; i++) {
      for(int j = 0 ; j < chromosome_name.length ; j++) {
        if(gene_data_mother[i].chromosome_name.equals(chromosome_name[j])) {
          num_gene_by_chromosome[j]++ ;
        }
      }
    }

    int [] step_num_gene = new int[chromosome_name.length] ;
    for(int i = 0 ; i < step_num_gene.length ; i++) {
      for( int j = 0 ; j < i ; j++) {
        step_num_gene [i] += num_gene_by_chromosome[j] ;
      }
    }




    for(int i = 0 ; i < zygote_data.length ; i++ ) {
    // check if the allele mother and the allele father have same chromosome
      if(gene_data_mother[i].gene_name.equals(gene_data_father[i].gene_name)) {
        // number locus when there is no locus allocation.
        int locus = 0 ;
        if(gene_data_mother[i].locus >= 0 ) {
          locus = gene_data_mother[i].locus ; 
        } else {
          for(int j = 0 ; j < step_num_gene.length ; j++) {
            if(i < step_num_gene [j] && j > 0) {
              locus = i -step_num_gene [j]  ;
              break ;
            } else {
              locus = i ;
            }
          }
        }
        zygote_data[i] = new Zygote( gene_data_mother[i].chromosome_name, 
                                     gene_data_mother[i].gene_name,
                                     locus,  

                                     gene_data_mother[i].data_left_arm, 
                                     gene_data_mother[i].data_right_arm, 
                                     gene_data_mother[i].dominance_left_arm, 
                                     gene_data_mother[i].dominance_right_arm, 

                                     gene_data_father[i].data_left_arm, 
                                     gene_data_father[i].data_right_arm, 
                                     gene_data_father[i].dominance_left_arm, 
                                     gene_data_father[i].dominance_right_arm ) ;
      }
    }



    // how to choice which allele for which chromosome ?????
    int pointer = 0 ;
    for(int i = 0 ; i < chromosome_name.length ; i++) {
      String [] gene_name_by_chromosome = new String[num_gene_by_chromosome[i]] ;
      // create a raw Zygote without the name
      Zygote [] gene_data_by_chromosome = new Zygote[num_gene_by_chromosome[i]] ;
      int rank = 0 ;
      for(int j = pointer ; j < pointer + num_gene_by_chromosome[i] ; j++) {
        if(zygote_data[j].chromosome_name == chromosome_name[i]) {
          gene_name_by_chromosome[rank] =  gene_name[j] ;
          gene_data_by_chromosome[rank] =  new Zygote(  zygote_data[j].chromosome_name,
                                                        zygote_data[j].name, 
                                                        zygote_data[j].locus,

                                                        zygote_data[j].mother_data_left_arm, 
                                                        zygote_data[j].mother_data_right_arm, 
                                                        zygote_data[j].mother_dominance_left_arm, 
                                                        zygote_data[j].mother_dominance_right_arm, 

                                                        zygote_data[j].father_data_left_arm, 
                                                        zygote_data[j].father_data_right_arm, 
                                                        zygote_data[j].father_dominance_left_arm, 
                                                        zygote_data[j].father_dominance_right_arm) ;
          rank++ ;
        }
      }
      pointer += rank ;
      int rank_chromosome = i ;
      Chromosome c = new Chromosome(chromosome_name[i], rank_chromosome, gene_name_by_chromosome, gene_data_by_chromosome) ;
      list_chromosome.add(c) ;
    }
  }













  /**
  ADD GENE 
  WORK IN PROGRESS
  */
  Chromosome add_gene_to_chromosome(String chromosome, String[] gene_name, Gene [] gene_data_mother, Gene [] gene_data_father) {
    Chromosome c = new Chromosome() ; ;
    return c ;

  }



  /**
  Set Chromosome after buid
  WORK IN PROGRESS
  */
  
  void set_gender_chromosome(String[] gene_name, Gene [] gene_data_mother, Gene [] gene_data_father) {
    for(Chromosome c : list_chromosome ) {
      if(c.chromosome_name == "Gender") {
        add_gene_to_chromosome("Gender", gene_name, gene_data_mother, gene_data_father) ;
      }
    }
  } 
  





















  /**
  NUM

  */
  /**
  get num
  */
  // get num of chromosome
  int num_chromosome() {
    return list_chromosome.size() ;
  }

  int num_gene() {
    int num = 0 ;
    for(int i = 0 ; i < list_chromosome.size() ; i++ ) {
      Chromosome c = list_chromosome.get(i) ;
      int num_allele = num_allele (c) ;
      num += num_allele ;
    }
    return num ;
  }

  /**
  READ

  */
  /**
  get name
  */
  String [] get_chromosome_name() {
    String [] chromosome_name = new String[list_chromosome.size()] ;
    for(int i = 0 ; i < list_chromosome.size() ; i++ ) {
      Chromosome c = list_chromosome.get(i) ;
      chromosome_name [i] = c.chromosome_name ;
    }
    return chromosome_name ;
  }

  /**
  get genotype
  */
  Gene [] get_genotype() {
    Gene [] gene = new Gene[num_gene()] ;
    int pointer = 0 ;
    for(int i = 0 ; i < list_chromosome.size() ; i++) {
      for(int j = 0 ; j < get_chromosome(i).length ; j++) {
        gene[pointer] = get_chromosome(i)[j] ;
        pointer++ ;
      }
    }
    return gene ;
  }

  /**
  get chromosome
  */

  Gene [] get_chromosome(int which_chromosome) {
    // Chromosome c ;
    if(which_chromosome > list_chromosome.size()) {
      Chromosome c = list_chromosome.get(0) ;
      return get_chromosome(c) ;
    } else {
      Chromosome c = list_chromosome.get(which_chromosome) ;
      return get_chromosome(c) ;
    }

  }


  Gene [] get_chromosome(Chromosome c) {
    if(c != null) {
      int num_allele = c.list_allele_left.size() ;
      int size_left = c.list_allele_left.size() ;
      int size_right = c.list_allele_right.size() ;
      // choice the arm
      if(size_left > size_right) num_allele = size_right ; 
      Gene [] gene = new Gene[num_allele] ;
      // attribution data
      for(int i = 0 ; i < num_allele ; i++ ) {
        Allele left = c.list_allele_left.get(i) ;
        Allele right = c.list_allele_right.get(i) ;
        gene [i] = new Gene(c.chromosome_name, left.name, left.locus, left.data, right.data, left.dominance, right.dominance)  ; 
      }
      return gene ;
    } else return null ;
  }




  /**
  get gene
  */
  Gene get_gene(String target) {
    Gene gene = null ;
    boolean match = false  ;
    for(int i = 0 ; i < get_genotype().length ; i++) {
      if(get_genotype()[i].gene_name.equals(target)) {
        gene = get_genotype()[i] ;
        match = true ;
        break ;
      } else {
        match = false ;
        gene = get_genotype()[0] ;
      }
    }
    if(!match) println("Gene get_gene(String target) : your target don't match with any genes of the genotype, instead we use gene '0'") ;
    return gene ;
  }

  Gene get_gene(int target) {
    // Gene gene = null ;
    boolean match = false  ;
    if(target >= num_gene() || target < 0) {
      match = false ;
      target = 0 ;
    } else {
      match = true ;
    }

    if(!match) println("Gene get_gene(int target) : your target don't match with any genes of the genotype, instead we use gene '0'") ;
    return get_genotype()[target] ;
  }

  /**
  get DNA
  */
  char [] get_DNA(String chromosome_name, String gene_name, int arm) {
    char [] sequence_dna = new char[1] ;
    for(int i = 0 ; i < list_chromosome.size() ; i++ ) {
      Chromosome c = list_chromosome.get(i) ;
      if(c.chromosome_name.equals(chromosome_name)) {
        sequence_dna = new char[get_DNA(c, gene_name, arm).length] ;
        for(int j = 0 ; j < sequence_dna.length ; j++) {
          sequence_dna[j] = get_DNA(c, gene_name, arm)[j] ;
        }
        break ;
      }
    }
    return sequence_dna ;
  }


  char [] get_DNA(String chromosome_name, int which_gene, int arm) {
    char [] sequence_dna = new char[1] ;
    for(int i = 0 ; i < list_chromosome.size() ; i++ ) {
      Chromosome c = list_chromosome.get(i) ;
      if(c.chromosome_name.equals(chromosome_name)) {
        sequence_dna = new char[get_DNA(c, which_gene, arm).length] ;
        for(int j = 0 ; j < sequence_dna.length ; j++) {
          sequence_dna[j] = get_DNA(c, which_gene, arm)[j] ;
        }
        break ;
      }
    }
    return sequence_dna ;
  }

  char [] get_DNA(int which_chromosome, int which_gene, int arm) {
    char [] sequence_dna = new char[1] ;
    if(which_chromosome < list_chromosome.size()) {
      Chromosome c = list_chromosome.get(which_chromosome) ;
      sequence_dna = new char[get_DNA(c, which_gene, arm).length] ;
      for(int j = 0 ; j < sequence_dna.length ; j++) {
        sequence_dna[j] = get_DNA(c, which_gene, arm)[j] ;
      }
    }
    return sequence_dna ;
  }




  char [] get_DNA(Chromosome c, int which_gene, int arm) {
    char [] sequence_dna = new char[1] ;

    if (c != null) {
      if( arm == 0 ) {
        sequence_dna = new char[loop_dna(which_gene, c.list_allele_left, sequence_dna).length] ;
        for(int i = 0 ; i < sequence_dna.length ; i++) {
          sequence_dna[i] = loop_dna(which_gene, c.list_allele_left, sequence_dna)[i] ;
        }
      } else if(arm == 1) {
        sequence_dna = new char[loop_dna(which_gene, c.list_allele_right, sequence_dna).length] ;
        for(int i = 0 ; i < sequence_dna.length ; i++) {
          sequence_dna[i] = loop_dna(which_gene, c.list_allele_right, sequence_dna)[i] ;
        }
      } 
    }
    return sequence_dna ;
  }
  


  char [] get_DNA(Chromosome c, String gene_name, int arm) {
    char [] sequence_dna = new char[1] ;

    if (c != null) {
      if( arm == 0 ) {
        int num = c.list_allele_left.size() ;
        sequence_dna = new char[loop_dna(gene_name, num, c.list_allele_left, sequence_dna).length] ;
        for(int i = 0 ; i < sequence_dna.length ; i++) {
          sequence_dna[i] = loop_dna(gene_name, num, c.list_allele_left, sequence_dna)[i] ;
        }
      } else if(arm == 1) {
        int num = c.list_allele_right.size() ;
        sequence_dna = new char[loop_dna(gene_name, num, c.list_allele_right, sequence_dna).length] ;
        for(int i = 0 ; i < sequence_dna.length ; i++) {
          sequence_dna[i] = loop_dna(gene_name, num, c.list_allele_right, sequence_dna)[i] ;
        }
      } 
    }
    return sequence_dna ;
  }
  






  





  /**
  // get gene product
  */

  Info get_gene_product(String target) {
    Info info = new Info(target, "no gene for this name") ;

    int length  = get_gene_product().length ;
    int count  = 0 ;
    for(int i = 0 ; i < length ; i++) {
      if(get_gene_product()[i].name.contains(target)) {
        count ++ ;
        if(get_gene_product()[i].s_a != null)  {
          info = new Info(get_gene_product()[i].name, get_gene_product()[i].s_a) ;
          break ;
        } else if (!Float.isNaN(get_gene_product()[i].f_a)) {
          info = new Info(get_gene_product()[i].name, get_gene_product()[i].f_a) ;
          break ;
        } else if (get_gene_product()[i].i_a != INT_MAX) {
          info = new Info(get_gene_product()[i].name, get_gene_product()[i].i_a) ;
          break ;
        } else {
          info = new Info(get_gene_product()[i].name, "no data match with the request") ;
        }
      }
    }
    if(count > 1 ) info = new Info("target", "Find " + count + " targets for your target") ;
    return info ;
  }

  Info get_gene_product(String target_chromosome, String target_gene) {
    Info info = new Info(target_gene, "the chromosome or gene don't exist") ;
    for(int i = 0 ; i < list_chromosome.size() ; i++) {
      Chromosome c = list_chromosome.get(i) ;
      if(c.chromosome_name.equals(target_chromosome)) {
        for(int j = 0 ; j < get_gene_product(i).length ; j++ ) {
          if(get_gene_product(i)[j].s_a != null)  {
          info = new Info(get_gene_product(i)[j].name, get_gene_product(i)[j].s_a) ;
          break ;
        } else if (!Float.isNaN(get_gene_product(i)[j].f_a)) {
          info = new Info(get_gene_product(i)[j].name, get_gene_product(i)[j].f_a) ;
          break ;
        } else if (get_gene_product(i)[j].i_a != INT_MAX) {
          info = new Info(get_gene_product(i)[j].name, get_gene_product(i)[j].i_a) ;
          break ;
        } else {
          info = new Info(get_gene_product(i)[j].name, "no data match with the request") ;
        }

        }
      }
    }
    return info ;
  }


  Info get_gene_product(int which_chromosome, int locus) {
    Info info = new Info("Chromosome: " + which_chromosome + " locus: " +locus, "don't exist") ;
    if(which_chromosome < list_chromosome.size() &&  locus < list_chromosome.get(which_chromosome).list_allele_left.size() ) {
      if(get_gene_product(which_chromosome)[locus].s_a != null)  {
        info = new Info(get_gene_product(which_chromosome)[locus].name, get_gene_product(which_chromosome)[locus].s_a) ;
      } else if (!Float.isNaN(get_gene_product(which_chromosome)[locus].f_a)) {
        info = new Info(get_gene_product(which_chromosome)[locus].name, get_gene_product(which_chromosome)[locus].f_a) ;
      } else if (get_gene_product(which_chromosome)[locus].i_a != INT_MAX) {
        info = new Info(get_gene_product(which_chromosome)[locus].name, get_gene_product(which_chromosome)[locus].i_a) ;
      } else {
        info = new Info(get_gene_product(which_chromosome)[locus].name, "no data match with the request") ;
      }
    }
    return info ;
  }



  
  Info [] get_gene_product() {
    Info [] info_gene = new Info [num_gene] ;
    int pointer = 0 ;
    for(int i = 0 ; i < list_chromosome.size() ; i++ ) {
      Chromosome c = list_chromosome.get(i) ;
      int num_allele = num_allele (c) ;
      for(int j = 0 ; j < num_allele ; j++) {
        info_gene [ pointer +j] = get_gene_product(i)[j] ;
      }
      pointer += num_allele ;
    }
    return info_gene ;
  }


 

  Info [] get_gene_product(int which_chromosome) {
    if(which_chromosome < list_chromosome.size()) {
      Chromosome c = list_chromosome.get(which_chromosome) ;
      int num_allele = num_allele(c) ;

      Info []allele_name = new Info [num_allele] ;
      // attribution data
      for(int i = 0 ; i < num_allele ; i++ ) {
        Allele left = c.list_allele_left.get(i) ;
        Allele right = c.list_allele_right.get(i) ;
        
        // look for the dominance, recessive or codominace operation
        boolean number ;
        float gene_product_float = 0 ;
        String gene_product_string = "" ;
        float temp_left_dominance = Float.valueOf(left.dominance) ;
        float temp_right_dominance = Float.valueOf(right.dominance) ;
        // test if the data is String or float, 
        try {
          float temp_left_data = Float.valueOf(left.data) ;
          float temp_right_data = Float.valueOf(right.data) ;
          number = true ;
          gene_product_float = ((temp_left_data *temp_left_dominance) +(temp_right_data *temp_right_dominance)) / (temp_left_dominance +temp_right_dominance) ;
        } catch (NumberFormatException e) {
          number = false ;
          if(temp_left_dominance > temp_right_dominance) {
            gene_product_string = left.data ;
          } else if(temp_left_dominance < temp_right_dominance){ 
            gene_product_string = right.data ;
          } else {
            if(left.data == right.data ) {
              gene_product_string = left.data ;
            } else {
              gene_product_string = left.data + right.data ;
            }
          }
        }
        if(number) {
         allele_name [i] = new Info(c.chromosome_name + " > " + left.name, gene_product_float)  ; 
        } else {
          allele_name [i] = new Info(c.chromosome_name + " > " + left.name, gene_product_string)  ;
        }
      }
      return allele_name ;
    } else {
      Info [] i = new Info [1] ;
      i[0] = new Info("This chromosome is not found", which_chromosome) ;
      return i ;
    }
  }





















  /**
  MUTATION

  */
  /**
  get to specific allele gene to do mutation of data.
  */
  // data mutation
  void mutation_data(String target_gene, String mutation, boolean left, boolean right) {
    boolean match = false  ;
    int which_chromosome = 0 ;
    int locus = 0 ;
    // find the gene who match with the target
    for (Info i : gene_map) {
      if(i.s_a.equals(target_gene)) {
        which_chromosome = Integer.parseInt(i.s_b);
        locus = Integer.parseInt(i.s_c);
        match = true ;
        break ;
      } else {
        match = false ;
      }
    }
    // mutation
    if(!match) {
      println("Target gene don't match with any genes of the genotype, no mutation can be done") ;
    } else {
      if(left) {
        list_chromosome.get(which_chromosome).list_allele_left.get(locus).data = mutation ;
      }
      if(right) {
        list_chromosome.get(which_chromosome).list_allele_right.get(locus).data = mutation ;
      }
    }
  }
  
  
  void mutation_data(int which_chromosome, int locus, String mutation, boolean left, boolean right) {
    boolean match_left = false  ;
    boolean match_right = false  ;
    int locus_left  = 0 ;
    int locus_right = 0 ;
    
    // left part
    // find the gene who match with the target
    if(left) {
      if(which_chromosome < list_chromosome.size()) {
        if(locus < list_chromosome.get(which_chromosome).list_allele_left.size()) {
          locus_left = locus ;
          match_left = true ;
        }
      } else {
        match_left = false ;
      }
  
      // mutation
      if(!match_left) {
        println("Target Allele - gene - left don't match with any genes of the genotype, no mutation can be done") ;
      } else {
        list_chromosome.get(which_chromosome).list_allele_left.get(locus_left).data = mutation ;
      }
    }
    // right
     if(right) {
      if(which_chromosome < list_chromosome.size()) {
        if(locus < list_chromosome.get(which_chromosome).list_allele_right.size()) {
          locus_right = locus ;
          match_right = true ;
        }
      } else {
        match_right = false ;
      }
  
      // mutation
      if(!match_right) {
        println("Target Allele - gene - right don't match with any genes of the genotype, no mutation can be done") ;
      } else {
        list_chromosome.get(which_chromosome).list_allele_right.get(locus_right).data = mutation ;
      }
    }
  }
  
  // dominance mutation
  void mutation_dominance(String target_gene, float mutation, boolean left, boolean right) {
    boolean match = false  ;
    int which_chromosome = 0 ;
    int locus = 0 ;
    // find the gene who match with the target
    for (Info i : gene_map) {
      if(i.s_a.equals(target_gene)) {
        which_chromosome = Integer.parseInt(i.s_b);
        locus = Integer.parseInt(i.s_c);
        match = true ;
        break ;
      } else {
        match = false ;
      }
    }
    // mutation
    if(!match) {
      println("Target gene don't match with any genes of the genotype, no mutation can be done") ;
    } else {
      if(left) {
        list_chromosome.get(which_chromosome).list_allele_left.get(locus).dominance = mutation ;
      }
      if(right) {
        list_chromosome.get(which_chromosome).list_allele_right.get(locus).dominance = mutation ;
      }
    }
  }
  
    void mutation_dominance(int which_chromosome, int locus, float mutation, boolean left, boolean right) {
    boolean match_left = false  ;
    boolean match_right = false  ;
    int locus_left  = 0 ;
    int locus_right = 0 ;
    
    // left part
    // find the gene who match with the target
    if(left) {
      if(which_chromosome < list_chromosome.size()) {
        if(locus < list_chromosome.get(which_chromosome).list_allele_left.size()) {
          locus_left = locus ;
          match_left = true ;
        }
      } else {
        match_left = false ;
      }
  
      // mutation
      if(!match_left) {
        println("Target Allele - gene - left don't match with any genes of the genotype, no mutation can be done") ;
      } else {
        list_chromosome.get(which_chromosome).list_allele_left.get(locus_left).dominance = mutation ;
      }
    }
    // right
     if(right) {
      if(which_chromosome < list_chromosome.size()) {
        if(locus < list_chromosome.get(which_chromosome).list_allele_right.size()) {
          locus_right = locus ;
          match_right = true ;
        }
      } else {
        match_right = false ;
      }
  
      // mutation
      if(!match_right) {
        println("Target Allele - gene - right don't match with any genes of the genotype, no mutation can be done") ;
      } else {
        list_chromosome.get(which_chromosome).list_allele_right.get(locus_right).dominance = mutation ;
      }
    }
  }

  



























  

  /**
  LOCAL METHOD

  */


    /**
  write gene map info
  */
  void write_gene_map() {
    gene_map.clear() ;
    for(int i = 0 ; i < get_genotype().length ; i++) {
      String chromosome_name_temp = get_genotype()[i].chromosome_name ;
      String chromosome_rank_temp = "-" ;
      for(int j = 0 ; j < get_chromosome_name().length ; j++) {
        if(get_chromosome_name()[j].equals(get_genotype()[i].chromosome_name)) chromosome_rank_temp = int_to_String(j) ;
      }
      String gene_name_temp = get_genotype()[i].gene_name ;
      String gene_locus_temp = int_to_String(get_genotype()[i].locus) ;
      Info temp = new Info(chromosome_name_temp, gene_name_temp, chromosome_rank_temp, gene_locus_temp) ;
      gene_map.add(temp) ;

    }
  }


  /**
  special chromosome for the gender ;
  */
  void gender_chromosome(float gender) {
    String [] allele_name = new String [1] ;
    // no specific data
    Zygote [] allele_data = new Zygote[1] ;
    allele_data [0] = new Zygote() ;
    allele_name [0] = ("Unknow") ;
    int rank_chromosome = list_chromosome.size() ;
    // build
    Chromosome chromosome_gender = new Chromosome(chromosome_gender_name, rank_chromosome, allele_name, allele_data, gender) ;
    list_chromosome.add(chromosome_gender) ;
  }


  int num_allele (Chromosome c) {
    int num = 0 ;
    num = c.list_allele_left.size() ;
    int size_left = c.list_allele_left.size() ;
    int size_right = c.list_allele_right.size() ;
    // choice the arm
    if(size_left > size_right) { 
      num = size_right ; 
    }
    return num ;
  }

  /**
  DNA writing
  */
  char [] loop_dna(int which_gene, ArrayList<Allele> list_allele, char[] seq) {
    if(which_gene < list_allele.size()) {
      Allele a = list_allele.get(which_gene) ;
      seq = new char[allele_dna(a).length] ;
      for(int j = 0 ; j < seq.length ; j++) {
        seq[j] = allele_dna(a)[j] ;
      } 
    }
    return seq ;
  }



  char [] loop_dna(String gene_name, int num, ArrayList<Allele> list_allele, char[] seq) {
    for(int i = 0 ; i < num ; i++ ) {
      Allele a = list_allele.get(i) ;
      if(a.name.equals(gene_name)) {
        seq = new char[allele_dna(a).length] ;
        for(int j = 0 ; j < seq.length ; j++) {
          seq[j] = allele_dna(a)[j] ;
        }
        break ;
      } 
    }
    return seq ;
  }
 
  //
  char [] allele_dna(Allele a) {

    char [] info = new char[1] ;
    int length_locus = a.dna_locus.get_sequence().length ;
    int length_ancester = a.dna_ancester.get_sequence().length ;
    int length_name = a.dna_name.get_sequence().length ;
    int length_data = a.dna_data.get_sequence().length ;
    int length_dominance = a.dna_dominance.get_sequence().length ;

    int total_length = length_locus +length_ancester +length_name +length_data +length_dominance ;
    info = new char[total_length] ;

    int pointer = 0 ;
    for(int i = 0 ; i < a.dna_locus.get_sequence().length ; i++ ) {
      info[pointer] = a.dna_locus.get_sequence()[i] ;
      pointer++ ;
    }
    for(int i = 0 ; i < a.dna_ancester.get_sequence().length ; i++ ) {
      info[pointer] = a.dna_ancester.get_sequence()[i] ;
      pointer++ ;
    }
    for(int i = 0 ; i < a.dna_name.get_sequence().length ; i++ ) {
      info[pointer] = a.dna_name.get_sequence()[i] ;
      pointer++ ;
    }
    for(int i = 0 ; i < a.dna_data.get_sequence().length ; i++ ) {
      info[pointer] = a.dna_data.get_sequence()[i] ;
      pointer++ ;
    }
    for(int i = 0 ; i < a.dna_dominance.get_sequence().length ; i++ ) {
      info[pointer] = a.dna_dominance.get_sequence()[i] ;
      pointer++ ;
    }
    return info ;
  }
  /**
  END LOCAL METHOD
  */
}
/**
END GENOME

*/




  










/**
CHROMOSOME

*/

class Chromosome {
  // int [] telomere ;
  String chromosome_name ;
  int rank ;

  ArrayList <Allele> list_allele_left = new ArrayList<Allele>() ;
  ArrayList <Allele> list_allele_right = new ArrayList<Allele>() ;
  
  Chromosome() {} ;
  // CONSTRUCTOR for symetric arms chromosome
  Chromosome(String chromosome_name, int rank, String [] gene_name, Zygote [] data) {
    this.chromosome_name = chromosome_name ;
    this.rank = rank ;
    arm_left(gene_name, rank, data) ;
    arm_right(gene_name, rank, data) ;
  }

  // CONSTRUCTOR for gender arms chromosome, no symetric chromosome
  Chromosome(String chromosome_name, int rank, String [] gene_name, Zygote [] data, float gender) {
    this.rank = rank ;
    this.chromosome_name = chromosome_name ;
    int locus = 0 ;
    if(gender < .5 ) {
      gene_name [0] = "XX" ;
      data[0] = new Zygote(chromosome_name, "XX", locus, "X","X",0,0, "X","X",0,0) ;
      arm_left(gene_name, rank, data) ;
      arm_right(gene_name, rank, data) ;
    } else {
      // here we give no choice to the random for the allele distribution.
      gene_name [0] = "XY" ;
      data[0] = new Zygote(chromosome_name, "XY", locus, "X","X",0,0, "X","X",0,0) ;
      arm_left(gene_name, rank, data) ;
      data[0] = new Zygote(chromosome_name, "XY", locus, "Y","Y",1,1, "Y","Y",1,1) ;
      arm_right(gene_name, rank, data) ;
    }
  }

  
  


  void arm_left(String [] gene_name, int rank_chromosome, Zygote [] data) {
    build_allele(gene_name, rank_chromosome, data, list_allele_left) ;
  }
  
  void arm_right(String [] gene_name, int rank_chromosome, Zygote [] data) {
    build_allele(gene_name, rank_chromosome, data, list_allele_right) ;
  }


  void build_allele(String [] gene_name, int rank_chromosome, Zygote [] data, ArrayList<Allele> list_allele) {
    int ref_selected_gene = -1 ;
    for(int i = 0 ; i < gene_name.length ; i++) {
      try {
        // crossing-over
        String final_data = "" ;
        float final_dominance = 0 ;
        String allele_ancester = "" ;
        // choice the allele is replicate from mother or father and which arm, total 4 choices
        int which_allele_data = crossing_over(ref_selected_gene) ;
        ref_selected_gene = which_allele_data ;
        // replicate allele on the selected arm
        if(which_allele_data == 0) {
          allele_ancester = "mother" ;
          final_data = data[i].mother_data_left_arm ; 
          final_dominance = data[i].mother_dominance_left_arm ; 
        } else if (which_allele_data == 1) {
          allele_ancester = "mother" ;
          final_data = data[i].mother_data_right_arm ;
          final_dominance = data[i].mother_dominance_right_arm ; 
        } else if (which_allele_data == 2) {
          allele_ancester = "father" ;
          final_data = data[i].father_data_left_arm ;
          final_dominance = data[i].father_dominance_left_arm ; 
        } else {
          allele_ancester = "father" ;
          final_data = data[i].father_data_right_arm  ;
          final_dominance = data[i].father_dominance_right_arm ; 
        }
        // locus is the position of the allele in the chromosome arm,
        int locus = data[i].locus ;
        // build
        Allele allele = new Allele(rank_chromosome, locus, allele_ancester, gene_name[i], final_data, final_dominance) ;
        list_allele.add(allele) ;
      }
      catch(ArrayIndexOutOfBoundsException e) {
        e.printStackTrace();
      }
    }
  }





  int crossing_over(int ref) {
    int setected_gene = floor(random(4)) ;
    if(setected_gene == 4) setected_gene = 3 ;
    if(setected_gene == ref) crossing_over(ref) ;
    return setected_gene ;
  }
}








/**
Zygote is a container for the mother and father gene
*/
class Zygote {
  String chromosome_name ;
  String name ; 
  int locus ;
  String mother_data_left_arm, mother_data_right_arm ;
  float mother_dominance_left_arm, mother_dominance_right_arm ;
  String father_data_left_arm, father_data_right_arm ;
  float father_dominance_left_arm, father_dominance_right_arm ;

  Zygote() {}

  Zygote (String chromosome_name, String name, 
          int locus,

          String mother_data_left_arm, String mother_data_right_arm, 
          float mother_dominance_left_arm, float mother_dominance_right_arm, 

          String father_data_left_arm, String father_data_right_arm, 
          float father_dominance_left_arm, float father_dominance_right_arm) {

    this.chromosome_name = chromosome_name ;
    this.name = name ; 
    this.locus = locus ;
    this.mother_data_left_arm = mother_data_left_arm ;
    this.mother_data_right_arm = mother_data_right_arm ;
    this.mother_dominance_left_arm = mother_dominance_left_arm ;
    this.mother_dominance_right_arm = mother_dominance_right_arm ;
    this.father_data_left_arm = father_data_left_arm ;
    this.father_data_right_arm = father_data_right_arm ;
    this.father_dominance_left_arm = father_dominance_left_arm ;
    this.father_dominance_right_arm = father_dominance_right_arm ;
  }
}













/**
ALLELE

*/
class Allele {
  int type = 0 ;
  /**
  allele type
  0 = lethal ;
  1 = null ;
  2 = co-dominance ;
  */
  /**
  dominance and recessive is a complexe question, must be resolve in the future
  */
  int rank_chromosome ;
  int locus ;
  String ancester ;
  String name ;
  String data ;
  float dominance ;
  DNA dna_locus, dna_ancester, dna_name, dna_data, dna_dominance ;
  Allele(int rank_chromosome, int locus, String ancester, String name, String data, float dominance) {
    this.rank_chromosome = rank_chromosome ;
    this.locus = locus ;
    this.ancester = ancester ;
    this.name = name ;
    this.data = data ;
    this.dominance = dominance ;
    dna_locus = new DNA(int_to_String(locus)) ;
    dna_ancester = new DNA(ancester) ;
    dna_name = new DNA(name) ;
    dna_data = new DNA(data) ;
    dna_dominance = new DNA(float_to_String_4(dominance)) ;
  }
}










/**
GENE 
This class is used when we need it, but it's the Allele the real information container.
*/
class Gene {
  String chromosome_name ;
  String gene_name ;
  int locus = -1 ;
  String data_left_arm, data_right_arm ;
  float dominance_left_arm, dominance_right_arm ;


  /**
  with locus
  */
  Gene(String chromosome_name, String gene_name, int locus, String data_left_arm, String data_right_arm, float dominance_left_arm, float dominance_right_arm) {
    this.chromosome_name = chromosome_name ;
    this.gene_name = gene_name ;
    this.locus = locus ;
    this.data_left_arm = data_left_arm ;
    this.data_right_arm = data_right_arm ;
    this.dominance_left_arm = dominance_left_arm ;
    this.dominance_right_arm = dominance_right_arm ;
  }

  Gene(String chromosome_name, String gene_name, int locus, float data_left_arm, float data_right_arm, float dominance_left_arm, float dominance_right_arm) {
    this.chromosome_name = chromosome_name ;
    this.gene_name = gene_name ;
    this.locus = locus ;
    this.data_left_arm = float_to_String_3(data_left_arm) ;
    this.data_right_arm = float_to_String_3(data_right_arm) ;
    this.dominance_left_arm = dominance_left_arm ;
    this.dominance_right_arm = dominance_right_arm ;
  }


  Gene(String chromosome_name, String gene_name, int locus, Vec2 data, Vec2 dominance) {
    this.chromosome_name = chromosome_name ;
    this.gene_name = gene_name ;
    this.locus = locus ;
    this.data_left_arm = float_to_String_3(data.x) ;
    this.data_right_arm = float_to_String_3(data.y) ;
    this.dominance_left_arm = dominance.x ;
    this.dominance_right_arm = dominance.y ;
  }

  Gene(String chromosome_name, String gene_name, int locus, String data_left_arm, String data_right_arm, Vec2 dominance) {
    this.chromosome_name = chromosome_name ;
    this.gene_name = gene_name ;
    this.locus = locus ;
    this.data_left_arm = data_left_arm ;
    this.data_right_arm = data_right_arm ;
    this.dominance_left_arm = dominance.x ;
    this.dominance_right_arm = dominance.y ;
  }

    /**
  without locus
  */
  Gene(String chromosome_name, String gene_name, String data_left_arm, String data_right_arm, float dominance_left_arm, float dominance_right_arm) {
    this.chromosome_name = chromosome_name ;
    this.gene_name = gene_name ;
    this.data_left_arm = data_left_arm ;
    this.data_right_arm = data_right_arm ;
    this.dominance_left_arm = dominance_left_arm ;
    this.dominance_right_arm = dominance_right_arm ;
  }

  Gene(String chromosome_name, String gene_name, float data_left_arm, float data_right_arm, float dominance_left_arm, float dominance_right_arm) {
    this.chromosome_name = chromosome_name ;
    this.gene_name = gene_name ;
    this.data_left_arm = float_to_String_3(data_left_arm) ;
    this.data_right_arm = float_to_String_3(data_right_arm) ;
    this.dominance_left_arm = dominance_left_arm ;
    this.dominance_right_arm = dominance_right_arm ;
  }


  Gene(String chromosome_name, String gene_name, Vec2 data, Vec2 dominance) {
    this.chromosome_name = chromosome_name ;
    this.gene_name = gene_name ;
    this.data_left_arm = float_to_String_3(data.x) ;
    this.data_right_arm = float_to_String_3(data.y) ;
    this.dominance_left_arm = dominance.x ;
    this.dominance_right_arm = dominance.y ;
  }

  Gene(String chromosome_name, String gene_name, String data_left_arm, String data_right_arm, Vec2 dominance) {
    this.chromosome_name = chromosome_name ;
    this.gene_name = gene_name ;
    this.data_left_arm = data_left_arm ;
    this.data_right_arm = data_right_arm ;
    this.dominance_left_arm = dominance.x ;
    this.dominance_right_arm = dominance.y ;
  }



  String get_chromosome_name() {
    return chromosome_name ;
  }

  String get_gene_name() {
    return gene_name ;
  }

  int get_locus() {
    return locus ;
  }


  @ Override String toString() {
    return "[ < Chromosome " + chromosome_name + " > < Gene " + gene_name + " > < Locus " + locus + " >< data: " + data_left_arm + " / " + data_right_arm + " > < dominance: " + dominance_left_arm + " / " +dominance_right_arm + " > ]";
  }
}