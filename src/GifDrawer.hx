import gml.gpu.GPU;
import gml.Draw;
import gml.ds.Color;
import Gif;
import gml.gpu.Surface;
import gml.assets.Sprite;
import gml.io.Buffer;

class GifDrawer {
	static var white32:Sprite = Sprite.defValue;
	static function initWhite32() {
		var ws = new Surface(32, 32);
		ws.setTarget();
		Draw.clear(Color.white);
		ws.resetTarget();
		white32 = ws.toSprite(0, 0);
		ws.destroy();
	}
	static inline function ensureWhite32() {
		if (white32 == Sprite.defValue) initWhite32();
	}
	
	var restoreBuf = Buffer.defValue;
	var surface = Surface.defValue;
	var gif:Gif;
	
	public function new(gif:Gif) {
		ensureWhite32();
		this.gif = gif;
	}
	public function destroy() {
		if (restoreBuf != Buffer.defValue) {
			restoreBuf.destroy();
			restoreBuf = Buffer.defValue;
		}
		if (Surface.isValid(surface)) {
			surface.destroy();
			surface = Surface.defValue;
		}
	}
	public function draw(frame:GifFrame) {
		var sprite = gif.sprite;
		//
		if (!Surface.isValid(surface)) {
			var sf = new Surface(gif.width, gif.height);
			sf.setTarget();
			Draw.clearAlpha(Color.white, 0);
			if (sprite != Sprite.defValue) {
				// draw the last frame if surface went missing mid-draw
				sprite.draw(sprite.frames - 1, gif.xorig, gif.yorig);
			}
			sf.resetTarget();
			surface = sf;
		}
		
		//
		if (frame.disposalMethod == 2) {
			if (restoreBuf == Buffer.defValue) {
				restoreBuf = new Buffer(gif.width * gif.height * 4, Fixed, 1);
			}
			restoreBuf.getSurface(surface, 0);
		}
		
		//
		var frameSurf = new Surface(frame.width, frame.height);
		frame.buffer.setSurface(frameSurf, 0);
		surface.copyFrom(frame.x, frame.y, frameSurf);
		frameSurf.destroy();
		// if problems arise from above:
		/*sf.setTarget();
		frame.surface.draw(frame.x, frame.y);
		sf.resetTarget();*/
		
		// create/add to sprite:
		if (gif.frameSprites != null) {
			sprite = Sprite.fromSurface(surface, gif.xorig, gif.yorig);
			gif.frameSprites.push(sprite);
			gif.sprite = sprite;
		} else if (sprite == Sprite.defValue) {
			sprite = Sprite.fromSurface(surface, gif.xorig, gif.yorig);
			gif.sprite = sprite;
		} else {
			//var t = gml.Lib.getTimer();
			sprite.addSurface(surface);
			//trace("add", gml.Lib.getTimer() - t);
		}
		
		//
		switch (frame.disposalMethod) {
			case 2: { // restore pixel data
				restoreBuf.setSurface(surface, 0);
			}
			case 1: { // clear the frame region
				surface.setTarget();
				GPU.blendSimple = Sub;
				white32.drawStretched(0, frame.x, frame.y, frame.width, frame.height);
				GPU.blendSimple = Normal;
				surface.resetTarget();
			};
		}
	}
}