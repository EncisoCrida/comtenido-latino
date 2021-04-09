$(document).ready(function () {

  //cuando se da clic en el boton de likes se ejecuta lo siguiente
  $('.like_libros').click(function () {
    //la accion 1 hace referencia a que seesta dando like
    var accion = 1;
    //guardo la id de la publicacion
    var id = this.id;
    //convierto a numero la id eliminando las cadenas de texto
    var id_send = id;
    id_send = id_send.replaceAll("libro_like_", '');
    id_send = parseInt(id_send);
    //peticion ajax
    $.ajax({
      url: 'publicaciones/extra_libros.php',
      type: 'POST',
      data: { id: id_send, accion: accion },
      dataType: 'json',
      beforeSend: function() 
			{
				document.getElementById(`loader_reacion_libro`+id_send).classList.remove('esconder_loader');
				document.getElementById(`loader_reacion_libro`+id_send).classList.add('loader-activo');
				document.getElementById(`reaciones`+id_send).classList.add('esconder_loader');
			},
      //respuesta ajax
      success: function (data) {
        //guardo resultados en variables
        var likes = data['likes'];
        var dislikes = data['dislikes'];
        var busqueda = data['buscar_like'];
        //cantidad de likes y dislikes
        $('#libro_cantidad_likes_' + id_send).text(likes);
        $('#libro_cantidad_dislikes_' + id_send).text(dislikes);
        //boton activo o desactivo
        if (busqueda ==0) {
          $('#'+id).css("color", "red");
          $('#libro_dislike_'+id_send).css("color", "white");

        }else{
          $('#'+id).css("color", "#fff");
        }
        document.getElementById(`loader_reacion_libro`+id_send).classList.add('esconder_loader');
        document.getElementById(`loader_reacion_libro`+id_send).classList.remove('loader-activo');
        document.getElementById(`reaciones`+id_send).classList.remove('esconder_loader');
      }
      });
  });

    //cuando se da clic en el boton de dislike se ejecuta lo siguiente
    $('.dislike_libros').click(function () {
      //la accion 2 hace referencia a que se esta dando dislike
      var accion = 2;
      //guardo la id de la publicacion
      var id = this.id;
      //convierto a numero la id eliminando las cadenas de texto
      var id_send = id;
      id_send = id_send.replaceAll("libro_dislike_", '');
      id_send = parseInt(id_send);
      //peticion ajax
      $.ajax({
        url: 'publicaciones/extra_libros.php',
        type: 'POST',
        data: { id: id_send, accion: accion },
        dataType: 'json',
        beforeSend: function() 
        {
          document.getElementById(`loader_reacion_libro`+id_send).classList.remove('esconder_loader');
          document.getElementById(`loader_reacion_libro`+id_send).classList.add('loader-activo');
          document.getElementById(`reaciones`+id_send).classList.add('esconder_loader');
        },
        //respuesta ajax
        success: function (data) {
          //guardo resultados en variables
          var likes = data['likes'];
          var dislikes = data['dislikes'];
          var busqueda = data['buscar_dislike'];
          //cantidad de likes y dislikes
          $('#libro_cantidad_likes_' + id_send).text(likes);
          $('#libro_cantidad_dislikes_' + id_send).text(dislikes);
          //boton activo o desactivo
          if (busqueda == 0) {
            $('#'+id).css("color", "red");
            $('#libro_like_'+id_send).css("color", "white");
  
          }else{
            $('#'+id).css("color", "#fff");
          }
          document.getElementById(`loader_reacion_libro`+id_send).classList.add('esconder_loader');
          document.getElementById(`loader_reacion_libro`+id_send).classList.remove('loader-activo');
          document.getElementById(`reaciones`+id_send).classList.remove('esconder_loader');
        }
        });
    });

    // al dar clic en comentarios

    $('.comentarios_libros').click(function(){
      //la accion 3 es listar los comentarios
      var accion = 3;
      var id = this.id;
      var id_send = id;
      id_send = id_send.replaceAll("comentarios_libro_", '');
      id_send = parseInt(id_send);
      $('#id_publicacion').val(id_send);
      $.ajax({
        url: 'publicaciones/extra_libros.php',
        type: 'POST',
        data: { id: id_send, accion: accion },
        dataType: 'json',
        beforeSend: function() 
        {
          document.getElementById(`loader_reacion_libro`+id_send).classList.remove('esconder_loader');
          document.getElementById(`loader_reacion_libro`+id_send).classList.add('loader-activo');
          document.getElementById(`reaciones`+id_send).classList.add('esconder_loader');
        },
        success: function(data){
          if(data['comentarios'] == 0)
          {
            document.getElementById('comentarios_libros').innerHTML += "Algo para opinar? ¡deja tu comenatrio sobre esta publicacion!";
          }else{
            $.each(data, function(i){
              var comentarios = "<div class='media'><div class='cabezara-user'>"+
              "<img src='../"+data[i].foto_perfil+"' alt=''>"+ 
              "<p class='usuario'>"+data[i].usuario+"<span>"+data[i].fecha_comentario+"</span></p></div>"+
              "<div class='media-body'><p class='comentario'>"+data[i].comentario+"</p></div></div>";
              document.getElementById('comentarios_libros').innerHTML += comentarios; 
            })
          }
          //$('#footer-libros').html("<button class='btn ver_mis_comentarios_libro' data-bs-toggle='modal'>Mis comentarios</button><button type='button' class='btn-cerrar btn btn-secondary'>Close</button>")
          $('#modal_comentarios_libros').modal('show');
          document.getElementById(`loader_reacion_libro`+id_send).classList.add('esconder_loader');
          document.getElementById(`loader_reacion_libro`+id_send).classList.remove('loader-activo');
          document.getElementById(`reaciones`+id_send).classList.remove('esconder_loader');
        }
        
      });
    });
//al dar cerrar limpio todos los comenatarios
      $('.btn-cerrar').click(function(){
        //escondo el modal
        $('#modal_comentarios_libros').modal('hide');
        //el div de comentarios es igual a una cadena vacia
        document.getElementById('comentarios_libros').innerHTML = '';
        
      });
//al agregar un nuevo comentario
      $('#add_comentario_libro').submit(function(evt){
        evt.preventDefault();
        var accion  = 4;
        id_send = $('#id_publicacion').val();
        var form_comentario_libro = new FormData(document.getElementById("add_comentario_libro"));
        form_comentario_libro.append('accion',accion);
        var comentario = form_comentario_libro.getAll('comentario');
        var comen_temp = document.getElementById('comentarios_libros').innerHTML;
        var new_comen = "<div class='media'><div class='cabezara-user'>"+ 
        "<p class='usuario'>Tu: <span> justo ahora</span></p></div>"+
        "<div class='media-body'><p class='comentario'>"+comentario+"</p></div></div>";
        document.getElementById('comentarios_libros').innerHTML = '';
        document.getElementById('comentarios_libros').innerHTML = new_comen;
        if(comen_temp == 'Algo para opinar? ¡deja tu comenatrio sobre esta publicacion!')
        {
          comen_temp = ''
        }
        document.getElementById('comentarios_libros').innerHTML += comen_temp;
        var ruta = 'publicaciones/extra_libros.php';
        $.ajax({
            url: ruta,
            type: "POST",
            data: form_comentario_libro,
            contentType: false,
            processData: false
        });

        
      });
      // para ver los comentarios del usuario estoy usando otra libreria de modales distinta a bustrap
      //ver mis comentarios
      $(document).on('opening', '.remodal', function () {
        var accion = 5
        /*         $('#modal_comentarios_libros').modal('hide');
                $('#modal_mis_comentarios_libros').modal('show'); */
                id_send = $('#id_publicacion').val();
                $.ajax({
                  url: 'publicaciones/extra_libros.php',
                  type: 'POST',
                  data: { id: id_send, accion: accion },
                  dataType: 'json',
                  success: function(data){
                    if(data['comentarios'] == 0)
                    {
                      document.getElementById('mis_comentarios_libros').innerHTML += "Algo para opinar? ¡deja tu comenatrio sobre esta publicacion!";
                    }else{
                      $.each(data, function(i){
                        var comentarios = "<div class='media'><div class='cabezara-user'>"+
                        "<img src='../"+data[i].foto_perfil+"' alt=''>"+ 
                        "<p class='usuario'>"+data[i].usuario+"<span>"+data[i].fecha_comentario+"</span></p></div>"+
                        "<div class='media-body'><p class='comentario'>"+data[i].comentario+"</p></div></div>";
                        document.getElementById('mis_comentarios_libros').innerHTML += comentarios; 
                      })
                    }
                    /* $('#modal_comentarios_libros').modal('hide'); */
                    /* $('#modal_mis_comentarios_libros').modal('show'); */
                  }
                })
      });
      //cerrar mis comentarios
      $(document).on('closed', '.remodal', function (e) {
        document.getElementById('mis_comentarios_libros').innerHTML = '';
      });

      

      

});

$(function () {
  $(".material-card > .mc-btn-action").click(function () {
    var card = $(this).parent(".material-card");
    var icon = $(this).children("i");
    icon.addClass("fa-spin-fast");

    if (card.hasClass("mc-active")) {
      card.removeClass("mc-active");

      window.setTimeout(function () {
        icon
          .removeClass("fa-arrow-left")
          .removeClass("fa-spin-fast")
          .addClass("fa-bars");
      }, 800);
    } else {
      card.addClass("mc-active");

      window.setTimeout(function () {
        icon
          .removeClass("fa-bars")
          .removeClass("fa-spin-fast")
          .addClass("fa-arrow-left");
      }, 800);
    }
  });
});

