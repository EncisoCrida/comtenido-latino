


//camniar foto perfil       
$(document).on("click", ".cambiarFoto", function () {

    $('#edit').modal('hide');
    $('#cambiarFotoPerfil').modal('show');

});
$(document).ready(function(){
    $('#formPerfil').submit(function (e) {
        e.preventDefault(); //evita el comportambiento normal del submit, es decir, recarga total de la página
        nombres = $.trim($('#nombres').val());
        apellidos = $.trim($('#apellidos').val());
        usuario = $.trim($('#usuario').val());
        correo = $.trim($('#correo').val());
        telefono = $.trim($('#telefono').val());
        $.ajax({
        url: "editar_perfil.php",
        type: "POST",
        datatype: "json",
        data: {
        nombres: nombres,
        apellidos: apellidos,
        usuario: usuario,
        correo: correo,
        telefono: telefono
        },
        beforeSend: function() 
        {
            document.getElementById(`loader-editar-perfil`).classList.remove('esconder');
            document.getElementById(`loader-editar-perfil`).classList.add('loader-activo');
            document.getElementById(`btnEditarPerfil`).classList.add('esconder');
        },

        }).done(function (resp) {
            if(resp == 1)
            {
                Swal.fire({
                title: 'Se actualizaron los datos de usuario con exito',
                text: '',
                icon: 'success',
                showConfirmButton: true,
                showClass: {
                  popup: 'animate__animated animate__fadeInDown'
                },
                hideClass: {
                  popup: 'animate__animated animate__fadeOutUp'
                }
              }).then((result) => {
                /* Read more about isConfirmed, isDenied below */
                if (result.isConfirmed) {
                    location.reload(false);
                }
              });

              $('#RestablecerClaveUser').modal('hide');
              document.getElementById(`btnEditarPerfil`).classList.remove('esconder');
              document.getElementById(`loader-editar-perfil`).classList.add('esconder');
              
            }else
            {
                Swal.fire({
                    icon: 'error',
                    title: 'Oops...',
                    text: 'error al actualizar datos de usuario, presione las teclas "Ctrl" + "f5" al mismo tiempo y vuelva a intentarlo!'
                  })
                  document.getElementById(`btnEditarPerfil`).classList.remove('esconder');
                  document.getElementById(`loader-editar-perfil`).classList.add('esconder');
                }
    });
});

$('.send_foto').on("click", function(evt){
    evt.preventDefault();
    var formData = new FormData(document.getElementById("Foto"));
    console.log(formData+"este es el formulario");
    var ruta = 'cambiarFoto.php';
    $.ajax({
        url: ruta,
        type: "POST",
        data: formData,
        contentType: false,
        processData: false,
        beforeSend: function() 
        {
            document.getElementById(`loader-cambiar-foto-perfil`).classList.remove('esconder');
            document.getElementById(`loader-cambiar-foto-perfil`).classList.add('loader-activo');
            document.getElementById(`send_foto`).classList.add('esconder');
        },

    }).done(function (resp) {
        if(resp == 1)
        {
            Swal.fire({
            title: 'Foto de perfil actualizada con exito',
            text: '',
            icon: 'success',
            showConfirmButton: true,
            showClass: {
              popup: 'animate__animated animate__fadeInDown'
            },
            hideClass: {
              popup: 'animate__animated animate__fadeOutUp'
            }
          }).then((result) => {
            /* Read more about isConfirmed, isDenied below */
            if (result.isConfirmed) {
                location.reload(false);
            }
          });

          $('#RestablecerClaveUser').modal('hide');
          document.getElementById(`send_foto`).classList.remove('esconder');
          document.getElementById(`loader-cambiar-foto-perfil`).classList.add('esconder');
          
        }else
        {
            Swal.fire({
                icon: 'error',
                title: 'Oops...',
                text: 'error al actualizar datos de usuario, presione las teclas "Ctrl" + "f5" al mismo tiempo y vuelva a intentarlo!'
              })
              document.getElementById(`send_foto`).classList.remove('esconder');
              document.getElementById(`loader-cambiar-foto-perfil`).classList.add('esconder');
            }

    });
});

$("#file").change(function () {
    var file = this.files[0];
    var imagefile = file.type;
    var match = ["image/jpeg", "image/png", "image/jpg"];
    if (!((imagefile == match[0]) || (imagefile == match[1]) || (imagefile == match[2]))) {
        alert('Please select a valid image file (JPEG/JPG/PNG).');
        $("#file").val('');
        return false;
    }
});
 
});