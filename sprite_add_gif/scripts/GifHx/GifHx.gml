// Generated at 2023-04-22 03:31:18 (389ms) for v2.3.1+
/// @lint nullToAny true
// Feather disable all
globalvar gif_std_haxe_type_markerValue;gif_std_haxe_type_markerValue=[];
globalvar mt_Gif;
globalvar mt_GifFrame;
globalvar mt_GifReader;
globalvar mt_format_gif_Block;
globalvar mt_format_gif_Extension;
globalvar mt_format_gif_ApplicationExtension;
globalvar mt_format_gif_Version;
globalvar mt_format_gif_DisposalMethod;
globalvar mt_gif_std_haxe_class;
globalvar mt_gif_std_haxe_enum;
globalvar mt_gif_std_haxe_io_Bytes;
globalvar mt_gif_std_haxe_io_Output;
globalvar mt_gif_std_haxe_io_BytesOutput;
(function(){
mt_Gif=new gif_std_haxe_class(-1,"Gif");
mt_GifFrame=new gif_std_haxe_class(-1,"GifFrame");
mt_GifReader=new gif_std_haxe_class(-1,"GifReader");
mt_format_gif_Block=new gif_std_haxe_enum(-1,"format_gif_Block");
mt_format_gif_Extension=new gif_std_haxe_enum(-1,"format_gif_Extension");
mt_format_gif_ApplicationExtension=new gif_std_haxe_enum(-1,"format_gif_ApplicationExtension");
mt_format_gif_Version=new gif_std_haxe_enum(-1,"format_gif_Version");
mt_format_gif_DisposalMethod=new gif_std_haxe_enum(-1,"format_gif_DisposalMethod");
mt_gif_std_haxe_class=new gif_std_haxe_class(-1,"gif_std_haxe_class");
mt_gif_std_haxe_enum=new gif_std_haxe_class(-1,"gif_std_haxe_enum");
mt_gif_std_haxe_io_Bytes=new gif_std_haxe_class(-1,"gif_std_haxe_io_Bytes");
mt_gif_std_haxe_io_Output=new gif_std_haxe_class(-1,"gif_std_haxe_io_Output");
mt_gif_std_haxe_io_BytesOutput=new gif_std_haxe_class(-1,"gif_std_haxe_io_BytesOutput");
mt_gif_std_haxe_io_BytesOutput.superClass=mt_gif_std_haxe_io_Output;
})();
function gif_std_enum_toString(){
	return gif_std_Std_stringify(self);
}
function gif_std_enum_getIndex(){
	return __enumIndex__;
}

function Gif()constructor{
	static frames=undefined; /// @is {array<GifFrame>}
	static width=undefined; /// @is {int}
	static height=undefined; /// @is {int}
	static loops=undefined; /// @is {int}
	static destroy=function(){
		var _this=self;
		var __g=0;
		var __g1=_this.frames;
		while(__g<array_length(__g1)){
			var _frame=__g1[__g];
			__g++;
			_frame.destroy();
		}
	}
	static read=function(_gif_buffer){
		var _this=self;
		var _n=buffer_get_size(_gif_buffer);
		var _bytes_b=array_create(_n,0);
		var _i=0;
		for(var __g1=_n;_i<__g1;_i++){
			_bytes_b[@_i]=(buffer_peek(_gif_buffer,_i,buffer_u8)&255);
		}
		var _q=new GifReader(_gif_buffer).read();
		_this.width=_q.logicalScreenDescriptor.width;
		_this.height=_q.logicalScreenDescriptor.height;
		var _gce=undefined;
		var _globalColorTable=undefined;
		if(_q.globalColorTable!=undefined)_globalColorTable=_Gif_GifTools_colorTableToVector(_q.globalColorTable,_q.logicalScreenDescriptor.globalColorTableSize);
		var __break=false;
		var __g=0;
		var __g1=_q.blocks;
		while(__g<array_length(__g1)){
			var _block=__g1[__g];
			__g++;
			switch(_block.__enumIndex__){
				case 0:
					var _f=_block.frame;
					var _gf=new GifFrame();
					var _transparentIndex=-1;
					if(_gce!=undefined){
						_gf.delay=_gce.delay;
						if(_gce.hasTransparentColor)_transparentIndex=_gce.transparentIndex;
						switch(_gce.disposalMethod.__enumIndex__){
							case 2:_gf.disposalMethod=1;break;
							case 3:_gf.disposalMethod=2;break;
						}
					}
					_gf.x=_f.x;
					_gf.y=_f.y;
					_gf.width=_f.width;
					_gf.height=_f.height;
					var _colorTable=_globalColorTable;
					if(_f.colorTable!=undefined)_colorTable=_Gif_GifTools_colorTableToVector(_f.colorTable,_f.localColorTableSize);
					var _buf=buffer_create(_f.width*_f.height*4,buffer_fixed,1);
					var _pxData=_f.pixels.b;
					var _i=0;
					for(var __g3=array_length(_f.pixels.b);_i<__g3;_i++){
						var _col=_pxData[_i];
						if(_col==_transparentIndex)buffer_write(_buf,buffer_s32,0); else buffer_write(_buf,buffer_s32,_colorTable[_col]);
					}
					_gf.buffer=_buf;
					var _base="frame"+string(array_length(_this.frames));
					var _sf=surface_create(_f.width,_f.height);
					gif_std_gml_io__Buffer_BufferImpl_setSurface(_buf,_sf,0);
					_gf.surface=_sf;
					buffer_save(_buf,_base+".bin");
					surface_save(_sf,_base+".png");
					_gce=undefined;
					array_push(_this.frames,_gf);
					break;
				case 1:
					var __g4=_block.extension;
					switch(__g4.__enumIndex__){
						case 3:
							var __g5=__g4.ext;
							if(__g5.__enumIndex__==0){
								var _n=__g5.loops;
								_this.loops=_n;
							}
							break;
						case 0:_gce=__g4.gce;break;
					}
					break;
				case 2:__break=true;break;
			}
			if(__break)break;
		}
	}
	var _this=self;
	_this.loops=-1;
	_this.height=0;
	_this.width=0;
	_this.frames=[];
	static __class__=mt_Gif;
}

function sprite_add_gif_buffer(_buf,_xorig,_yorig,_delays){
	if(false)show_debug_message(argument[3]);
	var _gif=new Gif();
	_gif.read(_buf);
	var _sf=surface_create(_gif.width,_gif.height);
	surface_set_target(_sf);
	draw_clear_alpha(16777215,0);
	surface_reset_target();
	var _restoreBuf=-1;
	var _spr=-1;
	var _white32=Gif_white32;
	if(_white32==-1){
		var _ws=surface_create(32,32);
		surface_set_target(_ws);
		draw_clear(16777215);
		surface_reset_target();
		_white32=sprite_create_from_surface(_ws,0,0,surface_get_width(_ws),surface_get_height(_ws),false,false,0,0);
		surface_free(_ws);
		Gif_white32=_white32;
	}
	var __color=draw_get_color();
	var __alpha=draw_get_alpha();
	draw_set_color(16777215);
	draw_set_alpha(1);
	var _firstDelay=0;
	var __g=0;
	var __g1=_gif.frames;
	while(__g<array_length(__g1)){
		var _frame=__g1[__g];
		__g++;
		if(_frame.disposalMethod==2){
			if(_restoreBuf==-1)_restoreBuf=buffer_create(_gif.width*_gif.height*4,buffer_fixed,1);
			gif_std_gml_io__Buffer_BufferImpl_getSurface(_restoreBuf,_sf,0);
		}
		surface_copy(_sf,_frame.x,_frame.y,_frame.surface);
		if(_spr==-1)_spr=sprite_create_from_surface(_sf,0,0,surface_get_width(_sf),surface_get_height(_sf),false,false,_xorig,_yorig); else sprite_add_from_surface(_spr,_sf,0,0,surface_get_width(_sf),surface_get_height(_sf),false,false);
		var _fdelay=_frame.delay;
		if(_delays!=undefined)array_push(_delays,_fdelay);
		if(_firstDelay<=0&&_fdelay>0)_firstDelay=_fdelay;
		switch(_frame.disposalMethod){
			case 2:gif_std_gml_io__Buffer_BufferImpl_setSurface(_restoreBuf,_sf,0);break;
			case 1:
				surface_set_target(_sf);
				var _mode=bm_subtract;
				gpu_set_blendmode(_mode);
				draw_sprite_stretched(_white32,0,_frame.x,_frame.y,_frame.width,_frame.height);
				var _mode1=bm_normal;
				gpu_set_blendmode(_mode1);
				surface_reset_target();
				break;
		}
	}
	if(_firstDelay>0)sprite_set_speed(_spr,100/_firstDelay,spritespeed_framespersecond);
	draw_set_color(__color);
	draw_set_alpha(__alpha);
	if(_restoreBuf!=-1)buffer_delete(_restoreBuf);
	_gif.destroy();
	surface_free(_sf);
	return _spr;
}

function sprite_add_gif(_path1,_xorig,_yorig,_delays){
	if(false)show_debug_message(argument[3]);
	var _buf=buffer_load(_path1);
	var _spr=sprite_add_gif_buffer(_buf,_xorig,_yorig,_delays);
	buffer_delete(_buf);
	return _spr;
}

function GifFrame()constructor{
	static delay=undefined; /// @is {int}
	static surface=undefined; /// @is {surface}
	static buffer=undefined; /// @is {buffer}
	x=undefined; /// @is {int}
	y=undefined; /// @is {int}
	static width=undefined; /// @is {int}
	static height=undefined; /// @is {int}
	static disposalMethod=undefined; /// @is {int}
	static destroy=function(){
		var _this=self;
		if(surface_exists(_this.surface))surface_free(_this.surface);
		buffer_delete(_this.buffer);
	}
	var _this=self;
	_this.disposalMethod=0;
	_this.delay=0;
	static __class__=mt_GifFrame;
}

function _Gif_GifTools_colorTableToVector(_pal,_num){
	var _r,_g,_b;
	var _p=0;
	var _a=255;
	var _vec=array_create(_num,undefined);
	var _i=0;
	for(var __g1=_num;_i<__g1;_i++){
		_r=_pal.b[_p];
		_g=_pal.b[_p+1];
		_b=_pal.b[_p+2];
		var _val=((((_a<<24)|(_b<<16))|(_g<<8))|_r);
		_vec[@_i]=_val;
		_p+=3;
	}
	return _vec;
}

function GifReader(_i)constructor{
	static i=undefined; /// @is {buffer}
	static readString=function(_len){
		var _this=self;
		var _buf=GifReader_readString_tmpBuf;
		if(_buf==-1){
			_buf=buffer_create(_len+1,buffer_fixed,1);
			GifReader_readString_tmpBuf=_buf;
		} else if(buffer_get_size(_buf)<=_len){
			buffer_resize(_buf,_len+1);
		}
		buffer_poke(_buf,gif_std_gml_io__Buffer_BufferImpl_readBuffer(_this.i,_buf,0,_len),buffer_u8,0);
		buffer_seek(_buf,buffer_seek_start,0);
		return buffer_read(_buf,buffer_string);
	}
	static read=function(){
		var _this=self;
		var _b=71;
		if(buffer_read(_this.i,buffer_u8)!=_b)throw string("Invalid header");
		var _b=73;
		if(buffer_read(_this.i,buffer_u8)!=_b)throw string("Invalid header");
		var _b=70;
		if(buffer_read(_this.i,buffer_u8)!=_b)throw string("Invalid header");
		var _gifVer=_this.readString(3);
		var _version=format_gif_Version_GIF89a;
		switch(_gifVer){
			case "87a":_version=format_gif_Version_GIF87a;break;
			case "89a":_version=format_gif_Version_GIF89a;break;
			default:_version=format_gif_Version_Unknown(_gifVer);
		}
		var _width=buffer_read(_this.i,buffer_u16);
		var _height=buffer_read(_this.i,buffer_u16);
		var _packedField=buffer_read(_this.i,buffer_u8);
		var _bgIndex=buffer_read(_this.i,buffer_u8);
		var _pixelAspectRatio=buffer_read(_this.i,buffer_u8);
		if(_pixelAspectRatio!=0)_pixelAspectRatio=(_pixelAspectRatio+15)/64; else _pixelAspectRatio=1;
		var _lsd={
			width:_width,
			height:_height,
			hasGlobalColorTable:(_packedField&128)==128,
			colorResolution:((((_packedField&112) & $FFFFFFFF) >> 4)),
			sorted:(_packedField&8)==8,
			globalColorTableSize:(2<<(_packedField&7)),
			backgroundColorIndex:_bgIndex,
			pixelAspectRatio:_pixelAspectRatio
		}
		var _gct=undefined;
		if(_lsd.hasGlobalColorTable)_gct=_this.readColorTable(_lsd.globalColorTableSize);
		var _blocks=[];
		while(true){
			var _b=_this.readBlock();
			array_push(_blocks,_b);
			if(_b==format_gif_Block_BEOF)break;
		}
		return {
			version:_version,
			logicalScreenDescriptor:_lsd,
			globalColorTable:_gct,
			blocks:_blocks
		}
	}
	static readBlock=function(){
		var _this=self;
		var _blockID=buffer_read(_this.i,buffer_u8);
		switch(_blockID){
			case 44:return _this.readImage();
			case 33:return _this.readExtension();
			case 59:return format_gif_Block_BEOF;
		}
		return format_gif_Block_BEOF;
	}
	static readImage=function(){
		var _this=self;
		var _x=buffer_read(_this.i,buffer_u16);
		var _y=buffer_read(_this.i,buffer_u16);
		var _width=buffer_read(_this.i,buffer_u16);
		var _height=buffer_read(_this.i,buffer_u16);
		var _packed=buffer_read(_this.i,buffer_u8);
		var _localColorTable=(_packed&128)==128;
		var _interlaced=(_packed&64)==64;
		var _sorted=(_packed&32)==32;
		var _localColorTableSize=(2<<(_packed&7));
		var _lct=undefined;
		if(_localColorTable)_lct=_this.readColorTable(_localColorTableSize);
		var _frame={
			x:_x,
			y:_y,
			width:_width,
			height:_height,
			localColorTable:_localColorTable,
			interlaced:_interlaced,
			sorted:_sorted,
			localColorTableSize:_localColorTableSize,
			pixels:_this.readPixels(_width,_height,_interlaced),
			colorTable:_lct
		}
		return format_gif_Block_BFrame(_frame);
	}
	static readPixels=function(_width,_height,_interlaced){
		var _this=self;
		var _input=_this.i;
		var _pixelsCount=_width*_height;
		var _pixels=new gif_std_haxe_io_Bytes(array_create(_pixelsCount,0));
		var _minCodeSize=buffer_read(_input,buffer_u8);
		var _blockSize=buffer_read(_input,buffer_u8)-1;
		var _bits=buffer_read(_input,buffer_u8);
		var _bitsCount=8;
		var _clearCode=(1<<_minCodeSize);
		var _eoiCode=_clearCode+1;
		var _codeSize=_minCodeSize+1;
		var _codeSizeLimit=(1<<_codeSize);
		var _codeMask=_codeSizeLimit-1;
		var _baseDict=[];
		var _i=0;
		for(var __g1=_clearCode;_i<__g1;_i++){
			_baseDict[@_i]=[_i];
		}
		var _dict=[];
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
				_blockSize--;
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
					array_push(_newRecord,_dict[_code][0]);
					_dict[@_dictLen++]=_newRecord;
				}
			} else {
				if(_code!=_dictLen)throw string("Invalid LZW code. Excepted: "+string(_dictLen)+", got: "+string(_code));
				_newRecord=gif_std_gml_internal_ArrayImpl_copy(_dict[_last]);
				array_push(_newRecord,_newRecord[0]);
				_dict[@_dictLen++]=_newRecord;
			}
			_newRecord=_dict[_code];
			var __g=0;
			while(__g<array_length(_newRecord)){
				var _item=_newRecord[__g];
				__g++;
				_pixels.b[@_i++]=(_item&255);
			}
			if(_dictLen==_codeSizeLimit&&_codeSize<12){
				_codeSize++;
				_codeSizeLimit=(1<<_codeSize);
				_codeMask=_codeSizeLimit-1;
			}
		}
		while(_blockSize>0){
			buffer_read(_input,buffer_u8);
			_blockSize--;
			if(_blockSize==0)_blockSize=buffer_read(_input,buffer_u8);
		}
		while(_i<_pixelsCount){
			_pixels.b[@_i++]=0;
		}
		if(_interlaced){
			var _buffer1=new gif_std_haxe_io_Bytes(array_create(_pixelsCount,0));
			var _offset=_this.deinterlace(_pixels,_buffer1,8,0,0,_width,_height);
			_offset=_this.deinterlace(_pixels,_buffer1,8,4,_offset,_width,_height);
			_offset=_this.deinterlace(_pixels,_buffer1,4,2,_offset,_width,_height);
			_this.deinterlace(_pixels,_buffer1,2,1,_offset,_width,_height);
			_pixels=_buffer1;
		}
		return _pixels;
	}
	static deinterlace=function(_input,_output,_step,_y,_offset,_width,_height){
		var _this=self;
		while(_y<_height){
			array_copy(_output.b,_y*_width,_input.b,_offset,_width);
			_offset+=_width;
			_y+=_step;
		}
		return _offset;
	}
	static readExtension=function(){
		var _this=self;
		var _subId=buffer_read(_this.i,buffer_u8);
		switch(_subId){
			case 249:
				if(buffer_read(_this.i,buffer_u8)!=4)throw string("Incorrect Graphic Control Extension block size!");
				var _packed=buffer_read(_this.i,buffer_u8);
				var _disposalMethod;
				switch((_packed&28)>>2){
					case 2:_disposalMethod=format_gif_DisposalMethod_FILL_BACKGROUND;break;
					case 3:_disposalMethod=format_gif_DisposalMethod_RENDER_PREVIOUS;break;
					case 1:_disposalMethod=format_gif_DisposalMethod_NO_ACTION;break;
					case 0:_disposalMethod=format_gif_DisposalMethod_UNSPECIFIED;break;
					default:_disposalMethod=format_gif_DisposalMethod_UNDEFINED(((_packed&28)>>2));
				}
				var _delay=buffer_read(_this.i,buffer_u16);
				var _gcx={
					disposalMethod:_disposalMethod,
					userInput:(_packed&2)==2,
					hasTransparentColor:(_packed&1)==1,
					delay:_delay,
					transparentIndex:buffer_read(_this.i,buffer_u8)
				}
				var _b=format_gif_Block_BExtension(format_gif_Extension_EGraphicControl(_gcx));
				buffer_read(_this.i,buffer_u8);
				return _b;
			case 1:
				if(buffer_read(_this.i,buffer_u8)!=12)throw string("Incorrect size of Plain Text Extension introducer block.");
				var _textGridX=buffer_read(_this.i,buffer_u16);
				var _textGridY=buffer_read(_this.i,buffer_u16);
				var _textGridWidth=buffer_read(_this.i,buffer_u16);
				var _textGridHeight=buffer_read(_this.i,buffer_u16);
				var _charCellWidth=buffer_read(_this.i,buffer_u8);
				var _charCellHeight=buffer_read(_this.i,buffer_u8);
				var _textForegroundColorIndex=buffer_read(_this.i,buffer_u8);
				var _textBackgroundColorIndex=buffer_read(_this.i,buffer_u8);
				var _buffer1=new gif_std_haxe_io_BytesOutput();
				var _bytes=new gif_std_haxe_io_Bytes(array_create(255,0));
				var _bdata=_bytes.b;
				for(var _len=buffer_read(_this.i,buffer_u8);_len!=0;_len=buffer_read(_this.i,buffer_u8)){
					var _k=0;
					for(var __g1=_len;_k<__g1;_k++){
						_bdata[@_k]=buffer_read(_this.i,buffer_u8);
					}
					_buffer1.writeBytes(_bytes,0,_len);
				}
				_buffer1.flush();
				_bytes=new gif_std_haxe_io_Bytes(_buffer1.data);
				_buffer1.close();
				var __this=_bytes;
				var _ptx={
					textGridX:_textGridX,
					textGridY:_textGridY,
					textGridWidth:_textGridWidth,
					textGridHeight:_textGridHeight,
					charCellWidth:_charCellWidth,
					charCellHeight:_charCellHeight,
					textForegroundColorIndex:_textForegroundColorIndex,
					textBackgroundColorIndex:_textBackgroundColorIndex,
					text:haxe_io__Bytes_BytesImpl_getString(__this.b,0,array_length(__this.b))
				}
				return format_gif_Block_BExtension(format_gif_Extension_EText(_ptx));
			case 254:
				var _buffer1=new gif_std_haxe_io_BytesOutput();
				var _bytes=new gif_std_haxe_io_Bytes(array_create(255,0));
				var _bdata=_bytes.b;
				for(var _len=buffer_read(_this.i,buffer_u8);_len!=0;_len=buffer_read(_this.i,buffer_u8)){
					var _k=0;
					for(var __g1=_len;_k<__g1;_k++){
						_bdata[@_k]=buffer_read(_this.i,buffer_u8);
					}
					_buffer1.writeBytes(_bytes,0,_len);
				}
				_buffer1.flush();
				_bytes=new gif_std_haxe_io_Bytes(_buffer1.data);
				_buffer1.close();
				var __this=_bytes;
				return format_gif_Block_BExtension(format_gif_Extension_EComment(haxe_io__Bytes_BytesImpl_getString(__this.b,0,array_length(__this.b))));
			case 255:return _this.readApplicationExtension();
			default:
				var _buffer1=new gif_std_haxe_io_BytesOutput();
				var _bytes=new gif_std_haxe_io_Bytes(array_create(255,0));
				var _bdata=_bytes.b;
				for(var _len=buffer_read(_this.i,buffer_u8);_len!=0;_len=buffer_read(_this.i,buffer_u8)){
					var _k=0;
					for(var __g1=_len;_k<__g1;_k++){
						_bdata[@_k]=buffer_read(_this.i,buffer_u8);
					}
					_buffer1.writeBytes(_bytes,0,_len);
				}
				_buffer1.flush();
				_bytes=new gif_std_haxe_io_Bytes(_buffer1.data);
				_buffer1.close();
				return format_gif_Block_BExtension(format_gif_Extension_EUnknown(_subId,_bytes));
		}
	}
	static readApplicationExtension=function(){
		var _this=self;
		if(buffer_read(_this.i,buffer_u8)!=11)throw string("Incorrect size of Application Extension introducer block.");
		var _name=_this.readString(8);
		var _version=_this.readString(3);
		var _buffer1=new gif_std_haxe_io_BytesOutput();
		var _bytes=new gif_std_haxe_io_Bytes(array_create(255,0));
		var _bdata=_bytes.b;
		for(var _len=buffer_read(_this.i,buffer_u8);_len!=0;_len=buffer_read(_this.i,buffer_u8)){
			var _k=0;
			for(var __g1=_len;_k<__g1;_k++){
				_bdata[@_k]=buffer_read(_this.i,buffer_u8);
			}
			_buffer1.writeBytes(_bytes,0,_len);
		}
		_buffer1.flush();
		_bytes=new gif_std_haxe_io_Bytes(_buffer1.data);
		_buffer1.close();
		var _data=_bytes;
		if(_name=="NETSCAPE"&&_version=="2.0"&&_data.b[0]==1)return format_gif_Block_BExtension(format_gif_Extension_EApplicationExtension(format_gif_ApplicationExtension_AENetscapeLooping((_data.b[1]|(_data.b[2]<<8)))));
		return format_gif_Block_BExtension(format_gif_Extension_EApplicationExtension(format_gif_ApplicationExtension_AEUnknown(_name,_version,_data)));
	}
	static readColorTable=function(_size){
		var _this=self;
		_size*=3;
		var _output=new gif_std_haxe_io_Bytes(array_create(_size,0));
		for(var _c=0;_c<_size;_c+=3){
			var _v=buffer_read(_this.i,buffer_u8);
			_output.b[@_c]=(_v&255);
			var _v1=buffer_read(_this.i,buffer_u8);
			_output.b[@_c+1]=(_v1&255);
			var _v2=buffer_read(_this.i,buffer_u8);
			_output.b[@_c+2]=(_v2&255);
		}
		return _output;
	}
	var _this=self;
	_this.i=_i;
	static __class__=mt_GifReader;
}

function gif_std_Std_stringify(_value){
	if(_value==undefined)return "null";
	if(is_string(_value))return _value;
	var _n,_i,_s;
	if(is_struct(_value)){
		var _e=_value[$"__enum__"];
		if(_e==undefined)return string(_value);
		var _ects=_e.constructors;
		if(_ects!=undefined){
			_i=_value.__enumIndex__;
			if(_i>=0&&_i<array_length(_ects))_s=_ects[_i]; else _s="?";
		} else {
			_s=instanceof(_value);
			if(string_copy(_s,1,3)=="mc_")_s=string_delete(_s,1,3);
			_n=string_length(_e.name);
			if(string_copy(_s,1,_n)==_e.name)_s=string_delete(_s,1,_n+1);
		}
		_s+="(";
		var _fields=_value.__enumParams__;
		_n=array_length(_fields);
		for(_i=-1;++_i<_n;_s+=gif_std_Std_stringify(_value[$ _fields[_i]])){
			if(_i>0)_s+=", ";
		}
		return _s+")";
	}
	if(is_real(_value)){
		_s=string_format(_value,0,16);
		if(os_browser!=browser_not_a_browser){
			_n=string_length(_s);
			_i=_n;
			while(_i>0){
				switch(string_ord_at(_s,_i)){
					case 48:
						_i--;
						continue;
					case 46:_i--;break;
				}
				break;
			}
		} else {
			_n=string_byte_length(_s);
			_i=_n;
			while(_i>0){
				switch(string_byte_at(_s,_i)){
					case 48:
						_i--;
						continue;
					case 46:_i--;break;
				}
				break;
			}
		}
		return string_copy(_s,1,_i);
	}
	return string(_value);
}

/// @interface {format_gif_Block}
function mc_format_gif_Block()constructor{
	/// @hint {array} format_gif_Block:__enumParams__
	/// @hint {int} format_gif_Block:__enumIndex__
	static getIndex=method(undefined,gif_std_enum_getIndex);
	static toString=method(undefined,gif_std_enum_toString);
	static __enum__=mt_format_gif_Block;
}

global.__mp_format_gif_Block_BFrame=["frame"];
/// @implements {format_gif_Block}
function mc_format_gif_Block_BFrame():mc_format_gif_Block()constructor{
	/// @hint {format_gif_Frame} :frame
	static __enumParams__=global.__mp_format_gif_Block_BFrame;
	static __enumIndex__=0;
}

function format_gif_Block_BFrame(_frame){
	var _this=new mc_format_gif_Block_BFrame();
	_this.frame=_frame;
	return _this
}

global.__mp_format_gif_Block_BExtension=["extension"];
/// @implements {format_gif_Block}
function mc_format_gif_Block_BExtension():mc_format_gif_Block()constructor{
	/// @hint {format_gif_Extension} :extension
	static __enumParams__=global.__mp_format_gif_Block_BExtension;
	static __enumIndex__=1;
}

function format_gif_Block_BExtension(_extension){
	var _this=new mc_format_gif_Block_BExtension();
	_this.extension=_extension;
	return _this
}

global.__mp_format_gif_Block_BEOF=[];
/// @implements {format_gif_Block}
function mc_format_gif_Block_BEOF():mc_format_gif_Block()constructor{
	static __enumParams__=global.__mp_format_gif_Block_BEOF;
	static __enumIndex__=2;
}
globalvar format_gif_Block_BEOF;format_gif_Block_BEOF=new mc_format_gif_Block_BEOF(); /// @is {format_gif_Block}

/// @interface {format_gif_Extension}
function mc_format_gif_Extension()constructor{
	/// @hint {array} format_gif_Extension:__enumParams__
	/// @hint {int} format_gif_Extension:__enumIndex__
	static getIndex=method(undefined,gif_std_enum_getIndex);
	static toString=method(undefined,gif_std_enum_toString);
	static __enum__=mt_format_gif_Extension;
}

global.__mp_format_gif_Extension_EGraphicControl=["gce"];
/// @implements {format_gif_Extension}
function mc_format_gif_Extension_EGraphicControl():mc_format_gif_Extension()constructor{
	/// @hint {format_gif_GraphicControlExtension} :gce
	static __enumParams__=global.__mp_format_gif_Extension_EGraphicControl;
	static __enumIndex__=0;
}

function format_gif_Extension_EGraphicControl(_gce){
	var _this=new mc_format_gif_Extension_EGraphicControl();
	_this.gce=_gce;
	return _this
}

global.__mp_format_gif_Extension_EComment=["text"];
/// @implements {format_gif_Extension}
function mc_format_gif_Extension_EComment():mc_format_gif_Extension()constructor{
	/// @hint {string} :text
	static __enumParams__=global.__mp_format_gif_Extension_EComment;
	static __enumIndex__=1;
}

function format_gif_Extension_EComment(_text){
	var _this=new mc_format_gif_Extension_EComment();
	_this.text=_text;
	return _this
}

global.__mp_format_gif_Extension_EText=["pte"];
/// @implements {format_gif_Extension}
function mc_format_gif_Extension_EText():mc_format_gif_Extension()constructor{
	/// @hint {format_gif_PlainTextExtension} :pte
	static __enumParams__=global.__mp_format_gif_Extension_EText;
	static __enumIndex__=2;
}

function format_gif_Extension_EText(_pte){
	var _this=new mc_format_gif_Extension_EText();
	_this.pte=_pte;
	return _this
}

global.__mp_format_gif_Extension_EApplicationExtension=["ext"];
/// @implements {format_gif_Extension}
function mc_format_gif_Extension_EApplicationExtension():mc_format_gif_Extension()constructor{
	/// @hint {format_gif_ApplicationExtension} :ext
	static __enumParams__=global.__mp_format_gif_Extension_EApplicationExtension;
	static __enumIndex__=3;
}

function format_gif_Extension_EApplicationExtension(_ext){
	var _this=new mc_format_gif_Extension_EApplicationExtension();
	_this.ext=_ext;
	return _this
}

global.__mp_format_gif_Extension_EUnknown=["id","data"];
/// @implements {format_gif_Extension}
function mc_format_gif_Extension_EUnknown():mc_format_gif_Extension()constructor{
	/// @hint {int} :id
	/// @hint {gif_std_haxe_io_Bytes} :data
	static __enumParams__=global.__mp_format_gif_Extension_EUnknown;
	static __enumIndex__=4;
}

function format_gif_Extension_EUnknown(_id,_data){
	var _this=new mc_format_gif_Extension_EUnknown();
	_this.id=_id;
	_this.data=_data;
	return _this
}

/// @interface {format_gif_ApplicationExtension}
function mc_format_gif_ApplicationExtension()constructor{
	/// @hint {array} format_gif_ApplicationExtension:__enumParams__
	/// @hint {int} format_gif_ApplicationExtension:__enumIndex__
	static getIndex=method(undefined,gif_std_enum_getIndex);
	static toString=method(undefined,gif_std_enum_toString);
	static __enum__=mt_format_gif_ApplicationExtension;
}

global.__mp_format_gif_ApplicationExtension_AENetscapeLooping=["loops"];
/// @implements {format_gif_ApplicationExtension}
function mc_format_gif_ApplicationExtension_AENetscapeLooping():mc_format_gif_ApplicationExtension()constructor{
	/// @hint {int} :loops
	static __enumParams__=global.__mp_format_gif_ApplicationExtension_AENetscapeLooping;
	static __enumIndex__=0;
}

function format_gif_ApplicationExtension_AENetscapeLooping(_loops){
	var _this=new mc_format_gif_ApplicationExtension_AENetscapeLooping();
	_this.loops=_loops;
	return _this
}

global.__mp_format_gif_ApplicationExtension_AEUnknown=["name","version","data"];
/// @implements {format_gif_ApplicationExtension}
function mc_format_gif_ApplicationExtension_AEUnknown():mc_format_gif_ApplicationExtension()constructor{
	/// @hint {string} :name
	/// @hint {string} :version
	/// @hint {gif_std_haxe_io_Bytes} :data
	static __enumParams__=global.__mp_format_gif_ApplicationExtension_AEUnknown;
	static __enumIndex__=1;
}

function format_gif_ApplicationExtension_AEUnknown(_name,_version,_data){
	var _this=new mc_format_gif_ApplicationExtension_AEUnknown();
	_this.name=_name;
	_this.version=_version;
	_this.data=_data;
	return _this
}

/// @interface {format_gif_Version}
function mc_format_gif_Version()constructor{
	/// @hint {array} format_gif_Version:__enumParams__
	/// @hint {int} format_gif_Version:__enumIndex__
	static getIndex=method(undefined,gif_std_enum_getIndex);
	static toString=method(undefined,gif_std_enum_toString);
	static __enum__=mt_format_gif_Version;
}

global.__mp_format_gif_Version_GIF87a=[];
/// @implements {format_gif_Version}
function mc_format_gif_Version_GIF87a():mc_format_gif_Version()constructor{
	static __enumParams__=global.__mp_format_gif_Version_GIF87a;
	static __enumIndex__=0;
}
globalvar format_gif_Version_GIF87a;format_gif_Version_GIF87a=new mc_format_gif_Version_GIF87a(); /// @is {format_gif_Version}

global.__mp_format_gif_Version_GIF89a=[];
/// @implements {format_gif_Version}
function mc_format_gif_Version_GIF89a():mc_format_gif_Version()constructor{
	static __enumParams__=global.__mp_format_gif_Version_GIF89a;
	static __enumIndex__=1;
}
globalvar format_gif_Version_GIF89a;format_gif_Version_GIF89a=new mc_format_gif_Version_GIF89a(); /// @is {format_gif_Version}

global.__mp_format_gif_Version_Unknown=["version"];
/// @implements {format_gif_Version}
function mc_format_gif_Version_Unknown():mc_format_gif_Version()constructor{
	/// @hint {string} :version
	static __enumParams__=global.__mp_format_gif_Version_Unknown;
	static __enumIndex__=2;
}

function format_gif_Version_Unknown(_version){
	var _this=new mc_format_gif_Version_Unknown();
	_this.version=_version;
	return _this
}

/// @interface {format_gif_DisposalMethod}
function mc_format_gif_DisposalMethod()constructor{
	/// @hint {array} format_gif_DisposalMethod:__enumParams__
	/// @hint {int} format_gif_DisposalMethod:__enumIndex__
	static getIndex=method(undefined,gif_std_enum_getIndex);
	static toString=method(undefined,gif_std_enum_toString);
	static __enum__=mt_format_gif_DisposalMethod;
}

global.__mp_format_gif_DisposalMethod_UNSPECIFIED=[];
/// @implements {format_gif_DisposalMethod}
function mc_format_gif_DisposalMethod_UNSPECIFIED():mc_format_gif_DisposalMethod()constructor{
	static __enumParams__=global.__mp_format_gif_DisposalMethod_UNSPECIFIED;
	static __enumIndex__=0;
}
globalvar format_gif_DisposalMethod_UNSPECIFIED;format_gif_DisposalMethod_UNSPECIFIED=new mc_format_gif_DisposalMethod_UNSPECIFIED(); /// @is {format_gif_DisposalMethod}

global.__mp_format_gif_DisposalMethod_NO_ACTION=[];
/// @implements {format_gif_DisposalMethod}
function mc_format_gif_DisposalMethod_NO_ACTION():mc_format_gif_DisposalMethod()constructor{
	static __enumParams__=global.__mp_format_gif_DisposalMethod_NO_ACTION;
	static __enumIndex__=1;
}
globalvar format_gif_DisposalMethod_NO_ACTION;format_gif_DisposalMethod_NO_ACTION=new mc_format_gif_DisposalMethod_NO_ACTION(); /// @is {format_gif_DisposalMethod}

global.__mp_format_gif_DisposalMethod_FILL_BACKGROUND=[];
/// @implements {format_gif_DisposalMethod}
function mc_format_gif_DisposalMethod_FILL_BACKGROUND():mc_format_gif_DisposalMethod()constructor{
	static __enumParams__=global.__mp_format_gif_DisposalMethod_FILL_BACKGROUND;
	static __enumIndex__=2;
}
globalvar format_gif_DisposalMethod_FILL_BACKGROUND;format_gif_DisposalMethod_FILL_BACKGROUND=new mc_format_gif_DisposalMethod_FILL_BACKGROUND(); /// @is {format_gif_DisposalMethod}

global.__mp_format_gif_DisposalMethod_RENDER_PREVIOUS=[];
/// @implements {format_gif_DisposalMethod}
function mc_format_gif_DisposalMethod_RENDER_PREVIOUS():mc_format_gif_DisposalMethod()constructor{
	static __enumParams__=global.__mp_format_gif_DisposalMethod_RENDER_PREVIOUS;
	static __enumIndex__=3;
}
globalvar format_gif_DisposalMethod_RENDER_PREVIOUS;format_gif_DisposalMethod_RENDER_PREVIOUS=new mc_format_gif_DisposalMethod_RENDER_PREVIOUS(); /// @is {format_gif_DisposalMethod}

global.__mp_format_gif_DisposalMethod_UNDEFINED=["index"];
/// @implements {format_gif_DisposalMethod}
function mc_format_gif_DisposalMethod_UNDEFINED():mc_format_gif_DisposalMethod()constructor{
	/// @hint {int} :index
	static __enumParams__=global.__mp_format_gif_DisposalMethod_UNDEFINED;
	static __enumIndex__=4;
}

function format_gif_DisposalMethod_UNDEFINED(_index){
	var _this=new mc_format_gif_DisposalMethod_UNDEFINED();
	_this.index=_index;
	return _this
}

function gif_std_haxe_class(_id,_name)constructor{
	static superClass=undefined; /// @is {haxe_class<any>}
	static marker=undefined; /// @is {any}
	static index=undefined; /// @is {int}
	static name=undefined; /// @is {string}
	var _this=self;
	_this.superClass=undefined;
	_this.marker=gif_std_haxe_type_markerValue;
	_this.index=_id;
	_this.name=_name;
	static __class__="class";
}

function gif_std_haxe_enum(_id,_name,_constructors,_functions)constructor{
	static constructors=undefined; /// @is {array<string>}
	static functions=undefined; /// @is {array<haxe_Function>}
	static marker=undefined; /// @is {any}
	static index=undefined; /// @is {int}
	static name=undefined; /// @is {string}
	var _this=self;
	if(false)show_debug_message(argument[3]);
	_this.marker=gif_std_haxe_type_markerValue;
	_this.index=_id;
	_this.name=_name;
	_this.constructors=_constructors;
	_this.functions=_functions;
	static __class__="enum";
}

function gif_std_gml_NativeTypeHelper_isNumber(_v){
	return (is_real(_v)||is_bool(_v)||is_int32(_v))||is_int64(_v);
}

function gif_std_gml_internal_ArrayImpl_copy(_arr){
	var _out;
	var _len=array_length(_arr);
	if(_len>0){
		_out=array_create(_len,0);
		array_copy(_out,0,_arr,0,_len);
	} else _out=[];
	return _out;
}

function gif_std_gml_io__Buffer_BufferImpl_readBuffer(_src,_dst,_dstPos,_len){
	var _srcPos=buffer_tell(_src);
	var _srcLen=min(_len,buffer_get_size(_src)-_srcPos);
	var _dstLen=min(_srcLen,buffer_get_size(_dst)-_dstPos);
	if(_srcLen<0)return 0;
	if(_dstLen<0){
		buffer_seek(_src,buffer_seek_relative,_srcLen);
		return 0;
	}
	buffer_copy(_src,_srcPos,_dstLen,_dst,_dstPos);
	buffer_seek(_src,buffer_seek_relative,_srcLen);
	return _dstLen;
}

function gif_std_gml_io__Buffer_BufferImpl_bufferSurfaceFunctionsHave3args_init(){
	var _rt=GM_runtime_version;
	if(string_pos("2.3.0.",_rt)==1)return false;
	if(string_pos("23.1.1.",_rt)!=1)return true;
	var _buildStr=string_delete(_rt,1,string_length("23.1.1."));
	if(string_digits(_buildStr)!=_buildStr)return true;
	var _buildNum=real(_buildStr);
	return _buildNum>=186;
}

function gif_std_gml_io__Buffer_BufferImpl_getSetSurface_init(_fn){
	var _ctx={fn:_fn}
	if(gif_std_gml_io__Buffer_BufferImpl_bufferSurfaceFunctionsHave3args)return method(_ctx,function(_buf,_surf,_offset){
		self.fn(_buf,_surf,_offset);
	}); else return method(_ctx,function(_buf,_surf,_offset){
		self.fn(_buf,_surf,0,_offset,0);
	});
}

function gif_std_haxe_io_Bytes(_b)constructor{
	static b=undefined; /// @is {haxe_io_BytesData}
	var _this=self;
	_this.b=_b;
	static __class__=mt_gif_std_haxe_io_Bytes;
}

function haxe_io__Bytes_BytesImpl_getString(_d,_pos,_len){
	var _b=haxe_io__Bytes_BytesImpl_buffer;
	buffer_seek(_b,buffer_seek_start,0);
	while(--_len>=0){
		buffer_write(_b,buffer_u8,_d[_pos++]);
	}
	buffer_write(_b,buffer_u8,0);
	buffer_seek(_b,buffer_seek_start,0);
	return buffer_read(_b,buffer_string);
}

function gif_std_haxe_io_Output_new(){
	var _this=self;
	_this.dataLen=32;
	_this.dataPos=0;
	_this.data=array_create(32,0);
}

function gif_std_haxe_io_Output()constructor{
	static data=undefined; /// @is {haxe_io_BytesData}
	static dataPos=undefined; /// @is {int}
	static dataLen=undefined; /// @is {int}
	static flush=method(undefined,gif_std_haxe_io_Output_flush);
	static close=method(undefined,gif_std_haxe_io_Output_close);
	static writeBytes=method(undefined,gif_std_haxe_io_Output_writeBytes);
	method(self, gif_std_haxe_io_Output_new)();
	static __class__=mt_gif_std_haxe_io_Output;
}

function gif_std_haxe_io_Output_flush(){
	var _this=self;
	
}

function gif_std_haxe_io_Output_close(){
	var _this=self;
	
}

function gif_std_haxe_io_Output_writeBytes(_b,_pos,_len){
	var _this=self;
	var _bd=_b.b;
	var _p0=_this.dataPos;
	var _p1=_p0+_len;
	var _d=_this.data;
	var _dlen=_this.dataLen;
	if(_p1>_dlen){
		do {
			_dlen*=2;
		} until(_p1<=_dlen);
		_dlen*=2;
		_d[@_dlen-1]=0;
		_this.dataLen=_dlen;
	}
	array_copy(_d,_p0,_bd,_pos,_len);
	_this.dataPos=_p1;
	return _len;
}

function gif_std_haxe_io_BytesOutput()constructor{
	static data=undefined; /// @is {haxe_io_BytesData}
	static dataPos=undefined; /// @is {int}
	static dataLen=undefined; /// @is {int}
	static flush=method(undefined,gif_std_haxe_io_Output_flush);
	static close=method(undefined,gif_std_haxe_io_Output_close);
	static writeBytes=method(undefined,gif_std_haxe_io_Output_writeBytes);
	var _this=self;
	method(_this, gif_std_haxe_io_Output_new)();
	static __class__=mt_gif_std_haxe_io_BytesOutput;
}

globalvar Gif_white32; /// @is {sprite}
Gif_white32=-1;
globalvar GifReader_readString_tmpBuf; /// @is {buffer}
GifReader_readString_tmpBuf=-1;
globalvar gif_std_gml_io__Buffer_BufferImpl_bufferSurfaceFunctionsHave3args; /// @is {bool}
gif_std_gml_io__Buffer_BufferImpl_bufferSurfaceFunctionsHave3args=gif_std_gml_io__Buffer_BufferImpl_bufferSurfaceFunctionsHave3args_init();
globalvar gif_std_gml_io__Buffer_BufferImpl_getSurface; /// @is {function<buf:buffer;surf:surface;offset:int;void>}
gif_std_gml_io__Buffer_BufferImpl_getSurface=gif_std_gml_io__Buffer_BufferImpl_getSetSurface_init(method(undefined,buffer_get_surface));
globalvar gif_std_gml_io__Buffer_BufferImpl_setSurface; /// @is {function<buf:buffer;surf:surface;offset:int;void>}
gif_std_gml_io__Buffer_BufferImpl_setSurface=gif_std_gml_io__Buffer_BufferImpl_getSetSurface_init(method(undefined,buffer_set_surface));
globalvar haxe_io__Bytes_BytesImpl_buffer; /// @is {buffer}
haxe_io__Bytes_BytesImpl_buffer=buffer_create(128,buffer_grow,1);


/// @typedef {array<int>} haxe_io_BytesData
/// @typedef {any} format_gif_PlainTextExtension
/// @typedef {any} format_gif_GraphicControlExtension
/// @typedef {any} format_gif_Frame