ECO-SYSTEME 0.0.6
--
GUIDE TO USE
--
this guide is not updated
--
Ecosystem is a multi-agent system with predator, prey. Where the death is a begin of life !


SET ECOSYSTEM
--
void use_horizon(boolean horizon) ;
>you can use this method to ask agent to dissapear smoothly when this one approche to the hozizon.
>Can be use only in P3D mode.

void use_rebound(boolean horizon) ;
>turn on or off the rebound effect on the wall box

void use_style(boolean style) ;
>to use external aspect for your agents if it's true. If it's false Ecosystem use the genetic information for the aspect.

To look the agent behavior and why that's must happen
INFO_DISPLAY_AGENT = false ; 




HOST
--
symbiosis
--
void set_symbiosis_area(Vec3 [] target_host_list) ;

void update_symbiosis_area(Vec3 [] target_host_list) ;

void symbiosis(ArrayList<Agent> symbiotic_agent_list, Vec3 [] list_coord_host, int [] address) ;

void sync_symbiosis(ArrayList<Agent> symbiotic_agent_list, Vec3 pos) ;

void sync_symbiosis(ArrayList<Agent> symbiotic_agent_list) ;






LIST
--
ArrayList<Agent> AGENT_LIST = new ArrayList<Agent>() ;

ArrayList<Dead> DEAD_LIST = new ArrayList<Dead>() ;

STYLE
--
Info_obj style_agent = new Info_obj("Blabla name", int costume, Vec4 fill, Vec4 stroke, float thickness, Vec3 alpha_behavior, boolean fill_is, bolean stroke_is) ;  


CARACTERISTIC
--
Info_dict carac_agent = new Info_dict() ;


CLEAR
--
agent_carac.clear() ;

AGENT_LIST.clear() ;


SET CARACTERISTIC AGENT DYNAMIC
--
When you set the caracteric, you must be carefuly with the float and use the 'dot' if the value is like an interger. for '1' you must write like that '1.'
agent_carac.add("name", "Human") ;
>String

agent_carac.add("size", Vec3(25)) ; 
>Vec3

agent_carac.add("density", .5) ; 
>float around 1 it's use to create the mass of your agent by this way: size.x + size.y + size.z /3 *density

agent_carac.add("melanin", Vec4(1)) ; 
>Vec4 value. the component must be normalize, because the values are used to multiply the color 'r' 'g' 'b' 'a' or 'h' 's' 'b' 'a'

agent_carac.add("first_colour", Vec4()) ; 
>Vec4 value. 

agent_carac.add("second_colour", Vec4()) ; 
>Vec4 value. 

agent_carac.add("third_colour", Vec4()) ; 
>Vec4 value. 

agent_carac.add("stamina", 200) ;
>int

agent_carac.add("life_expectancy", 800 *60) ; 
>int value 

agent_carac.add("velocity", 8) ;
>int value 

agent_carac.add("nutrient_quality", 20) ; 
>int value 

agent_carac.add("sense_range", 1000) ; 
>int value 

agent_carac.add("gourmet", 2.5) ; 
>float value 

agent_carac.add("attack", 5) ; 
>int value 

agent_carac.add("starving", 3) ; 
>int value 

agent_carac.add("digestion", 6.5) ; 
>float value. Capacity to use calories from food

agent_carac.add("sex_appeal", Vec2(45, 4)) ;
>Vec2 value, vec.x is for 'female' and vec.y is for 'male' 

agent_carac.add("multiple_pregnancy", 10.5) ; 
>float value. It's mutiplicator value to give a change to have an other child in reproduction period











--
LOG
--
>Create log and save in the log folder.

void set_log_ecosystem(boolean log) ;

void set_log_agents(oolean log) ;

void set_log_herbivore(oolean log) ;

void set_log_omnivore(foolean log) ;

void set_log_carnivore(oolean log) ;

void set_log_bacterium(oolean log) ;

void set_log_flora(oolean log) ;

void set_log_dead(oolean log) ;















































SYSTEM MULTI AGENT 0.0.6
--
Guide to build agents system
--




BUILD
---------
void build_environment(Vec3 pos, Vec3 size, Biomass biomass)
void build_environment(Vec2 pos, Vec2 size, Biomass biomass)
> with Vec2, the world will be in 2D, with Vec3 it will be in 3D




CLEAR
-----------
void clear_ecosytem()
> empty all the list of the ecosytem



set aspect, fill, stroke and thickness (strokeWeight) of your agent
--
set_aspect_flora(Vec4 fill, Vec4 stroke, float thickness) ;

set_aspect_herbivore(Vec4 fill, Vec4 stroke, float thickness) ;

set_aspect_carnivore(Vec4 fill, Vec4 stroke, float thickness) ;

set_aspect_bacterium(Vec4 fill, Vec4 stroke, float thickness) ;

set_aspect_corpse(Vec4 fill, Vec4 stroke, float thickness) ;























--
--
CLASS AGENT
--
--

interface Agent
int CLOCK
> a high value slowest the time...
@ this var can change the speed_feeding, hunger...


VARIABLE
--
Vec4 colour_fill ;

Vec4 colour_stroke ;

float thickness ;

String name ;

int ID ;




GET METHOD AGENT
--
get home
-- 
Vec4 get_home() ;

Vec3 get_home_pos() ;

int get_home_id() ;



SET METHOD AGENT
--
set home
--
void set_home(Vec4 home) ;

void set_home(Vec3 pos, int id_home) ;

void set_home_pos(Vec3 pos) ;

void set_home_ID(int id_home) ;




set aspect
--
void set_fill(Vec4 colour_fill) ;
> colour_fill = Vec4(0,0,0,max_color_environment_value) is colour by default

void set_stroke(Vec4 colour_stroke) ;
> colour_stroke = Vec4(0,0,0,max_color_environment_value) is colour by default

void set_thickness(float thickness) ;
> thickness = 1 by default > thickness is strokeWeight

void set_alpha(Vec3 alpha_behavior) ;
>this setting is used with the 'z' coordinate.
>'alpha_behavior.x' is the medium value be use to calucul the front and the back horizon.
>'alpha_behavior.y' this value must start from '0' to negative value. This value multiply the HORIZON constante to calcule where the alpha is 0.
>'alpha_behavior.z' this value must start from '0' to positive value. This value multiply the HORIZON constante to calcule where the alpha is 1.
>your setting can be something like that : Vec3(-100, -.5, .1). if the HORIZON is 500. the agent have an alpha to 0 at : 500 *(-.5) -100 = -350, and alpha to 100% : 500 *.1 -100 = -50 ;














--
CLASS AGENT DYNAMIC
--
Constructor
-------------
Agent(Vec3 pos, int size, int velocity, int life, String name)




variable
-----------
boolean watching  ;
boolean alive  ;
boolean carrion ;
boolean satiate ;
boolean eating ;

Vec3 pos, motion, direction ;
Vec3 velocity_xyz ;
int velocity ;



int size ;
int life ;



int hunger  ;
float gourmet ;


int greed 
@by default is 180 *SPEED_TIME






SET METHOD
----------
set feeding
--
set_hunger(int hunger) ;
> hunger = 0 by default, your agent start in life very hungry :)

set_step_hunger(float step_hunger) ;
>by default spep hunger is calculated on this formula :
>step_hunger = (size + life)/2 *((life_expectancy -age)/life_expectancy) ;
>where a default age = 0 ; and life_expectancy = 1 ;

when you set step_hunger the result is life *step_hunger 
For axample if you choice 2 and the life is 10, your agent be angry if he don't 20 units, so it can be an eternal hunter :)

void set_speed_feeding(int speed_feeding) ;
>speed_feeding = 1 by default

void set_starving(int starving) ;
>speed the starving statement of the agent

void set_greed(int greed) ;
>this.greed = int(greed *SPEED_TIME) ;

void set_gourmet(int gourmet) ;
>this.gourmet = gourmet*1.1 ;
>gourmet set the attitude with the Flora or meet, 0 the Agent is very gourmet and want the best part of the Flora, for the higher value the Agent became step by step a scavenger

void set_digestion(int digestion)
> set the speed of digestion "1" is very fast. 
value from 1 or more !












set misc
--
void set_nutrient_quality(int nutrient_quality) 
> nutrient_quality = 1 by default

void set_watching(int  max_watching) 
> time in frame before the creature change target, time if frame by second

void set_alive(boolean alive) 
> dead or alive agent

void set_size(Vec3 size) ;










motion method
---------------
void rebound(float top, float bottom, float left, float right)
void motion() ;

statement method
-
int hunger_speed
void hunger(hunger_speed)

boolean carrion(int ratio_carrion) 
update the statement body of the agent








Class Carnivor extends Agent_dynamic
------------------------------------
Variable
--------
int kill_zone
int max_time_track = 300 ; 


Constructor
--------------
Carnivor(Vec2 pos, int size, int velocity, int stamina, String name, int sense_range)

Set
------
void set_kill_zone(int radius) 
> Default the value : int(size *2) +size ;

void set_max_time_track(int seconds)
> Default the value : int(max_time_track *clock) ;

void set_attack(int attack)
> Default value : 1 
@ speed to kill the target




Hunt and Flora method
--------------------------
void watch(Agent_dynamic target)
void kill(Agent_dynamic  target) 
void eat(Agent_dynamic  target) 
void hunt(Agent_dynamic  target) 
boolean hunting() 







Class Herbivor extends Agent_dynamic
-------------------------------------
Carnivor(Vec2 pos, int size, int velocity, int stamina, String name, int sense_range)

Variable
--------
int sense_range
@ the final sense_range is the result of : size *sense_range

Method
---------
same than agent plus :
void watch(Flora f)
void eat(Flora f) 
void pick(Flora f) 
boolean picking() 






Class Bacterium extends Agent_dynamic
-------------------------------------
Var
-------
float humus_prod ;

Constructor
---------------
Bacterium(Vec2 pos, int radius, int velocity, int stamina, String name, int sense_range)

Set
------
void set_humus_prod(float prod)
> by default float humus_prod = .25 ;


Variable
--------
int sense_range
@ the final sense_range is the result of : size *sense_range

Method
---------
same than agent plus :
void watch(Agent a)
void eat(Agent a) 
void pick(Agent a) 
boolean picking() 















-------------------------------
CLASS AGENT STATIC
-------------------------------
Class Agent_static implements Agent
-----------------------------------------------
Constructor
-------------
Agent_static(Vec3 pos, int size, String name)

Set
--
void set_fill(Vec4 colour) ;
> colour_fill = Vec4(0,0,0,max8value) is colour by default

void set_stroke(Vec4 colour) ;
> colour_stroke = Vec4(0,0,0,max8value) is colour by default

void set_thickness(float thivkness) ;
> float thivkness by default = 1 > it's strokeWeight in Processing

void set_size(int size) ;

void set_nutrient_quality(int nutrient_quality) 
> by default nutrient_quality = 1 ;



Variable
--------
Vec3 pos 
int size
String name







SUB CLASS AGENT STATIC
------------------------------------
Class Flora extends Agent_static
-----------------------------------
Flora(Vec2 pos, int size, String name)





void set_growth(int speed)
> by default is 1

void set_need( float need)
> by default is .1 ;
@ it's quantity of humus to each unit growth


Variable
--------
int Flora_quality


















--
Class Humus
--
Humus(Vec2 pos)

Set
---
void set_colour(Vec4 colour) 
> colour = Vec4(0,0,0,max8value) is colour by default












--
Class Helix DNA
--
Helix (int num_strand, int num_nucleotide, int nucleotide_by_revolution)

Get
--
int size() ;
>return strand.length ;

int num() ;
>return num of nucletotide of all strands ;

int length() {
>return nucleotide of the first strand

int length(int which_strand) ;
>return length of a specific strand ;

Vec3 get_final_pos() ;
return a Vec3 pos of the Helix

Vec3 get_radius() {;
>return radius of the helix

float get_height() {;
>return the helix height

float get_width() {;
>return the helix width

float get_depth() {;
>return the helix depth

DNA get_DNA(int which_strand) ;
>return dna sequence of specific strand

Strand_DNA [] get() 
>return array of all Strand

Vec3 [] get_nuc_pos() 
>return array Vec3 of all nucleotides position

Vec3 [] get_nuc_pos(int which_strand) 
>return array Vec3 of nucleotide of a specific strand


Set
--
void set_radius(int radius) ;

void set_radius(int radius_x, int radius_z) ;

void rotation(float angle) :

void set_height(int height_strand) ;

void set_pos(Vec3 global_pos) ;








