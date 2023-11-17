GDPC                @                                                                         P   res://.godot/exported/133200997/export-3070c538c03ee49b7677ff960a3f5195-main.scn0       0      �TY{8����wݺ    T   res://.godot/exported/133200997/export-587cd83b161f236aa1681c703043f642-bullet.scn        �      O^���>\X�
�R�    X   res://.godot/exported/133200997/export-a8cf13c19ca9a53941619a83d1bafc3c-character.scn   `
      4      �a���'�CC��d>�    ,   res://.godot/global_script_class_cache.cfg  �&             ��Р�8���8~$}P�    D   res://.godot/imported/icon.svg-218a8f2b3041327d8a5756f3a245f83b.ctex�      �      �̛�*$q�*�́        res://.godot/uid_cache.bin  �*      �       i��L��c�	�1�{4        res://Character/bullet/bullet.gd              <��	��Y@HxiL�3    (   res://Character/bullet/bullet.tscn.remap`%      c       ���E��A*��k.       res://Character/character.gd�      �      f-�K*]��`���    $   res://Character/character.tscn.remap�%      f       ��� �����d       res://Scripts/GunStates.gd  �      �      �n�X�x�@��3���       res://icon.svg  �&      �      C��=U���^Qu��U3       res://icon.svg.import   `      �       
�Pؑ�V.)���n&M       res://main.tscn.remap   @&      a       �J�Sw� ������       res://project.binary0+      >
      T�[Z��%�g,,11�+        extends Area2D

@export var speed = 750

func _physics_process(delta):
	position += transform.x * speed * delta
	

func _on_Bullet_body_entered(body):
	if body.is_in_group("mobs"):
		body.queue_free()
	queue_free()


func _on_screen_exited():
	queue_free()
               RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name    custom_solver_bias    size    script 	   _bundled       Script !   res://Character/bullet/bullet.gd ��������
   Texture2D    res://icon.svg ��@�Cl      local://RectangleShape2D_qm5q4 �         local://PackedScene_6nybx �         RectangleShape2D       
      C   C         PackedScene          	         names "         Bullet    scale    script    Area2D 	   Sprite2D    texture    CollisionShape2D 	   position 	   rotation    shape    VisibleOnScreenEnabler2D    _on_screen_exited    screen_exited    	   variants       
   \��>�Q8=                   
     6       ��?                node_count             nodes     (   ��������       ����                                  ����                           ����               	                  
   
   ����              conn_count             conns                                      node_paths              editable_instances              version             RSRC              extends CharacterBody2D

@export var speed = 500
@export var friction = 0.25
@export var acceleration = 0.5
@export var ogZoom = 1
@onready var camera = $Camera2D
@export var Bullet : PackedScene
var text = 0

func get_input():
	var input = Vector2()
	if Input.is_action_pressed('right'):
		input.x += 1
	if Input.is_action_pressed('left'):
		input.x -= 1
	if Input.is_action_pressed('down'):
		input.y += 1
	if Input.is_action_pressed('up'):
		input.y -= 1
	#if Input.is_anything_pressed() == false:
		#camera.zoom = Vector2(1,1)
	return input

func _physics_process(_delta):
	var direction = get_input()
	if direction.length() > 0:
		velocity = velocity.lerp(direction.normalized() * speed, acceleration)
	else:
		velocity = velocity.lerp(Vector2.ZERO, friction)
	
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		var b = Bullet.instantiate()
		owner.add_child(b)
		b.transform = $Muzzle.global_transform
		b.scale.x = 0.255
		b.scale.y = 0.045
		text += 1
		
	if Input.is_action_just_pressed("CheckDB"):
		GunStates.SaveData("Bullets", "Total", text)
		var a = GunStates.loadData("Bullets", "Total", text)
		print(a)
		
	look_at(get_global_mouse_position())
	
	move_and_slide()
            RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name    custom_solver_bias    size    script 	   _bundled       Script    res://Character/character.gd ��������   PackedScene #   res://Character/bullet/bullet.tscn �����B
   Texture2D    res://icon.svg ��@�Cl      local://RectangleShape2D_fikrf �         local://PackedScene_rja8m �         RectangleShape2D       
     �B  �B         PackedScene          	         names "      
   Character    floor_stop_on_slope    floor_block_on_wall    script    Bullet    metadata/_edit_group_    CharacterBody2D 	   Sprite2D    texture    CollisionShape2D    shape 	   Camera2D    position_smoothing_enabled    Muzzle 	   position    Node2D    	   variants                                                          
     xB          node_count             nodes     5   ��������       ����                                                     ����                     	   	   ����   
                        ����                           ����                   conn_count              conns               node_paths              editable_instances              version             RSRC            extends Node

# Path to save file 
var file= "res://GunConfig.cfg" 
 
func SaveData(Header, Adress, Value): 
	# Initiate ConfigFile 
	var configFile = ConfigFile.new()  
 
	# Add values to file 
	configFile.set_value(Header,Adress,Value)
 
	# Save file 
	configFile.save(file)


func loadData(Header, Adress, Value): 

	# Initiate ConfigFile  

	var configFile= ConfigFile.new() 

	# Load file 
	configFile.load(file) 

	# ----------
	var loadedData 

	# METHOD-1: 
	# Check if "hostname" exists in Config section 
	if (configFile.has_section(Header)): 
		if (configFile.has_section_key(Header, Adress)): 

			# Get hostname value and print it 
			loadedData = configFile.get_value(Header, Adress)
			
	return loadedData
               GST2   �   �      ����               � �        �  RIFF�  WEBPVP8L�  /������!"2�H�$�n윦���z�x����դ�<����q����F��Z��?&,
ScI_L �;����In#Y��0�p~��Z��m[��N����R,��#"� )���d��mG�������ڶ�$�ʹ���۶�=���mϬm۶mc�9��z��T��7�m+�}�����v��ح�m�m������$$P�����එ#���=�]��SnA�VhE��*JG�
&����^x��&�+���2ε�L2�@��		��S�2A�/E���d"?���Dh�+Z�@:�Gk�FbWd�\�C�Ӷg�g�k��Vo��<c{��4�;M�,5��ٜ2�Ζ�yO�S����qZ0��s���r?I��ѷE{�4�Ζ�i� xK�U��F�Z�y�SL�)���旵�V[�-�1Z�-�1���z�Q�>�tH�0��:[RGň6�=KVv�X�6�L;�N\���J���/0u���_��U��]���ǫ)�9��������!�&�?W�VfY�2���༏��2kSi����1!��z+�F�j=�R�O�{�
ۇ�P-�������\����y;�[ ���lm�F2K�ޱ|��S��d)é�r�BTZ)e�� ��֩A�2�����X�X'�e1߬���p��-�-f�E�ˊU	^�����T�ZT�m�*a|	׫�:V���G�r+�/�T��@U�N׼�h�+	*�*sN1e�,e���nbJL<����"g=O��AL�WO!��߈Q���,ɉ'���lzJ���Q����t��9�F���A��g�B-����G�f|��x��5�'+��O��y��������F��2�����R�q�):VtI���/ʎ�UfěĲr'�g�g����5�t�ۛ�F���S�j1p�)�JD̻�ZR���Pq�r/jt�/sO�C�u����i�y�K�(Q��7őA�2���R�ͥ+lgzJ~��,eA��.���k�eQ�,l'Ɨ�2�,eaS��S�ԟe)��x��ood�d)����h��ZZ��`z�պ��;�Cr�rpi&��՜�Pf��+���:w��b�DUeZ��ڡ��iA>IN>���܋�b�O<�A���)�R�4��8+��k�Jpey��.���7ryc�!��M�a���v_��/�����'��t5`=��~	`�����p\�u����*>:|ٻ@�G�����wƝ�����K5�NZal������LH�]I'�^���+@q(�q2q+�g�}�o�����S߈:�R�݉C������?�1�.��
�ڈL�Fb%ħA ����Q���2�͍J]_�� A��Fb�����ݏ�4o��'2��F�  ڹ���W�L |����YK5�-�E�n�K�|�ɭvD=��p!V3gS��`�p|r�l	F�4�1{�V'&����|pj� ߫'ş�pdT�7`&�
�1g�����@D�˅ �x?)~83+	p �3W�w��j"�� '�J��CM�+ �Ĝ��"���4� ����nΟ	�0C���q'�&5.��z@�S1l5Z��]�~L�L"�"�VS��8w.����H�B|���K(�}
r%Vk$f�����8�ڹ���R�dϝx/@�_�k'�8���E���r��D���K�z3�^���Vw��ZEl%~�Vc���R� �Xk[�3��B��Ğ�Y��A`_��fa��D{������ @ ��dg�������Mƚ�R�`���s����>x=�����	`��s���H���/ū�R�U�g�r���/����n�;�SSup`�S��6��u���⟦;Z�AN3�|�oh�9f�Pg�����^��g�t����x��)Oq�Q�My55jF����t9����,�z�Z�����2��#�)���"�u���}'�*�>�����ǯ[����82һ�n���0�<v�ݑa}.+n��'����W:4TY�����P�ר���Cȫۿ�Ϗ��?����Ӣ�K�|y�@suyo�<�����{��x}~�����~�AN]�q�9ޝ�GG�����[�L}~�`�f%4�R!1�no���������v!�G����Qw��m���"F!9�vٿü�|j�����*��{Ew[Á��������u.+�<���awͮ�ӓ�Q �:�Vd�5*��p�ioaE��,�LjP��	a�/�˰!{g:���3`=`]�2��y`�"��N�N�p���� ��3�Z��䏔��9"�ʞ l�zP�G�ߙj��V�>���n�/��׷�G��[���\��T��Ͷh���ag?1��O��6{s{����!�1�Y�����91Qry��=����y=�ٮh;�����[�tDV5�chȃ��v�G ��T/'XX���~Q�7��+[�e��Ti@j��)��9��J�hJV�#�jk�A�1�^6���=<ԧg�B�*o�߯.��/�>W[M���I�o?V���s��|yu�xt��]�].��Yyx�w���`��C���pH��tu�w�J��#Ef�Y݆v�f5�e��8��=�٢�e��W��M9J�u�}]釧7k���:�o�����Ç����ս�r3W���7k���e�������ϛk��Ϳ�_��lu�۹�g�w��~�ߗ�/��ݩ�-�->�I�͒���A�	���ߥζ,�}�3�UbY?�Ӓ�7q�Db����>~8�]
� ^n׹�[�o���Z-�ǫ�N;U���E4=eȢ�vk��Z�Y�j���k�j1�/eȢK��J�9|�,UX65]W����lQ-�"`�C�.~8ek�{Xy���d��<��Gf�ō�E�Ӗ�T� �g��Y�*��.͊e��"�]�d������h��ڠ����c�qV�ǷN��6�z���kD�6�L;�N\���Y�����
�O�ʨ1*]a�SN�=	fH�JN�9%'�S<C:��:`�s��~��jKEU�#i����$�K�TQD���G0H�=�� �d�-Q�H�4�5��L�r?����}��B+��,Q�yO�H�jD�4d�����0*�]�	~�ӎ�.�"����%
��d$"5zxA:�U��H���H%jس{���kW��)�	8J��v�}�rK�F�@�t)FXu����G'.X�8�KH;���[             [remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://dje8852wumobj"
path="res://.godot/imported/icon.svg-218a8f2b3041327d8a5756f3a245f83b.ctex"
metadata={
"vram_texture": false
}
                RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name    custom_solver_bias    size    script 	   _bundled       PackedScene    res://Character/character.tscn _<����[   PackedScene #   res://Character/bullet/bullet.tscn �����B
   Texture2D    res://icon.svg ��@�Cl      local://RectangleShape2D_q3aiw �         local://PackedScene_ccrrw �         RectangleShape2D       
      C  �B         PackedScene          	         names "         main    Node2D 
   Character 	   position    Bullet    Area2D    scale    disable_mode    metadata/_edit_group_ 	   Sprite2D    texture    CollisionShape2D    shape    	   variants                 
     C  C         
     �C ��C
     �C ��C
   �pA�̌>                     
          ?                node_count             nodes     <   ��������       ����                ���                            ���                                 ����                                      	   	   ����   
                       ����      	      
             conn_count              conns               node_paths              editable_instances              version             RSRC[remap]

path="res://.godot/exported/133200997/export-587cd83b161f236aa1681c703043f642-bullet.scn"
             [remap]

path="res://.godot/exported/133200997/export-a8cf13c19ca9a53941619a83d1bafc3c-character.scn"
          [remap]

path="res://.godot/exported/133200997/export-3070c538c03ee49b7677ff960a3f5195-main.scn"
               list=Array[Dictionary]([])
     <svg height="128" width="128" xmlns="http://www.w3.org/2000/svg"><rect x="2" y="2" width="124" height="124" rx="14" fill="#363d52" stroke="#212532" stroke-width="4"/><g transform="scale(.101) translate(122 122)"><g fill="#fff"><path d="M105 673v33q407 354 814 0v-33z"/><path fill="#478cbf" d="m105 673 152 14q12 1 15 14l4 67 132 10 8-61q2-11 15-15h162q13 4 15 15l8 61 132-10 4-67q3-13 15-14l152-14V427q30-39 56-81-35-59-83-108-43 20-82 47-40-37-88-64 7-51 8-102-59-28-123-42-26 43-46 89-49-7-98 0-20-46-46-89-64 14-123 42 1 51 8 102-48 27-88 64-39-27-82-47-48 49-83 108 26 42 56 81zm0 33v39c0 276 813 276 813 0v-39l-134 12-5 69q-2 10-14 13l-162 11q-12 0-16-11l-10-65H447l-10 65q-4 11-16 11l-162-11q-12-3-14-13l-5-69z"/><path d="M483 600c3 34 55 34 58 0v-86c-3-34-55-34-58 0z"/><circle cx="725" cy="526" r="90"/><circle cx="299" cy="526" r="90"/></g><g fill="#414042"><circle cx="307" cy="532" r="60"/><circle cx="717" cy="532" r="60"/></g></g></svg>
             �����B"   res://Character/bullet/bullet.tscn_<����[   res://Character/character.tscn��@�Cl   res://icon.svg�O�#�   res://main.tscn               ECFG      application/config/name         TDC    application/run/main_scene         res://main.tscn    application/config/features$   "         4.1    Forward Plus       application/config/icon         res://icon.svg     autoload/GunStates$         *res://Scripts/GunStates.gd    input/right�              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   D   	   key_label             unicode    d      echo          script      
   input/left�              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   A   	   key_label             unicode    a      echo          script         input/up�              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   W   	   key_label             unicode    w      echo          script      
   input/down�              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   S   	   key_label             unicode    s      echo          script         input/CheckDB�              events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   C   	   key_label             unicode    c      echo          script            deadzone      ?%   rendering/driver/threads/thread_model           