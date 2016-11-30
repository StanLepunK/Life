ECO-SYSTEME 0.0.6
--
GUIDE TO USE
--
this guide is not updated
--
Ecosystem is a multi-agent system with predator, prey. Where the death is a begin of life !


SET ECOSYSTEM
--
set_horizon(boolean horizon) ;
>you can use this method to ask agent to dissapear smoothly when this one approche to the hozizon.
>Can be use only in P3D mode.

To look the agent behavior and why that's must happen
INFO_DISPLAY_AGENT = false ; 

To choice between 2D or 3D mode
ENVIRONMENT = 2 ; for 2D
ENVIRONMENT = 3 ; for 3D

CLOCK
> to set the time, slower or faster...





SET ECOSYTEM
--
void ecosystem_setting()
> in this method you can set your different creatures.

// QUANTITY
int num_flora = 200 ;
int num_herbivore = 100 ; 
int num_carnivore = 3 ; 
int num_bacterium = 5 ;

// Colour, the value depend of your color environment
Vec4 colour_flora = Vec4(100,100,80,100) ;
Vec4 colour_herbivore = Vec4(50,100,100,100) ;
Vec4 colour_carnivore = Vec4(0,100,100,100)  ; 
Vec4 colour_bacterium = Vec4(30,0,30,100) ;

// Size, like health
int size_herbivore = 35 ;
int size_carnivore = 55 ;
int size_bacterium = 10 ;

// Life, time before die !
int stamina_herbivore = 30 ;
int stamina_carnivore = 300 ;
int stamina_bacterium = 600 ;

// Velocity
int velocity_herbivore = 5 ;
int velocity_carnivore = 8 ;
int velocity_bacterium = 2 ;

// Radar, it's like a field vision to hunt or eat
int sense_range_herbivore = 3 ;
int sense_range_carnivore = 12 ;
int sense_range_bacterium = 400 ;

// COSTUME, choose from among 6
flora_costume = 2 ;
corpse_costume = 1 ;
carnivore_costume = 5 ;
herbivore_costume = 3 ;
bacterium_costume = 4 ;



// INFO
print_info_environment() ;

print_list() ;
> println the size of different list

print_info_carnivore(CARNIVORE_CHILD_LIST) ;
print_info_herbivore(HERBIVORE_CHILD_LIST) ;
print_info_bacterium(BACTERIUM_LIST) ;















































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






SET AGENT
--------------

> set aspect, fill, stroke and thickness ( strokeWeight) of your agent
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





--------------------
Class Agent_dynamic implements Agent
-----------------------------------------------
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

String name ;
int ID ;

int size ;
int life ;

Vec4 colour_fill ;
Vec4 colour_stroke ;
float thickness ;

int hunger  ;
float gourmet ;


int greed 
@by default is 180 *SPEED_TIME



set methode
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


















-----------------
Class Humus
-----------------
Humus(Vec2 pos)

Set
---
void set_colour(Vec4 colour) 
> colour = Vec4(0,0,0,max8value) is colour by default







