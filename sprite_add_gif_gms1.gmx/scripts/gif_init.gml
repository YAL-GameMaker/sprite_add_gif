#define gif_preinit
// Generated at 2023-05-08 20:34:32 (392ms) for v1.4.1804+
/// @lint nullToAny true
// Feather disable all
globalvar mq_gif;mq_gif=gif_std_haxe_type_proto(undefined,undefined,0,0,0);
globalvar mq_gif_frame;mq_gif_frame=gif_std_haxe_type_proto(undefined,0,undefined,undefined,0,0,0,0,0);
globalvar mq_gif_reader;mq_gif_reader=gif_std_haxe_type_proto(undefined,undefined);
globalvar mq_gif_std_haxe_class;mq_gif_std_haxe_class=gif_std_haxe_type_proto(undefined,undefined,0,undefined,undefined,undefined);
globalvar mq_gif_std_haxe_enum;mq_gif_std_haxe_enum=gif_std_haxe_type_proto(undefined,undefined,0,undefined,undefined,undefined);
globalvar mq_gif_std_haxe_io_Bytes;mq_gif_std_haxe_io_Bytes=gif_std_haxe_type_proto(undefined,undefined);
globalvar mq_gif_std_haxe_io_Output;mq_gif_std_haxe_io_Output=gif_std_haxe_type_proto(undefined,undefined,0,0,undefined,undefined);
globalvar mq_gif_std_haxe_io_BytesOutput;mq_gif_std_haxe_io_BytesOutput=gif_std_haxe_type_proto(undefined,undefined,0,0,undefined,undefined);
globalvar gif_std_haxe_type_markerValue;gif_std_haxe_type_markerValue=0;gif_std_haxe_type_markerValue[0]=undefined;
globalvar mt_gif;mt_gif=gif_std_haxe_class_create(7,"gif");
globalvar mt_gif_frame;mt_gif_frame=gif_std_haxe_class_create(8,"gif_frame");
globalvar mt_gif_reader;mt_gif_reader=gif_std_haxe_class_create(9,"gif_reader");
globalvar mt_format_gif_block;mt_format_gif_block=gif_std_haxe_enum_create(10,"format_gif_block");
globalvar mt_format_gif_extension;mt_format_gif_extension=gif_std_haxe_enum_create(11,"format_gif_extension");
globalvar mt_format_gif_application_extension;mt_format_gif_application_extension=gif_std_haxe_enum_create(12,"format_gif_application_extension");
globalvar mt_format_gif_version;mt_format_gif_version=gif_std_haxe_enum_create(13,"format_gif_version");
globalvar mt_format_gif_disposal_method;mt_format_gif_disposal_method=gif_std_haxe_enum_create(14,"format_gif_disposal_method");
globalvar mt_gif_std_haxe_class;mt_gif_std_haxe_class=gif_std_haxe_class_create(16,"gif_std_haxe_class");
globalvar mt_gif_std_haxe_enum;mt_gif_std_haxe_enum=gif_std_haxe_class_create(17,"gif_std_haxe_enum");
globalvar mt_gif_std_haxe_io_Bytes;mt_gif_std_haxe_io_Bytes=gif_std_haxe_class_create(18,"gif_std_haxe_io_Bytes");
globalvar mt_gif_std_haxe_io_Output;mt_gif_std_haxe_io_Output=gif_std_haxe_class_create(19,"gif_std_haxe_io_Output");
globalvar mt_gif_std_haxe_io_BytesOutput;mt_gif_std_haxe_io_BytesOutput=gif_std_haxe_class_create(20,"gif_std_haxe_io_BytesOutput");
globalvar g_gif_white32; /// @is {sprite}
g_gif_white32=-1;
globalvar g_gif_reader_read_string_tmp_buf; /// @is {buffer}
g_gif_reader_read_string_tmp_buf=-1;
/// @typedef {array} format_gif_block
globalvar format_gif_block_beof;format_gif_block_beof=mc_format_gif_block_beof(); /// @is {format_gif_block}
/// @typedef {array} format_gif_extension
/// @typedef {array} format_gif_application_extension
/// @typedef {array} format_gif_version
globalvar format_gif_version_gif87a;format_gif_version_gif87a=mc_format_gif_version_gif87a(); /// @is {format_gif_version}
globalvar format_gif_version_gif89a;format_gif_version_gif89a=mc_format_gif_version_gif89a(); /// @is {format_gif_version}
/// @typedef {array} format_gif_disposal_method
globalvar format_gif_disposal_method_unspecified;format_gif_disposal_method_unspecified=mc_format_gif_disposal_method_unspecified(); /// @is {format_gif_disposal_method}
globalvar format_gif_disposal_method_no_action;format_gif_disposal_method_no_action=mc_format_gif_disposal_method_no_action(); /// @is {format_gif_disposal_method}
globalvar format_gif_disposal_method_fill_background;format_gif_disposal_method_fill_background=mc_format_gif_disposal_method_fill_background(); /// @is {format_gif_disposal_method}
globalvar format_gif_disposal_method_render_previous;format_gif_disposal_method_render_previous=mc_format_gif_disposal_method_render_previous(); /// @is {format_gif_disposal_method}
globalvar g_haxe_io__bytes_bytes_impl_buffer; /// @is {buffer}
haxe_io__bytes_bytes_impl_buffer=buffer_create(128,buffer_grow,1);

#define gif_create
var _this;_this[0]=mt_gif;
array_copy(_this,1,mq_gif,1,4);
/// @typedef {tuple<any,frames:array<gif_frame>,width:int,height:int,loops:int>} gif
_this[@4]=-1;
_this[@3]=0;
_this[@2]=0;
_this[@1]=gif_std_haxe_boot_decl();
return _this;

#define sprite_add_gif_buffer
var _delays;
if(argument_count>3)_delays=argument[3];else _delays=undefined;
var _white32=g_gif_white32;
if(_white32==-1){
	var _ws=surface_create(32,32);
	surface_set_target(_ws);
	draw_clear(16777215);
	surface_reset_target();
	_white32=sprite_create_from_surface(_ws,0,0,surface_get_width(_ws),surface_get_height(_ws),false,false,0,0);
	surface_free(_ws);
	g_gif_white32=_white32;
}
var _gif=gif_create();
gif_read(_gif,argument[0]);
var _sf=surface_create(_gif[2],_gif[3]);
surface_set_target(_sf);
draw_clear_alpha(16777215,0);
surface_reset_target();
var _restoreBuf=-1;
var _spr=-1;
var __color=draw_get_color();
var __alpha=draw_get_alpha();
draw_set_color(16777215);
draw_set_alpha(1);
var _firstDelay=0;
var __g=0;
var __g1=_gif[1];
while(__g<array_length_1d(__g1)){
	var _frame=__g1[__g];
	++__g;
	if(_frame[8]==2){
		if(_restoreBuf==-1)_restoreBuf=buffer_create(_gif[2]*_gif[3]*4,buffer_fixed,1);
		buffer_get_surface(_restoreBuf,_sf,0,0,0);
	}
	surface_copy(_sf,_frame[4],_frame[5],_frame[2]);
	if(_spr==-1)_spr=sprite_create_from_surface(_sf,0,0,surface_get_width(_sf),surface_get_height(_sf),false,false,argument[1],argument[2]); else sprite_add_from_surface(_spr,_sf,0,0,surface_get_width(_sf),surface_get_height(_sf),false,false);
	var _fdelay=_frame[1];
	if(_delays!=undefined)gif_std_gml_internal_ArrayImpl_push(_delays,_fdelay);
	if(_firstDelay<=0&&_fdelay>0)_firstDelay=_fdelay;
	switch(_frame[8]){
		case 2:buffer_set_surface(_restoreBuf,_sf,0,0,0);break;
		case 1:
			surface_set_target(_sf);
			var _mode=bm_subtract;
			draw_set_blend_mode(_mode);
			draw_sprite_stretched(_white32,0,_frame[4],_frame[5],_frame[6],_frame[7]);
			var _mode1=bm_normal;
			draw_set_blend_mode(_mode1);
			surface_reset_target();
			break;
	}
}
draw_set_color(__color);
draw_set_alpha(__alpha);
if(_restoreBuf!=-1)buffer_delete(_restoreBuf);
gif_destroy(_gif);
surface_free(_sf);
return _spr;

#define sprite_add_gif
var _delays;
if(argument_count>3)_delays=argument[3];else _delays=undefined;
var _buf=buffer_load(argument[0]);
var _spr=sprite_add_gif_buffer(_buf,argument[1],argument[2],_delays);
buffer_delete(_buf);
return _spr;

#define gif_destroy
var _this=argument[0];
var __g=0;
var __g1=_this[1];
while(__g<array_length_1d(__g1)){
	var _frame=__g1[__g];
	++__g;
	gif_frame_destroy(_frame);
}

#define gif_read
var _this=argument[0],_gif_buffer=argument[1];
var _n=buffer_get_size(_gif_buffer);
var _bytes_b=gmv_array_create(_n,0);
var _i=0;
for(var __g1=_n;_i<__g1;++_i){
	_bytes_b[@_i]=(buffer_peek(_gif_buffer,_i,buffer_u8)&255);
}
var _q=gif_reader_read(gif_reader_create(_gif_buffer));
_this[@2]=gif_std_haxe_boot_wget(_q[1],0);
_this[@3]=gif_std_haxe_boot_wget(_q[1],1);
var _gce=undefined;
var _globalColorTable=undefined;
if(_q[2]!=undefined)_globalColorTable=_gif_gif_tools_color_table_to_vector(_q[2],gif_std_haxe_boot_wget(_q[1],5));
var __break=false;
var __g=0;
var __g1=_q[3];
while(__g<array_length_1d(__g1)){
	var _block=__g1[__g];
	++__g;
	switch(_block[0]){
		case 0:
			var _f=_block[1];
			var _gf=gif_frame_create();
			var _transparentIndex=-1;
			if(_gce!=undefined){
				_gf[@1]=_gce[3];
				if(_gce[2])_transparentIndex=_gce[4];
				switch(gif_std_haxe_boot_wget(_gce[0],0)){
					case 2:_gf[@8]=1;break;
					case 3:_gf[@8]=2;break;
				}
			}
			_gf[@4]=_f[0];
			_gf[@5]=_f[1];
			_gf[@6]=_f[2];
			_gf[@7]=_f[3];
			var _colorTable=_globalColorTable;
			if(_f[9]!=undefined)_colorTable=_gif_gif_tools_color_table_to_vector(_f[9],_f[7]);
			var _fWidth=_f[2];
			var _fHeight=_f[3];
			var _sf=surface_create(_fWidth,_fHeight);
			var _pxData=gif_std_haxe_boot_wget(_f[8],1);
			var _buf=buffer_create(_f[2]*_f[3]*4,buffer_fixed,1);
			var _i=0;
			for(var __g3=array_length_1d(gif_std_haxe_boot_wget(_f[8],1));_i<__g3;++_i){
				var _col=_pxData[_i];
				if(_col==_transparentIndex)buffer_write(_buf,buffer_s32,0); else buffer_write(_buf,buffer_s32,_colorTable[_col]);
			}
			_gf[@3]=_buf;
			buffer_set_surface(_buf,_sf,0,0,0);
			_gf[@2]=_sf;
			_gce=undefined;
			gif_std_gml_internal_ArrayImpl_push(_this[1],_gf);
			break;
		case 1:
			var __g4=_block[1];
			switch(__g4[0]){
				case 3:
					var __g5=__g4[1];
					if(__g5[0]==0){
						var _n=__g5[1];
						_this[@4]=_n;
					}
					break;
				case 0:_gce=__g4[1];break;
			}
			break;
		case 2:__break=true;break;
	}
	if(__break)break;
}

#define gif_frame_create
var _this;_this[0]=mt_gif_frame;
array_copy(_this,1,mq_gif_frame,1,8);
/// @typedef {tuple<any,delay:int,surface:surface,buffer:buffer,x:int,y:int,width:int,height:int,disposal_method:int>} gif_frame
_this[@8]=0;
_this[@3]=-1;
_this[@1]=0;
return _this;

#define gif_frame_destroy
var _this=argument[0];
if(surface_exists(_this[2]))surface_free(_this[2]);
if(_this[3]!=-1)buffer_delete(_this[3]);

#define _gif_gif_tools_color_table_to_vector
var _pal=argument[0],_num=argument[1];
var _r,_g,_b;
var _p=0;
var _a=255;
var _vec=gmv_array_create(_num,undefined);
var _i=0;
for(var __g1=_num;_i<__g1;++_i){
	_r=gif_std_haxe_boot_wget(_pal[1],_p);
	_g=gif_std_haxe_boot_wget(_pal[1],_p+1);
	_b=gif_std_haxe_boot_wget(_pal[1],_p+2);
	var _val=((((_a<<24)|(_b<<16))|(_g<<8))|_r);
	_vec[@_i]=_val;
	_p+=3;
}
return _vec;

#define gif_reader_create
var _this;_this[0]=mt_gif_reader;
array_copy(_this,1,mq_gif_reader,1,1);
/// @typedef {tuple<any,i:buffer>} gif_reader
_this[@1]=argument[0];
return _this;

#define gif_reader_read_string
var _this=argument[0],_len=argument[1];
var _buf=g_gif_reader_read_string_tmp_buf;
if(_buf==-1){
	_buf=buffer_create(_len+1,buffer_fixed,1);
	g_gif_reader_read_string_tmp_buf=_buf;
} else if(buffer_get_size(_buf)<=_len){
	buffer_resize(_buf,_len+1);
}
buffer_poke(_buf,gif_std_gml_io__Buffer_BufferImpl_readBuffer(_this[1],_buf,0,_len),buffer_u8,0);
buffer_seek(_buf,buffer_seek_start,0);
return buffer_read(_buf,buffer_string);

#define gif_reader_read
var _this=argument[0];
var _b=71;
if(buffer_read(_this[1],buffer_u8)!=_b)show_error(string("Invalid header"),false);
var _b=73;
if(buffer_read(_this[1],buffer_u8)!=_b)show_error(string("Invalid header"),false);
var _b=70;
if(buffer_read(_this[1],buffer_u8)!=_b)show_error(string("Invalid header"),false);
var _gifVer=gif_reader_read_string(_this,3);
var _version=format_gif_version_gif89a;
switch(_gifVer){
	case "87a":_version=format_gif_version_gif87a;break;
	case "89a":_version=format_gif_version_gif89a;break;
	default:_version=format_gif_version_unknown(_gifVer);
}
var _width=buffer_read(_this[1],buffer_u16);
var _height=buffer_read(_this[1],buffer_u16);
var _packedField=buffer_read(_this[1],buffer_u8);
var _bgIndex=buffer_read(_this[1],buffer_u8);
var _pixelAspectRatio=buffer_read(_this[1],buffer_u8);
if(_pixelAspectRatio!=0)_pixelAspectRatio=(_pixelAspectRatio+15)/64; else _pixelAspectRatio=1;
var _lsd=undefined;
_lsd[7]=_pixelAspectRatio;
_lsd[0]=_width;
_lsd[1]=_height;
_lsd[2]=(_packedField&128)==128;
_lsd[3]=((((_packedField&112) & $FFFFFFFF) >> 4));
_lsd[4]=(_packedField&8)==8;
_lsd[5]=(2<<(_packedField&7));
_lsd[6]=_bgIndex;
var _gct=undefined;
if(_lsd[2])_gct=gif_reader_read_color_table(_this,_lsd[5]);
var _blocks=gif_std_haxe_boot_decl();
while(true){
	var _b=gif_reader_read_block(_this);
	gif_std_gml_internal_ArrayImpl_push(_blocks,_b);
	if(_b==format_gif_block_beof)break;
}
return gif_std_haxe_boot_odecl("GifData",4,0,_version,1,_lsd,2,_gct,3,_blocks);

#define gif_reader_read_block
var _this=argument[0];
var _blockID=buffer_read(_this[1],buffer_u8);
switch(_blockID){
	case 44:return gif_reader_read_image(_this);
	case 33:return gif_reader_read_extension(_this);
	case 59:return format_gif_block_beof;
}
return format_gif_block_beof;

#define gif_reader_read_image
var _this=argument[0];
var _x=buffer_read(_this[1],buffer_u16);
var _y=buffer_read(_this[1],buffer_u16);
var _width=buffer_read(_this[1],buffer_u16);
var _height=buffer_read(_this[1],buffer_u16);
var _packed=buffer_read(_this[1],buffer_u8);
var _localColorTable=(_packed&128)==128;
var _interlaced=(_packed&64)==64;
var _sorted=(_packed&32)==32;
var _localColorTableSize=(2<<(_packed&7));
var _lct=undefined;
if(_localColorTable)_lct=gif_reader_read_color_table(_this,_localColorTableSize);
var _frame=undefined;
_frame[9]=_lct;
_frame[0]=_x;
_frame[1]=_y;
_frame[2]=_width;
_frame[3]=_height;
_frame[4]=_localColorTable;
_frame[5]=_interlaced;
_frame[6]=_sorted;
_frame[7]=_localColorTableSize;
_frame[8]=gif_reader_read_pixels(_this,_width,_height,_interlaced);
return format_gif_block_bframe(_frame);

#define gif_reader_read_pixels
var _this=argument[0],_width=argument[1],_height=argument[2];
var _input=_this[1];
var _pixelsCount=_width*_height;
var _pixels=gif_std_haxe_io_Bytes_create(gmv_array_create(_pixelsCount,0));
var _minCodeSize=buffer_read(_input,buffer_u8);
var _blockSize=buffer_read(_input,buffer_u8)-1;
var _bits=buffer_read(_input,buffer_u8);
var _bitsCount=8;
var _clearCode=(1<<_minCodeSize);
var _eoiCode=_clearCode+1;
var _codeSize=_minCodeSize+1;
var _codeSizeLimit=(1<<_codeSize);
var _codeMask=_codeSizeLimit-1;
var _baseDict=gif_std_haxe_boot_decl();
var _i=0;
for(var __g1=_clearCode;_i<__g1;++_i){
	_baseDict[@_i]=gif_std_haxe_boot_decl(_i);
}
var _dict=gif_std_haxe_boot_decl();
var _dictLen=_clearCode+2;
var _newRecord;
var _i=0;
var _code=0;
var _last;
while(_i<_pixelsCount){
	_last=_code;
	while(_bitsCount<_codeSize){
		if(_blockSize==0)break;
		_bits|=(buffer_read(_input,buffer_u8)<<_bitsCount);
		_bitsCount+=8;
		--_blockSize;
		if(_blockSize==0)_blockSize=buffer_read(_input,buffer_u8);
	}
	_code=(_bits&_codeMask);
	_bits=_bits>>_codeSize;
	_bitsCount-=_codeSize;
	if(_code==_clearCode){
		_dict=gif_std_gml_internal_ArrayImpl_copy(_baseDict);
		_dictLen=_clearCode+2;
		_codeSize=_minCodeSize+1;
		_codeSizeLimit=(1<<_codeSize);
		_codeMask=_codeSizeLimit-1;
		continue;
	}
	if(_code==_eoiCode)break;
	if(_code<_dictLen){
		if(_last!=_clearCode){
			_newRecord=gif_std_gml_internal_ArrayImpl_copy(_dict[_last]);
			gif_std_gml_internal_ArrayImpl_push(_newRecord,gif_std_haxe_boot_wget(_dict[_code],0));
			_dict[@_dictLen++]=_newRecord;
		}
	} else {
		if(_code!=_dictLen)show_error(string("Invalid LZW code. Excepted: "+string(_dictLen)+", got: "+string(_code)),false);
		_newRecord=gif_std_gml_internal_ArrayImpl_copy(_dict[_last]);
		gif_std_gml_internal_ArrayImpl_push(_newRecord,_newRecord[0]);
		_dict[@_dictLen++]=_newRecord;
	}
	_newRecord=_dict[_code];
	var __g=0;
	while(__g<array_length_1d(_newRecord)){
		var _item=_newRecord[__g];
		++__g;
		gif_std_haxe_boot_wset(_pixels[1],_i++,(_item&255));
	}
	if(_dictLen==_codeSizeLimit&&_codeSize<12){
		++_codeSize;
		_codeSizeLimit=(1<<_codeSize);
		_codeMask=_codeSizeLimit-1;
	}
}
while(_blockSize>0){
	buffer_read(_input,buffer_u8);
	--_blockSize;
	if(_blockSize==0)_blockSize=buffer_read(_input,buffer_u8);
}
while(_i<_pixelsCount){
	gif_std_haxe_boot_wset(_pixels[1],_i++,0);
}
if(argument[3]){
	var _buffer1=gif_std_haxe_io_Bytes_create(gmv_array_create(_pixelsCount,0));
	var _offset=gif_reader_deinterlace(_this,_pixels,_buffer1,8,0,0,_width,_height);
	_offset=gif_reader_deinterlace(_this,_pixels,_buffer1,8,4,_offset,_width,_height);
	_offset=gif_reader_deinterlace(_this,_pixels,_buffer1,4,2,_offset,_width,_height);
	gif_reader_deinterlace(_this,_pixels,_buffer1,2,1,_offset,_width,_height);
	_pixels=_buffer1;
}
return _pixels;

#define gif_reader_deinterlace
var _input=argument[1],_output=argument[2],_y=argument[4],_offset=argument[5],_width=argument[6];
while(_y<argument[7]){
	array_copy(_output[1],_y*_width,_input[1],_offset,_width);
	_offset+=_width;
	_y+=argument[3];
}
return _offset;

#define gif_reader_read_extension
var _this=argument[0];
var _subId=buffer_read(_this[1],buffer_u8);
switch(_subId){
	case 249:
		if(buffer_read(_this[1],buffer_u8)!=4)show_error(string("Incorrect Graphic Control Extension block size!"),false);
		var _packed=buffer_read(_this[1],buffer_u8);
		var _disposalMethod;
		switch((_packed&28)>>2){
			case 2:_disposalMethod=format_gif_disposal_method_fill_background;break;
			case 3:_disposalMethod=format_gif_disposal_method_render_previous;break;
			case 1:_disposalMethod=format_gif_disposal_method_no_action;break;
			case 0:_disposalMethod=format_gif_disposal_method_unspecified;break;
			default:_disposalMethod=format_gif_disposal_method_undefined_hx(((_packed&28)>>2));
		}
		var _delay=buffer_read(_this[1],buffer_u16);
		var _gcx=undefined;
		_gcx[4]=0;
		_gcx[0]=_disposalMethod;
		_gcx[1]=(_packed&2)==2;
		_gcx[2]=(_packed&1)==1;
		_gcx[3]=_delay;
		_gcx[4]=buffer_read(_this[1],buffer_u8);
		var _b=format_gif_block_bextension(format_gif_extension_egraphic_control(_gcx));
		buffer_read(_this[1],buffer_u8);
		return _b;
	case 1:
		if(buffer_read(_this[1],buffer_u8)!=12)show_error(string("Incorrect size of Plain Text Extension introducer block."),false);
		var _textGridX=buffer_read(_this[1],buffer_u16);
		var _textGridY=buffer_read(_this[1],buffer_u16);
		var _textGridWidth=buffer_read(_this[1],buffer_u16);
		var _textGridHeight=buffer_read(_this[1],buffer_u16);
		var _charCellWidth=buffer_read(_this[1],buffer_u8);
		var _charCellHeight=buffer_read(_this[1],buffer_u8);
		var _textForegroundColorIndex=buffer_read(_this[1],buffer_u8);
		var _textBackgroundColorIndex=buffer_read(_this[1],buffer_u8);
		var _buffer1=gif_std_haxe_io_BytesOutput_create();
		var _bytes=gif_std_haxe_io_Bytes_create(gmv_array_create(255,0));
		var _bdata=_bytes[1];
		for(var _len=buffer_read(_this[1],buffer_u8);_len!=0;_len=buffer_read(_this[1],buffer_u8)){
			var _k=0;
			for(var __g1=_len;_k<__g1;++_k){
				_bdata[@_k]=buffer_read(_this[1],buffer_u8);
			}
			gif_std_haxe_io_Output_writeBytes(_buffer1,_bytes,0,_len);
		}
		script_execute(_buffer1[4],_buffer1);
		_bytes=gif_std_haxe_io_Bytes_create(_buffer1[1]);
		script_execute(_buffer1[5],_buffer1);
		var __this=_bytes;
		var _ptx=undefined;
		_ptx[8]=0;
		_ptx[0]=_textGridX;
		_ptx[1]=_textGridY;
		_ptx[2]=_textGridWidth;
		_ptx[3]=_textGridHeight;
		_ptx[4]=_charCellWidth;
		_ptx[5]=_charCellHeight;
		_ptx[6]=_textForegroundColorIndex;
		_ptx[7]=_textBackgroundColorIndex;
		_ptx[8]=haxe_io__bytes_bytes_impl_get_string(__this[1],0,array_length_1d(__this[1]));
		return format_gif_block_bextension(format_gif_extension_etext(_ptx));
	case 254:
		var _buffer1=gif_std_haxe_io_BytesOutput_create();
		var _bytes=gif_std_haxe_io_Bytes_create(gmv_array_create(255,0));
		var _bdata=_bytes[1];
		for(var _len=buffer_read(_this[1],buffer_u8);_len!=0;_len=buffer_read(_this[1],buffer_u8)){
			var _k=0;
			for(var __g1=_len;_k<__g1;++_k){
				_bdata[@_k]=buffer_read(_this[1],buffer_u8);
			}
			gif_std_haxe_io_Output_writeBytes(_buffer1,_bytes,0,_len);
		}
		script_execute(_buffer1[4],_buffer1);
		_bytes=gif_std_haxe_io_Bytes_create(_buffer1[1]);
		script_execute(_buffer1[5],_buffer1);
		var __this=_bytes;
		return format_gif_block_bextension(format_gif_extension_ecomment(haxe_io__bytes_bytes_impl_get_string(__this[1],0,array_length_1d(__this[1]))));
	case 255:return gif_reader_read_application_extension(_this);
	default:
		var _buffer1=gif_std_haxe_io_BytesOutput_create();
		var _bytes=gif_std_haxe_io_Bytes_create(gmv_array_create(255,0));
		var _bdata=_bytes[1];
		for(var _len=buffer_read(_this[1],buffer_u8);_len!=0;_len=buffer_read(_this[1],buffer_u8)){
			var _k=0;
			for(var __g1=_len;_k<__g1;++_k){
				_bdata[@_k]=buffer_read(_this[1],buffer_u8);
			}
			gif_std_haxe_io_Output_writeBytes(_buffer1,_bytes,0,_len);
		}
		script_execute(_buffer1[4],_buffer1);
		_bytes=gif_std_haxe_io_Bytes_create(_buffer1[1]);
		script_execute(_buffer1[5],_buffer1);
		return format_gif_block_bextension(format_gif_extension_eunknown(_subId,_bytes));
}

#define gif_reader_read_application_extension
var _this=argument[0];
if(buffer_read(_this[1],buffer_u8)!=11)show_error(string("Incorrect size of Application Extension introducer block."),false);
var _name=gif_reader_read_string(_this,8);
var _version=gif_reader_read_string(_this,3);
var _buffer1=gif_std_haxe_io_BytesOutput_create();
var _bytes=gif_std_haxe_io_Bytes_create(gmv_array_create(255,0));
var _bdata=_bytes[1];
for(var _len=buffer_read(_this[1],buffer_u8);_len!=0;_len=buffer_read(_this[1],buffer_u8)){
	var _k=0;
	for(var __g1=_len;_k<__g1;++_k){
		_bdata[@_k]=buffer_read(_this[1],buffer_u8);
	}
	gif_std_haxe_io_Output_writeBytes(_buffer1,_bytes,0,_len);
}
script_execute(_buffer1[4],_buffer1);
_bytes=gif_std_haxe_io_Bytes_create(_buffer1[1]);
script_execute(_buffer1[5],_buffer1);
var _data=_bytes;
if(_name=="NETSCAPE"&&_version=="2.0"&&gif_std_haxe_boot_wget(_data[1],0)==1)return format_gif_block_bextension(format_gif_extension_eapplication_extension(format_gif_application_extension_aenetscape_looping((gif_std_haxe_boot_wget(_data[1],1)|(gif_std_haxe_boot_wget(_data[1],2)<<8)))));
return format_gif_block_bextension(format_gif_extension_eapplication_extension(format_gif_application_extension_aeunknown(_name,_version,_data)));

#define gif_reader_read_color_table
var _this=argument[0],_size=argument[1];
_size*=3;
var _output=gif_std_haxe_io_Bytes_create(gmv_array_create(_size,0));
for(var _c=0;_c<_size;_c+=3){
	var _v=buffer_read(_this[1],buffer_u8);
	gif_std_haxe_boot_wset(_output[1],_c,(_v&255));
	var _v1=buffer_read(_this[1],buffer_u8);
	gif_std_haxe_boot_wset(_output[1],_c+1,(_v1&255));
	var _v2=buffer_read(_this[1],buffer_u8);
	gif_std_haxe_boot_wset(_output[1],_c+2,(_v2&255));
}
return _output;

#define format_gif_block_bframe
var _this;
_this[0]=0;
_this[1]=argument[0];
return _this;

#define format_gif_block_bextension
var _this;
_this[0]=1;
_this[1]=argument[0];
return _this;

#define mc_format_gif_block_beof
var _this;
_this[0]=2;
return _this;

#define format_gif_extension_egraphic_control
var _this;
_this[0]=0;
_this[1]=argument[0];
return _this;

#define format_gif_extension_ecomment
var _this;
_this[0]=1;
_this[1]=argument[0];
return _this;

#define format_gif_extension_etext
var _this;
_this[0]=2;
_this[1]=argument[0];
return _this;

#define format_gif_extension_eapplication_extension
var _this;
_this[0]=3;
_this[1]=argument[0];
return _this;

#define format_gif_extension_eunknown
var _this;
_this[0]=4;
_this[1]=argument[0];
_this[2]=argument[1];
return _this;

#define format_gif_application_extension_aenetscape_looping
var _this;
_this[0]=0;
_this[1]=argument[0];
return _this;

#define format_gif_application_extension_aeunknown
var _this;
_this[0]=1;
_this[1]=argument[0];
_this[2]=argument[1];
_this[3]=argument[2];
return _this;

#define mc_format_gif_version_gif87a
var _this;
_this[0]=0;
return _this;

#define mc_format_gif_version_gif89a
var _this;
_this[0]=1;
return _this;

#define format_gif_version_unknown
var _this;
_this[0]=2;
_this[1]=argument[0];
return _this;

#define mc_format_gif_disposal_method_unspecified
var _this;
_this[0]=0;
return _this;

#define mc_format_gif_disposal_method_no_action
var _this;
_this[0]=1;
return _this;

#define mc_format_gif_disposal_method_fill_background
var _this;
_this[0]=2;
return _this;

#define mc_format_gif_disposal_method_render_previous
var _this;
_this[0]=3;
return _this;

#define format_gif_disposal_method_undefined_hx
var _this;
_this[0]=4;
_this[1]=argument[0];
return _this;

#define gif_std_haxe_type_proto
var _n=argument_count;
var _out=undefined;
for(var _i=0;_i<_n;++_i){
	_out[_i] = argument[_i];
}
return _out;

#define gif_std_haxe_class_create
var _this;_this[0]="mt_gif_std_haxe_class";
array_copy(_this,1,mq_gif_std_haxe_class,1,5);
/// @typedef {tuple<any,marker:any,index:int,name:string,superClass:haxe_class<any>,constructor:any>} gif_std_haxe_class
_this[@4]=undefined;
_this[@1]=gif_std_haxe_type_markerValue;
_this[@2]=argument[0];
_this[@3]=argument[1];
return _this;

#define gif_std_haxe_enum_create
var _this;_this[0]="mt_gif_std_haxe_enum";
array_copy(_this,1,mq_gif_std_haxe_enum,1,5);
/// @typedef {tuple<any,marker:any,index:int,name:string,constructors:array<string>,functions:array<haxe_Function>>} gif_std_haxe_enum
var _constructors,_functions;
if(argument_count>2)_constructors=argument[2];else _constructors=undefined;
if(argument_count>3)_functions=argument[3];else _functions=undefined;
_this[@1]=gif_std_haxe_type_markerValue;
_this[@2]=argument[0];
_this[@3]=argument[1];
_this[@4]=_constructors;
_this[@5]=_functions;
return _this;

#define gif_std_gml_internal_ArrayImpl_push
var _arr=argument[0];
var _i=array_length_1d(_arr);
_arr[@_i]=argument[1];
return _i;

#define gif_std_gml_internal_ArrayImpl_copy
var _arr=argument[0];
var _out;
var _len=array_length_1d(_arr);
if(_len>0){
	_out=gmv_array_create(_len,0);
	array_copy(_out,0,_arr,0,_len);
} else _out=gif_std_haxe_boot_decl();
return _out;

#define gif_std_gml_io__Buffer_BufferImpl_readBuffer
var _src=argument[0],_dst=argument[1],_dstPos=argument[2];
var _srcPos=buffer_tell(_src);
var _srcLen=min(argument[3],buffer_get_size(_src)-_srcPos);
var _dstLen=min(_srcLen,buffer_get_size(_dst)-_dstPos);
if(_srcLen<0)return 0;
if(_dstLen<0){
	buffer_seek(_src,buffer_seek_relative,_srcLen);
	return 0;
}
buffer_copy(_src,_srcPos,_dstLen,_dst,_dstPos);
buffer_seek(_src,buffer_seek_relative,_srcLen);
return _dstLen;

#define gif_std_haxe_io_Bytes_create
var _this;_this[0]=mt_gif_std_haxe_io_Bytes;
array_copy(_this,1,mq_gif_std_haxe_io_Bytes,1,1);
/// @typedef {tuple<any,b:haxe_io_BytesData>} gif_std_haxe_io_Bytes
_this[@1]=argument[0];
return _this;

#define haxe_io__bytes_bytes_impl_get_string
var _d=argument[0];
var _b=haxe_io__bytes_bytes_impl_buffer;
buffer_seek(_b,buffer_seek_start,0);
while(--argument[2]>=0){
	buffer_write(_b,buffer_u8,_d[argument[1]++]);
}
buffer_write(_b,buffer_u8,0);
buffer_seek(_b,buffer_seek_start,0);
return buffer_read(_b,buffer_string);

#define gif_std_haxe_io_Output_new
var _this=argument[0];
_this[@3]=32;
_this[@2]=0;
_this[@1]=gmv_array_create(32,0);

#define gif_std_haxe_io_Output_create
var _this;_this[0]=mt_gif_std_haxe_io_Output;
array_copy(_this,1,mq_gif_std_haxe_io_Output,1,5);
/// @typedef {tuple<any,data:haxe_io_BytesData,dataPos:int,dataLen:int,flush:function<void>,close:function<void>>} gif_std_haxe_io_Output
_this[@4]=gif_std_haxe_io_Output_flush;
_this[@5]=gif_std_haxe_io_Output_close;
gif_std_haxe_io_Output_new(_this);
return _this;

#define gif_std_haxe_io_Output_flush
var _this=argument[0];


#define gif_std_haxe_io_Output_close
var _this=argument[0];


#define gif_std_haxe_io_Output_writeBytes
var _this=argument[0],_b=argument[1],_len=argument[3];
var _bd=_b[1];
var _p0=_this[2];
var _p1=_p0+_len;
var _d=_this[1];
var _dlen=_this[3];
if(_p1>_dlen){
	do {
		_dlen*=2;
	} until(_p1<=_dlen);
	_dlen*=2;
	_d[@_dlen-1]=0;
	_this[@3]=_dlen;
}
array_copy(_d,_p0,_bd,argument[2],_len);
_this[@2]=_p1;
return _len;

#define gif_std_haxe_io_BytesOutput_create
var _this;_this[0]=mt_gif_std_haxe_io_BytesOutput;
array_copy(_this,1,mq_gif_std_haxe_io_BytesOutput,1,5);
/// @typedef {tuple<any,data:haxe_io_BytesData,dataPos:int,dataLen:int,flush:function<void>,close:function<void>>} gif_std_haxe_io_BytesOutput
_this[@4]=gif_std_haxe_io_Output_flush;
_this[@5]=gif_std_haxe_io_Output_close;
gif_std_haxe_io_Output_new(_this);
return _this;

#define gif_std_haxe_boot_decl
var _n=argument_count;
var _i,_r;
if(_n==0){
	_r=undefined;
	var _val=undefined;
	_r[1, 0] = _val;
	return _r;
}
if(os_browser!=browser_not_a_browser){
	_r=undefined;
	_r[@0]=argument[0];
	_i=0;
	while(++_i<_n){
		_r[_i] = argument[_i];
	}
} else {
	_r=undefined;
	while(--_n>=0){
		_r[_n] = argument[_n];
	}
}
return _r;

#define gif_std_haxe_boot_odecl
var _size=argument[1];
var _i;
var _r=undefined;
if(os_browser!=browser_not_a_browser){
	_i=0;
	while(_i<_size){
		_r[_i] = undefined;
	}
} else {
	_i=_size;
	while(--_i>=0){
		_r[_i] = undefined;
	}
}
var _n=argument_count;
for(_i=2;_i<_n;_i+=2){
	_r[@argument[_i]]=argument[_i+1];
}
return _r;

#define gif_std_haxe_boot_wget
var _arr=argument[0],_index=argument[1];
return _arr[_index];

#define gif_std_haxe_boot_wset
var _arr=argument[0],_index=argument[1];
_arr[@_index]=argument[2];

/// @typedef {array<int>} haxe_io_BytesData