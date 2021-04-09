/* function restablecerClave(){
  var correo = document.getElementById('correo2').value;
    var caracteres = "abcdefghijklmnopqrstwxyzABCDEFGHIJKMNOPQRSRWXYZ0123456789";
    var clave = "";
  
    for(var i = 0; i < 10; i++ )
    {
      clave+= caracteres.charAt(Math.floor(Math.random()*caracteres.length));
    }
  
    $.ajax({
      url:'../controlador/restablecer-clave.php',
      type:'POST',
      data:{
        correo:correo,
        clave:clave
      }
    }).done(function(resp){
      alert(resp);
    })
  } */

const RestablecerClave = document.getElementById('RestablecerClave');
const correoRestablecer = document.querySelectorAll('#RestablecerClave input');
const expresion = {
	correo2: /^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$/,
}
const camposCorreo2 = {
	correo2: false,
}

const validarFormRestablecer = (e) => {
	switch (e.target.name) {
		case "correo2":
			validarCorreo2(expresion.correo2, e.target, 'correo2');
			break;
	}
}

const validarCorreo2 = (expresion, input, campo) => {
	if (expresion.test(input.value)) {
		document.getElementById(`grupo__${campo}`).classList.remove('formulario__grupo-incorrecto');
		document.getElementById(`grupo__${campo}`).classList.add('formulario__grupo-correcto');
		document.querySelector(`#grupo__${campo} i`).classList.add('fa-check-circle');
		document.querySelector(`#grupo__${campo} i`).classList.remove('fa-times-circle');
		document.querySelector(`#grupo__${campo} .formulario__input-error`).classList.remove('formulario__input-error-activo');
		camposCorreo2[campo] = true;
	} else {
		document.getElementById(`grupo__${campo}`).classList.add('formulario__grupo-incorrecto');
		document.getElementById(`grupo__${campo}`).classList.remove('formulario__grupo-correcto');
		document.querySelector(`#grupo__${campo} i`).classList.add('fa-times-circle');
		document.querySelector(`#grupo__${campo} i`).classList.remove('fa-check-circle');
		document.querySelector(`#grupo__${campo} .formulario__input-error`).classList.add('formulario__input-error-activo');
		camposCorreo2[campo] = false;
	}
}



correoRestablecer.forEach((input) => {
	input.addEventListener('keyup', validarFormRestablecer);
	input.addEventListener('blur', validarFormRestablecer);
});

RestablecerClave.addEventListener('submit', (e) => {

	e.preventDefault();
	if (camposCorreo2.correo2) {
		var correo2 = document.getElementById('correo2').value;
		var caracteres = "abcdefghijklmnopqrstwxyzABCDEFGHIJKMNOPQRSRWXYZ0123456789";
		var clave = "";
	  
		for(var i = 0; i < 10; i++ )
		{
		  clave+= caracteres.charAt(Math.floor(Math.random()*caracteres.length));
		}
		$.ajax({
			url: '../controlador/restablecer-clave.php',
			type: 'POST',
			data: {
				correo: correo2,
				clave: clave
			},
			beforeSend: function() 
			{
				document.getElementById(`loader-restablecer`).classList.remove('esconder');
				document.getElementById(`loader-restablecer`).classList.add('loader-activo');
				document.getElementById(`btnRestablecer`).classList.add('esconder');
			},
		}).done(function (resp) {
						camposCorreo2['correo2'] = false;
						document.querySelectorAll('.formulario__grupo-correcto').forEach((icono) => {
							icono.classList.remove('formulario__grupo-correcto');
						});
						if(resp == 1)
						{
							Swal.fire({
							title: 'Se restablecio su clave con exito',
							text: 'aceeda a la bandeja de entrada de su correo, hemos enviado un correo electronico con los pasos a seguir',
							icon: 'success',
							showConfirmButton: true,
							showClass: {
							  popup: 'animate__animated animate__fadeInDown'
							},
							hideClass: {
							  popup: 'animate__animated animate__fadeOutUp'
							}
						  })
						  $('#RestablecerClaveUser').modal('hide');
						  document.getElementById(`btnRestablecer`).classList.remove('esconder');
						  document.getElementById(`loader-restablecer`).classList.add('esconder');
						}else
						{
							Swal.fire({
								icon: 'error',
								title: 'Oops...',
								text: 'error al restaclecer la clave, presione las teclas "Ctrl" + "f5" al mismo tiempo y vuelva a intentarlo!'
							  })
							  document.getElementById(`btnRestablecer`).classList.remove('esconder');
							  document.getElementById(`loader-restablecer`).classList.add('esconder');
							}

					  })
					  formulario.reset();

		}else {
			document.getElementById('formulario__mensaje').classList.add('formulario__mensaje-activo');
		}
});
