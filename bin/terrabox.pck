GDPC                                                                               <   res://.import/icon.png-487276ed1e3a0c39cad0279d744ee560.stex�)      �      ��xV+��]��}]�<   res://.import/test.png-2b0b935732229e5bd5e655f2644b2498.stexPJ      �'      >�%���kZ�C�J�   res://IG_Test.tscn  �       	      M��wҺ�2���"��-Y   res://Main.gd.remap 0{             �(@Er�#��K�F�[   res://Main.gdc  �      s      ?���t�S��-�֖   res://Main.tscn `      �      ��5�s�D�,��    res://MultiMeshInstance.gd.remapP{      ,       ��g�XO�Y��Ր   res://MultiMeshInstance.gdc #      L      DJ{�%̘���������    res://bin/x11/gdrealsense.gdnlib`&      �      a��"8�c���o���    res://bin/x11/gdrealsense.gdns  0(      �       O��d[ً�����a�9   res://default_env.tres   )      �       um�`�N��<*ỳ�8   res://icon.png  |      �      $Uʥ��ֶ�����n�   res://icon.png.import   �:      �      ��fe��6�B��^ U�   res://mesh_ig.gd.remap  �{      "       �&���ϋ[߉��   res://mesh_ig.gdc   p=      L      ##��A���S�1s�   res://mesh_ig.gdns  �C      7       ?nЊ�{5���   res://project.binary��      	      ��P7�R��J�.<�×f   res://terrain_ig.gd.remap   �{      %       �����6���:��   res://terrain_ig.gdc D      L      ##��A���S�1s�   res://test.png.import   �q      �      �}�Z��9��ۭ��   res://test_ig.gd.remap  �{      "       �5�����P�w`
�   res://test_ig.gdc   �t      �      �w<���u0܃��p�`            [gd_scene load_steps=4 format=2]

[ext_resource path="res://test_ig.gd" type="Script" id=1]

[sub_resource type="Shader" id=2]
code = "shader_type spatial;
//render_mode unshaded;

uniform sampler2D realsense_heightmap;
uniform float height_scale = 0.5;

varying float vertex_height;
varying vec3 vertex_normal;

float get_height(vec2 position) {
	float height = texture(realsense_heightmap, position).r;
	
	return (0.5 - height) * height_scale;
}

void vertex() {
//	vec2 coord = VERTEX.xz / 2.0 + 0.5;//vec2(0.5 - VERTEX.x/16.0, 0.5 - VERTEX.z/9.0);
//	float height = texture(realsense_heightmap, coord).x * height_scale;
//	VERTEX.y += height;
//	COLOR.xyz = vec3(height);
//
//	vec2 e = vec2(0.01, 0.0);
//	vec3 normal = normalize(vec3(get_height(coord - e) - get_height(coord + e), 2.0 * e.x, get_height(coord - e.yx) - get_height(coord + e.yx)));
//	NORMAL = normal;
	
	//NORMAL = normalize(vec3(get_height(coord) - get_height(coord + vec2(0.1, 0.0)), 0.1, get_height(coord) - get_height(coord + vec2(0.0, 0.1))));
	
	vertex_height = VERTEX.y;
	vertex_normal = NORMAL;
}

void fragment() {
	float slope = 1.0 - dot(vertex_normal, vec3(0.0, 1.0, 0.0));
	float altitude = (vertex_height/height_scale) + 0.5;

	//#7f9e31
	vec3 grass = vec3(0.49804, 0.61961, 0.19216);
	//#ead2ac
	vec3 sand = vec3(0.91765, 0.82353, 0.67451);
	//#353527
	vec3 rock = vec3(0.20784, 0.20784, 0.15294);
	//#6b542a
	vec3 dirt = vec3(0.41961, 0.32941, 0.16471);
	//#f2f4f3
	vec3 snow = vec3(0.94902, 0.95686, 0.95294);


	if (altitude <= 0.1) {
		ALBEDO = sand;
	} 
	if (altitude > 0.1 && altitude <= 0.7) {
		if (slope <= 0.7) {
			ALBEDO = grass;
		} 
		if (slope > 0.7 && slope <= 0.95) {
			ALBEDO = dirt;
		} 
		if (slope > 0.95) {
			ALBEDO = rock;
		}
	} 
	if (altitude > 0.7 && altitude <= 0.9) {
		ALBEDO = rock;
	} 
	if (altitude > 0.9) {
		ALBEDO = snow;
	}

	ROUGHNESS = 0.9;
}"

[sub_resource type="ShaderMaterial" id=1]
shader = SubResource( 2 )
shader_param/height_scale = 0.5

[node name="Spatial" type="Spatial"]

[node name="Camera" type="Camera" parent="."]
transform = Transform( -1, 8.74228e-08, 0, -8.74228e-08, -1, 0, 0, 0, 1, 0, 0, 0 )

[node name="ImmediateGeometry" type="ImmediateGeometry" parent="."]
transform = Transform( 1, 0, 0, 0, 1, 0, 0, 0, 1, -2.5, 1, -3 )
material_override = SubResource( 1 )
script = ExtResource( 1 )
GDSC            [      ������ڶ   �����϶�   ��¶   �����������ڶ���   ����   �Ҷ�   �������Ӷ���   ���޶���   �������޶���   ������������������Ӷ   ߶��   ���������������¶���   �����ζ�   ���������ζ�   ���������ζ�   ����������������Ӷ��      Terrain                                                            	      
         (      1      >      H      Q      X      Y      3YYYYYYY0�  PQV�  ;�  �  T�  PQ�  ;�  �  PQ�  ;�  �  T�  PQ�  �  T�	  P�  R�  Q�  )�
  �K  P�  T�  PQQV�  ;�  �  T�  P�
  Q�  �  T�  P�
  R�  Q�  �  T�  P�  QYY`             [gd_scene load_steps=4 format=2]

[sub_resource type="SpatialMaterial" id=8]
flags_unshaded = true
vertex_color_use_as_albedo = true

[sub_resource type="PlaneMesh" id=6]
material = SubResource( 8 )
size = Vector2( 16, 9 )
subdivide_width = 152
subdivide_depth = 86

[sub_resource type="GDScript" id=7]
script/source = "extends MeshInstance
#
##Load realsense
var realsense = preload(\"res://bin/x11/gdrealsense.gdns\").new()
#
var st = SurfaceTool.new()
var img = Image.new()
var mdt = MeshDataTool.new()
var t_off = 75
var r_off = 50
var b_off = 40
var l_off = 120
var segment_size = 3
var sea_level = 0.02
var material
var rng = RandomNumberGenerator.new()
#
## Called when the node enters the scene tree for the first time.
func _ready():
	material = mesh.material
	rng.randomize()
	
	var depth_array = realsense.get_depth_frame(t_off, r_off, b_off, l_off,segment_size)
	var width = realsense.get_frame_width()
	var height = realsense.get_frame_height()

	img.create_from_data(width, height, false, Image.FORMAT_R8, depth_array)
	img.lock()

	st.clear()

	st.begin(Mesh.PRIMITIVE_TRIANGLES)

	var vert_x_width = width - 1
	var vert_y_height = height - 1
	for y in range(height):
		for x in range(width):
			st.add_smooth_group(true)
			st.add_vertex(Vector3(((8.0*x)/(width)), 0.0, ((4.5 * y)/(height))))
			# Build indices for a complete mesh
			var vert_y = y
			var vert_x = x
			var next_vert_y = vert_y + 1
			var next_vert_x = vert_x + 1
			if(vert_y < vert_y_height and vert_x < vert_x_width):
				st.add_index((vert_x_width * vert_y) + vert_x)
				st.add_index((vert_x_width * vert_y) + next_vert_x)
				st.add_index((vert_x_width * next_vert_y) + next_vert_x)
				
				st.add_index((vert_x_width * vert_y) + vert_x)
				st.add_index((vert_x_width * next_vert_y) + next_vert_x)
				st.add_index((vert_x_width * next_vert_y) + vert_x)

	# st.index()
	#st.generate_normals()
	#st.generate_tangents()
	st.set_material(material)
	# Commit to a mesh.
	mesh = st.commit()
	mdt.create_from_surface(mesh, 0)
	img.unlock()
	
func set_color(mesh_height):
	#print(mesh_height)
	var color = Color(1.0, 0.0, 0.0)
	var rand = (rng.randf() - 0.5) * 0.2
	
	if mesh_height <= sea_level: # Water
		color = Color(0.35686 + rand, 0.75294 + rand, 0.92156 + rand)
	elif mesh_height > sea_level and mesh_height <= (sea_level + 0.05): # Sand
		color = Color(0.91765 + rand, 0.82353 + rand, 0.67451 + rand)
	elif mesh_height > (sea_level + 0.05) and mesh_height <= (sea_level + 0.3): # Grass
		color = Color(0.49804 + rand, 0.61961 + rand, 0.19216 + rand)
	elif mesh_height > (sea_level + 0.3) and mesh_height <= (sea_level + 0.6): # Grass
		# color = Color(0.20784 + rand, 0.20784 + rand, 0.15294 + rand)
		# color = Color(0.93725 + rand, 0.94509 + rand, 0.95294 + rand)
		color = Color((208.0/255.0)+rand, (83.0/255.0) + rand, (83/255) + rand)
	else:
		color = Color(0.93725 + rand, 0.94509 + rand, 0.95294 + rand)
	return color
	
func _process(_delta):
	var depth_array = realsense.get_depth_frame(t_off, r_off, b_off, l_off, segment_size)
	var width = realsense.get_frame_width()
	var height = realsense.get_frame_height()
	
	if Input.is_action_pressed(\"toggle_fullscreen\"):
		OS.window_fullscreen = !OS.window_fullscreen

	img.create_from_data(width, height, false, Image.FORMAT_R8, depth_array)
	img.lock()

	for i in range(mdt.get_vertex_count()):
		var vert=mdt.get_vertex(i)
		var x = (vert.x  * width)/8.0
		var y = (vert.z * height)/4.5
		#x = x + ((x - (width/2.0))/(width/2.0)*4)
		#y = y + ((y - (height/2.0))/(height/2.0)*2.0)
		var mesh_height = 1.0 - img.get_pixel(x, y).r

		if typeof(mdt.get_vertex_meta(i)) == TYPE_REAL:
			if (mesh_height <= sea_level and Engine.get_idle_frames() % 20 == 0): # Update water colors every 20 frames
				mdt.set_vertex_color(i, set_color(mesh_height))
			elif abs(mdt.get_vertex_meta(i) - mesh_height) > 0.05: # Only update terrain colors when signficant change since last frame
				mdt.set_vertex_color(i, set_color(mesh_height))
		else:
			mdt.set_vertex_color(i, set_color(mesh_height))
		
		mdt.set_vertex_meta(i, mesh_height)

	mesh.surface_remove(0)
	mdt.commit_to_surface(mesh)

	img.unlock()
"

[node name="Main" type="Spatial"]

[node name="Terrain" type="MeshInstance" parent="."]
mesh = SubResource( 6 )
material/0 = null
script = SubResource( 7 )

[node name="Avatar" type="Spatial" parent="."]

[node name="Camera" type="Camera" parent="Avatar"]
transform = Transform( 1, 1.74846e-07, -3.82137e-15, -3.82137e-15, 4.37114e-08, 1, 1.74846e-07, -1, 4.37114e-08, 4, 2.9, 2.3 )
 GDSC            �      ����������������Ӷ��   �����϶�   �۶�   ��������޶��   ����   ���������������¶���   ����������򶶶�   �������������¶�   ���޶���   �������Ӷ���   �������޶���   ߶��   ��Ŷ   ¶��   �����Ҷ�   �����������������Ķ�   ���������������������۶�   ��������޶��   (         ../Tree                  �@  {�G�z�?                   	      
                  !      .   	   /   
   0      ;      Y      q      {      �      �      �      �      3YY0�  PQV�  �  ;�  �  T�  PQ�  �  T�  �  T�  �  �  T�  �  �  T�  �	  P�  QT�
  PQY�  �  )�  �K  P�  T�  QV�  ;�  �  P�(  P�  R�  QR�(  P�  R�  QR�(  P�  R�  QQ�  ;�  �  P�  PQT�  P�  P�  R�  R�  QQR�  Q�  �?  P�  T�  P�  QQ�  �  T�  P�  R�  QY�  �  T�  �  Y`    [general]

singleton=false
load_once=true
symbol_prefix="godot_"
reloadable=true

[entry]

X11.64="res://bin/x11/libgdrealsense.so"
Windows.64="res://bin/win64/libgdrealsense.dll"
OSX.64="res://bin/osx/libgdrealsense.dylib"
X11.32="res://bin/x11/libgdrealsense.so"
Windows.32="res://bin/win64/libgdrealsense.dll"
OSX.32="res://bin/osx/libgdrealsense.dylib"

[dependencies]

X11.64=[  ]
Windows.64=[  ]
OSX.64=[  ]
X11.32=[  ]
Windows.32=[  ]
OSX.32=[  ]
          [gd_resource type="NativeScript" load_steps=2 format=2]

[ext_resource path="res://bin/x11/gdrealsense.gdnlib" type="GDNativeLibrary" id=1]

[resource]
resource_name = "gdrealsense"
class_name = "Realsense"
library = ExtResource( 1 )
      [gd_resource type="Environment" load_steps=2 format=2]

[sub_resource type="ProceduralSky" id=1]

[resource]
background_mode = 2
background_sky = SubResource( 1 )
             GDST�   �            �  WEBPRIFF�  WEBPVP8L�  /�����^""""J�������WY���՝�����g���0�efffffffjzK����+�eɶ�H������ᏩQi�IY�P��	I�$G�����NeuW�9i���m���j0��.�Q6̵(5��e��P��6�$��I��>&�o����ڴ��xvw�mv���w��A'8�w��
��!5�ϓ_���%��$���ՙ�$K��-/E:ql##A���m���&	6���Ⱛ��$7�I�]Wx���7��骈�e)�bա��-�L�ܞ��Aj�J-R�W�Z�vH���=��Unu(r�Z7�tO鞶Q(�t��R2���J��(���Z6�� %3!5Z6ײ��7�*��H�P�ZuU�p�tB��J�$��-�u�X��c]h�P��O�]&��t�P屔G�J��l�cUF�x�%*�/��]	�J=���1�i��*+�V���ԃ�j�UU>s%{f���a��ժ򙍚?��OH�ˍU�R�.5���)����h;��A7��@v�Qm��*KG[!@v��N��d^_:cU����sU�H�}��r����>T�-�J�A�JH�0n!W�-�*w�7;���D�ƪlE����p��O���W�d�����ښS��է�v|�~8���2{u	����:�㵴�^�]G! ���W����N���<33;s�D-����cj���g�v��hUG��A�� t�����Z��� �������  �˾j����:��h�^&G�Ɗ�{��5�]S�&�����n���Κ)2 ��6���  3E��I7���c2*O��7r�{��4�yW�-�K��W���Jf �j��A�  ų�0(��۲���C k��,�^|  �ؖ/��S�� �#��: \YNN*_S�k �{��j�� (4g���M�0 �p*��N�5�Pd͜Q�� �ݵ���5 P`-Rg�4[ ��%<V7�Cff33{3:��� ��-oS��  �wm5c�  ([<�� �|s�)[ ��5���& �~�J���DTP&��;���/ 0؄Vб�5;7�����i��T����"Q�yW�!-����ٹ -��j�O	 б=I�]`� P}J���� �A�i�m ��2���� ái8t @Fn��aR �Ċ�L, �0)ͷ]rh���7�q-r�� �D��2 ^+}-r�����&�.���.��p��@~�������9*`�G�H�Q	`9*����)���n,�B\���E�915n��ws2�W�  ^���������U  XQ�dX3����lbjx>s+*��&�3]񧡓����I��  ��"��-uv��v, �Z$�/�)9+~Z�k�H# �e7�ȩ�������~D �=|  �WJ��5���_�R  `��W���_?�*^lB@@p��${���Y��/\�w�z��Ӏ@�C�W���R�x����<����qh~��劀`r��~�M�����9����[�=ς�  �E�<�J�ݤ���" ��<s^�_�w�w���Ea��w��Ƚ:���,�g��ө}�ձ�]���ݟ{�tj�G�Y�8���<�w��̵�+�+���q����!I���ajj\�]E`�D~�O���쐨O�i$�%�̳����������*�懯#����,�r�vF@09�"��L�$N�-�붳@Vy6I�������!a9z@@0Ic�gal
'�[k~H��� �p��Yg��!i߬�`�GF@@p�w)s�w�#<��[��N���.������G@�����iK����G�t��bE@��kgiW����f���Y�������o"���#���u�oir�oC����(ƺ3���ɡ�Ejx+���	�Ͻ�]�J��H�{�$��'AzޞcUU:y�v&+��.=�-w��^���"1��?c�����_�%�t1��/c�A�f<*�6����!��W��6��T����K�b���W��s-T����/_zS�y�U��o��K�
�e��)��MV��Ɔ�*��iЁ��9�
��V+��cԿ-�Z�Ҿ9��`v�;@�L
	���s�N���
¤�5 �j���i�|����.T�Pj������W�sd?�n�F�Ƨ�L�e�,  8-T�P�2�À�9|�n��[��Eb�zbxZ�    w�[Bbk�L!1B�@ ����P�OŞC�b �> @'3�0aMb����  �`�P���@�',�b k�*W=`���M�9  ��G+hY_�:���������К��&t�O 7��iY_�`�m�x�Ԅ ^xu�^x5�	!% ̀�ZA�׃�B�@�s�"�. �
a�V�7^�. � �h:G�h:V��AL�x������5�Y(�q!�`+q�?.��	�8.��Pk��x��n����!F_����I��|D��`�ʨt�LT�e
  �WB��j �2���ш���2���t�ʁ  ��2�ʹ�5zm>4  x��!{��R%� ��r'���#@�;Y}�x�J�!{�\R��  ���Y�����^����y�\=JH�7�Y�izI����9��3�i�o��]N���4a���`�m:�����P��"�&�������Y�ݹ�f3��d/v��4�ƛ�F���lw�6kb�M'���;^#h��_j�  �q׊4�y*�n��؝k���YS�����Zl�To?��u��Ⱦ��SE������kii��u�Ƀ�xɃo��(N�� �D�����78@��U���εe}�}7:���5!O��r6 n+g�3z�kB��~8t��Z��s�\��%�7��Bk�YS�}�;WW��אG� �d��l�5 �Js�sm��6k*�㎄�&���� @Hót�#�t�yB ���m�9��  �/�t>��K�g�٬��g߱S�#�e  ��;d�q�<=  s���+�5z�R  P��!��  �>��ы�3W�U���  ��L7�L���Jf�f|hiƇ)�M�Bka8�m6 �/��K �|����6f��T�����6���; �*�k�* ���N�TV���C���6Z�� xq	ũ�K��^Ź��S�����"�}'����s& P*ãT p&���S���+�`(�T�a/�
 ��KŹ9 �mF�1��
�ɨ�����	 ���g���� �-G�[��rE����؞x:�'.��S�qg9�M-_ �W���1
����=�H�����fM����\�εmsV�3���]����&�7��J�͇V�8�njۜ�e���fM���f��4U�/�I��A �b�[�ԯX @�M4"��� ������f%����� ��/�I��^�>�>�Z]����b��Ղ������eAT���	�g׳dң�����c'ƪ *y�nA@@��vrl�K���	�5ۙ�*�j^�]|��~�+N������+cU ��jE@@��k���b�f���=����������B��W+q���Gs����sD ���g�
�����^z�XXf����=�����e����©�|Wm�L��6�wS>�	��Ѿ/�	���ظ�z1ς�*!��Z~�����'����r��J����Z��E� ̫G7؄!��
�oz*)ZחBs�М[7���X�i�Ԑf���DN���Tj�EE����|��dY��X��Yst��s�[ߵ;z�̧<����.*r�U+J/����Z Z���4r���uv����l���}"��OmA�s�;׾�8�4���=�Q�Ǌ]�8q<Թy�SG���z�(7Ϗ5���y�o��Yƣ�`񡣳��G�A���b��j�!Zl���c���G��2U�}�Y��4���8��Q�Giff/�A��_������U�Ҵ��J��+�H�*�B��\i� �R	�[�G�+��H_*}$��˕�t�J��w�h+�d��L�~�eѲo����U�S˾�,]��T#_0.G����TS(�
�tU��"��H�=ˏaϐ"@ZJ�@
��).��`�*�#�R)�R ��(�z*���蓌x�#^�I�"���'!"�	R�/�G�ha�90օF�ȼ)�jm�X(��Ax�*�`fzG�*�<�<ma� �B�搚܀�h�Ra��?,Z-K��ӡ�N9�I�����Ү����[t(�ݢʴ����v�Ԧ�*�H퐾�s{F�)d�:{����        [remap]

importer="texture"
type="StreamTexture"
path="res://.import/icon.png-487276ed1e3a0c39cad0279d744ee560.stex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://icon.png"
dest_files=[ "res://.import/icon.png-487276ed1e3a0c39cad0279d744ee560.stex" ]

[params]

compress/mode=0
compress/lossy_quality=0.7
compress/hdr_mode=0
compress/bptc_ldr=0
compress/normal_map=0
flags/repeat=0
flags/filter=true
flags/mipmaps=false
flags/anisotropic=false
flags/srgb=2
process/fix_alpha_border=true
process/premult_alpha=false
process/HDR_as_SRGB=false
process/invert_color=false
process/normal_map_invert_y=false
stream=false
size_limit=0
detect_3d=true
svg/scale=1.0
              GDSC         4        ����������������϶��   ��������Ӷ��   ����   ������Ӷ   �����������Ӷ���   ��Ѷ   ����Ӷ��   �����϶�   ����������϶   ��������������Ӷ   ���������������׶���   ��������������޶   ���������������¶���   �������䎶��   ����������������Ӷ��   �������Ѷ���   �������Ŷ���   �����׶�   ����Ķ��   ����ض��   ���޶���   �������������������   ��������Ķ��   ��Ҷ   ���������ڶ�   ��������   ���������ζ�   ����ض��   ���Ӷ���   ��Ҷ      res://bin/x11/gdrealsense.gdns                               
   ./test.png                                                                   	   %   
   &      '      (      .      7      8      U      ^      _      f      g      h      o      p      q      r      s      t      x      y      z      �       �   !   �   "   �   #   �   $   �   %   �   &   �   '   �   (   �   )   �   *   �   +   �   ,   �   -   �   .   �   /   �   0     1     2     3   
  4   3YYYYY;�  ?PQT�  PQYY;�  �  T�  PQY;�  �  T�  PQYYYY0�  PQV�  ;�  �  T�	  PQY�  �  T�
  P�  T�  PQ�  R�  T�  PQ�  R�  R�  T�  R�  Q�  �  T�  P�  R�  QY�  �  T�  P�  QYYY0�  P�  QVYYYYY�  �  PQY�  �  �  P�  T�  QY�  �  �  P�  T�  Q�  �  P�  P�  R�  R�  QQ�  �  P�  P�  R�  QQ�  �  �  P�  P�  R�  R�  QQY�  �  P�  T�  Q�  �  P�  P�  R�  R�  QQ�  �  P�  P�  R�  QQ�  �  P�  P�  R�  R�  QQY�  �  P�  T�  Q�  �  P�  P�  R�  R�  QQ�  �  P�  P�  R�  QQ�  �  P�  P�  R�  R�  QQY�  �  �  PQY`    [gd_resource type="NativeScript" format=2]

[resource]
         GDSC         4        ����������������϶��   ��������Ӷ��   ����   ������Ӷ   �����������Ӷ���   ��Ѷ   ����Ӷ��   �����϶�   ����������϶   ��������������Ӷ   ���������������׶���   ��������������޶   ���������������¶���   �������䎶��   ����������������Ӷ��   �������Ѷ���   �������Ŷ���   �����׶�   ����Ķ��   ����ض��   ���޶���   �������������������   ��������Ķ��   ��Ҷ   ���������ڶ�   ��������   ���������ζ�   ����ض��   ���Ӷ���   ��Ҷ      res://bin/x11/gdrealsense.gdns                               
   ./test.png                                                                   	   %   
   &      '      (      .      7      8      U      ^      _      f      g      h      o      p      q      r      s      t      x      y      z      �       �   !   �   "   �   #   �   $   �   %   �   &   �   '   �   (   �   )   �   *   �   +   �   ,   �   -   �   .   �   /   �   0     1     2     3   
  4   3YYYYY;�  ?PQT�  PQYY;�  �  T�  PQY;�  �  T�  PQYYYY0�  PQV�  ;�  �  T�	  PQY�  �  T�
  P�  T�  PQ�  R�  T�  PQ�  R�  R�  T�  R�  Q�  �  T�  P�  R�  QY�  �  T�  P�  QYYY0�  P�  QVYYYYY�  �  PQY�  �  �  P�  T�  QY�  �  �  P�  T�  Q�  �  P�  P�  R�  R�  QQ�  �  P�  P�  R�  QQ�  �  �  P�  P�  R�  R�  QQY�  �  P�  T�  Q�  �  P�  P�  R�  R�  QQ�  �  P�  P�  R�  QQ�  �  P�  P�  R�  R�  QQY�  �  P�  T�  Q�  �  P�  P�  R�  R�  QQ�  �  P�  P�  R�  QQ�  �  P�  P�  R�  R�  QQY�  �  �  PQY`    GDST`  V           j'  WEBPRIFF^'  WEBPVP8LQ'  /_BU !�$II�}@�Wx�� �*@�ޱj��Y�� 9��������$��=DD�N��$�a3��-�)�ђ$I�d���>f����}/Ss�F@�$7n�%���;>�Jn#	�$��ٙ��Q�d�(i۶�M���h�[���
�k`5V��.S�)��=��q׸����$�Q��a�ĝ��z�06O-H<��N(h0'//O��.L��H��f�73 ��Ea�lH���5��07���6��C_�^��t�0�)���)�|:�Ͼ��m:Ks&��8l�Oi`����N�ױf����E�_ơl�Ng�P<x^"RA`�O���B���o<P��V����
�/�o���"�8��d]C>��gΞ�X7���1ޔ:��?��w�s����G���[o{��\6��Sd���{g%�'O�\��Dj6%�����hp�e��{'�$j��d�
?�F�h
���`�}d�@���'�rQX���+>� A����F�(�-֨�2O�ϝRu�C5��aٶAé��>=o���!N��Z\(�:P�vg��s�;T>�sR�`�V��d�Aa��� ! ��>����ЙL���ƕ�hw�5�F�j|l��U]�xlg(�:/>޾�����M�nU�C�T��������w_���I���
�����|��C8x�i�Q�o ���M� 2p�h�qf�t��J?J���[��:X�(����煭�|�.�X�h{I9��s�-�"��b�y-=��'^T��w�"ck��N���|�FA?U���O�v0�C���H�:|\M���C;I�O	�e!�hf?���JS�?�w���B�2�����~�}��$�A���\����U����2ގbj��ETJ�X� P�D�1��GL�RD.�旁*=2le@3��[���SR)֞D�w|�p���Z7�3���:i���/�7��$F�m��(�)S,>y��Kk��-l��~|�h�9C	���rQU��-�,�,\�8H�P�Đ���7�IU5,߭9k/��]N\1g8��ӜTc����m�l
��E��U�� ����m���ּFs
�V�o��}.�2p�Z����(� ���q�m^ �^Ȣ"��C�B%IW�lq�hA�}���R�w��h)	G��&�:��P# ~�p)?C�nTx����f�&�ء?��~ȇ�@�;�d2�_�V����=0<a����̵�8ζ���=�@���Q$�Udn�K?�`�ns<SY#œ������lT9�;m��|A����фȇ�	�F[�κq���"��}6|�-ނmU�"y���69�C�����G���k>sN��9M�!X>�H[�X���9ȸ�N�n�����1={��#̊ �� !&��v�g�d��`1�2/�]�"�!�Q�HP�{4$�}�Ae���ص�������Da���[��}2��$�x &���2g���3T�z���t��ƶ�$�C_~�0<x j���Q;Ac��H[(��V�i�E2�f�$������8�rd5��+�$k��8�3�#
?���	����8�1	w-y4�xNĜ��o�b7=,�� ��X,�P��O���X�&(HI�i#G�y��2p$��AE�=�Zv�OG��2C��.�Q��-�B���ў�\��X�S��W@�WD��D�	p���b@.�B�q��j����pa�挧�H����7�»z�RL�aO�ݣ�|�=�ͻ�@��0���3���&��Q��±��~?���{�0�i��z��PV�>nZ48|r�P�VrKɉ�������b�s1��2�����I܋y��>{Cx���u�{�����q�o�A~�Q���Sr茖s��@�o��q�I0Hɞ{gy�I)h�湘���Bu�m�;烳��h�a�sPʮ/=��".Wb����}˰�a8,�Ey��à9��c%(�ӯ�c[p�`ؘ��Z����Ð�����sG���[��2n����-`��S�/��_�����	�'�_��yeA��I&@��8t�W!8��m_�#���4���|�.��a�%�q5�'p0�W*u��P�~ꁧ18Ǣql�ĥ�)$>��w.=&��}�@d-k�Ѽ�w�¥�NC>.��@�0��_���§�W6�].4��a����ua�P�;7'�������qbd?}�BKp6� ϧ��~�t!X��\0\[��f����\R�7O8֑���
�6��]_-�؛j��[��~e{������	˾9��� �����\X�̲w�xw���6�wB&�o.6�Y�nA��a�>i{g|ȗ�ek�e�]iKy���W~���!!�βke�/�8ɕ�S>�mY�i�8>�@��8_
����_�׺ã|��������f�g��o�P4��'�]��_<|�¤i̥���-y��/�q�$9���Z����O?��/�*�H��'��s�Y�Q6����_8(!q�V{>|��$4��F:�H=�͗�<�y�o��L�t����l#����)�&gL~�'�#�A���ÎPJH�?9����9Z%d?S��!o�������ߑ��Γ��J�����| �7�8:v+;_��v�n� ��9W��u�����'�םx�����p���,�[Y�ݎ8��4|1����"���[��o���~RnH+�מ?JȮ`��������\`�<��m�P0�r���OP�C_��!��R�Yѷ��|o/��o3ǀ�e�*��XD�����H���Y�؎��K7���?�~��N�r�3��o��ď~T8n8蠍��3ږ�w'��ϴ"�FZ���!���7&r��,���+����S��b��y��=��N�gm�)!ct~�����ò��	y2ĕ|'~��>"�@!��}}�iw��m� F�qp�}BZ~�-�p�ǅ��Ly�z&~���b���qn8���gN�C����h`�"Z���5�.���h�i~�M�|�J��ݕ`�U��L������Bj'��d�ϼ��y}*V9����L�cYo<]��lm̑!�|�.�6��sQڽ�Ϋ+��,�K�te�r�A��k
#
���]�-����;k|�!�%F�!N;��x��ʓ��w�)��;��V��\�u�"�>���A׎����Y0�������%����pi��sh�3�V8�A�tZ����� �±":r�ŭb�:��c��*��'���ﴚR~�A��IF�=��Q�������U��<znz<D�T�ɢ�0`B��8�ȇ}�hs �|��Vu�ڋ���aG��s-tC� �D%��A����"�����J;r2z�H	��Jj��r�X�5;6�4�w��JcD0y�x��)�=p�s�h�����ML��{�1�d^^�^���7��3Gǔ��#ɫ��U)$R���� +�c_QC��8�낒���z�0�$(�CI�ط��::G����J�my%'ȏ�"�0nڍJh���w����"'	T�0�Xx�9������ 
��*�?�0u���Y�~�q���(�aLyi)����E���2o�G�	������,��V��p-���eM�w�� ���� ���w�	��B ��Mݱ���XG�R���YP,ȉ�u��M����p��� z����D'P)K!,r���Ϻ���9v�FX��=��
�b\��M��ݼ/���$D:Ӱ��ֳR�EPզ~rU½9%<�8��{�W����hQ��]˳)���z�
 )BFd����<�����z�4�gd��	�u���bhKe��<�֟��I�v3�Nť�Y�q"c�|��VM��_+�`HuaL��}ݾ��`r��/E����P\
�	�O���o��+(Γ�D���΄>���F�q��@��Q�\ ������p<�h��)�$*f0�����>F\��,�-31����`�"�	.R���|:Z�󜛱�|����t������x6KD(�D\f�Tt��?�|�3&�0�����d�HP��2t��|�տ��u��?q R�o0a	&͈����rB�c�w���"�A�p�������ACS�c�k���h��P,��  ;N�Qc�/�?��Ӟ��(v��H 7�"�D�q����l['��i�	vӹ�@C�&'��P"C��mv�a~b--��W
6�>/�9Ꮬ`���A��w8?W"c�	��9��P8{4����]���ջ��-�8l���?rt���v@
�������7�e�,R/8��q�g��B��=lA+_RxJ��m�~]֪#՟���e_�FVwa#�"�C߫���{{�)�rc�HR8�X�T�;
�$�!��5�K��i�޻�,����)��}�I��Zr&`��0�F�^����m|
�, op�c�pT����'�noNy�.%��,P������#>��`]���VΉ�Q]�U��v�;����C�����V�E�;�u�B�+���c'�%
&��n��R�z�Y�?��q#ܦг�����ߡ�L���+1{{|�F,��vbrs_bL81�'~�ZX���5zuI��[��z&��
#pG�?N�CXq�z��S���C��~ k��3�⃍O0;��~�do�"Q�� �Ă� �i�-��k�dG?�8m�A��gށxǦq@�@��uO9J`� C��k��Aqd$���b9�y��zJņ�u%��� �؆��r����;<�
ܒ^���3"I���-3El\]��j)Sy��a[��G�Z�:������=n�v�(��ƗP� �q���,���e�P�N�ci�9���r<��6�Ѹ�K�(������*,�" �;`ic"eqs��-���
�es��J^��?/߭�ZtJ=��Ap a���`�ӓB�F1J8 �nNǡ�A�Ӻ���\�ȁ��0Љ2ǈ��$c��J.B'�p6����	�)���P̠���3��[%	gc�4��ES���q-�{^����vx�v�X����PId��j�����G�1r�ӎB�{Th����6�27��h�r���,E/hF}g&/塐,m���x f� BP��Ψ��Y	�GGVL������;RΧfN�d; �p��s�eYwf�FU�'�҅��^�����Kut����P�v�Vh�=��g
�X*L(� ����WcI1���o-�<C��5���N� ޝ�z�E�Y'!���B��l�^����8(<c�1��N�$����?R�tԧG���'F9�|����a�T���J�v�90�z�O�2H>���'Ň��-�m`S{�&3k����ĝ)�D���q����*D
�s:���u[%)\U��o�y�q�[����kr��E58L`j1(���|��`tZ}Ă��í�5@fQ�;���O^ԸI��Ş,����>Z�^�|���j;L�ڋ=�5왲S9�Mf�TQnJ��Ӻ7t6��80�U�_-��."P���D5y��FN��g���%j%�j������N���!�\JF�_2�ګ[`��ӎJ���"77B#�������9�y�ZJ@#DH�&%r�5[����R��H؋��a H�Xkv�Ѿ��7ʚh	x𞠔0�`aq��l��ҫ�m�쥨XL	$b�n���oG���O�QR�1Hk>��}"i�V�����d��zZ��ro�T,�����~��j�V��pVj��2���'A�1��V�݀��H�!�N��}T*����|cĳ���1���2��C���m{SV$e���E�x/ȅ�W�a$��۫�D,�c��Au�sMpOD�,F�q���@8aqMC���Dbo6�_�N���%F���!��M�p��;�X{����X��8+{��o�a�O7~̟���]MgmG��Ƹ�G����n�`�o�.#��^_Y��|��:�+:. �/�bF	�:glF%��#4r�
|rP�a+���8�i�Ɔ��і8x�8��sxl�����%Ij~C@q�0�G!_-��̐#:�w�� ��LZB�����!�i�Y-���4�T b|;�w{����2
���>>X�m$���W�
˜]��ѓ�eP�RBhwG�"!V�ԑ�lOZ�A .���\��9ly���@�!_����E1�<�V6�ՙ&P0�o'��*;A ����2`w�:�r�J,˼�qa��b��@��^�v�69���;i6��n�q��<��D��Z���L����� �����e�@�Y��A��/���p���+��~��P�m�W��'��og1I�7�� 8p!�̽���fA�]Lx7W<q���
8)D�p�5��H8A�0�҇��#3(��Ҭ�	\�S?�)|�M�7$8@�Zk���c�w+�{�-u�bϦ�Z��Nv}�Tm�þ�}e+�|���a����1h�	%4*�d���b��To�\12���8���*��ͫ���a����H��&�8�7{�U a-mY�`����/W<q(.�9���J=H�� ^W��ZFS��r���O<�<Q|vg��!�x�s��Ι�na�g�0j��\�~��/6��)Ϥ ѷJT�����i�JN�C�W	:� x��鷻)�#��ke��q�"�u�{���|�[ࠀ	�Y���~���Nh�R���ts�O�uy�;8������np�5��ѩ�KU|���7�H��z��k�}�P����8����X6	}��<��K;pu�B�����n�fB�U];����N��P5�%�B>/.������R��
���L����Ch�x3��ަ4�m���>qQ!�"�s`̵�,0��v4�;6Yg�R��Iȵ\��cH�c.���(\hY�w�	ƒ�R7&c6����F���V<Μ�"�fj��.3#Yy@��L A���N~�<���3���ѓʪ�A˸�˴�m�DC�8�m����7�<�J'�q��U-~L=�[bU�,]+�����cg8\�pJPT3�AS���2s��P�r��b���2����&L���椚
��.�%6�-r�1qY��CJ��������t)C��`���
)�\m�9�#�Ҁ�Q+��C8�)��35'	�\�*��U����D��c�nHG[&�`��K[��-�y%#��H��w�����qw6����.~-G�5	��Ŀ�z8	����{����O^�y,V蹝|
77-]���cq�
��m-ξ��?̔&�9XJTvh
�	4�_T�ݣso�Ҕ�s���7��̉��|cG��e��� ��ۆ"��Ұ���Ӳ3������C��A>�U;O��I�w���1�9I�!z�#�S��*No2���C��c@��4��M�%٢��Mef]ݓ��M���u_{cǻ��E�	�O�����x��"y�B��~���Iv���ҙ��vR��{C|��w.jfw�᠀TE����A�����F��J��1��8�P0���\�}@��21�v�T$��1��&*{��Rk�-KL�#�c7�n��}�.>'��-��z��N�XZ��B&�}������!x����GH�KV�Ԁ-��㌫HC�,A;ydJ��Ε^�U��N��D�(�'DR�5�#;a����N���}O�\��Q�b����>i�`���yXx �����D�LT�&,\���T�U1F(c�Ɓ��:W'֡� + 4g�r�|��Sd^����4��l�Iu��b�v�Wn�z��Ec��PP ���I�r?x�8񈋪)j���/��0B'<�C׭�����t�<�͸���G�*��:T�r7̔�,�i� �]�{�\�O�
6Qi�kL��hˢ2��'>��hu,+�߬��|�r�"�<@���%?;�>TfBV��4�`\�B�Q,�͎G�[ �/K)r���\N�W��q��y��(�p�E���̈́����X�mr����:)�lf�^x���Ì%S�Y��)���)"Jil�����n3j���5� q���Oh	��IO���>�Ш/�X'3tZ���B��F�a��)2\��~��a�(pht
�&����^:���х��iF�x�fK���2ݔ��GeB���QȎ�G��"��  ґGn���Bg�Z=88�q�+�Tj��{�O�����ֳ������',�H��«͘1GG"��Jb��q4Ưk�I���:�/�Tr��c�>�N�"��;��)�4x8u1�?G��N���k����bB��!3ν�Q몂�Ɨ\N���O���dhx�΂�!�F���u�j�z��?ٌ��!�֎_z�p��]}�B[�l5Ԣ��m���"ʍ��ov����X����6��eD��ScJ}c;!�`yI
�th����s,,�[6�]v����4�����D������l�?��(_\���Z�� �	j�j`������
���尮^pK�L��SM�,L
�����y�?*xxŅ��Ǻ\�c�
��� �)�T�1ppP��;m�����VW�#�ss�9�P
��>pw�B �+����zM�U������o��4&L�%��·�@����lV���ōl�m�FP:j�'�z��9&$ 4F�*�L�Z8�Hd����P�K`2oLw+�.s垾Q�W��(���@�	pq^$#5(���_f8o�q_T��z��������B�hg)�w�C�����z\��˺�ػ� �$��G���	���[�2O�8s�@27ɥ��$�B��n�=���w!��L��z!N$�P;�ؐF�Y6#Y	�#���v���<9�pD����9n47r�;�]A��T9������$��֫�����镳@���qJ͸�uoT��p�^p�}�F��:�*�ʰ\��3���e3$�30|�3Q.��x9�ˠ�T=�y�3�Q��:1��a���
T_±GQ����o녽B�rb����ͿD����	E����݄�&� �����ٙ{��Mc����|K���J�I���AJLf�Z�Nr��0o���U��9(���F�B����U�������A��� �����h�\|��Z��\8;K��-߿q�RP��<�(mK"����N&�K�8��Co�~l�o����!��!Ў�&{i?Ärp��Q㦘���?�S2-�  $� 0x�����8�*��em^@C��J	KQe'�h����SQ݀�τ �0���ǀMQ_G�,�.���}���������N��F�X�F@DɎc��@�7El�$��6��cK5��#+	A�Ia#n�|/l x�7?����nٽ�����ȹlA���y��z�V� 2@��0wF���G���[,VCi�W��c<��bL���� R=��3a���&R�� ��Ѥ�5.Oo�)�A i`��>v�*ae�d��|S��i)�w��]����7OR�-�M����$D�J|��q,�:�ā��~�j�|9X�Y�Å�K�����k��	#��c����;����e�@|��C*I#X] ��ǭ��q!�8o��������B�=SX�-��2X�_t�Ϣ5�v&�`B�D��A#׏r���`��]u�e�?��D�)%�q� 3Z��`>�@oens��`�,CUD4<��me?����>��& hd��2'/g�û�z�4���mTO��i���I�z�!��!��h"Lh�%$�rnnS!X��ʐ �~��Z��E\�$n4�X6D��y��8sP�}��s+����^�P�-�ɝ��Vu ��w?��'2���yC0����.���:`������u           [remap]

importer="texture"
type="StreamTexture"
path="res://.import/test.png-2b0b935732229e5bd5e655f2644b2498.stex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://test.png"
dest_files=[ "res://.import/test.png-2b0b935732229e5bd5e655f2644b2498.stex" ]

[params]

compress/mode=0
compress/lossy_quality=0.7
compress/hdr_mode=0
compress/bptc_ldr=0
compress/normal_map=0
flags/repeat=0
flags/filter=true
flags/mipmaps=false
flags/anisotropic=false
flags/srgb=2
process/fix_alpha_border=true
process/premult_alpha=false
process/HDR_as_SRGB=false
process/invert_color=false
process/normal_map_invert_y=false
stream=false
size_limit=0
detect_3d=true
svg/scale=1.0
              GDSC   "      -   $     ����������������϶��   ��������Ӷ��   ����   ������Ӷ   �����������Ӷ���   ��Ѷ   ����Ӷ��   �����϶�   ����������϶   ��������������Ӷ   ���������������׶���   ��������������޶   ���������������¶���   �������䎶��   ����������������Ӷ��   �������Ѷ���   �������Ŷ���   �����׶�   ����޶��   �����¶�   �������������Ӷ�   �������������Ӷ�   ���ݶ���   ����Ķ��   ����ض��   ���޶���   ������������������������   ϶��   ζ��   ���������ζ�   ��������ڶ��   Ķ��   ��Ҷ   �����ݶ�      res://bin/x11/gdrealsense.gdns                               
   ./test.png     
         A     �?     �@  333333@     �?                                                    	   %   
   &      '      (      .      7      8      U      ^      _      f      g      h      o      x      �      �      �      �      �      �      �      �       �   !   �   "   �   #   �   $   �   %   �   &   �   '   �   (   �   )     *     +     ,   "  -   3YYYYY;�  ?PQT�  PQYY;�  �  T�  PQY;�  �  T�  PQYYYY0�  PQV�  ;�  �  T�	  PQY�  �  T�
  P�  T�  PQ�  R�  T�  PQ�  R�  R�  T�  R�  Q�  �  T�  P�  R�  QY�  �  T�  P�  QYYY0�  P�  QV�  ;�  �  T�	  PQ�  ;�  �  T�  PQ�  �  ;�  �  T�  PQ�  �  ;�  �  �  ;�  �  Y�  �  T�
  P�  T�  PQ�  R�  T�  PQ�  R�  R�  T�  R�  Q�  �  T�  PQ�  �  �  �  PQY�  �  �  P�  T�  QY�  )�  �K  P�  R�  R�  QV�  )�  �K  P�  R�  R�  QV�  �  �  P�  PPP�  �  QP�  QQ�  RPP�	  �  QP�  QQ�
  R�  �  T�  P�  R�  QT�  QQ�  �  �   PQ�  �  T�!  PQY`      [remap]

path="res://Main.gdc"
 [remap]

path="res://MultiMeshInstance.gdc"
    [remap]

path="res://mesh_ig.gdc"
              [remap]

path="res://terrain_ig.gdc"
           [remap]

path="res://test_ig.gdc"
              �PNG

   IHDR   �   �   �>a�   sRGB ���  �IDATx��y|T����̒�$�L��F��������bEo�R���^�z�j�����~�WkUz�z�ꯥ�U�r��,.��(;� !�B�/3�d�s�2��d2�I&8�����y�3�s�y��Y^�a�[z3]2m�y�b�j�h[!ظ$I�� �]#L�$	A8�M�Z���2�}�(��h�r*vo���o�R
r��Z-�
e��H��Bt��&�HHz����	�L^_Z����������@%�)�)�2A�ֆ�  D��V�P��d�u����z)�F�U�!Ym�"Ԋ��vg�I�����ՂL��ܳ��o.0�[��@\$�Hq�� ��� �� w=�/X-f�$�f#��f�(#A��&�6c;X�٠8 f�jbb#24��� �ΕQD��B��}�	�S�� H�Ԣ�,�{��=G> t�����6Eh�6���+#P�$�!�P��L�r^�d� ���m� �z d �3/!->�� |ǹ�BIDdLx�7�RH�,f��I���(�G��'����)V�x���"�bǾ�a������8����}R>�(�	*�#��_E��1���0A@� �����H�8A���W*@Z�RA~�_D��R���#�Q�+b�V�R@��E��oG��	�R�(����O�_)"r�sA�B9�36x���M�`���r�:��xp[�&M%�E��0'�c+	B�R�K!��}(�E���JI��h/��/V��V@��ǩ/G����0��3�YP���Slر����Q]79A��+�b��\������r����d����0c�Z��DT\�ʆ��Ҹb����#��~�l6�~}�uon���gD�N����w�f�esE�W��b�ȩ
����ˣ���k�����-.�N TJ��r�,���)>����~�����:���ng���T������x;�<J��4�vƚ	+ �ӓ�u��Zz	ё�-�u���l��l6I���: ���w����|j++5��/��y��益�9YZ.�M`RB��z�>~q���x��-^ˌ7��:@J����_���7[9P�΁�v��u�������`��x�2?�uO�����=��p�њ��vp�����">JɼIq,�M`qN*��lt���W^��+����r�y���F��YRά_;�P��K�x���kY2�e���}��u/�(����z1��u�\?+���Tv}}�.]��eg���=�"�ט��4�zW�2��T���eY+k���Dj��X���Tzr�I	|��1?�:x��]�?�����{۷�I_���ڮr^�]I�9f�4d�6���T�q����6&���Y��o%o�]hT���p����V��s:�o����B$+>A���BIU=uM�#����. !��s�?z�>��a��z���#{����I�ʲ��?9��e�'�s��v�A�$���fDm���٭�y�Îs������p1��~A*Z��h��$A���7�ۉ��$=9�Ɩvz�}�w�JG��*ڨl��רS_C}a-��[���������UK��%�{���$�����ݞs_��!	�O��w�ǋQ��^��˞Rߧe{J[�mZY
�:�C(2a� ��b����+�&��e��l��h��� @F��H��BF�V��#������P�� ��B�(> ��V��=>.�8���B���t;��cF�Kb\� a�}`t��ƹ������ 8�ڍVK��:���x3&:@vf
ٙ�t��9z�ҧ:
�x�Վ��� c�s_�c5�^GNU�Tw��\�1�Tן���9X]t�_5B�็��ʅ3]��>T̺7�����^�:���\��˖��o���E������=� �?���x�z��##%��ﺉ���r9���I�\�&F��k��4[��?���y����떠�Pr���eЈ�7)�??� �fMu�������e��uM@�5�+o�����,-��N*�s�X~�|�,��{p�Q�Rr�w��3�AnV�ǵ&�'3%=�O�>����1����\�������#y)v�C�Ld��nX���nuM,�d&�~�����(~Y��/�?AI�ȼyB���^>9�L�V���D�Yy�B���Q���ʫ���w�d�td�AulǉF���0r< ٙ�(r���_�p���^į��g���#g����~^r4\���tנ�ʺ&r'J��;ΰ��7�P��$���H�����9��.�J�yuW9�m�^������k���G�w��������G���݁�6^���a��5���s4v����A����.��Wĩ�n��j�u��������h�O�bc���F���r��y��S˱�N�Ɍ�`ɼ�/��������������7"U��ª=Om.�j��n�e�	�#��T�C`��v��"��G����]���Oѐ�����,V�;x��><My�Σ��lgQvqQJd�ȕ�l�^�_�� ���KO���t��]o����鿰�j�I����3-$k"8Z���w��h��os�`�������9z#��r�}�mXl�u[l��Y:-�n�P*���Ň�"�a"� �q�����o:A}�o+`z��ݥ������?����5�.mEo�-���d����兩��@Jb�~'J�G�~�=��3Sn[ ����:3:ʛu����q|�m�&;�#�ۈ� �d"����P*��\iSԍ�Sa���@���J��g��{.�GU��y�r�����;�`����'l��;�`:�'M���_n^6�k�- ��ܽf��x��U�w����b�����_V9��^���X����- jU�#�����G�v�86�����-��P��O�spsw�7B�$�y �[ �������T.�KH���ey�,+\Fv��� �k�d�GǏ,/ .2�`*��E*ydy��x�G8�����>Ͽ���x�Z��+
��f�<����sx������4��J z����k�:B��$8�1���g��8��$I�y�]z�F��Z	<|���;�8��&�a�8Ҵj�&�q�q���@@f������s �2~z�4����P����i�<U��x�����v .b�Xy���v�w�Ȉ廋&��a��.�Č����om�x�C������V�������;.���0��Rȸ�)���7���:p�n�
��?v���,#R�\&��3 
3�c�K�05ECVB$�}�7�(o�Q��3�},����c�Oѐ��!3>���}�5�h�q���o�(�����������+�]� �lF����.G�?d�G����䧸�$?E�5��&��V=�o/��m|/�$F����d'����h��{_˛u�~{	gGi+��l�,��R�eL�HqH�H�ea�޹�c���N��;����~��^:�W�X�1���hx��ܲ0k�r�A�B�ܓ+��u���hi�×��^OYiˠ�B&r��٬��[��@�z^w]���I�-e�e����E�r?Z��u��OB&�*Q�2��í�a�F�M��=������ ��9��?Gɑ��U��+s�G��7��L�ǹ��tn��6n�����]�Ǳ�ΐ�t
��Ї�M%*bP�f3O<�3^z�e��8Sr��~����]S~t���I�V�Ng��t�4#3�>���1�����c?y�e�y饗y��a6:�FE�yh�TB�� �B���x�s����C�Yoûسg/ �2�>������,�����uSy������i1j�2� �ݻ���NA{��!��m�˹���!3E	�M�v$f���c���|����uX��E��d�<c~pe�� �2�W�P�a�Zy��u>�ٸ�=���:�EA �Ǿ�� ��+..��e�[otuuQ[k��-H�m��t/�
o�1�Fmm-]]��,��l�p9竰����h�opy�o����㢂�0��H�XQ����ǋ���V�iS�f�5 w��"�^'�1Ц����X��BB *�2rN-��<u��|���QP0�YG�T�l���<^�� 4t���&5w�\}�1�7o.��ɘ,�1Y�i��d����ļys}�����ܹ�e{�Bą>$@��7�ͣ?yt�zj���~� o];&�!�M����J�c?}�zx��'�=Jt�������	 �r��N��/�t1O��I����fdd���'--�Ҧ6:�\0�t�,�M=������'#��RtTTO��I/�z���.�k��K�,����ܱ����lٵ̝;���wPVZJ[[���̘1���V�R��5ZxaGɘ���$�v����-�������۷m������ד���ԂV�ZIB U��`�ŝg����R���Ͽ�?ȏ�+p�$&&r�]wz-���u���x]��EX����N���_W���x�ܲ�5���`��+���'�t�'ۗ���  t��yf�I����M�3�O�x��/oֱ������m�V�����I�FJ���/�?����X5'�Ä-I��:�m`WI�s��C�	� �J�?Z^J4�)*���7�F�@��Y9�1*ǀ�7�xu���;���Y܄�����My����И�E�
�3������z�}��8���3��5�(�@	2&� �@�D&d��aƇ� |�	�7��� �S�����>�:#�~3��1���w�a2ۨ���j��g���";1
�L`r|J�Hf\$j���X��dM�A�� �ܼ���J�>܄M���U4�h�����>��U�#��07���#Y���x2� Q��Scլ��t<�5j�Y������IP�益H�U���LN�B&�w�.�`f�o���HӪy��BG{�Rբ�[O��r��=$׬j�c�$j�z1Ym4w��ܭs�j��* ��[�_���hD�$D���,�I��\�`4����%Y�|���h��,��2��;����6T�c�بi��f�3(B\=}�??��J_���������]�Gs-�{�q��U޷�/. �fYg�O&��2���g����U����9	ܹ$��Z#A���(��(�ο��GO�p����<��P���x�tWsi�Z1�khTr� �����Trw.�F%G�?�tTq���^#{��O^L����sJ���|����g�߽�?o�������8��s�d��)�V+���k�z��B�̀��`���g��w:�LL�緵ɈSsf�ͫ2����M��#����|!U��Sw����ӕu\6w ����-kQ}�U��lu�nݲ0�k\��&9�>����v��\��Gc�k�48o.�O"]�v��8���l�t(�f밂덁8D����&�p�Tw�b�">7K;Li�T��=vsG&
.k	s�⼖kE�xCנ ,�Kd�(��V�2��}"-�;���j0��}�����9r!x��rV�Sެ����h�EFh��7Sެ�`U;�|:�����u��~#'�k��1r�0��l�}�[W\�wdr�޷ ��Z��js����	Q(�Kt�Z!sl���T:b�㣔��ӱ�x��u|e[Q#���H���Ǟ��Ug��NQ��瘡T��If�Dm{`����g�e�!L���E���q�^nY~9� �$/������x���-;|��>��_��d���ƼIq�O��fc��=������3�6���u���/i^L�2~�|0>򓯎S�42e�W�6*����ykj��_�4eX�E)yju!����l���׿���6"�=z^Z��q�`J<��yV�M0r�߮�ł)��/��}�z��0���*ꚰZm,�i�N�U333��e�!��3TP)d<{�lf;Mg�k�66}�/������+��h2�h�=�>%F��,-���7_��Ďm��߮�Ea�����o}��[>x[c.  E����X2w: Iߞ���b����#}&*� 7����3Iw�5���a�9. p����nW�/��#Y�����Dj�zi�ĉcEaF,�|g���(ǿ{���q`_�Ό�  �T�����¼�h5�v⢔���F�VEu�~�;�����vM�KR���f~��Mv�/
j�� �X������}����p5?\s�Ǧ���]|T��޲֋f+���U�,���b�{
�76}Ļ�v�j�7_��lq9 9A�#߿�k/�̵�g���L�<G�0f�Pezz�SY:-�a9t擯����-�vt�Y�BJ �7#����rłB����^#�z8��M��N�[C3�$;)��Yqv�AF�Q�� �6{���m_p����U�KH
� q1Ѭ\z	��YLvf���-�n��TC7�z:�L����"/9m����h��h(索�sl�� �v���p�� 83k�dn�z1�^:��h�ܱ��F:zMT4���3Ӣ�G�����p��o��m�ݴXQn^�y��5*��
�R4�G)}��٭���El��`PL��0a������g��L�&9�?G�`���ŉ�j����Pq5-�Wc&� ���ǜ�fO�&;#���)�d���f:�uT74St���3գ��w��(�B�''��Ր;)���8�b����L�r1Qj2R\ݻ�ϵ��su;SUHt��r���ʺFڻ�4��Vp�Hp�q�
$�-�4��S\V3�]�0����$�a��0c���JH:�V�B��[O<�VhIr�(H���I&�p[A�ZDI\➭�o�U��J�P*"�k���Q��x���f���c��"h�Y����놙�XL��l�� 	IW�t|���UA��\�l��."$I�lp���I�T������g~J�$�*��f��71M�a<1���>��d0���U�"V��dr�Axù��d�d�l�a��d�c1�)����(��+vo��<y)�jz~�f;��+#PF�x���H�����c�%8QRް�v�������k��f�a�$�0d11��c1�3kO,F�}��_��l6��ת���{;2�+H̙�#�����D;״�MXL$��$� ӱZ�HV+c�>�}�=�}i���j��a��y��z��۱Z��"Ԋ�0	N�����.�x�;jO�vJ�٦��I�1	�0�lOa�	��k%���7{����Y���j5?l6�J�����L$$�$�͆�V��a����z0�j���f�dڬ=�BŤ�6ѶB�qH"�4#<=g$IBN�`�D�m�G��u$�b,Z���ݞO�3�m�߷P5�:    IEND�B`�      ECFG      _global_script_classes             _global_script_class_icons             application/config/name         TerraBox   application/run/main_scene         res://Main.tscn    application/config/icon         res://icon.png     display/window/size/resizable             display/window/size/borderless            display/window/size/fullscreen         !   display/window/size/always_on_top            input/toggle_fullscreen�              events              InputEventKey         resource_local_to_scene           resource_name             device            alt           shift             control           meta          command           pressed           scancode          physical_scancode           unicode           echo          script            deadzone      ?$   rendering/quality/driver/driver_name         GLES2      rendering/quality/depth/hdr          )   rendering/environment/default_environment          res://default_env.tres         