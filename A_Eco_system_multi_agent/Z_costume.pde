/**
RPE Costume 0.1.1
* @author Stan le Punk
* @see https://github.com/StanLepunK/Costume
*/
final int POINT_ROPE = 0 ;
final int ELLIPSE_ROPE = 1 ;
final int RECT_ROPE = 2 ;


final int TRIANGLE_ROPE = 13 ;
final int SQUARE_ROPE = 14 ;
final int PENTAGON_ROPE = 15 ;
final int HEXAGON_ROPE = 16 ;
final int HEPTAGON_ROPE = 17 ;
final int OCTOGON_ROPE = 18 ;
final int NONAGON_ROPE = 19 ;
final int DECAGON_ROPE = 20 ;

final int CROSS_2_ROPE = 52 ;
final int CROSS_3_ROPE = 53 ;

final int SPHERE_LOW_ROPE = 100 ;
final int SPHERE_MEDIUM_ROPE = 101 ;
final int SPHERE_HIGH_ROPE = 102 ;
final int TETRAHEDRON_ROPE = 103 ;
final int BOX_ROPE = 104 ;


void costume_rope(Vec3 pos, int size_int,  int which_costume)  {
	Vec3 dir_null = Vec3() ;
	Vec3 size = Vec3(size_int) ;
	costume_rope(pos, size, dir_null, which_costume) ;
}

void costume_rope(Vec3 pos, Vec3 size,  int which_costume)  {
	Vec3 dir_null = Vec3() ;
	costume_rope(pos, size, dir_null, which_costume) ;
}

void costume_rope(Vec2 pos, int size_int,  int which_costume)  {
	Vec3 dir_null = Vec3() ;
	Vec3 size = Vec3(size_int) ;
	costume_rope(Vec3(pos.x,pos.y,0), size, dir_null, which_costume) ;
}

void costume_rope(Vec2 pos, Vec3 size,  int which_costume)  {
	Vec3 dir_null = Vec3() ;
	costume_rope(Vec3(pos.x,pos.y,0), size, dir_null, which_costume) ;
}

/**
Change the method for method with 
case
and 
break
*/
void costume_rope(Vec3 pos, Vec3 size, Vec3 dir, int which_costume) {
	if (which_costume == 0 ) {
		point(pos) ;
	}  else if (which_costume == 1 ) {
		start_matrix() ;
		translate(pos) ;
		ellipse(0,0, size.x, size.y) ;
		stop_matrix() ;
	}  else if (which_costume == 2 ) {
		start_matrix() ;
		translate(pos) ;
		rect(0,0, size.x, size.y) ;
		stop_matrix() ;
	}  




		else if (which_costume == 13) {
		primitive(pos, size.x, 3) ;
	}  else if (which_costume == 14) {
		primitive(pos, size.x, 4) ;
	} else if (which_costume == 15) {
		primitive(pos, size.x, 5) ;
	} else if (which_costume == 16) {
		primitive(pos, size.x, 6) ;
	} else if (which_costume == 17) {
		primitive(pos, size.x, 7) ;
	} else if (which_costume == 18) {
		primitive(pos, size.x, 8) ;
	} else if (which_costume == 19) {
		primitive(pos, size.x, 9) ;
	} else if (which_costume == 20) {
		primitive(pos, size.x, 10) ;
	}



		else if (which_costume == 52) {
		start_matrix() ;
		translate(pos) ;
		cross_2(size) ;
		stop_matrix() ;
	} else if (which_costume == 53) {
		start_matrix() ;
		translate(pos) ;
		cross_3(size) ;
		stop_matrix() ;
	}




		else if (which_costume == 100) {
		start_matrix() ;
		translate(pos) ;
		sphereDetail(5);
		sphere(size.x) ;
		stop_matrix() ;
	} else if (which_costume == 101) {
		start_matrix() ;
		translate(pos) ;
		sphereDetail(12);
		sphere(size.x) ;
		stop_matrix() ;
	}else if (which_costume == 102) {
		start_matrix() ;
		translate(pos) ;
		sphere(size.x) ;
		stop_matrix() ;
	} else if (which_costume == 103) {
		start_matrix() ;
		translate(pos) ;
		tetrahedron((int)size.x) ;
		stop_matrix() ;
	} else if (which_costume == 104) {
		start_matrix() ;
		translate(pos) ;
		box(size) ;
		stop_matrix() ;
	} 



		else if (which_costume == 1001) {
		start_matrix() ;
		translate(pos) ;
		polyhedron("TETRAHEDRON","LINE", (int)size.x) ;
		stop_matrix() ;
	} else if (which_costume == 1002) {
		start_matrix() ;
		translate(pos) ;
		polyhedron("CUBE","LINE", (int)size.x) ;
		stop_matrix() ;
	} else if (which_costume == 1003) {
		start_matrix() ;
		translate(pos) ;
		polyhedron("OCTOHEDRON","LINE", (int)size.x) ;
		stop_matrix() ;
	} else if (which_costume == 1004) {
		start_matrix() ;
		translate(pos) ;
		polyhedron("RHOMBIC COSI DODECAHEDRON SMALL","LINE", (int)size.x) ;
		stop_matrix() ;
	} else if (which_costume == 1005) {
		start_matrix() ;
		translate(pos) ;
		polyhedron("ICOSI DODECAHEDRON","LINE", (int)size.x) ;
		stop_matrix() ;
	}
}









// ANNEXE COSTUME
// CROSS
void cross_2(Vec3 size) {
	float ratio_cross = .3 ;
	float scale_cross = (size.x + size.y + size.z) *.3 ;
	float small_part = scale_cross *ratio_cross ;

	box(size.x, small_part, small_part) ;
	box(small_part, size.y, small_part) ;
}


void cross_3(Vec3 size) {
	float ratio_cross = .3 ;
	float scale_cross = (size.x + size.y + size.z) *.3 ;
	float small_part = scale_cross *ratio_cross ;
   
	box(size.x, small_part, small_part) ;
	box(small_part, size.y, small_part) ;
	box(small_part, small_part, size.z) ;
}
