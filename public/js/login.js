$(document).ready(function () {
  $('#loginbtn').click(function(){
	  $.ajax({
		  type: 'POST',
		  url: '/user/login',
		  data: { username: $('#username').val(), password: $('#password').val() },
		  success: function(a,b,c) { console.log(a); console.log(b); console.log(c); alert("Ya estas logueado"); },
		  error: function() { alert("Error"); }
		});
	});
});