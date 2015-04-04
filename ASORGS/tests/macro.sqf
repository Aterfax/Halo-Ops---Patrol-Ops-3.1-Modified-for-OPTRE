//can't define defines :(
/*#define hash #

#define MULTICOMBO(VARNAME,FIRSTIDC) \
	hash##define ASORGS_##VARNAME##_combo (FIRSTIDC+1) 
	hash##define ASORGS_##VARNAME##_minus (FIRSTIDC+2) \
	hash##define ASORGS_##VARNAME##_count (FIRSTIDC+3) \
	hash##define ASORGS_##VARNAME##_plus (FIRSTIDC+4) ;
	
	MULTICOMBO(launcherAmmo,420060);
*/

#define ASORGS_Main_Display 418000

#define ASORGS_save_dialog 420999
#define ASORGS_save_listbox 421000
#define ASORGS_save_textbox 421001
#define ASORGS_save_cancel 421002
#define ASORGS_save_save 421003
#define ASORGS_save_delete 421004

#define ASORGS_deleteconfirm_dialog 421999
#define ASORGS_deleteconfirm_text 422001
#define ASORGS_deleteconfirm_cancel 422002
#define ASORGS_deleteconfirm_delete 422003

#define ASORGS_preset_label 419000
#define ASORGS_preset_combo 419001
//new combo boxes
#define ASORGS_primary_label 420000
#define ASORGS_primary_combo 420001

#define ASORGS_primaryAmmo_label 420010
#define ASORGS_primaryAmmo1_combo 420011
#define ASORGS_primaryAmmo1_minus 420012
#define ASORGS_primaryAmmo1_count 420013
#define ASORGS_primaryAmmo1_plus 420014

#define ASORGS_primaryAmmo2_combo 420021
#define ASORGS_primaryAmmo2_minus 420022
#define ASORGS_primaryAmmo2_count 420023
#define ASORGS_primaryAmmo2_plus 420024

#define ASORGS_primaryAmmo3_combo 420031
#define ASORGS_primaryAmmo3_minus 420032
#define ASORGS_primaryAmmo3_count 420033
#define ASORGS_primaryAmmo3_plus 420034

#define ASORGS_primaryAmmo4_combo 420041
#define ASORGS_primaryAmmo4_minus 420042
#define ASORGS_primaryAmmo4_count 420043
#define ASORGS_primaryAmmo4_plus 420044

#define ASORGS_primaryAmmo5_combo 420051
#define ASORGS_primaryAmmo5_minus 420052
#define ASORGS_primaryAmmo5_count 420053
#define ASORGS_primaryAmmo5_plus 420054

#define ASORGS_primaryScope_label 420060
#define ASORGS_primaryScope_combo 420061

#define ASORGS_primaryRail_label 420070
#define ASORGS_primaryRail_combo 420071

#define ASORGS_primarySuppressor_label 420080
#define ASORGS_primarySuppressor_combo 420081

#define ASORGS_launcher_label 420090
#define ASORGS_launcher_combo 420091


#define ASORGS_launcherAmmo_label 420100

#define ASORGS_launcherAmmo1_combo 420101
#define ASORGS_launcherAmmo1_minus 420102
#define ASORGS_launcherAmmo1_count 420103
#define ASORGS_launcherAmmo1_plus 420104

#define ASORGS_launcherAmmo2_combo 420111
#define ASORGS_launcherAmmo2_minus 420112
#define ASORGS_launcherAmmo2_count 420113
#define ASORGS_launcherAmmo2_plus 420114
#define ASORGS_launcherAmmo3_combo 420121
#define ASORGS_launcherAmmo3_minus 420122
#define ASORGS_launcherAmmo3_count 420123
#define ASORGS_launcherAmmo3_plus 420124
#define ASORGS_launcherAmmo4_combo 420131
#define ASORGS_launcherAmmo4_minus 420132
#define ASORGS_launcherAmmo4_count 420133
#define ASORGS_launcherAmmo4_plus 420134
#define ASORGS_launcherAmmo5_combo 420141
#define ASORGS_launcherAmmo5_minus 420142
#define ASORGS_launcherAmmo5_count 420143
#define ASORGS_launcherAmmo5_plus 420144

#define ASORGS_launcherScope_label 420150
#define ASORGS_launcherScope_combo 420151

#define ASORGS_handgun_label 420160
#define ASORGS_handgun_combo 420161

#define ASORGS_handgunAmmo_label 420170
#define ASORGS_handgunAmmo1_combo 420171
#define ASORGS_handgunAmmo1_minus 420172
#define ASORGS_handgunAmmo1_count 420173
#define ASORGS_handgunAmmo1_plus 420174
#define ASORGS_handgunAmmo2_combo 420181
#define ASORGS_handgunAmmo2_minus 420182
#define ASORGS_handgunAmmo2_count 420183
#define ASORGS_handgunAmmo2_plus 420184
#define ASORGS_handgunAmmo3_combo 420191
#define ASORGS_handgunAmmo3_minus 420192
#define ASORGS_handgunAmmo3_count 420193
#define ASORGS_handgunAmmo3_plus 420194
#define ASORGS_handgunAmmo4_combo 420201
#define ASORGS_handgunAmmo4_minus 420202
#define ASORGS_handgunAmmo4_count 420203
#define ASORGS_handgunAmmo4_plus 420204
#define ASORGS_handgunAmmo5_combo 420211
#define ASORGS_handgunAmmo5_minus 420212
#define ASORGS_handgunAmmo5_count 420213
#define ASORGS_handgunAmmo5_plus 420214

#define ASORGS_handgunScope_label 420220
#define ASORGS_handgunScope_combo 420221

#define ASORGS_handgunSuppressor_label 420230
#define ASORGS_handgunSuppressor_combo 420231

#define ASORGS_uniform_label 420240
#define ASORGS_uniform_combo 420241

#define ASORGS_headgear_label 420250
#define ASORGS_headgear_combo 420251

#define ASORGS_vest_label 420260
#define ASORGS_vest_combo 420261

#define ASORGS_backpack_label 420270
#define ASORGS_backpack_combo 420271

#define ASORGS_goggles_label 422000
#define ASORGS_goggles_combo 422001

#define ASORGS_nightvision_label 422010
#define ASORGS_nightvision_combo 422011

#define ASORGS_binoculars_label 422020
#define ASORGS_binoculars_combo 422021

#define ASORGS_grenade_label 420300
#define ASORGS_grenade1_combo 420301
#define ASORGS_grenade1_minus 420302
#define ASORGS_grenade1_count 420303
#define ASORGS_grenade1_plus 420304

#define ASORGS_grenade2_combo 420311
#define ASORGS_grenade2_minus 420312
#define ASORGS_grenade2_count 420313
#define ASORGS_grenade2_plus 420314

#define ASORGS_grenade3_combo 420321
#define ASORGS_grenade3_minus 420322
#define ASORGS_grenade3_count 420323
#define ASORGS_grenade3_plus 420324

#define ASORGS_grenade4_combo 420331
#define ASORGS_grenade4_minus 420332
#define ASORGS_grenade4_count 420333
#define ASORGS_grenade4_plus 420334

#define ASORGS_grenade5_combo 420341
#define ASORGS_grenade5_minus 420342
#define ASORGS_grenade5_count 420343
#define ASORGS_grenade5_plus 420344

#define ASORGS_explosives_label 420350
#define ASORGS_explosives1_combo 420351
#define ASORGS_explosives1_minus 420352
#define ASORGS_explosives1_count 420353
#define ASORGS_explosives1_plus 420354

#define ASORGS_explosives2_combo 420361
#define ASORGS_explosives2_minus 420362
#define ASORGS_explosives2_count 420363
#define ASORGS_explosives2_plus 420364

#define ASORGS_explosives3_combo 420371
#define ASORGS_explosives3_minus 420372
#define ASORGS_explosives3_count 420373
#define ASORGS_explosives3_plus 420374

#define ASORGS_explosives4_combo 420381
#define ASORGS_explosives4_minus 420382
#define ASORGS_explosives4_count 420383
#define ASORGS_explosives4_plus 420384

#define ASORGS_explosives5_combo 420391
#define ASORGS_explosives5_minus 420392
#define ASORGS_explosives5_count 420393
#define ASORGS_explosives5_plus 420394

#define ASORGS_medical_label 420400
#define ASORGS_medical1_combo 420401
#define ASORGS_medical1_minus 420402
#define ASORGS_medical1_count 420403
#define ASORGS_medical1_plus 420404

#define ASORGS_medical2_combo 420411
#define ASORGS_medical2_minus 420412
#define ASORGS_medical2_count 420413
#define ASORGS_medical2_plus 420414

#define ASORGS_medical3_combo 420421
#define ASORGS_medical3_minus 420422
#define ASORGS_medical3_count 420423
#define ASORGS_medical3_plus 420424

#define ASORGS_medical4_combo 420431
#define ASORGS_medical4_minus 420432
#define ASORGS_medical4_count 420433
#define ASORGS_medical4_plus 420434

#define ASORGS_medical5_combo 420441
#define ASORGS_medical5_minus 420442
#define ASORGS_medical5_count 420443
#define ASORGS_medical5_plus 420444

#define ASORGS_medical6_combo 420451
#define ASORGS_medical6_minus 420452
#define ASORGS_medical6_count 420453
#define ASORGS_medical6_plus 420454

#define ASORGS_medical7_combo 420461
#define ASORGS_medical7_minus 420462
#define ASORGS_medical7_count 420463
#define ASORGS_medical7_plus 420464

#define ASORGS_medical8_combo 420471
#define ASORGS_medical8_minus 420472
#define ASORGS_medical8_count 420473
#define ASORGS_medical8_plus 420474

#define ASORGS_medical9_combo 420481
#define ASORGS_medical9_minus 420482
#define ASORGS_medical9_count 420483
#define ASORGS_medical9_plus 420484

#define ASORGS_medical10_combo 420491
#define ASORGS_medical10_minus 420492
#define ASORGS_medical10_count 420493
#define ASORGS_medical10_plus 420494

#define ASORGS_medical11_combo 420501
#define ASORGS_medical11_minus 420502
#define ASORGS_medical11_count 420503
#define ASORGS_medical11_plus 420504

#define ASORGS_medical12_combo 420511
#define ASORGS_medical12_minus 420512
#define ASORGS_medical12_count 420513
#define ASORGS_medical12_plus 420514

#define ASORGS_medical13_combo 420521
#define ASORGS_medical13_minus 420522
#define ASORGS_medical13_count 420523
#define ASORGS_medical13_plus 420524

#define ASORGS_medical14_combo 420531
#define ASORGS_medical14_minus 420532
#define ASORGS_medical14_count 420533
#define ASORGS_medical14_plus 420534

#define ASORGS_medical15_combo 420541
#define ASORGS_medical15_minus 420542
#define ASORGS_medical15_count 420543
#define ASORGS_medical15_plus 420544

#define ASORGS_medical16_combo 420551
#define ASORGS_medical16_minus 420552
#define ASORGS_medical16_count 420553
#define ASORGS_medical16_plus 420554

#define ASORGS_medical17_combo 420561
#define ASORGS_medical17_minus 420562
#define ASORGS_medical17_count 420563
#define ASORGS_medical17_plus 420564

#define ASORGS_medical18_combo 420571
#define ASORGS_medical18_minus 420572
#define ASORGS_medical18_count 420573
#define ASORGS_medical18_plus 420574

#define ASORGS_medical19_combo 420681
#define ASORGS_medical19_minus 420682
#define ASORGS_medical19_count 420683
#define ASORGS_medical19_plus 420684

#define ASORGS_medical20_combo 420791
#define ASORGS_medical20_minus 420792
#define ASORGS_medical20_count 420793
#define ASORGS_medical20_plus 420794

#define ASORGS_misc_label 420600
#define ASORGS_misc1_combo 420601
#define ASORGS_misc1_minus 420602
#define ASORGS_misc1_count 420603
#define ASORGS_misc1_plus 420604

#define ASORGS_misc2_combo 420611
#define ASORGS_misc2_minus 420612
#define ASORGS_misc2_count 420613
#define ASORGS_misc2_plus 420614

#define ASORGS_misc3_combo 420621
#define ASORGS_misc3_minus 420622
#define ASORGS_misc3_count 420623
#define ASORGS_misc3_plus 420624

#define ASORGS_misc4_combo 420631
#define ASORGS_misc4_minus 420632
#define ASORGS_misc4_count 420633
#define ASORGS_misc4_plus 420634

#define ASORGS_misc5_combo 420641
#define ASORGS_misc5_minus 420642
#define ASORGS_misc5_count 420643
#define ASORGS_misc5_plus 420644

#define ASORGS_extraammo_label 420650
#define ASORGS_extraammo1_combo 420651
#define ASORGS_extraammo1_minus 420652
#define ASORGS_extraammo1_count 420653
#define ASORGS_extraammo1_plus 420654

#define ASORGS_extraammo2_combo 420661
#define ASORGS_extraammo2_minus 420662
#define ASORGS_extraammo2_count 420663
#define ASORGS_extraammo2_plus 420664

#define ASORGS_extraammo3_combo 420671
#define ASORGS_extraammo3_minus 420672
#define ASORGS_extraammo3_count 420673
#define ASORGS_extraammo3_plus 420674

#define ASORGS_extraammo4_combo 420681
#define ASORGS_extraammo4_minus 420682
#define ASORGS_extraammo4_count 420683
#define ASORGS_extraammo4_plus 420684

#define ASORGS_extraammo5_combo 420691
#define ASORGS_extraammo5_minus 420692
#define ASORGS_extraammo5_count 420693
#define ASORGS_extraammo5_plus 420694

#define ASORGS_extraattach_label 420700
#define ASORGS_extraattach1_combo 420701
#define ASORGS_extraattach2_combo 420711
#define ASORGS_extraattach3_combo 420721
#define ASORGS_extraattach4_combo 420731
#define ASORGS_extraattach5_combo 420741

#define ASORGS_insignia_label 420750
#define ASORGS_insignia_combo 420751


#define DB_Rifles 0
#define DB_Launchers 1
#define DB_Handguns 2
#define DB_Weapons 3
#define DB_Items 4
#define DB_Misc 4
#define DB_Binoculars 5
#define DB_Suppressors 6
#define DB_Scopes 7
#define DB_Rail 8
#define DB_Headgear 9
#define DB_Uniforms 10
#define DB_Vests 11
#define DB_Magazines 12
#define DB_Throwable 13
#define DB_Explosives 14
#define DB_Backpacks 15
#define DB_Medical 16
#define DB_Goggles 17
#define DB_NightVision 18
#define DB_Attachments 19
#define DB_Insignia 20

#define DBF_DB 0
#define DBF_Class 1
#define DBF_ClassName 1
#define DBF_Name 2
#define DBF_Picture 3
#define DBF_Magazines 4
#define DBF_Index 5
#define DBF_Side 6
#define DBF_Scopes 6
#define DBF_Rail 7
#define DBF_Suppressors 8
#define DBF_Capacity  4
#define DBF_Mass 6

//["",_primary,_launcher,_handgun,_magazines,_uniform,_vest,_backpack,_items,_primitems,_secitems,_handgunitems,_uitems,_vitems,_bitems, _insignia]
#define GSVI_Name 0
#define GSVI_Primary 1
#define GSVI_Launcher 2
#define GSVI_Secondary 2
#define GSVI_Handgun 3
#define GSVI_Magazines 4
#define GSVI_Uniform 5
#define GSVI_Vest 6
#define GSVI_Backpack 7
#define GSVI_Items 8
#define GSVI_PrimaryItems 9
#define GSVI_SecondaryItems 10
#define GSVI_LauncherItems 10
#define GSVI_HandgunItems 11
#define GSVI_UniformItems 12
#define GSVI_VestItems 13
#define GSVI_BackpackItems 14
#define GSVI_Insignia 15

#define IT_HANDGUN 2
#define IT_SCOPED 0
#define IT_RIFLE  1
#define IT_LAUNCHER 4
#define IT_BINOCULAR 4096
#define IT_ITEM 131072


#define IIT_SUPPRESSOR 101
#define IIT_SCOPE 201
#define IIT_RAIL 301
#define IIT_HEADGEAR 605
#define IIT_UNIFORM 801
#define IIT_VEST 701
#define IIT_NIGHTVISION 616

#define ASORGS_capacityUniform 426000
#define ASORGS_capacityVest 426001
#define ASORGS_capacityBackpack 426002

#define ASORGS_capacityUniformTT 426003
#define ASORGS_capacityVestTT 426004
#define ASORGS_capacityBackpackTT 426005

#define ASORGS_weaponsBorder 400000
#define ASORGS_uniformBorder 400001
#define ASORGS_miscBorder 400002
#define ASORGS_presetBorder 399999
//Control Macros
#define ASORGS_getControl(disp,ctrl) ((findDisplay ##disp) displayCtrl ##ctrl)
#define ASORGS_getSelData(ctrl) (lbData[##ctrl,(lbCurSel ##ctrl)])