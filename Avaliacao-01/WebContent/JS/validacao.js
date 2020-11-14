
// FUNÇÃO DE VALIDAÇÃO DOS CAMPOS DO FORMULÁRIO

$(document).ready(function(){
		
	$("#formNota").validate({
				rules:{
					
					nota: {
						required:true,
						number:true,
						maxlength:3, 
			            range: [0, 10]
					},
				},
	})
	
	
	
	
})



