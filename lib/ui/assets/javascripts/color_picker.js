String.prototype.toHex = function() {
  if(/^(transparent)?\s*$/i.test(this))
    return "";

  if(/^\#?[0-9a-fA-F]{6}\s*$/.test(this))
    return /^\#/.test(this) ? this : ("#" + this);
  
  if(/^\#?[0-9a-fA-F]{3}\s*$/.test(this)) {
    var parts = this.match(/\#?([0-9a-fA-F])([0-9a-fA-F])([0-9a-fA-F])/);
    delete(parts[0]);
    for(var i = 1; i <= 3; ++i)
      parts[i] = parts[i].toString() + parts[i].toString();
      
    return "#" + parts.join("");
  }
    
  
  if(!/^rgb/.test(this))
    throw "\"" + this + "\" is not an RGB value in the form of rgb(dd, dd, dd)";
  
  var parts = this.match(/^rgb\((\d+),\s*(\d+),\s*(\d+)\)$/);

  delete(parts[0]);
  for(var i = 1; i <= 3; ++i) {
      parts[i] = parseInt(parts[i]).toString(16);
      if(parts[i].length == 1) parts[i] = '0' + parts[i];
  }
  return "#" + parts.join("");
}