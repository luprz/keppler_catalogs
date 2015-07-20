#Archivo coffee generado por Keppler.
$(document).ready ->
	$(".upload-select").on 'change', ->
	  if $(".upload-select").val() == ""
	  	$("#image").hide()
	  	$("#url").hide()
	  	return
	  else if $(".upload-select").val() == "1"
	  	$("#image").show()
	  	$("#url").hide()
	  	return
	  else
	  	$("#image").hide()
	  	$("#url").show()
	  	return
	  return
	return