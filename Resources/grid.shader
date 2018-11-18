shader_type spatial;

uniform vec3 ink;
uniform vec3 paper;
uniform float dt;

void fragment()
  {		
  if (mod((UV.x+0.005)*30.0,6.0)>0.5 && mod((UV.y+dt)*100.0,6.0)>0.5)
	  ALBEDO=paper;
	else
	  ALBEDO=ink;
  }