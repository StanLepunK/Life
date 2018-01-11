GENETEC 0.4.0 
--
by Stan le Punk 2016-2016
--

Method
--
Archetype is fast method to create genome.
you asign a value and the algrithm create the ascendant mother and father.
@return Object of type Genome

Genome archetype(float [] float_data) ;

Genome archetype(String [] string_data) ;

Genome archetype(float [] float_data, int gender) ;

Genome archetype(String [] string_data, int gender) ;

Genome archetype(float [] float_data, String [] data_name) ;

Genome archetype(String [] string_data, String [] data_name) ;

Genome archetype(float [] float_data, String [] string_data, int gender) ;

Genome archetype(float [] float_data, String [] string_data, String [] data_name) ;

Genome archetype(float [] float_data, String [] string_data, String [] data_name, int gender) ;

--
Arg array list of gene to add in the method archetype
--
float [] float_data ;
>float list of argument to manage the genome with float member

String [] string_data ;
>String list of argument to manage the genome with String member

String [] data_name ;
>String name give to the float list then the String data list, the quantity must me equal to the num float and String list.

int gender ;
>int "0" for female, "1" for male







Build
--
Genome build() ;
>return Object of type Genome




CLASS
--
There is few differente class to build a Genome
> Genome, Chromosome, Gene, Zygote, Allele and DNA


Class Genome
--

Constructor
--
Genome (String [] chromosome_name, String[] gene_name, Gene [] gene_data_mother, Gene [] gene_data_father) ;


Method
--




GENE MAP
--
ArrayList <Info> gene_map = new ArrayList<Info>() ;
>return INfo
String chromosome_name ;

String gene_name ;

String rank_chromosome ;

String locus_gene ;






GET NUM
--
int num_chromosome() ;

int num_gene() ;






GET NAME
--
String [] get_chromosome_name() ;


GET GENE PRODUCT
--
Info get_gene_product(String target_gene) ;

Info get_gene_product(String target_chromosome, String target_gene) ;

Info get_gene_product(int which_chromosome, int locus) ;
>can return a float or String
--
catch String with component method_name().s_a ;

catch the float with component method_name().f_a ;

Info [] get_gene_product() ;

Info [] get_gene_product(int which_chromosome) ;

Info [] get_gene_product(String name_gene) ;



GET GENOTYPE
--
Gene [] get_genotype() ;
>returm the gene data map of Genotype – all chromosomes –


GET CHROMOSOME
--
Gene [] get_chromosome(int which_chromosome) ;
>returm the gene data map for a specific chromosome

Gene [] get_chromosome(Chromosome c) ;
>returm the gene data map for a specific chromosome



GET GENE
--
Gene get_gene(String gene_name) ;
>return gene targeting, if this one exist else return gene '0'

Gene get_gene(int gene_target) ;
>return gene targeting, if this one exist else return gene '0'




GET DNA
--
return the Nac - Nucleotide Acide Code - of the Nucleotide... just for fun.
It's very slow to make this map :)
>return an array char

char [] get_DNA(String chromosome_name, String gene_name, int arm) ;

char [] get_DNA(String chromosome_name, int which_gene, int arm) ;

char [] get_DNA(int which_chromosome, int which_gene, int arm) ;

char [] get_DNA(Chromosome c, int which_gene, int arm) ;


arg
--
String Chromosome_name ;

int which_chromosome ;

Chromosome c ;

String gene_name ;

int which_gene ;

int arm ; 0 for the left arm, 1 for the right arm







MUTATION
--
MUTATION DATA
--
void mutation_data(String target_gene, String mutation, boolean left, boolean right) ;

void mutation_data(int which_chromosome, int locus, String mutation, boolean left, boolean right) ;
--
arg
--
>target gene
String target_gene ;

>or

>int which_chromosome
>int locus

String mutation ;

>to choice on which allele is done
boolean left ;

boolean right ;



MUTATION DOMINACE
--
void mutation_dominance(String target_gene, float mutation, boolean left, boolean right) ;

void mutation_dominance(int which_chromosome, int locus, float mutation, boolean left, boolean right) ;
--
arg
--
String target_gene ;
>target gene

or
int which_chromosome
int locus

String mutation

> to choice on which allele is done
boolean left
boolean right















Class Gene
--
Constructor
--
>Four constructors very similar, the only difference is the data for the right and the left arm, can be in String or in float
>without locus location

Gene(String chromosome_name, String name, String data_left_arm, String data_right_arm, float dominance_left_arm, float dominance_right_arm) ; 

Gene(String chromosome_name, String name, float data_left_arm, float data_right_arm, float dominance_left_arm, float dominance_right_arm) ;

Gene(String chromosome_name, String name, Vec2 data, Vec2 dominance) ;

Gene(String chromosome_name, String name, String data_left_arm, String data_right_arm, Vec2 dominance)  ;

>with locus location
Gene(String chromosome_name, String name, int locus, String data_left_arm, String data_right_arm, float dominance_left_arm, float dominance_right_arm) ;

Gene(String chromosome_name, String name, int locus, float data_left_arm, float data_right_arm, float dominance_left_arm, float dominance_right_arm) ;

Gene(String chromosome_name, String name, int locus, Vec2 data, Vec2 dominance) ;

Gene(String chromosome_name, String name, int locus, String data_left_arm, String data_right_arm, Vec2 dominance) ;


















Class DNA
--
This class write a DNA sequence from String or int length, this DNA can be pairing.

This class use a table to write the DNA code, you can read this one in the folder data, file 'code.csv'



Constructor
--
DNA(String data, boolean pairing_dna) ;

DNA(int length, boolean pairing_dna) ;



















HELIX DNA
--
> Method and class Helix DNA work only in P3D mode

class Helix_DNA
--
Constructor
--
Helix_DNA (int num_strand, int num_nucleotide, int nucleotide_by_revolution) ;

Info
--
void size() ;
>return the DNA strand quantity

int length() ;
>return the num of nucleotides of the first strand

int length(int which_strad) ;
>return the num of nucleotides in this strand, if this strand don't exist the method return '0'

Vec3 get_radius() ;
>return radius of the DNA, by default you must catch the x and z value, because the representation of strand DNA is like horizontal disk.

DNA get_DNA(which_strand) ;
>return DNA sequence, in case special where there is two strand you must chosse the strand '0' because for this only case the DNA have two strand but pairing. it's special case, but universale one too :)


Setting
--
void set_radius(int ratio) ;

void set_radius(int ratio_x, int ratio_z) ;

void set_height(int height_strand) ;

void set_pos(Vec3 global_pos) ;


get Strand DNA
--
Strand_DNA [] get() ;
>return an Array with all Strand of this DNA

Strand get(int which_strand) ;
>return this Strand DNA targeted.


get Vec position
--
Vec3 [] get_pos() ;
>return all Vec positions of the nucleotide

Vec3 [] get_pos(int which_strand) ;
>return all Vec position of this DNA strand





Method
--
Vec3 [] helix(int num_pts_by_revolution, int level, float spacing, int radius, float start_angle)
>return an list of points position x,y and z position of the differents DNA elements, like Guaninie, Cytosine... in the helix.
>this helix is simple and not paired.

argument
--
int num_pts_by_revolution ;
>quantity of nucleotide of one rotation

int level ;
>quantity of revolution

int spacing
>space between revolution

int radius
>helix radius

float start_angle
>useful when you want use more of one helix, like the gene with two strand DNA, where the strand are opposite.






