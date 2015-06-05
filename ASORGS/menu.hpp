#include "common.hpp"
#define CATEGORY_SPACING  .01
#define ITEM_SPACING .005
#define ITEM_HEIGHT (1/25)
#define ITEM_WIDTH (ITEM_HEIGHT*(3/4))
#define DIALOG_MARGIN .01
#define LABEL_WIDTH .21
#define TOTAL_WIDTH (safezoneW * 0.34)
#define TOP_SPACING .005
#define TOP (safezoneY + TOP_SPACING)
#define TEXT_SIZE .04
#define FULLCOMBO_WIDTH (TOTAL_WIDTH - (DIALOG_MARGIN * 2) - LABEL_WIDTH)
#define SAVE_LIST_HEIGHT (TOTAL_HEIGHT - (ITEM_HEIGHT*7 - CATEGORY_SPACING*4))
#define TOTAL_HEIGHT safezoneH


#define BOX_COMBO_WIDTH ((FULLCOMBO_WIDTH/5) - (ITEM_SPACING * 4))
#define BOX_COMBO_HEIGHT ((BOX_COMBO_WIDTH *0.86)*(4/3))
#define BOX_SPACING ((FULLCOMBO_WIDTH - BOX_COMBO_WIDTH*5) / 4)
#define MULTI_COMBO_WIDTH (TOTAL_WIDTH - DIALOG_MARGIN - (CATEGORY_SPACING*5) - LABEL_WIDTH - ITEM_WIDTH*3)
#define SAVE_WIDTH (TOTAL_WIDTH - DIALOG_MARGIN - CATEGORY_SPACING*2 - LABEL_WIDTH - MULTI_COMBO_WIDTH)
#define LEFT_START (safezoneX)

/*	class primaryWeaponAmmoCombo : ASORGS_AmmoCombo 
	{
		idc= 420011;
		y = safezoneY + (ITEM_HEIGHT + ITEM_SPACING) * 2;
	};
	class primaryWeaponAmmoMinus : ASORGS_MinusButton 
	{
		idc= 420012;
		y = safezoneY + (ITEM_HEIGHT + ITEM_SPACING) * 2;
	};
	class primaryWeaponAmmoCount : ASORGS_CountText 
	{
		idc= 420013;
		y = safezoneY + (ITEM_HEIGHT + ITEM_SPACING) * 2;
	};
	class primaryWeaponAmmoPlus : ASORGS_PlusButton
	{
		idc= 420014;
		y = safezoneY + (ITEM_HEIGHT + ITEM_SPACING) * 2;
	};*/
#define MULTICOMBO(NAME,FIRSTIDC,YPOS) \
class NAME##Combo : ASORGS_AmmoCombo { \
	idc= FIRSTIDC; \
	y = YPOS; }; \
class NAME##Minus : ASORGS_MinusButton { \
	idc= FIRSTIDC+1; \
	y = YPOS; };\
class NAME##Count : ASORGS_CountText { \
	idc= FIRSTIDC+2; \
	y = YPOS; };\
class NAME##CountTextBoxBG : ASORGS_CountTextBoxBG { \
	idc= FIRSTIDC+4; \
	y = -1000; \
};\
class NAME##CountTextBox : ASORGS_CountTextBox { \
	idc= FIRSTIDC+5; \
	y = -1000; \
	onLoad = "(this select 0) ctrlShow false; (this select 0) ctrlEnable false"; \
	onKillFocus = "_this spawn ASORGS_fnc_numberDeselected;";\
	onChar = "_this spawn ASORGS_fnc_numberCharEntered";\
};\
class NAME##Plus : ASORGS_PlusButton { \
	idc= FIRSTIDC+3; \
	y = YPOS; };
	
#define SINGLECOMBO(NAME,FIRSTIDC,YPOS) \
class NAME##Combo : ASORGS_FullCombo \
{ \
	idc= FIRSTIDC;\
	y = YPOS;	\
}; 
#define LABEL(NAME, FIRSTIDC, YPOS, TEXT) \
	class NAME##Text : ASORGS_FieldLabel \
	{ \
		idc= FIRSTIDC; \
		text=TEXT; \
		y = YPOS; \
	}; 
#define HEADING(NAME, FIRSTIDC, YPOS, TEXT) \
	class NAME##Text : ASORGS_FieldLabelHeading \
	{ \
		idc= FIRSTIDC; \
		text=TEXT; \
		y = YPOS; \
	}; 	
#define false 0
#define true 1
class ASORGS_FieldLabel : ASORGS_RscText
{
	style = 0x01;//ST_RIGHT
	x = LEFT_START + DIALOG_MARGIN;
	h = ITEM_HEIGHT;
	w = LABEL_WIDTH - DIALOG_MARGIN;
	sizeEx = TEXT_SIZE;
};
class ASORGS_FieldLabelHeading : ASORGS_FieldLabel
{
	font = "PuristaSemiBold";
};
class ASORGS_FullCombo : ASORGS_RscCombo
{
	x = LEFT_START + DIALOG_MARGIN + LABEL_WIDTH;
	w = FULLCOMBO_WIDTH;
	h = ITEM_HEIGHT;
	soundExpand[] = {"", 0.0, 1};
	soundCollapse[] = {"", 0.0, 1};
	//need to work out wtf this does
	maxHistoryDelay = 1000;
	autoScrollSpeed = 1000;
	onLBSelChanged = "_this spawn ASORGS_fnc_selectionChanged";
	sizeEx = TEXT_SIZE;
	colorFrame[] = {1,1,1,1};
	colorBox[] = {1,1,1,1};
	colorBorder[] = {1,1,1,1};
	colorPicture[] = {1,1,1,1};
	colorPictureRight[] = {1,1,1,1};
	colorPictureDisabled[] = {1,1,1,1};
	colorPictudeDisabled[] = {1,1,1,1};
	colorPictureSelected[] = {1,1,1,1};
	//style=ST_FRAME;
	colorBackground[] = {.3, .3, .3, 1};
	style=ST_MULTI + ST_SHADOW + ST_KEEP_ASPECT_RATIO + ST_FRAME;
};
class ASORGS_BoxCombo : ASORGS_RscCombo
{
	x = LEFT_START + DIALOG_MARGIN + LABEL_WIDTH;
	soundExpand[] = {"", 0.0, 1};
	soundCollapse[] = {"", 0.0, 1};
	//need to work out wtf this does
	maxHistoryDelay = 1000;
	autoScrollSpeed = 1000;
	onLBSelChanged = "_this spawn ASORGS_fnc_selectionChanged";
	colorFrame[] = {1,1,1,1};
	colorBox[] = {1,1,1,1};
	colorBorder[] = {1,1,1,1};
	colorPicture[] = {1,1,1,1};
	colorPictureDisabled[] = {1,1,1,1};
	colorPictudeDisabled[] = {1,1,1,1};
	colorPictureSelected[] = {1,1,1,1};
	//style=ST_FRAME;
	arrowEmpty="#(argb,8,8,3)color(0,0,0,0)";
	arrowFull="#(argb,8,8,3)color(0,0,0,0)";
	colorBackground[] = {.3, .3, .3, 1};
	w=BOX_COMBO_WIDTH;
	h=BOX_COMBO_HEIGHT;
	style=ST_PICTURE;
};
class ASORGS_AmmoCombo : ASORGS_FullCombo
{
	w = MULTI_COMBO_WIDTH;
	sizeEx = TEXT_SIZE;
};

class ASORGS_MinusButton :ASORGS_RscShortcutButton
{
	x = LEFT_START + (TOTAL_WIDTH - DIALOG_MARGIN - CATEGORY_SPACING*3 - ITEM_WIDTH*3);

	//text= "ASORGS\images\minus_ca.paa";
	textureNoShortcut =  "ASORGS\images\minus_ca.paa";
	onButtonClick = "_this spawn ASORGS_fnc_PressMinus; false";
	sizeEx = TEXT_SIZE;
	/*animTextureDefault = "ASORGS\images\minus_ca.paa";
	animTextureNormal = "ASORGS\images\minus_ca.paa";
	animTextureDisabled = "ASORGS\images\minus_ca.paa";
	animTextureOver =  "ASORGS\images\minus_ca.paa";
	animTextureFocused = "ASORGS\images\minus_ca.paa";
	animTexturePressed =  "ASORGS\images\minus_ca.paa";*/
	w = ITEM_WIDTH;//1/30;
	type = CT_SHORTCUTBUTTON;
	h = ITEM_HEIGHT;
	style = ST_KEEP_ASPECT_RATIO;
	class ShortcutPos{
		left=0;
		top=0;
		w=ITEM_WIDTH;
		h=ITEM_HEIGHT;
	};
	#define ANIMTEXTURECOLOR "#(rgb,8,8,3)color(0.15,0.15,0.15,1)"
	colorBackground[] = {1,1,1,1};
	animTextureDefault = ANIMTEXTURECOLOR;
	animTextureNormal = ANIMTEXTURECOLOR;
	animTextureDisabled =   "#(rgb,8,8,3)color(0.05,0.05,0.05,1)";
	animTextureOver =  "#(rgb,8,8,3)color(1,1,1,1)";
	animTextureFocused =  "#(rgb,8,8,3)color(1,1,1,1)";
	animTexturePressed =  "#(rgb,8,8,3)color(1,1,1,1)";
	color2[]={0,0,0,1};
	color[]={0,1,1,1};
	colorFocused[]={0,1,1,1};
	/* default A3
	animTextureDefault = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\normal_ca.paa";
	animTextureNormal = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\normal_ca.paa";
	animTextureDisabled = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\normal_ca.paa";
	animTextureOver = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\over_ca.paa";
	animTextureFocused = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\focus_ca.paa";
	animTexturePressed = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\down_ca.paa";
	*/
};
class ASORGS_CountText : ASORGS_RscButton
{
	text="20";
	style = ST_CENTER;
	w = ITEM_WIDTH + CATEGORY_SPACING*3;
	h = ITEM_HEIGHT;
	x = LEFT_START + (TOTAL_WIDTH - DIALOG_MARGIN - ITEM_HEIGHT*2 - CATEGORY_SPACING);
	onSetFocus = "_this spawn ASORGS_fnc_numberSelected;";
	sizeEx = TEXT_SIZE;
	colorBackground[] = {0.3, 0.3, 0.3, 1};
};
class ASORGS_CountTextBoxBG : ASORGS_RscText
{
	//type=CT_STATIC;
	//style = 0;

	text="";
	w = ITEM_HEIGHT;
	h = ITEM_HEIGHT;
	x = LEFT_START + (TOTAL_WIDTH - DIALOG_MARGIN - ITEM_HEIGHT*2);
	colorBackground[] = {1,1,1,1};
	colorText[] = {0,1,0,1};
	colorDisabled[] = {1,1,1,1};
	 colorBackgroundDisabled[] = { 1, 1, 1, 1 };   // background color for disabled state
  	colorBackgroundActive[] = { 1, 1, 1, 1 };   // background color for active state
	color[] = {1,1,0,1};
	colorBorder[] = {0,0,1,1}; // grey
	colorFrame[] = {1,0,0,1}; 
	colorBackground2[] = {0,1,0,1};
	visible = false;
	autocomplete = false;
	colorSelection[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 1};
	class Attributes
	{
		shadow = "false";
	};
};
class ASORGS_CountTextBox : ASORGS_RscEdit
{
	text="20";
	w = ITEM_HEIGHT;
	h = ITEM_HEIGHT;
	x = LEFT_START + (TOTAL_WIDTH - DIALOG_MARGIN - ITEM_HEIGHT*2);
	colorBackground[] = {1,1,1,1};
	colorText[] = {0,0,0,1};
	colorDisabled[] = {1,1,1,1};
		colorBorder[] = {0,0,0,1};
			colorFrame[] = {0,0,0,1}; 
	  colorShadow[] = {0.5,0.5,0.5,1}; // darkgrey
	 colorBackgroundDisabled[] = { 1, 1, 1, 1 };   // background color for disabled state
  	colorBackgroundActive[] = { 1, 1, 1, 1 };   // background color for active state
	color[] = {1,1,1,1};
	style = ST_FRAME + ST_CENTER;
	autocomplete = false;
	visible = false;
	colorSelection[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 1};
	sizeEx = TEXT_SIZE;
};
class ASORGS_PlusButton :ASORGS_MinusButton
{
	textureNoShortcut =  "ASORGS\images\plus_ca.paa";
	x = LEFT_START + (TOTAL_WIDTH - ITEM_HEIGHT*(3/4)) - DIALOG_MARGIN;
	onButtonClick = "_this spawn ASORGS_fnc_PressPlus; false";
};
class ASORGS_Main_Dialog {
	idd = 418000;
	name= "ASORGS_Main_Dialog";
	movingEnable = 1;
	enableSimulation = true;
	onLoad = "ASORGS_Open = true; [] spawn ASORGS_fnc_ReloadMainDialog; ";
	onUnload = "ASORGS_Open = false; [] spawn ASORGS_fnc_Closed; ";
	onMouseMoving = "_this spawn ASORGS_fnc_RotateClone";
	class controlsBackground {
		#define PRESET_SIZE ((CATEGORY_SPACING) + TOP_SPACING + ITEM_HEIGHT)
		#define WEAPONS_SIZE ((CATEGORY_SPACING * 7) + (ITEM_HEIGHT + ITEM_SPACING)*8)
		#define UNIFORM_SIZE ((CATEGORY_SPACING * 1) + (ITEM_HEIGHT + ITEM_SPACING)*8)
		#define MISC_SIZE ((CATEGORY_SPACING * 2) + (ITEM_HEIGHT + ITEM_SPACING)*2)
		#define EQUIPPED_SIZE ((CATEGORY_SPACING * 1) + (BOX_COMBO_HEIGHT + ITEM_SPACING))
		class PresetBorder:ASORGS_RscText {
			colorBackground[] = {0, 0, 0, 0};
			colorFrame[] = {1,1,1,1};
			colorBox[] = {1,1,1,1};
			colorBorder[] = {1,1,1,1};
			style=ST_FRAME;
			idc = 399999;
			x = LEFT_START;
			y = safezoneY;
			w = TOTAL_WIDTH;
			h = PRESET_SIZE;
		};
		class WeaponsBorder:PresetBorder {
			idc = 400000;
			y = safezoneY + PRESET_SIZE;
			h = WEAPONS_SIZE;
		};
		class UniformBorder:PresetBorder {
			idc = 400001;
			y = safezoneY + PRESET_SIZE + WEAPONS_SIZE;
			h = UNIFORM_SIZE;
		};
		class MiscBorder:PresetBorder {
			idc = 400002;
			y = safezoneY + PRESET_SIZE + WEAPONS_SIZE + UNIFORM_SIZE;
			h = MISC_SIZE; 
		};
		class EquippedBorder:PresetBorder {
			idc = 400003;
			y = safezoneY + PRESET_SIZE + WEAPONS_SIZE + UNIFORM_SIZE + MISC_SIZE;
			h = EQUIPPED_SIZE; 
		};
	};
	
	class controls {

		HEADING(preset, 419000, TOP + (ITEM_HEIGHT*0), "Preset");
		class presetCombo : ASORGS_FullCombo 
		{
			idc= 419001;
			y = TOP + (ITEM_HEIGHT*0) ;
			w = TOTAL_WIDTH - (SAVE_WIDTH) - LABEL_WIDTH - (DIALOG_MARGIN*3) ;
		};
		class presetSave : ASORGS_RscShortcutButton {
			idc= 419002;
			text = "SAVE";
			h = ITEM_HEIGHT;
			w = SAVE_WIDTH;
			x = LEFT_START + TOTAL_WIDTH - (SAVE_WIDTH) - (DIALOG_MARGIN);
			y = TOP + (ITEM_HEIGHT*0) ; 
			onButtonClick = "createDialog ""ASORGS_SaveDialog"";";
			colorBackground[] = {1, 1, 1, 1};
			animTextureDefault = ANIMTEXTURECOLOR;
			animTextureNormal = ANIMTEXTURECOLOR;
			animTextureDisabled =   "#(rgb,8,8,3)color(0.05,0.05,0.05,1)";
			animTextureOver =  "#(rgb,8,8,3)color(1,1,1,1)";
			animTextureFocused =  "#(rgb,8,8,3)color(1,1,1,1)";
			animTexturePressed =  "#(rgb,8,8,3)color(1,1,1,1)";
			class ShortcutPos{
				left=0;
				top=0;
				w=SAVE_WIDTH;
				h=ITEM_HEIGHT;
			};
			class TextPos{
				left="(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1) * (3/4)";
				top=0;
				right=0.005;
				bottom=0;
			};
		};
		
		HEADING(primaryWeapon, 420000, TOP + CATEGORY_SPACING + ITEM_HEIGHT + ITEM_SPACING, "Main Weapon" );
		SINGLECOMBO(primaryWeapon, 420001, TOP + CATEGORY_SPACING + ITEM_HEIGHT + ITEM_SPACING);
		LABEL(primaryWeaponAmmo, 420010, TOP +  CATEGORY_SPACING + (ITEM_HEIGHT + ITEM_SPACING)*2, "Magazines" );
		MULTICOMBO(primaryWeaponAmmo1, 420011, TOP + CATEGORY_SPACING + (ITEM_HEIGHT + ITEM_SPACING) * 2);
		MULTICOMBO(primaryWeaponAmmo2, 420021, TOP + CATEGORY_SPACING + (ITEM_HEIGHT + ITEM_SPACING) * 2);
		MULTICOMBO(primaryWeaponAmmo3, 420031, TOP + CATEGORY_SPACING + (ITEM_HEIGHT + ITEM_SPACING) * 2);
		MULTICOMBO(primaryWeaponAmmo4, 420041, TOP + CATEGORY_SPACING +  (ITEM_HEIGHT + ITEM_SPACING) * 2);
		MULTICOMBO(primaryWeaponAmmo5, 420051, TOP + CATEGORY_SPACING + (ITEM_HEIGHT + ITEM_SPACING) * 2);
		LABEL(primaryWeaponScope, 420060, TOP + CATEGORY_SPACING + (ITEM_HEIGHT + ITEM_SPACING)*2, "Scope");
		SINGLECOMBO(primaryWeaponScope, 420061, TOP + CATEGORY_SPACING + (ITEM_HEIGHT+ ITEM_SPACING)*2 );
		LABEL(primaryWeaponRail, 420070,  TOP + CATEGORY_SPACING + (ITEM_HEIGHT + ITEM_SPACING)*2, "Rail");
		SINGLECOMBO(primaryWeaponRail, 420071,   TOP + CATEGORY_SPACING + (ITEM_HEIGHT+ ITEM_SPACING)*2 );
		LABEL(primaryWeaponSuppressor, 420080,  TOP + CATEGORY_SPACING + (ITEM_HEIGHT + ITEM_SPACING)*2, "Suppressor");
		SINGLECOMBO(primaryWeaponSuppressor, 420081,  TOP + CATEGORY_SPACING + (ITEM_HEIGHT + ITEM_SPACING)*2);
		LABEL(primaryWeaponBipod, 428000,  TOP + CATEGORY_SPACING + (ITEM_HEIGHT + ITEM_SPACING)*2, "Bipod");
		SINGLECOMBO(primaryWeaponBipod, 428001,  TOP + CATEGORY_SPACING + (ITEM_HEIGHT + ITEM_SPACING)*2);
		
		HEADING(launcher, 420090, TOP + (CATEGORY_SPACING * 2) + (ITEM_HEIGHT + ITEM_SPACING)*3, "Launcher");
		SINGLECOMBO(launcher, 420091, TOP + (CATEGORY_SPACING * 2) + (ITEM_HEIGHT + ITEM_SPACING)*3);
		LABEL(launcherAmmo, 420100,  TOP + (CATEGORY_SPACING * 2) + (ITEM_HEIGHT + ITEM_SPACING)*3, "Ammo")
		MULTICOMBO(launcherAmmo1, 420101,  TOP + (CATEGORY_SPACING * 2) + (ITEM_HEIGHT + ITEM_SPACING)*3);
		MULTICOMBO(launcherAmmo2, 420111,  TOP + (CATEGORY_SPACING * 2) + (ITEM_HEIGHT + ITEM_SPACING)*3);
		MULTICOMBO(launcherAmmo3, 420121,  TOP + (CATEGORY_SPACING * 2) + (ITEM_HEIGHT + ITEM_SPACING)*3);
		MULTICOMBO(launcherAmmo4, 420131,  TOP + (CATEGORY_SPACING * 2) + (ITEM_HEIGHT + ITEM_SPACING)*3);
		MULTICOMBO(launcherAmmo5, 420141,  TOP + (CATEGORY_SPACING * 2) + (ITEM_HEIGHT + ITEM_SPACING)*3);
		LABEL(launcherScope, 420150, TOP + (CATEGORY_SPACING * 2) + (ITEM_HEIGHT + ITEM_SPACING)*3, "Scope");
		SINGLECOMBO(launcherScope, 420151, TOP + (CATEGORY_SPACING * 2) + (ITEM_HEIGHT + ITEM_SPACING)*3);
		
		HEADING(handgun, 420160,  TOP + (CATEGORY_SPACING * 3) + (ITEM_HEIGHT + ITEM_SPACING)*4, "Handgun");
		SINGLECOMBO(handgun, 420161, TOP + (CATEGORY_SPACING * 3) + (ITEM_HEIGHT + ITEM_SPACING)*4);
		LABEL(handgunAmmo, 420170, TOP + (CATEGORY_SPACING * 3) + (ITEM_HEIGHT + ITEM_SPACING)*4, "Magazines");
		MULTICOMBO(handgunAmmo1, 420171,  TOP + (CATEGORY_SPACING * 3) + (ITEM_HEIGHT + ITEM_SPACING)*4);
		MULTICOMBO(handgunAmmo2, 420181,  TOP + (CATEGORY_SPACING * 3) + (ITEM_HEIGHT + ITEM_SPACING)*4);
		MULTICOMBO(handgunAmmo3, 420191,  TOP + (CATEGORY_SPACING * 3) + (ITEM_HEIGHT + ITEM_SPACING)*4);
		MULTICOMBO(handgunAmmo4, 420201,  TOP + (CATEGORY_SPACING * 3) + (ITEM_HEIGHT + ITEM_SPACING)*4);
		MULTICOMBO(handgunAmmo5, 420211,  TOP + (CATEGORY_SPACING * 3) + (ITEM_HEIGHT + ITEM_SPACING)*4);
		LABEL(handgunScope, 420220, TOP + (CATEGORY_SPACING * 3) + (ITEM_HEIGHT + ITEM_SPACING)*4, "Scope");
		SINGLECOMBO(handgunScope, 420221, TOP + (CATEGORY_SPACING * 3) + (ITEM_HEIGHT + ITEM_SPACING)*4);
		LABEL(handgunSuppressor, 420230, TOP + (CATEGORY_SPACING * 3) + (ITEM_HEIGHT + ITEM_SPACING)*4, "Suppressor");
		SINGLECOMBO(handgunSuppressor, 420231, TOP + (CATEGORY_SPACING * 3) + (ITEM_HEIGHT + ITEM_SPACING)*4);
		LABEL(handgunBipod, 428010,  TOP + CATEGORY_SPACING + (ITEM_HEIGHT + ITEM_SPACING)*2, "Bipod");
		SINGLECOMBO(handgunBipod, 428011,  TOP + CATEGORY_SPACING + (ITEM_HEIGHT + ITEM_SPACING)*2);
		
		
		HEADING(grenade, 420300, TOP + (CATEGORY_SPACING * 4) + (ITEM_HEIGHT + ITEM_SPACING)*5, "Grenades");
		MULTICOMBO(grenade1, 420301, TOP + (CATEGORY_SPACING * 4) + (ITEM_HEIGHT + ITEM_SPACING)*5);
		MULTICOMBO(grenade2, 420311, TOP + (CATEGORY_SPACING * 4) + (ITEM_HEIGHT + ITEM_SPACING)*5);
		MULTICOMBO(grenade3, 420321, TOP + (CATEGORY_SPACING * 4) + (ITEM_HEIGHT + ITEM_SPACING)*5);
		MULTICOMBO(grenade4, 420331, TOP + (CATEGORY_SPACING * 4) + (ITEM_HEIGHT + ITEM_SPACING)*5);
		MULTICOMBO(grenade5, 420341, TOP + (CATEGORY_SPACING * 4) + (ITEM_HEIGHT + ITEM_SPACING)*5);
		
		HEADING(explosives, 420350, TOP + (CATEGORY_SPACING * 5) + (ITEM_HEIGHT + ITEM_SPACING)*6, "Explosives"); 
		MULTICOMBO(explosives1, 420351, TOP + (CATEGORY_SPACING * 5) + (ITEM_HEIGHT + ITEM_SPACING)*6); 
		MULTICOMBO(explosives2, 420361, TOP + (CATEGORY_SPACING * 5) + (ITEM_HEIGHT + ITEM_SPACING)*6); 
		MULTICOMBO(explosives3, 420371, TOP + (CATEGORY_SPACING * 5) + (ITEM_HEIGHT + ITEM_SPACING)*6); 
		MULTICOMBO(explosives4, 420381, TOP + (CATEGORY_SPACING * 5) + (ITEM_HEIGHT + ITEM_SPACING)*6); 
		MULTICOMBO(explosives5, 420391, TOP + (CATEGORY_SPACING * 5) + (ITEM_HEIGHT + ITEM_SPACING)*6); 
		
		HEADING(extraammo, 420650, TOP + (CATEGORY_SPACING * 6) + (ITEM_HEIGHT + ITEM_SPACING)*7, "Extra Ammo"); 
		MULTICOMBO(extraammo1, 420651, TOP + (CATEGORY_SPACING * 6) + (ITEM_HEIGHT + ITEM_SPACING)*7); 
		MULTICOMBO(extraammo2, 420661, TOP + (CATEGORY_SPACING * 6) + (ITEM_HEIGHT + ITEM_SPACING)*7); 
		MULTICOMBO(extraammo3, 420671, TOP + (CATEGORY_SPACING * 6) + (ITEM_HEIGHT + ITEM_SPACING)*7); 
		MULTICOMBO(extraammo4, 420681, TOP + (CATEGORY_SPACING * 6) + (ITEM_HEIGHT + ITEM_SPACING)*7); 
		MULTICOMBO(extraammo5, 420691, TOP + (CATEGORY_SPACING * 6) + (ITEM_HEIGHT + ITEM_SPACING)*7); 
		
		HEADING(extraattach, 420700, TOP + (CATEGORY_SPACING * 7) + (ITEM_HEIGHT + ITEM_SPACING)*8, "Spare Attach"); 
		SINGLECOMBO(extraattach1, 420701, TOP + (CATEGORY_SPACING * 7) + (ITEM_HEIGHT + ITEM_SPACING)*8); 
		SINGLECOMBO(extraattach2, 420711, TOP + (CATEGORY_SPACING * 7) + (ITEM_HEIGHT + ITEM_SPACING)*8); 
		SINGLECOMBO(extraattach3, 420721, TOP + (CATEGORY_SPACING * 7) + (ITEM_HEIGHT + ITEM_SPACING)*8); 
		SINGLECOMBO(extraattach4, 420731, TOP + (CATEGORY_SPACING * 7) + (ITEM_HEIGHT + ITEM_SPACING)*8); 
		SINGLECOMBO(extraattach5, 420741, TOP + (CATEGORY_SPACING * 7) + (ITEM_HEIGHT + ITEM_SPACING)*8); 
		
		//--------------------------------------------------------------------------------------------------UNIFORMS
		HEADING(uniform, 420240, TOP + (CATEGORY_SPACING * 8) + (ITEM_HEIGHT + ITEM_SPACING)*9, "Uniform"); 
		SINGLECOMBO(uniform, 420241, TOP + (CATEGORY_SPACING * 8) + (ITEM_HEIGHT + ITEM_SPACING)*9); 
		
		LABEL(headgear, 420250, TOP + (CATEGORY_SPACING * 8) + (ITEM_HEIGHT + ITEM_SPACING)*10, "Head Gear"); 
		SINGLECOMBO(headgear, 420251, TOP + (CATEGORY_SPACING * 8) + (ITEM_HEIGHT + ITEM_SPACING)*10); 
		
		LABEL(vest, 420260, TOP + (CATEGORY_SPACING * 8) + (ITEM_HEIGHT + ITEM_SPACING)*11, "Vest"); 
		SINGLECOMBO(vest, 420261, TOP + (CATEGORY_SPACING * 8) + (ITEM_HEIGHT + ITEM_SPACING)*11); 
		
		LABEL(backpack, 420270, TOP + (CATEGORY_SPACING * 8) + (ITEM_HEIGHT + ITEM_SPACING)*12, "Backpack"); 
		SINGLECOMBO(backpack, 420271, TOP + (CATEGORY_SPACING * 8) + (ITEM_HEIGHT + ITEM_SPACING)*12); 
		
		LABEL(goggles, 422000, TOP + (CATEGORY_SPACING * 8) + (ITEM_HEIGHT + ITEM_SPACING)*13, "Glasses"); 
		SINGLECOMBO(goggles, 422001, TOP + (CATEGORY_SPACING * 8) + (ITEM_HEIGHT + ITEM_SPACING)*13); 
		
		LABEL(nightvision, 422010, TOP + (CATEGORY_SPACING * 8) + (ITEM_HEIGHT + ITEM_SPACING)*14, "Nightvision"); 
		SINGLECOMBO(nightvision, 422011, TOP + (CATEGORY_SPACING * 8) + (ITEM_HEIGHT + ITEM_SPACING)*14); 
		
		LABEL(binoculars, 422020, TOP + (CATEGORY_SPACING * 8) + (ITEM_HEIGHT + ITEM_SPACING)*15, "Binoculars"); 
		SINGLECOMBO(binoculars, 422021, TOP + (CATEGORY_SPACING * 8) + (ITEM_HEIGHT + ITEM_SPACING)*15); 
		
		LABEL(insignia, 420750, TOP + (CATEGORY_SPACING * 8) + (ITEM_HEIGHT + ITEM_SPACING)*16, "Insignia"); 
		SINGLECOMBO(insignia, 420751, TOP + (CATEGORY_SPACING * 8) + (ITEM_HEIGHT + ITEM_SPACING)*16); 	
		//--------------------------------------------------------------------------------------------------------MISC


		HEADING(medical, 420400, TOP + (CATEGORY_SPACING * 9) + (ITEM_HEIGHT + ITEM_SPACING)*17, "Medical"); 
		MULTICOMBO(medical1, 420401, TOP + (CATEGORY_SPACING * 9) + (ITEM_HEIGHT + ITEM_SPACING)*17); 
		MULTICOMBO(medical2, 420411, TOP + (CATEGORY_SPACING * 9) + (ITEM_HEIGHT + ITEM_SPACING)*17); 
		MULTICOMBO(medical3, 420421, TOP + (CATEGORY_SPACING * 9) + (ITEM_HEIGHT + ITEM_SPACING)*17); 
		MULTICOMBO(medical4, 420431, TOP + (CATEGORY_SPACING * 9) + (ITEM_HEIGHT + ITEM_SPACING)*17); 
		MULTICOMBO(medical5, 420441, TOP + (CATEGORY_SPACING * 9) + (ITEM_HEIGHT + ITEM_SPACING)*17); 
		MULTICOMBO(medical6, 420451, TOP + (CATEGORY_SPACING * 9) + (ITEM_HEIGHT + ITEM_SPACING)*17); 
		MULTICOMBO(medical7, 420461, TOP + (CATEGORY_SPACING * 9) + (ITEM_HEIGHT + ITEM_SPACING)*17); 
		MULTICOMBO(medical8, 420471, TOP + (CATEGORY_SPACING * 9) + (ITEM_HEIGHT + ITEM_SPACING)*17); 
		MULTICOMBO(medical9, 420481, TOP + (CATEGORY_SPACING * 9) + (ITEM_HEIGHT + ITEM_SPACING)*17); 
		MULTICOMBO(medical10, 420491, TOP + (CATEGORY_SPACING * 9) + (ITEM_HEIGHT + ITEM_SPACING)*17); 
		MULTICOMBO(medical11, 420501, TOP + (CATEGORY_SPACING * 9) + (ITEM_HEIGHT + ITEM_SPACING)*17); 
		MULTICOMBO(medical12, 420511, TOP + (CATEGORY_SPACING * 9) + (ITEM_HEIGHT + ITEM_SPACING)*17); 
		MULTICOMBO(medical13, 420521, TOP + (CATEGORY_SPACING * 9) + (ITEM_HEIGHT + ITEM_SPACING)*17); 
		MULTICOMBO(medical14, 420531, TOP + (CATEGORY_SPACING * 9) + (ITEM_HEIGHT + ITEM_SPACING)*17); 
		MULTICOMBO(medical15, 420541, TOP + (CATEGORY_SPACING * 9) + (ITEM_HEIGHT + ITEM_SPACING)*17); 
		MULTICOMBO(medical16, 420551, TOP + (CATEGORY_SPACING * 9) + (ITEM_HEIGHT + ITEM_SPACING)*17); 
		MULTICOMBO(medical17, 420561, TOP + (CATEGORY_SPACING * 9) + (ITEM_HEIGHT + ITEM_SPACING)*17); 
		MULTICOMBO(medical18, 420571, TOP + (CATEGORY_SPACING * 9) + (ITEM_HEIGHT + ITEM_SPACING)*17); 
		MULTICOMBO(medical19, 420581, TOP + (CATEGORY_SPACING * 9) + (ITEM_HEIGHT + ITEM_SPACING)*17); 
		MULTICOMBO(medical20, 420591, TOP + (CATEGORY_SPACING * 9) + (ITEM_HEIGHT + ITEM_SPACING)*17); 
		
		
		HEADING(misc, 420800, TOP + (CATEGORY_SPACING * 10) + (ITEM_HEIGHT + ITEM_SPACING)*18, "Misc"); 
		MULTICOMBO(misc1, 420801, TOP + (CATEGORY_SPACING * 10) + (ITEM_HEIGHT + ITEM_SPACING)*18); 
		MULTICOMBO(misc2, 420811, TOP + (CATEGORY_SPACING * 10) + (ITEM_HEIGHT + ITEM_SPACING)*18); 
		MULTICOMBO(misc3, 420821, TOP + (CATEGORY_SPACING * 10) + (ITEM_HEIGHT + ITEM_SPACING)*18); 
		MULTICOMBO(misc4, 420831, TOP + (CATEGORY_SPACING * 10) + (ITEM_HEIGHT + ITEM_SPACING)*18); 
		MULTICOMBO(misc5, 420841, TOP + (CATEGORY_SPACING * 10) + (ITEM_HEIGHT + ITEM_SPACING)*18); 
		MULTICOMBO(misc6, 420851, TOP + (CATEGORY_SPACING * 10) + (ITEM_HEIGHT + ITEM_SPACING)*18); 
		MULTICOMBO(misc7, 420861, TOP + (CATEGORY_SPACING * 10) + (ITEM_HEIGHT + ITEM_SPACING)*18); 
		MULTICOMBO(misc8, 420871, TOP + (CATEGORY_SPACING * 10) + (ITEM_HEIGHT + ITEM_SPACING)*18); 
		MULTICOMBO(misc9, 420881, TOP + (CATEGORY_SPACING * 10) + (ITEM_HEIGHT + ITEM_SPACING)*18); 
		MULTICOMBO(misc10, 420891, TOP + (CATEGORY_SPACING * 10) + (ITEM_HEIGHT + ITEM_SPACING)*18); 
		
		//===========================================================================================Equipped
		HEADING(equipped, 400099, (TOP + (CATEGORY_SPACING * 11) + (ITEM_HEIGHT + ITEM_SPACING)*19), "Equipped" );
		class MapCombo : ASORGS_BoxCombo {
			idc= 400100;
			x=LEFT_START + DIALOG_MARGIN + LABEL_WIDTH; 
			y=TOP + (CATEGORY_SPACING * 11) + (ITEM_HEIGHT + ITEM_SPACING)*19);
		};
		class GPSCombo : MapCombo {
			idc= 400101;
			x=LEFT_START + DIALOG_MARGIN + LABEL_WIDTH + (BOX_COMBO_WIDTH + BOX_SPACING);
		};
		class RadioCombo : MapCombo {
			idc= 400102;
			x=LEFT_START + DIALOG_MARGIN + LABEL_WIDTH + (BOX_COMBO_WIDTH + BOX_SPACING) * 2;
		};
		class CompassCombo : MapCombo {
			idc= 400103;
			x=LEFT_START + DIALOG_MARGIN + LABEL_WIDTH + (BOX_COMBO_WIDTH + BOX_SPACING) * 3;
		};
		class WatchCombo : MapCombo {
			idc= 400104;
			x=LEFT_START  + DIALOG_MARGIN + LABEL_WIDTH + (BOX_COMBO_WIDTH + BOX_SPACING) * 4;
		};
		class rotateDragThing : ASORGS_RscPicture
		{
			idc = 425004;
			type = 1;
			style = 48;
			text="ASORGS\images\rotate_right.paa";
				font = "PuristaMedium";
			onMouseButtonDown = "_this spawn ASORGS_fnc_RotateCloneStart";
			onMouseButtonUp = "_this spawn ASORGS_fnc_RotateCloneStop";
			onMouseZChanged = "_this spawn ASORGS_fnc_Zoom"; 
			//onMouseEnter="[1] spawn ASORGS_fnc_RotateClone";
			//onMouseExit="[0] spawn ASORGS_fnc_RotateCloneStop";
			colorText[] = {0,0,0,0};
			colorDisabled[] = {0,0,0,0};
			colorBackground[] = {0,0,0,0};
			colorBackgroundActive[] = {0,0,0,0};
			colorBackgroundDisabled[] = {0,0,0,0};
			offsetX = 0.003;
			offsetY = 0.003;
			offsetPressedX = 0.002;
			offsetPressedY = 0.002;
			colorFocused[] = {0,0,0,0};
			colorShadow[] = {0, 0, 0, 0};
			colorBorder[] = {0, 0, 0, 0};
			borderSize = 0.0;
			soundEnter[] = {"\A3\ui_f\data\Sound\RscButtonMenu\soundEnter", 0.09, 1};
			soundPush[] = {"\A3\ui_f\data\Sound\RscButtonMenu\soundPush", 0.0, 0};
			soundClick[] = {"\A3\ui_f\data\Sound\RscButtonMenu\soundClick", 0.07, 1};
			soundEscape[] = {"\A3\ui_f\data\Sound\RscButtonMenu\soundEscape", 0.09, 1};
			w=safezoneW - TOTAL_WIDTH - ITEM_HEIGHT*2 - ( LEFT_START - safezoneX); //remove item height so it doesn't overlap the close button
			h=safezoneH;
			y=safezoneY;
			x= LEFT_START + TOTAL_WIDTH;
		};
		
		
		class progressBarUniform : ASORGS_RscProgress
		{
			idc = 426000;
			h=ITEM_HEIGHT;
			w = TOTAL_WIDTH*0.3333;
			x=LEFT_START;
			y=safezoneY + safezoneH - ITEM_HEIGHT;
			texture = "";
			colorFrame[] = {1,1,1,1};
			colorBar[] = {1,1,1,1};
		};
		class progressBarVest : progressBarUniform
		{
			idc = 426001;
			h=ITEM_HEIGHT;
			w = TOTAL_WIDTH*0.3333;
			x=LEFT_START + (TOTAL_WIDTH*0.3333);
			y=safezoneY + safezoneH - ITEM_HEIGHT;
		};
		class progressBarBackpack : progressBarUniform
		{
			idc = 426002;
			h=ITEM_HEIGHT;
			w = TOTAL_WIDTH*0.3333;
			x=LEFT_START + (TOTAL_WIDTH*0.3333)*2;
			y=safezoneY + safezoneH - ITEM_HEIGHT;
		};
		class tooltipBarUniform : ASORGS_RscButtonMenu
		{
			idc = 426003;
			h=ITEM_HEIGHT;
			w = TOTAL_WIDTH*0.3333;
			x=LEFT_START;
			y=safezoneY + safezoneH - ITEM_HEIGHT;
			texture = "";
			style = "0x02 + 0xC0";
			colorFrame[] = {1,1,1,1};
			colorBar[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0};
			colorBackgroundFocused[] = {1,1,1,0};
			colorBackground2[] = {0.75,0.75,0.75,0};
			color[] = {1,1,1,0};
			colorFocused[] = {0,0,0,0};
			color2[] = {0,0,0,0};
			colorText[] = {1,1,1,0};
			colorDisabled[] = {1,1,1,0};
			enabled=false;
		soundEnter[] = {"",0.09,1};
	soundPush[] = {"",0.09,1};
	soundClick[] = {"",0.09,1};
	soundEscape[] = {"",0.09,1};
			tooltipColorText[] = {1,1,1,1};
			tooltipColorBox[] = {1,1,1,1};
			tooltipColorShade[] = {0,0,0,0.65};
		};
		class tooltipBarVest : tooltipBarUniform
		{
			idc = 426004;
			h=ITEM_HEIGHT;
			w = TOTAL_WIDTH*0.3333;
			x=LEFT_START + (TOTAL_WIDTH*0.3333);
			y=safezoneY + safezoneH - ITEM_HEIGHT;
		};
		class tooltipBarBackpack : tooltipBarUniform
		{
			idc = 426005;
			h=ITEM_HEIGHT;
			w = TOTAL_WIDTH*0.3333;
			x=LEFT_START + (TOTAL_WIDTH*0.3333)*2;
			y=safezoneY + safezoneH - ITEM_HEIGHT;
		};
		class progressBarWeight : ASORGS_RscProgress
		{
			idc = 427000;
			h=CATEGORY_SPACING*2;
			w = TOTAL_WIDTH;
			x=LEFT_START;
			y=safezoneY + safezoneH - ITEM_HEIGHT - CATEGORY_SPACING*2;
			texture = "";
			colorFrame[] = {1,1,1,1};
			colorBar[] = {1,1,1,1};
		};
		class tooltipBarWeight : tooltipBarUniform
		{
			idc = 427001;
			h=CATEGORY_SPACING*2;
			w = TOTAL_WIDTH;
			x=LEFT_START;
			y=safezoneY + safezoneH - ITEM_HEIGHT - CATEGORY_SPACING*2;
		};
		class closeButton : ASORGS_PlusButton {
			idc = 427010;
			textureNoShortcut =  "A3\ui_f\data\gui\Rsc\RscDisplayArcadeMap\icon_exit_cross_ca.paa";
			onButtonClick = "closeDialog 0;";
			w = ITEM_WIDTH*2;
			h = ITEM_HEIGHT*2;
			x = safezoneX +safezoneW - ITEM_WIDTH*2 - (LEFT_START-safezoneX);
			y = safezoneY;
			class ShortcutPos{
				left=0;
				top=0;
				w=ITEM_WIDTH*2;
				h=ITEM_HEIGHT*2;
			};
			#define ANIMTEXTURECOLORCLOSE "#(rgb,8,8,3)color(0.5,0,0,1)"
			colorBackground[] = {1,1,1,1};
			animTextureDefault = ANIMTEXTURECOLORCLOSE;
			animTextureNormal = ANIMTEXTURECOLORCLOSE;
			animTextureDisabled =  "#(rgb,8,8,3)color(0.05,0.05,0.05,1)";
			animTextureOver =  "#(rgb,8,8,3)color(0.7,0,0,1)";
			animTextureFocused =  "#(rgb,8,8,3)color(0.7,0,0,1)";
			animTexturePressed =  "#(rgb,8,8,3)color(0.4,0,0,1)";
		};
	};
};


class ASORGS_SaveDialog {
	idd = 420999;
	name = "ASORGS Save";
	movingEnable = false;
	enableSimulation = true;
	onLoad = "[] spawn ASORGS_fnc_OpenSave";
	class controlsBackground {	};
	class controls {
		class Title : ASORGS_RscTitle {
			idc=-1;
			text = "Save Preset";
			x = LEFT_START + DIALOG_MARGIN;
			y = TOP;
			w = TOTAL_WIDTH - DIALOG_MARGIN;
		};
		class SelectSlotLabel: ASORGS_RscText {
			idc = -1;
			text = "Select a slot:";
			y= TOP + (ITEM_HEIGHT*2);
			x = LEFT_START + DIALOG_MARGIN;
			w = TOTAL_WIDTH - DIALOG_MARGIN;
			h = ITEM_HEIGHT;
		};
		class SaveSlotsList : ASORGS_RscListBox {
			idc = 421000;
			x = LEFT_START + DIALOG_MARGIN;
			y = TOP + (ITEM_HEIGHT*3);
			w = TOTAL_WIDTH - (DIALOG_MARGIN*2);
			h = SAVE_LIST_HEIGHT;
			onLBSelChanged = "[] spawn ASORGS_fnc_SaveSlotChanged";
		};
		class EnterNameLabel: ASORGS_RscText {
			idc = -1;
			text = "Preset Name:";
			x = LEFT_START + DIALOG_MARGIN;
			y = TOP + (ITEM_HEIGHT*3) + SAVE_LIST_HEIGHT + CATEGORY_SPACING;
			w = LABEL_WIDTH;
			h = ITEM_HEIGHT;
		};
		class EnterNameTextbox: ASORGS_RscEdit {
			idc = 421001;
			text = "New Preset";
			x = LEFT_START + DIALOG_MARGIN + LABEL_WIDTH + (DIALOG_MARGIN *2);
			y = TOP + (ITEM_HEIGHT*3) + CATEGORY_SPACING + SAVE_LIST_HEIGHT;
			w = TOTAL_WIDTH - LABEL_WIDTH - (DIALOG_MARGIN*4);
			h = ITEM_HEIGHT;
		};
		class CancelButton : ASORGS_RscButtonMenu {
			idd = 421002;
			text = "Cancel";
			x = LEFT_START + DIALOG_MARGIN;
			y = TOP + (ITEM_HEIGHT*4) + (CATEGORY_SPACING*2) + SAVE_LIST_HEIGHT;
			w = (TOTAL_WIDTH / 3) - ((DIALOG_MARGIN/2)*2) - DIALOG_MARGIN;
			h = ITEM_HEIGHT;
			onButtonClick = "(findDisplay 420999) closeDisplay 0";
		};
		class DeleteButton : ASORGS_RscButtonMenu {
			idd = 421004;
			text = "Delete";
			x = LEFT_START + (TOTAL_WIDTH / 3) + ((DIALOG_MARGIN/2)*2);
			y = TOP + (ITEM_HEIGHT*4) + (CATEGORY_SPACING*2) + SAVE_LIST_HEIGHT;
			w = (TOTAL_WIDTH / 3) - ((DIALOG_MARGIN/2)*2) - DIALOG_MARGIN;
			h = ITEM_HEIGHT;
			onButtonClick = "createDialog ""ASORGS_ConfirmDeleteDialog"";";
		};
		class SaveButton : ASORGS_RscButtonMenu {
			idc = 421003;
			text = "Save";
			x = LEFT_START + ((TOTAL_WIDTH / 3)*2) + ((DIALOG_MARGIN/2)*2);
			y = TOP + (ITEM_HEIGHT*4) + (CATEGORY_SPACING*2) + SAVE_LIST_HEIGHT;
			w = (TOTAL_WIDTH / 3) - ((DIALOG_MARGIN/2)*2) - DIALOG_MARGIN;
			h = ITEM_HEIGHT;
			onButtonClick = "[] spawn ASORGS_fnc_savePressed";
		};
	};
};
class ASORGS_ConfirmDeleteDialog {
	idd = 421999;
	name = "ASORGS Delete Preset";
	movingEnable = false;
	enableSimulation = true;
	onLoad = "[] spawn ASORGS_fnc_DeleteConfirm";
	class controlsBackground {
	};
	class controls {
		class Title : ASORGS_RscTitle {
			idc=-1;
			text = "Delete Preset";
			x = LEFT_START + DIALOG_MARGIN;
			y = TOP;
			w = TOTAL_WIDTH - DIALOG_MARGIN;
		};
		class SelectSlotLabel: ASORGS_RscText {
			idc = 422001;
			text = "Are you sure you want to delete the preset?";
			y= TOP + (ITEM_HEIGHT*2);
			x = LEFT_START + DIALOG_MARGIN;
			w = TOTAL_WIDTH - DIALOG_MARGIN;
			h = ITEM_HEIGHT;
		};
		class CancelButton : ASORGS_RscButtonMenu {
			idd = 422002;
			text = "Cancel";
			x = LEFT_START + DIALOG_MARGIN;
			y = TOP + (ITEM_HEIGHT*4) + (CATEGORY_SPACING*2);
			w = (TOTAL_WIDTH / 2) - ((DIALOG_MARGIN/2)*2) - DIALOG_MARGIN;
			h = ITEM_HEIGHT;
			onButtonClick = "(findDisplay 421999) closeDisplay 0";
			
		};
		class DeleteButton : ASORGS_RscButtonMenu {
			idd = 422003;
			text = "Delete";
			x = LEFT_START + (TOTAL_WIDTH / 3) + ((DIALOG_MARGIN/2)*2);
			y = TOP + (ITEM_HEIGHT*4) + (CATEGORY_SPACING*2);
			w = (TOTAL_WIDTH / 2) - ((DIALOG_MARGIN/2)*2) - DIALOG_MARGIN;
			h = ITEM_HEIGHT;
			onButtonClick = "[] spawn ASORGS_fnc_deletePressed";
		};
	};
};
