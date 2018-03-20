var footerCheck = function() {
 var x=document.location.search.substring(1).split('&');
 var currentPage = 1;
 for (var i in x) {
   var z=x[i].split('=',2);
   if(z[0] == "page")
     currentPage = unescape(z[1]);
   if(z[0] == "topage" && currentPage == unescape(z[1]))
     document.getElementsByClassName("footerContent")[0].style.display = "block";
  }
}();
console.log("sdsadsad")