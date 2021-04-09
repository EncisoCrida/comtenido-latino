

window.onload = function() {
    $.ajax({
        url: 'info_user.php',
        type: 'POST'
    }).done(function (resp) {
        var js = JSON.parse(resp);
        var nombres, apellidos, usuario, correo, telefono, foto_perfil ;
        nombres = js[0].nombres;
        apellidos = js[0].apellidos;
        usuario = js[0].usuario;
        correo = js[0].correo;
        telefono = js[0].telefono;
        foto_perfil = js[0].foto_perfil;
    
    
        $("#nombres").val(nombres);
        $("#apellidos").val(apellidos);
        $("#usuario").val(usuario);
        $("#correo").val(correo);
        $("#telefono").val(telefono);
        document.getElementById("imgPerfilCambiar").innerHTML = '<img src="../'+foto_perfil+'" />';
        document.getElementById("imgPerfil").innerHTML += '<img src="../'+foto_perfil+'" />';
        document.getElementById("name_user").innerHTML += usuario;
        document.getElementById("imgU").innerHTML += '<img src="../'+foto_perfil+'" />';
        document.getElementById("avatar_menu").innerHTML += '<img src="../'+foto_perfil+'" />';
        
    });
  };