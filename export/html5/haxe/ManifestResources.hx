package;


import haxe.io.Bytes;
import lime.utils.AssetBundle;
import lime.utils.AssetLibrary;
import lime.utils.AssetManifest;
import lime.utils.Assets;

#if sys
import sys.FileSystem;
#end

@:access(lime.utils.Assets)


@:keep @:dox(hide) class ManifestResources {


	public static var preloadLibraries:Array<AssetLibrary>;
	public static var preloadLibraryNames:Array<String>;
	public static var rootPath:String;


	public static function init (config:Dynamic):Void {

		preloadLibraries = new Array ();
		preloadLibraryNames = new Array ();

		rootPath = null;

		if (config != null && Reflect.hasField (config, "rootPath")) {

			rootPath = Reflect.field (config, "rootPath");

		}

		if (rootPath == null) {

			#if (ios || tvos || emscripten)
			rootPath = "assets/";
			#elseif android
			rootPath = "";
			#elseif console
			rootPath = lime.system.System.applicationDirectory;
			#else
			rootPath = "./";
			#end

		}

		#if (openfl && !flash && !display)
		openfl.text.Font.registerFont (__ASSET__OPENFL__flixel_fonts_nokiafc22_ttf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__flixel_fonts_monsterrat_ttf);
		
		#end

		var data, manifest, library, bundle;

		#if kha

		null
		library = AssetLibrary.fromManifest (manifest);
		Assets.registerLibrary ("null", library);

		if (library != null) preloadLibraries.push (library);
		else preloadLibraryNames.push ("null");

		#else

		data = '{"name":null,"assets":"aoy4:pathy34:assets%2Fdata%2Fdata-goes-here.txty4:sizezy4:typey4:TEXTy2:idR1y7:preloadtgoR0y24:assets%2Ffonts%2F5px.fntR2i11149R3R4R5R7R6tgoR0y26:assets%2Ffonts%2F5px_0.pngR2i976R3y5:IMAGER5R8R6tgoR0y24:assets%2Ffonts%2F8px.fntR2i11150R3R4R5R10R6tgoR0y26:assets%2Ffonts%2F8px_0.pngR2i1272R3R9R5R11R6tgoR0y29:assets%2Ffonts%2F8px_bold.fntR2i11163R3R4R5R12R6tgoR0y31:assets%2Ffonts%2F8px_bold_0.pngR2i1363R3R9R5R13R6tgoR0y25:assets%2Ffonts%2Fmini.fntR2i11147R3R4R5R14R6tgoR0y27:assets%2Ffonts%2Fmini_0.pngR2i1160R3R9R5R15R6tgoR0y28:assets%2Ffonts%2Fpreset.bmfcR2i884R3R4R5R16R6tgoR0y24:assets%2Ffonts%2Frev.fntR2i11146R3R4R5R17R6tgoR0y26:assets%2Ffonts%2Frev_0.pngR2i1117R3R9R5R18R6tgoR0y44:assets%2Fimages%2Fbackgrounds%2Fbackdrop.pngR2i4973R3R9R5R19R6tgoR0y40:assets%2Fimages%2Fbackgrounds%2Fbsod.pngR2i700R3R9R5R20R6tgoR0y39:assets%2Fimages%2Fbackgrounds%2Fhud.pngR2i1268R3R9R5R21R6tgoR0y43:assets%2Fimages%2Fbackgrounds%2Fmenu_bg.pngR2i2981R3R9R5R22R6tgoR0y34:assets%2Fimages%2Fbutton_close.pngR2i124R3R9R5R23R6tgoR0y33:assets%2Fimages%2Fbutton_math.pngR2i188R3R9R5R24R6tgoR0y31:assets%2Fimages%2Fbutton_ok.pngR2i205R3R9R5R25R6tgoR0y27:assets%2Fimages%2Fclick.pngR2i99R3R9R5R26R6tgoR0y28:assets%2Fimages%2Fcursor.pngR2i376R3R9R5R27R6tgoR0y33:assets%2Fimages%2Fcursor_grab.pngR2i337R3R9R5R28R6tgoR0y32:assets%2Fimages%2Fcursor_old.pngR2i176R3R9R5R29R6tgoR0y38:assets%2Fimages%2Fcutscene%2Fenter.pngR2i369R3R9R5R30R6tgoR0y42:assets%2Fimages%2Fcutscene%2Fmessaging.pngR2i1068R3R9R5R31R6tgoR0y36:assets%2Fimages%2Fimages-go-here.txtR2zR3R4R5R32R6tgoR0y34:assets%2Fimages%2Fkeys%2Fkey_a.pngR2i252R3R9R5R33R6tgoR0y34:assets%2Fimages%2Fkeys%2Fkey_b.pngR2i249R3R9R5R34R6tgoR0y40:assets%2Fimages%2Fkeys%2Fkey_control.pngR2i319R3R9R5R35R6tgoR0y34:assets%2Fimages%2Fkeys%2Fkey_g.pngR2i259R3R9R5R36R6tgoR0y34:assets%2Fimages%2Fkeys%2Fkey_h.pngR2i239R3R9R5R37R6tgoR0y34:assets%2Fimages%2Fkeys%2Fkey_m.pngR2i251R3R9R5R38R6tgoR0y34:assets%2Fimages%2Fkeys%2Fkey_s.pngR2i261R3R9R5R39R6tgoR0y38:assets%2Fimages%2Fkeys%2Fkey_shift.pngR2i322R3R9R5R40R6tgoR0y34:assets%2Fimages%2Fkeys%2Fkey_w.pngR2i250R3R9R5R41R6tgoR0y34:assets%2Fimages%2Fkeys%2Fkey_x.pngR2i262R3R9R5R42R6tgoR0y34:assets%2Fimages%2Fkeys%2Fkey_y.pngR2i245R3R9R5R43R6tgoR0y34:assets%2Fimages%2Fkeys%2Fkey_z.pngR2i244R3R9R5R44R6tgoR0y35:assets%2Fimages%2Fmenu%2Fcircle.pngR2i175R3R9R5R45R6tgoR0y36:assets%2Fimages%2Fmenu%2Fhaxejam.pngR2i488R3R9R5R46R6tgoR0y33:assets%2Fimages%2Fmenu%2Finfo.pngR2i122R3R9R5R47R6tgoR0y38:assets%2Fimages%2Fmenu%2Finfo_card.pngR2i1187R3R9R5R48R6tgoR0y33:assets%2Fimages%2Fmenu%2Flogo.pngR2i969R3R9R5R49R6tgoR0y33:assets%2Fimages%2Fmenu%2Fplay.pngR2i364R3R9R5R50R6tgoR0y38:assets%2Fimages%2Fmenu%2Fplay_mask.pngR2i137R3R9R5R51R6tgoR0y32:assets%2Fimages%2Fmenu%2Fpop.pngR2i134R3R9R5R52R6tgoR0y26:assets%2Fimages%2Fplus.pngR2i98R3R9R5R53R6tgoR0y26:assets%2Fimages%2Ftemp.pngR2i206R3R9R5R54R6tgoR0y41:assets%2Fimages%2Fwindows%2Fmash_fill.pngR2i386R3R9R5R55R6tgoR0y40:assets%2Fimages%2Fwindows%2Fpull_bar.pngR2i167R3R9R5R56R6tgoR0y40:assets%2Fimages%2Fwindows%2Fwindow_1.pngR2i1384R3R9R5R57R6tgoR0y40:assets%2Fimages%2Fwindows%2Fwindow_2.pngR2i1650R3R9R5R58R6tgoR0y40:assets%2Fimages%2Fwindows%2Fwindow_3.pngR2i1450R3R9R5R59R6tgoR0y44:assets%2Fimages%2Fwindows%2Fwindow_big_1.pngR2i1158R3R9R5R60R6tgoR0y43:assets%2Fimages%2Fwindows%2Fwindow_hold.pngR2i361R3R9R5R61R6tgoR0y43:assets%2Fimages%2Fwindows%2Fwindow_mash.pngR2i764R3R9R5R62R6tgoR0y43:assets%2Fimages%2Fwindows%2Fwindow_math.pngR2i266R3R9R5R63R6tgoR0y41:assets%2Fimages%2Fwindows%2Fwindow_ok.pngR2i519R3R9R5R64R6tgoR0y43:assets%2Fimages%2Fwindows%2Fwindow_pull.pngR2i707R3R9R5R65R6tgoR0y45:assets%2Fimages%2Fwindows%2Fwindow_typing.pngR2i448R3R9R5R66R6tgoR2i2344056R3y5:MUSICR5y29:assets%2Fmusic%2Fdisposal.mp3y9:pathGroupaR68hR6tgoR0y36:assets%2Fmusic%2Fmusic-goes-here.txtR2zR3R4R5R70R6tgoR2i4558R3R67R5y25:assets%2Fsounds%2Fbad.mp3R69aR71hR6tgoR2i4183R3R67R5y27:assets%2Fsounds%2Fclick.mp3R69aR72hR6tgoR2i14582R3R67R5y25:assets%2Fsounds%2Fend.mp3R69aR73hR6tgoR2i714937R3R67R5y25:assets%2Fsounds%2Ffan.mp3R69aR74hR6tgoR2i1688R3R67R5y26:assets%2Fsounds%2Fgood.mp3R69aR75hR6tgoR2i4128R3R67R5y35:assets%2Fsounds%2Fkeys%2Fkey-01.mp3R69aR76hR6tgoR2i4584R3R67R5y35:assets%2Fsounds%2Fkeys%2Fkey-02.mp3R69aR77hR6tgoR2i4200R3R67R5y35:assets%2Fsounds%2Fkeys%2Fkey-03.mp3R69aR78hR6tgoR2i4200R3R67R5y35:assets%2Fsounds%2Fkeys%2Fkey-04.mp3R69aR79hR6tgoR2i4392R3R67R5y35:assets%2Fsounds%2Fkeys%2Fkey-05.mp3R69aR80hR6tgoR2i3936R3R67R5y35:assets%2Fsounds%2Fkeys%2Fkey-06.mp3R69aR81hR6tgoR2i4440R3R67R5y35:assets%2Fsounds%2Fkeys%2Fkey-07.mp3R69aR82hR6tgoR2i8138R3R67R5y28:assets%2Fsounds%2Fmetal1.mp3R69aR83hR6tgoR2i8762R3R67R5y28:assets%2Fsounds%2Fmetal2.mp3R69aR84hR6tgoR2i11594R3R67R5y28:assets%2Fsounds%2Fmetal3.mp3R69aR85hR6tgoR2i12854R3R67R5y27:assets%2Fsounds%2FnewHS.mp3R69aR86hR6tgoR2i3173R3R67R5y26:assets%2Fsounds%2Fpop1.mp3R69aR87hR6tgoR2i3245R3R67R5y26:assets%2Fsounds%2Fpop2.mp3R69aR88hR6tgoR2i3341R3R67R5y26:assets%2Fsounds%2Fpop3.mp3R69aR89hR6tgoR2i2710R3R67R5y24:assets%2Fsounds%2Fs1.mp3R69aR90hR6tgoR2i2239R3R67R5y24:assets%2Fsounds%2Fs2.mp3R69aR91hR6tgoR2i2239R3R67R5y24:assets%2Fsounds%2Fs3.mp3R69aR92hR6tgoR0y36:assets%2Fsounds%2Fsounds-go-here.txtR2zR3R4R5R93R6tgoR2i2114R3R67R5y26:flixel%2Fsounds%2Fbeep.mp3R69aR94y26:flixel%2Fsounds%2Fbeep.ogghR6tgoR2i39706R3R67R5y28:flixel%2Fsounds%2Fflixel.mp3R69aR96y28:flixel%2Fsounds%2Fflixel.ogghR6tgoR2i5794R3y5:SOUNDR5R95R69aR94R95hgoR2i33629R3R98R5R97R69aR96R97hgoR2i15744R3y4:FONTy9:classNamey35:__ASSET__flixel_fonts_nokiafc22_ttfR5y30:flixel%2Ffonts%2Fnokiafc22.ttfR6tgoR2i29724R3R99R100y36:__ASSET__flixel_fonts_monsterrat_ttfR5y31:flixel%2Ffonts%2Fmonsterrat.ttfR6tgoR0y33:flixel%2Fimages%2Fui%2Fbutton.pngR2i519R3R9R5R105R6tgoR0y36:flixel%2Fimages%2Flogo%2Fdefault.pngR2i3280R3R9R5R106R6tgh","rootPath":null,"version":2,"libraryArgs":[],"libraryType":null}';
		manifest = AssetManifest.parse (data, rootPath);
		library = AssetLibrary.fromManifest (manifest);
		Assets.registerLibrary ("default", library);
		

		library = Assets.getLibrary ("default");
		if (library != null) preloadLibraries.push (library);
		else preloadLibraryNames.push ("default");
		

		#end

	}


}


#if kha

null

#else

#if !display
#if flash

@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_data_goes_here_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_fonts_5px_fnt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_fonts_5px_0_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_fonts_8px_fnt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_fonts_8px_0_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_fonts_8px_bold_fnt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_fonts_8px_bold_0_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_fonts_mini_fnt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_fonts_mini_0_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_fonts_preset_bmfc extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_fonts_rev_fnt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_fonts_rev_0_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_backgrounds_backdrop_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_backgrounds_bsod_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_backgrounds_hud_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_backgrounds_menu_bg_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_button_close_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_button_math_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_button_ok_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_click_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_cursor_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_cursor_grab_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_cursor_old_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_cutscene_enter_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_cutscene_messaging_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_images_go_here_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_keys_key_a_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_keys_key_b_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_keys_key_control_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_keys_key_g_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_keys_key_h_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_keys_key_m_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_keys_key_s_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_keys_key_shift_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_keys_key_w_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_keys_key_x_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_keys_key_y_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_keys_key_z_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_menu_circle_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_menu_haxejam_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_menu_info_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_menu_info_card_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_menu_logo_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_menu_play_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_menu_play_mask_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_menu_pop_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_plus_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_temp_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_windows_mash_fill_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_windows_pull_bar_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_windows_window_1_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_windows_window_2_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_windows_window_3_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_windows_window_big_1_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_windows_window_hold_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_windows_window_mash_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_windows_window_math_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_windows_window_ok_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_windows_window_pull_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_windows_window_typing_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_disposal_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_music_goes_here_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_bad_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_click_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_end_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_fan_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_good_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_keys_key_01_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_keys_key_02_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_keys_key_03_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_keys_key_04_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_keys_key_05_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_keys_key_06_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_keys_key_07_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_metal1_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_metal2_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_metal3_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_newhs_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_pop1_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_pop2_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_pop3_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_s1_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_s2_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_s3_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_sounds_go_here_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_sounds_beep_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_sounds_flixel_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_sounds_beep_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_sounds_flixel_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_images_ui_button_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_images_logo_default_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__manifest_default_json extends null { }


#elseif (desktop || cpp)

@:keep @:file("assets/data/data-goes-here.txt") @:noCompletion #if display private #end class __ASSET__assets_data_data_goes_here_txt extends haxe.io.Bytes {}
@:keep @:file("assets/fonts/5px.fnt") @:noCompletion #if display private #end class __ASSET__assets_fonts_5px_fnt extends haxe.io.Bytes {}
@:keep @:image("assets/fonts/5px_0.png") @:noCompletion #if display private #end class __ASSET__assets_fonts_5px_0_png extends lime.graphics.Image {}
@:keep @:file("assets/fonts/8px.fnt") @:noCompletion #if display private #end class __ASSET__assets_fonts_8px_fnt extends haxe.io.Bytes {}
@:keep @:image("assets/fonts/8px_0.png") @:noCompletion #if display private #end class __ASSET__assets_fonts_8px_0_png extends lime.graphics.Image {}
@:keep @:file("assets/fonts/8px_bold.fnt") @:noCompletion #if display private #end class __ASSET__assets_fonts_8px_bold_fnt extends haxe.io.Bytes {}
@:keep @:image("assets/fonts/8px_bold_0.png") @:noCompletion #if display private #end class __ASSET__assets_fonts_8px_bold_0_png extends lime.graphics.Image {}
@:keep @:file("assets/fonts/mini.fnt") @:noCompletion #if display private #end class __ASSET__assets_fonts_mini_fnt extends haxe.io.Bytes {}
@:keep @:image("assets/fonts/mini_0.png") @:noCompletion #if display private #end class __ASSET__assets_fonts_mini_0_png extends lime.graphics.Image {}
@:keep @:file("assets/fonts/preset.bmfc") @:noCompletion #if display private #end class __ASSET__assets_fonts_preset_bmfc extends haxe.io.Bytes {}
@:keep @:file("assets/fonts/rev.fnt") @:noCompletion #if display private #end class __ASSET__assets_fonts_rev_fnt extends haxe.io.Bytes {}
@:keep @:image("assets/fonts/rev_0.png") @:noCompletion #if display private #end class __ASSET__assets_fonts_rev_0_png extends lime.graphics.Image {}
@:keep @:image("assets/images/backgrounds/backdrop.png") @:noCompletion #if display private #end class __ASSET__assets_images_backgrounds_backdrop_png extends lime.graphics.Image {}
@:keep @:image("assets/images/backgrounds/bsod.png") @:noCompletion #if display private #end class __ASSET__assets_images_backgrounds_bsod_png extends lime.graphics.Image {}
@:keep @:image("assets/images/backgrounds/hud.png") @:noCompletion #if display private #end class __ASSET__assets_images_backgrounds_hud_png extends lime.graphics.Image {}
@:keep @:image("assets/images/backgrounds/menu_bg.png") @:noCompletion #if display private #end class __ASSET__assets_images_backgrounds_menu_bg_png extends lime.graphics.Image {}
@:keep @:image("assets/images/button_close.png") @:noCompletion #if display private #end class __ASSET__assets_images_button_close_png extends lime.graphics.Image {}
@:keep @:image("assets/images/button_math.png") @:noCompletion #if display private #end class __ASSET__assets_images_button_math_png extends lime.graphics.Image {}
@:keep @:image("assets/images/button_ok.png") @:noCompletion #if display private #end class __ASSET__assets_images_button_ok_png extends lime.graphics.Image {}
@:keep @:image("assets/images/click.png") @:noCompletion #if display private #end class __ASSET__assets_images_click_png extends lime.graphics.Image {}
@:keep @:image("assets/images/cursor.png") @:noCompletion #if display private #end class __ASSET__assets_images_cursor_png extends lime.graphics.Image {}
@:keep @:image("assets/images/cursor_grab.png") @:noCompletion #if display private #end class __ASSET__assets_images_cursor_grab_png extends lime.graphics.Image {}
@:keep @:image("assets/images/cursor_old.png") @:noCompletion #if display private #end class __ASSET__assets_images_cursor_old_png extends lime.graphics.Image {}
@:keep @:image("assets/images/cutscene/enter.png") @:noCompletion #if display private #end class __ASSET__assets_images_cutscene_enter_png extends lime.graphics.Image {}
@:keep @:image("assets/images/cutscene/messaging.png") @:noCompletion #if display private #end class __ASSET__assets_images_cutscene_messaging_png extends lime.graphics.Image {}
@:keep @:file("assets/images/images-go-here.txt") @:noCompletion #if display private #end class __ASSET__assets_images_images_go_here_txt extends haxe.io.Bytes {}
@:keep @:image("assets/images/keys/key_a.png") @:noCompletion #if display private #end class __ASSET__assets_images_keys_key_a_png extends lime.graphics.Image {}
@:keep @:image("assets/images/keys/key_b.png") @:noCompletion #if display private #end class __ASSET__assets_images_keys_key_b_png extends lime.graphics.Image {}
@:keep @:image("assets/images/keys/key_control.png") @:noCompletion #if display private #end class __ASSET__assets_images_keys_key_control_png extends lime.graphics.Image {}
@:keep @:image("assets/images/keys/key_g.png") @:noCompletion #if display private #end class __ASSET__assets_images_keys_key_g_png extends lime.graphics.Image {}
@:keep @:image("assets/images/keys/key_h.png") @:noCompletion #if display private #end class __ASSET__assets_images_keys_key_h_png extends lime.graphics.Image {}
@:keep @:image("assets/images/keys/key_m.png") @:noCompletion #if display private #end class __ASSET__assets_images_keys_key_m_png extends lime.graphics.Image {}
@:keep @:image("assets/images/keys/key_s.png") @:noCompletion #if display private #end class __ASSET__assets_images_keys_key_s_png extends lime.graphics.Image {}
@:keep @:image("assets/images/keys/key_shift.png") @:noCompletion #if display private #end class __ASSET__assets_images_keys_key_shift_png extends lime.graphics.Image {}
@:keep @:image("assets/images/keys/key_w.png") @:noCompletion #if display private #end class __ASSET__assets_images_keys_key_w_png extends lime.graphics.Image {}
@:keep @:image("assets/images/keys/key_x.png") @:noCompletion #if display private #end class __ASSET__assets_images_keys_key_x_png extends lime.graphics.Image {}
@:keep @:image("assets/images/keys/key_y.png") @:noCompletion #if display private #end class __ASSET__assets_images_keys_key_y_png extends lime.graphics.Image {}
@:keep @:image("assets/images/keys/key_z.png") @:noCompletion #if display private #end class __ASSET__assets_images_keys_key_z_png extends lime.graphics.Image {}
@:keep @:image("assets/images/menu/circle.png") @:noCompletion #if display private #end class __ASSET__assets_images_menu_circle_png extends lime.graphics.Image {}
@:keep @:image("assets/images/menu/haxejam.png") @:noCompletion #if display private #end class __ASSET__assets_images_menu_haxejam_png extends lime.graphics.Image {}
@:keep @:image("assets/images/menu/info.png") @:noCompletion #if display private #end class __ASSET__assets_images_menu_info_png extends lime.graphics.Image {}
@:keep @:image("assets/images/menu/info_card.png") @:noCompletion #if display private #end class __ASSET__assets_images_menu_info_card_png extends lime.graphics.Image {}
@:keep @:image("assets/images/menu/logo.png") @:noCompletion #if display private #end class __ASSET__assets_images_menu_logo_png extends lime.graphics.Image {}
@:keep @:image("assets/images/menu/play.png") @:noCompletion #if display private #end class __ASSET__assets_images_menu_play_png extends lime.graphics.Image {}
@:keep @:image("assets/images/menu/play_mask.png") @:noCompletion #if display private #end class __ASSET__assets_images_menu_play_mask_png extends lime.graphics.Image {}
@:keep @:image("assets/images/menu/pop.png") @:noCompletion #if display private #end class __ASSET__assets_images_menu_pop_png extends lime.graphics.Image {}
@:keep @:image("assets/images/plus.png") @:noCompletion #if display private #end class __ASSET__assets_images_plus_png extends lime.graphics.Image {}
@:keep @:image("assets/images/temp.png") @:noCompletion #if display private #end class __ASSET__assets_images_temp_png extends lime.graphics.Image {}
@:keep @:image("assets/images/windows/mash_fill.png") @:noCompletion #if display private #end class __ASSET__assets_images_windows_mash_fill_png extends lime.graphics.Image {}
@:keep @:image("assets/images/windows/pull_bar.png") @:noCompletion #if display private #end class __ASSET__assets_images_windows_pull_bar_png extends lime.graphics.Image {}
@:keep @:image("assets/images/windows/window_1.png") @:noCompletion #if display private #end class __ASSET__assets_images_windows_window_1_png extends lime.graphics.Image {}
@:keep @:image("assets/images/windows/window_2.png") @:noCompletion #if display private #end class __ASSET__assets_images_windows_window_2_png extends lime.graphics.Image {}
@:keep @:image("assets/images/windows/window_3.png") @:noCompletion #if display private #end class __ASSET__assets_images_windows_window_3_png extends lime.graphics.Image {}
@:keep @:image("assets/images/windows/window_big_1.png") @:noCompletion #if display private #end class __ASSET__assets_images_windows_window_big_1_png extends lime.graphics.Image {}
@:keep @:image("assets/images/windows/window_hold.png") @:noCompletion #if display private #end class __ASSET__assets_images_windows_window_hold_png extends lime.graphics.Image {}
@:keep @:image("assets/images/windows/window_mash.png") @:noCompletion #if display private #end class __ASSET__assets_images_windows_window_mash_png extends lime.graphics.Image {}
@:keep @:image("assets/images/windows/window_math.png") @:noCompletion #if display private #end class __ASSET__assets_images_windows_window_math_png extends lime.graphics.Image {}
@:keep @:image("assets/images/windows/window_ok.png") @:noCompletion #if display private #end class __ASSET__assets_images_windows_window_ok_png extends lime.graphics.Image {}
@:keep @:image("assets/images/windows/window_pull.png") @:noCompletion #if display private #end class __ASSET__assets_images_windows_window_pull_png extends lime.graphics.Image {}
@:keep @:image("assets/images/windows/window_typing.png") @:noCompletion #if display private #end class __ASSET__assets_images_windows_window_typing_png extends lime.graphics.Image {}
@:keep @:file("assets/music/disposal.mp3") @:noCompletion #if display private #end class __ASSET__assets_music_disposal_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/music/music-goes-here.txt") @:noCompletion #if display private #end class __ASSET__assets_music_music_goes_here_txt extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/bad.mp3") @:noCompletion #if display private #end class __ASSET__assets_sounds_bad_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/click.mp3") @:noCompletion #if display private #end class __ASSET__assets_sounds_click_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/end.mp3") @:noCompletion #if display private #end class __ASSET__assets_sounds_end_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/fan.mp3") @:noCompletion #if display private #end class __ASSET__assets_sounds_fan_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/good.mp3") @:noCompletion #if display private #end class __ASSET__assets_sounds_good_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/keys/key-01.mp3") @:noCompletion #if display private #end class __ASSET__assets_sounds_keys_key_01_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/keys/key-02.mp3") @:noCompletion #if display private #end class __ASSET__assets_sounds_keys_key_02_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/keys/key-03.mp3") @:noCompletion #if display private #end class __ASSET__assets_sounds_keys_key_03_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/keys/key-04.mp3") @:noCompletion #if display private #end class __ASSET__assets_sounds_keys_key_04_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/keys/key-05.mp3") @:noCompletion #if display private #end class __ASSET__assets_sounds_keys_key_05_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/keys/key-06.mp3") @:noCompletion #if display private #end class __ASSET__assets_sounds_keys_key_06_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/keys/key-07.mp3") @:noCompletion #if display private #end class __ASSET__assets_sounds_keys_key_07_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/metal1.mp3") @:noCompletion #if display private #end class __ASSET__assets_sounds_metal1_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/metal2.mp3") @:noCompletion #if display private #end class __ASSET__assets_sounds_metal2_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/metal3.mp3") @:noCompletion #if display private #end class __ASSET__assets_sounds_metal3_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/newHS.mp3") @:noCompletion #if display private #end class __ASSET__assets_sounds_newhs_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/pop1.mp3") @:noCompletion #if display private #end class __ASSET__assets_sounds_pop1_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/pop2.mp3") @:noCompletion #if display private #end class __ASSET__assets_sounds_pop2_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/pop3.mp3") @:noCompletion #if display private #end class __ASSET__assets_sounds_pop3_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/s1.mp3") @:noCompletion #if display private #end class __ASSET__assets_sounds_s1_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/s2.mp3") @:noCompletion #if display private #end class __ASSET__assets_sounds_s2_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/s3.mp3") @:noCompletion #if display private #end class __ASSET__assets_sounds_s3_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/sounds-go-here.txt") @:noCompletion #if display private #end class __ASSET__assets_sounds_sounds_go_here_txt extends haxe.io.Bytes {}
@:keep @:file("C:/HaxeToolkit/haxe/lib/flixel/4,11,0/assets/sounds/beep.mp3") @:noCompletion #if display private #end class __ASSET__flixel_sounds_beep_mp3 extends haxe.io.Bytes {}
@:keep @:file("C:/HaxeToolkit/haxe/lib/flixel/4,11,0/assets/sounds/flixel.mp3") @:noCompletion #if display private #end class __ASSET__flixel_sounds_flixel_mp3 extends haxe.io.Bytes {}
@:keep @:file("C:/HaxeToolkit/haxe/lib/flixel/4,11,0/assets/sounds/beep.ogg") @:noCompletion #if display private #end class __ASSET__flixel_sounds_beep_ogg extends haxe.io.Bytes {}
@:keep @:file("C:/HaxeToolkit/haxe/lib/flixel/4,11,0/assets/sounds/flixel.ogg") @:noCompletion #if display private #end class __ASSET__flixel_sounds_flixel_ogg extends haxe.io.Bytes {}
@:keep @:font("export/html5/obj/webfont/nokiafc22.ttf") @:noCompletion #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends lime.text.Font {}
@:keep @:font("export/html5/obj/webfont/monsterrat.ttf") @:noCompletion #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends lime.text.Font {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel/4,11,0/assets/images/ui/button.png") @:noCompletion #if display private #end class __ASSET__flixel_images_ui_button_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel/4,11,0/assets/images/logo/default.png") @:noCompletion #if display private #end class __ASSET__flixel_images_logo_default_png extends lime.graphics.Image {}
@:keep @:file("") @:noCompletion #if display private #end class __ASSET__manifest_default_json extends haxe.io.Bytes {}



#else

@:keep @:expose('__ASSET__flixel_fonts_nokiafc22_ttf') @:noCompletion #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "flixel/fonts/nokiafc22"; #else ascender = 2048; descender = -512; height = 2816; numGlyphs = 172; underlinePosition = -640; underlineThickness = 256; unitsPerEM = 2048; #end name = "Nokia Cellphone FC Small"; super (); }}
@:keep @:expose('__ASSET__flixel_fonts_monsterrat_ttf') @:noCompletion #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "flixel/fonts/monsterrat"; #else ascender = 968; descender = -251; height = 1219; numGlyphs = 263; underlinePosition = -150; underlineThickness = 50; unitsPerEM = 1000; #end name = "Monsterrat"; super (); }}


#end

#if (openfl && !flash)

#if html5
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_nokiafc22_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__flixel_fonts_nokiafc22_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_nokiafc22_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_monsterrat_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__flixel_fonts_monsterrat_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_monsterrat_ttf ()); super (); }}

#else
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_nokiafc22_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__flixel_fonts_nokiafc22_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_nokiafc22_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_monsterrat_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__flixel_fonts_monsterrat_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_monsterrat_ttf ()); super (); }}

#end

#end
#end

#end
