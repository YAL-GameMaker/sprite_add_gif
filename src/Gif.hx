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
	
**/
@:native("gif_reader")
@:keep class Gif {
	public var frames:Array<GifFrame> = [];
	public var finFrameCount = 0;
	public var width:Int = 0;
	public var height:Int = 0;
	public var loops:Int = -1;
	public var xorig:Int;
	public var yorig:Int;
	public var buffer:Buffer;
	public var ownsBuffer = false;
	public var sprite = Sprite.defValue;
	
	public var frameDelays:Array<Int>;
	public var frameSprites:Array<Sprite>;
	
	public function new(buf, xorig, yorig, frameDelays, frameSprites) {
		this.buffer = buf;
		this.xorig = xorig;
		this.yorig = yorig;
		this.frameDelays = frameDelays;
		this.frameSprites = frameSprites;
	}
	public function destroy() {
		for (frame in frames) {
			frame.destroy();
		}
		if (ownsBuffer && buffer != Buffer.defValue) {
			buffer.destroy();
			buffer = Buffer.defValue;
		}
		if (drawer != null) {
			drawer.destroy();
		}
	}
	
	var reader:GifReader;
	var info = null;
	var gce:GraphicControlExtension = null;
	var globalColorTable:Vector<Int> = null;
	var currentFrame = -1;
	var setDelay = false;
	var drawer:GifDrawer = null;
	
	public function start() {
		reader = new GifReader(buffer);
		info = reader.read(false);
		width =  info.logicalScreenDescriptor.width;
		height = info.logicalScreenDescriptor.height;
		if (info.globalColorTable != null) {
			globalColorTable = GifTools.colorTableToVector(info.globalColorTable, info.logicalScreenDescriptor.globalColorTableSize);
		}
	}
	public function readFrame(f:Frame) {
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
		
		gce = null;
		frames.push(gf);
		nextFrame = gf;
	}
	
	public var lastAction:GifReaderAction = None;
	@:doc function getLastAction() return lastAction;
	@:doc function getLastActionName() return getActionName(lastAction);
	
	@:doc function getFrameCount() return finFrameCount;
	@:doc function getSprite() return sprite;
	
	public static function getActionName(action:GifReaderAction) {
		return switch (action) {
			case None: "None";
			case Meta: "Meta";
			case Frame: "Frame";
			case GCE: "GCE";
			case Render: "Render";
			case EOF: "EOF";
			default: "Action#" + action;
		}
	}
	
	/** Safeguard for trying to read past EOF **/
	var foundEOF = false;
	
	var nextFrame:GifFrame = null;
	public function next():Bool {
		if (foundEOF) return false;
		
		var frame = nextFrame;
		if (frame != null) {
			nextFrame = null;
			
			if (drawer == null) drawer = new GifDrawer(this);
			drawer.draw(frame);
			
			var fdelay = frame.delay;
			frameDelays?.push(fdelay);
			
			#if (sfgml_version >= "2.0")
			if (!setDelay && fdelay > 0 && frameSprites == null) {
				setDelay = true;
				sprite.setSpeed(100 / fdelay, SpriteSpeedType.FramesPerSecond);
			}
			#end
			lastAction = Render;
			finFrameCount += 1;
			return true;
		}
		/*if (currentFrame != -1) {
			//trace("frame", currentFrame);
			if (currentFrame >= frames.length) return false;
			
			var frame = frames[currentFrame];
			if (drawer == null) drawer = new GifDrawer(this);
			drawer.draw(frame);
			
			var fdelay = frame.delay;
			frameDelays?.push(fdelay);
			
			#if (sfgml_version >= "2.0")
			if (!setDelay && fdelay > 0) {
				setDelay = true;
				sprite.setSpeed(100 / fdelay, SpriteSpeedType.FramesPerSecond);
			}
			#end
			
			currentFrame += 1;
			return currentFrame < frames.length;
		}*/
		// going over blocks
		var block = reader.readNext(info.blocks);
		//trace("Block", block.getName());
		switch (block) {
			case BFrame(f): {
				readFrame(f);
				lastAction = Frame;
			};
			case BExtension(EApplicationExtension(AENetscapeLooping(n))): {
				loops = n;
				lastAction = Meta;
			};
			case BExtension(EGraphicControl(_gce)): {
				gce = _gce;
				lastAction = GCE;
			};
			case BEOF: {
				lastAction = EOF;
				foundEOF = true;
				return false;
				//currentFrame = 0;
				//return frames.length > 0;
			}
			default: lastAction = Meta;
		}
		return true;
	}
	public function nextFew(timeoutMs:Int) {
		var till = Lib.currentTime + timeoutMs;
		var cont:Bool;
		do {
			cont = next();
		} while (cont && Lib.currentTime < till);
		return cont;
	}
	
	public function finish() {
		foundEOF = true;
		destroy();
		return sprite;
	}
	
	@:expose("sprite_add_gif_buffer")
	static function addBuffer(buf:Buffer, xorig:Int, yorig:Int,
		?frameDelays:Array<Int>, ?frameSprites:Array<Sprite>
	) {
		var gif = new Gif(buf, xorig, yorig, frameDelays, frameSprites);
		gif.start();
		while (gif.next()) {}
		return gif.finish();
	}
	
	@:expose("sprite_add_gif_buffer_start")
	static function addBufferStart(buf:Buffer, xorig:Int, yorig:Int,
		?frameDelays:Array<Int>, ?frameSprites:Array<Sprite>
	) {
		var gif = new Gif(buf, xorig, yorig, frameDelays, frameSprites);
		gif.start();
		return gif;
	}
	
	@:expose("sprite_add_gif")
	static function addPath(path:String, xorig:Int, yorig:Int,
		?frameDelays:Array<Int>, ?frameSprites:Array<Sprite>
	) {
		var buf = Buffer.load(path);
		var spr = addBuffer(buf, xorig, yorig, frameDelays, frameSprites);
		buf.destroy();
		return spr;
	}
	
	@:expose("sprite_add_gif_start")
	static function addPathStart(path:String, xorig:Int, yorig:Int,
		?frameDelays:Array<Int>, ?frameSprites:Array<Sprite>
	) {
		var buf = Buffer.load(path);
		var gif = addBufferStart(buf, xorig, yorig, frameDelays, frameSprites);
		gif.ownsBuffer = true;
		return gif;
	}
	
	static inline function main() {
		
	}
}

@:keep class GifFrame {
	public var delay:Int = 0;
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
		if (buffer != Buffer.defValue) {
			buffer.destroy();
			buffer = Buffer.defValue;
		}
	}
}

@:native("gif_loader_tools")
private class GifTools {
	public static function colorTableToVector(pal:Bytes, num:Int):Vector<Int> {
		var r:Int, g:Int, b:Int, p:Int = 0;
		var a = 255;
		var vec:Vector<Int> = new Vector(num);
		for (i in 0 ... num) {
			r = pal.get(p);
			g = pal.get(p + 1);
			b = pal.get(p + 2);
			#if (sfgml_version >= "2.0")
			vec[i] = (a << 24) | (b << 16) | (g << 8) | r;
			#else
			vec[i] = (a << 24) | (r << 16) | (g << 8) | b;
			#end
			p += 3;
		}
		return vec;
	}
}

@:doc @:nativeGen @:keep @:sf.fakeEnum
enum GifReaderAction {
	None;
	Meta;
	Frame;
	GCE;
	Render;
	EOF;
}
/*enum abstract GifReaderAction(Int) {
	@:keep var None = 0;
	@:keep var Meta = 1;
	@:keep var Frame = 2;
	@:keep var GCE = 3;
	@:keep var Render = 4;
	@:keep var EOF = -1;
}*/