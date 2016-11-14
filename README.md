ECOSYSTEME 0.0.4
--
this guide is not updated
--
Ecosystem is a multi-agent system with predator, prey. Where the death is a begin of life !


USE ECOSYSTEM
/////////////
All method present in the main tab.

To look the agent behavior and why that's must happen
INFO_DISPLAY_AGENT = false ; 

To choice between 2D or 3D mode
ENVIRONMENT = 2 ; for 2D
ENVIRONMENT = 3 ; for 3D

CLOCK
> to set the time, slower or faster...







SET ECOSYTEM
////////////
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





