export function formatTime(millis, isSeconds) {
  if(isSeconds) millis *= 1000;

  const h = Math.floor(millis / 1000 / 60 / 60),
        m = Math.floor(millis / 1000 / 60 % 60),
        s = Math.floor(millis / 1000 % 60);

  const hour = `${h}`.padStart(2, '0'),
        minute = `${m}`.padStart(2, '0'),
        second = `${s}`.padStart(2, '0');

  return `${hour}:${minute}:${second}`;
}


// Taken and adapted from https://github.com/bevacqua/fuzzysearch/blob/master/index.js
// Adaptations:
// - ignore case
export function fuzzysearch(needle, haystack) {
  needle = needle.toLowerCase();
  haystack = haystack.toLowerCase();
  var hlen = haystack.length;
  var nlen = needle.length;
  if (nlen > hlen) {
    return false;
  }
  if (nlen === hlen) {
    return needle === haystack;
  }
  outer: for (var i = 0, j = 0; i < nlen; i++) {
    var nch = needle.charCodeAt(i);
    while (j < hlen) {
      if (haystack.charCodeAt(j++) === nch) {
        continue outer;
      }
    }
    return false;
  }
  return true;
}



// An arbitrary and poor implementation of application-unique ids for usage as
// keys when rendering lists.
let idCounter = 0;
export function uniqueID() {
  return idCounter++;
}
