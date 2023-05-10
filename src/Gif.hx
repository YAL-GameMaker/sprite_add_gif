package;
import format.gif.Data;
import gml.Draw;
import gml.Lib;
import gml.assets.Sprite;
import gml.ds.Color;
import gml.gpu.GPU;
import gml.gpu.Surface;
import gml.io.Buffer;
import haxe.ds.Vector;
import haxe.io.Bytes;
import haxe.io.BytesInput;

/**
 * ...
 * @author YellowAfterlife
 */
@:keep class Gif {
	public var frames:Array<GifFrame> = [];
	public var width:Int = 0;
	public var height:Int = 0;
	public var loops:Int = -1;
	public function new() {
		//
	}
	public function destroy() {
		for (frame in frames) frame.destroy();
	}
	public function read(gif_buffer:Buffer) {
		var n = gif_buffer.length;
		var bytes = Bytes.alloc(n);
		for (i in 0 ... n) bytes.set(i, gif_buffer.peekByte(i));
		//
		var q = (new GifReader(gif_buffer)).read();
		width = q.logicalScreenDescriptor.width;
		height = q.logicalScreenDescriptor.height;
		var gce:GraphicControlExtension = null;
		var globalColorTable:Vector<Int> = null;
		if (q.globalColorTable != null) {
			globalColorTable = GifTools.colorTableToVector(q.globalColorTable, q.logicalScreenDescriptor.globalColorTableSize);
		}
		var _break = false;
		#if gif_legacy_plotter
		var white1 = Gif.white1;
		if (white1 == Sprite.defValue) {
			var ws = new Surface(1, 1);
			ws.setTarget();
			Draw.clear(Color.white);
			ws.resetTarget();
			white1 = ws.toSprite(0, 0);
			ws.destroy();
			Gif.white1 = white1;
		}
		#end
		for (block in q.blocks) {
			switch (block) {
				case BFrame(f): {
					var gf = new GifFrame();
					var transparentIndex:Int = -1;
					if (gce != null) {
						gf.delay = gce.delay;
						if (gce.hasTransparentColor) transparentIndex = gce.transparentIndex;
						switch (gce.disposalMethod) {
							case FILL_BACKGROUND: gf.disposalMethod = 1;
							case RENDER_PREVIOUS: gf.disposalMethod = 2;
							default:
						}
					}
					gf.x = f.x;
					gf.y = f.y;
					gf.width = f.width;
					gf.height = f.height;
					//
					var colorTable:Vector<Int> = globalColorTable;
					if (f.colorTable != null) {
						colorTable = GifTools.colorTableToVector(f.colorTable, f.localColorTableSize);
					}
					//
					//trace([for (c in colorTable) StringTools.hex(c, 8)]);
					var fWidth = f.width;
					var fHeight = f.height;
					var sf = new Surface(fWidth, fHeight);
					var pxData = f.pixels.getData();
					//var base = "frame" + frames.length;
					
					#if gif_legacy_plotter
					sf.setTarget();
					Draw.clearAlpha(Color.black, 0);
					GPU.blendSimple = Add;
					var y = 0;
					var ind = 0;
					for (_ in 0 ... fHeight) {
						var x = 0;
						for (_ in 0 ... fWidth) {
							var col = pxData[ind++];
							if (col != transparentIndex) {
								var c32 = colorTable[col];
								white1.drawExt(0, x, y, 1, 1, 0, colorTable[col], 1);
							}
							x += 1;
						}
						y += 1;
					}
					GPU.blendSimple = Normal;
					sf.resetTarget();
					#else
					var buf = new Buffer(f.width * f.height * 4, Fixed, 1);
					for (i in 0 ... f.pixels.length) {
						var col = pxData[i];
						if (col == transparentIndex) {
							buf.writeInt(0);
						} else {
							buf.writeInt(colorTable[col]);
						}
					}
					gf.buffer = buf;
					//
					buf.setSurface(sf, 0);
					//buf.save(base + ".bin");
					#end
					gf.surface = sf;
					//
					//sf.save(base + ".png");
					gce = null;
					frames.push(gf);
				};
				case BExtension(EApplicationExtension(AENetscapeLooping(n))): {
					loops = n;
				};
				case BExtension(EGraphicControl(_gce)): {
					gce = _gce;
				};
				case BEOF: _break = true;
				default:
			}
			if (_break) break;
		}
	}
	
	#if gif_legacy_plotter
	static var white1:Sprite = Sprite.defValue;
	#end
	static var white32:Sprite = Sprite.defValue;
	@:expose("sprite_add_gif_buffer") static function addBuffer(buf:Buffer, xorig:Int, yorig:Int, ?delays:Array<Int>) {
		var white32 = Gif.white32;
		if (white32 == Sprite.defValue) {
			var ws = new Surface(32, 32);
			ws.setTarget();
			Draw.clear(Color.white);
			ws.resetTarget();
			white32 = ws.toSprite(0, 0);
			ws.destroy();
			Gif.white32 = white32;
		}
		//
		var gif = new Gif();
		gif.read(buf);
		//
		var sf = new Surface(gif.width, gif.height);
		sf.setTarget();
		Draw.clearAlpha(Color.white, 0);
		sf.resetTarget();
		//
		var restoreBuf = Buffer.defValue;
		var spr = Sprite.defValue;
		//
		var _color = GPU.color;
		var _alpha = GPU.alpha;
		GPU.color = Color.white;
		GPU.alpha = 1;
		var firstDelay = 0;
		for (frame in gif.frames) {
			// save the pixel data if required
			if (frame.disposalMethod == 2) {
				if (restoreBuf == Buffer.defValue) restoreBuf = new Buffer(gif.width * gif.height * 4, Fixed, 1);
				restoreBuf.getSurface(sf, 0);
			}
			
			// actual drawing:
			sf.copyFrom(frame.x, frame.y, frame.surface);
			// if problems arise from above:
			/*sf.setTarget();
			frame.surface.draw(frame.x, frame.y);
			sf.resetTarget();*/
			
			// create/add to sprite:
			if (spr == Sprite.defValue) {
				spr = Sprite.fromSurface(sf, xorig, yorig);
			} else spr.addSurface(sf);
			
			// figure out the delay:
			var fdelay = frame.delay;
			if (delays != null) delays.push(fdelay);
			if (firstDelay <= 0 && fdelay > 0) firstDelay = fdelay;
			
			//
			switch (frame.disposalMethod) {
				case 2: restoreBuf.setSurface(sf, 0); // restore pixel data
				case 1: { // clear the frame region
					sf.setTarget();
					GPU.blendSimple = Sub;
					white32.drawStretched(0, frame.x, frame.y, frame.width, frame.height);
					GPU.blendSimple = Normal;
					sf.resetTarget();
				};
			}
		}
		//
		#if (sfgml_version >= "2.0")
		if (firstDelay > 0) {
			spr.setSpeed(100 / firstDelay, SpriteSpeedType.FramesPerSecond);
		}
		#end
		//
		GPU.color = _color;
		GPU.alpha = _alpha;
		if (restoreBuf != Buffer.defValue) restoreBuf.destroy();
		gif.destroy();
		sf.destroy();
		return spr;
	}
	
	@:expose("sprite_add_gif") static function add(path:String, xorig:Int, yorig:Int, ?delays:Array<Int>) {
		var buf = Buffer.load(path);
		var spr = addBuffer(buf, xorig, yorig, delays);
		buf.destroy();
		return spr;
	}
	
	static inline function main() {
		
	}
}

@:keep class GifFrame {
	public var delay:Int = 0;
	public var surface:Surface;
	public var buffer:Buffer = Buffer.defValue;
	public var x:Int;
	public var y:Int;
	public var width:Int;
	public var height:Int;
	public var disposalMethod:Int = 0;
	public function new() {
		//
	}
	public function destroy() {
		if (Surface.isValid(surface)) surface.destroy();
		if (buffer != Buffer.defValue) buffer.destroy();
	}
}

private class GifTools {
	public static function colorTableToVector(pal:Bytes, num:Int):Vector<Int> {
		var r:Int, g:Int, b:Int, p:Int = 0;
		#if gif_legacy_plotter
		var a = 0;
		#else
		var a = 255;
		#end
		var vec:Vector<Int> = new Vector(num);
		for (i in 0 ... num) {
			r = pal.get(p);
			g = pal.get(p + 1);
			b = pal.get(p + 2);
			vec[i] = (a << 24) | (b << 16) | (g << 8) | r;
			p += 3;
		}
		return vec;
	}
}