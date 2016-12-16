/**
HOST SYMBIOSIS MANAGEMENT 0.0.1
*/
int [] target_host ;
Vec4 [] symbiosis_area ;
Vec3 pos_host, radius_host, canvas_host, size_host ;

Vec4 [] get_symbiosis_area() {
  if(symbiosis_area != null) return symbiosis_area ; else return null ;
}

Vec3 [] get_symbiosis_area_pos() {
  Vec3 [] list = new Vec3[symbiosis_area.length] ;
  for(int i = 0 ; i < list.length ; i++) {
    list[i] = Vec3(symbiosis_area[i].x, symbiosis_area[i].y, symbiosis_area[i].y) ;
  }
  if(list != null) return list ; else return null ;
}

int [] get_symbiosis_area_id() {
  int [] list = new int[symbiosis_area.length] ;
  for(int i = 0 ; i < list.length ; i++) {
      list[i] = int(symbiosis_area[i].w) ;
  }
  return list ;
}


void init_symbiosis_area(int num) {
	symbiosis_area = new Vec4[num];
}

void init_host_target(int num) {
	target_host = new int[num] ;
}

int [] get_host_address() {
  return target_host ;
}

void set_host_address(int target, int value) {
	if(target < target_host.length) {
     target_host[target] = value ;
	}
}

/**
pos host
*/
void pos_host(Vec pos) {
  if(pos_host == null) {
    pos_host = Vec3(pos.x,pos.y,pos.z) ;
  } else {
    pos_host.set(pos.x, pos.y, pos.z) ;
  }
}

void pos_host(float x, float y, float z) {
	if(pos_host == null) {
		pos_host = Vec3(x,y,z) ;
	} else {
		pos_host.set(x,y,z) ;
	}
}

Vec3 get_pos_host() {
	return pos_host ;
}

/**
radius host
*/
void radius_host(Vec radius) {
  if(radius_host == null) {
    radius_host = Vec3(radius.x,radius.y,radius.z) ;
  } else {
    radius_host.set(radius.x, radius.y, radius.z) ;
  }
}

void radius_host(float x, float y, float z) {
  if(radius_host == null) {
    radius_host = Vec3(x,y,z) ;
  } else {
    radius_host.set(x,y,z) ;
  }
}

Vec3 get_radius_host() {
  return radius_host ;
}

/**
size host
*/
void size_host(Vec size) {
  if(size_host == null) {
    size_host = Vec3(size.x,size.y,size.z) ;
  } else {
    size_host.set(size.x, size.y, size.z) ;
  }
}

void size_host(float x, float y, float z) {
  if(size_host == null) {
    size_host = Vec3(x,y,z) ;
  } else {
    size_host.set(x,y,z) ;
  }
}

Vec3 get_size_host() {
  return size_host ;
}


/**
canvas host
*/
void canvas_host(Vec canvas) {
  if(canvas_host == null) {
    canvas_host = Vec3(canvas.x,canvas.y,canvas.z) ;
  } else {
    canvas_host.set(canvas.x, canvas.y, canvas.z) ;
  }
}

void canvas_host(float x, float y, float z) {
  if(canvas_host == null) {
    canvas_host = Vec3(x,y,z) ;
  } else {
    canvas_host.set(x,y,z) ;
  }
}

Vec3 get_canvas_host() {
  return canvas_host ;
}


/**
symbiosis area
*/
void set_symbiosis_area(Vec4 [] symbiosis_area, Vec3 [] target_host_list) {
  for(int i = 0 ; i < symbiosis_area.length ; i++) {
    if(symbiosis_area[i] == null) symbiosis_area[i] = Vec4() ;
    int where = (int)random(target_host_list.length) ;
    set_host_address(i, where) ;
    symbiosis_area[i].set(target_host_list[where].x, target_host_list[where].y, target_host_list[where].z, where) ;
  }
}



void update_symbiosis_area(Vec4 [] symbiosis_area, Vec3 [] target_host_list) {

  for(int i = 0 ; i < symbiosis_area.length ; i++) {
    int where = (int)symbiosis_area[i].w ;
    Vec3 pos = target_host_list[where] ;
    symbiosis_area[i].x = pos.x ;
    symbiosis_area[i].y = pos.y ;
    symbiosis_area[i].z = pos.z ;
      printTempo(180, "host", where, target_host_list[where]) ;
    printTempo(180, "symbiosis", i, symbiosis_area[i]) ;
  }
}

/**
symbiosis
*/
void symbiosis(ArrayList<Agent> symbiotic_agent_list, Vec3 [] list_coord_host, int [] address) {
  if(list_coord_host.length > 0 && address.length > 0 && symbiotic_agent_list.size() > 0) {
    int max_loop = address.length ;
    if(max_loop > symbiotic_agent_list.size()) max_loop = symbiotic_agent_list.size() ;
    for(int i = 0 ; i < max_loop ; i++) {
      Agent a = symbiotic_agent_list.get(i) ;
      int where = floor(random(address.length)) ;
      a.set_home(list_coord_host[address[where]], address[where]) ;
      a.set_pos(a.get_home_pos()) ;
    }
  } 
}


void update_symbiosis(ArrayList<Agent> symbiotic_agent_list, Vec3 [] list_coord_host) {
  for(Agent a : symbiotic_agent_list)	{
    a.set_home_pos(list_coord_host[a.get_home_id()]) ;
    a.set_pos(a.get_home_pos()) ;
  }
}






