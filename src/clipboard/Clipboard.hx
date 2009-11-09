import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.display.PixelSnapping;

import flash.events.MouseEvent;

import flash.system.System;

import flash.text.TextFormat;
import flash.text.TextField;
import flash.text.TextFormatAlign;

class TahomaBold extends flash.text.Font {}
class CopyIcon extends BitmapData {}

class Clipboard extends Sprite {

  static var content:String;
  var icon : flash.display.Bitmap;
  var format : TextFormat;
  var copied_format : TextFormat;
  var label : TextField;

  static function main() {
    var clipboard = new Clipboard();
    flash.Lib.current.addChild(clipboard);
    clipboard.init();
    content = flash.Lib.current.loaderInfo.parameters.content;
  }

  function init() {
    icon = new Bitmap(new CopyIcon(16, 16), PixelSnapping.AUTO, true);
    icon.height = 10;
    icon.width = 10;
    icon.x = 44;
    icon.y = 3;
    addChild(icon);

    format = new TextFormat();
    format.font = "TahomaBold";
    format.size = 10;
    format.color = 0x004499;
    format.underline = true;
    format.align = TextFormatAlign.RIGHT;

    copied_format = new TextFormat();
    copied_format.font = "TahomaBold";
    copied_format.size = 10;
    copied_format.color = 0x000000;
    copied_format.underline = true;
    copied_format.align = TextFormatAlign.RIGHT;

    label = new TextField();
    label.text = "COPY";
    label.embedFonts = true;
    label.setTextFormat(format);
    label.width = 43;
    label.height = 14;
    label.selectable = false;

    addChild(label);

    this.buttonMode = true;
    this.mouseChildren = false;
    this.addEventListener(MouseEvent.MOUSE_OUT, reset_text);
    this.addEventListener(MouseEvent.MOUSE_DOWN, mouse_down);
  }

  function mouse_down(e : MouseEvent) {
    System.setClipboard(content);
    label.text = "COPIED";
    label.setTextFormat(copied_format);
  }

  function reset_text(e:Dynamic) {
    if ( label.text != "COPY" ) {
      label.text = "COPY";
      label.setTextFormat(format);
    }
  }
  
}