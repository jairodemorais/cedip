var showForm = function (eventObj) {
	document.getElementById("addForm").reset();
	var date = eventObj.data.calDayDate;
	$('#date').val(date);
	$('#addModal').reveal();
};

var addEvent = function() {
	var title = $('#title').val();
	var date = $('#date').val();
	jfcalplugin.addAgendaItem("#calendar",
		title,
		new Date(date),
		new Date(date),
		true,
		null,
		{ backgroundColor: "#FF0000", foregroundColor: "#FFFFFF"
	});
	$('.close-reveal-modal').click();
}

$(document).ready(function () {
	jfcalplugin = $("#calendar").jFrontierCal({
		date: new Date(),
		dayClickCallback: showForm,
		agendaClickCallback: function() {alert("agenda")},
		agendaDropCallback: function() {alert("agenda drop")},
		dragAndDropEnabled: true
	}).data("plugin");

	$('#save').click(addEvent);
})