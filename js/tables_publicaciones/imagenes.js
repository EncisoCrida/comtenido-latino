$(document).ready(function () {
  var id, opcion;
  opcion = 4;

  tablaImg = $('#tablaImg').DataTable({
    "ajax": {
      "url": "tabla_imagenes.php",
      "method": 'POST', //usamos el metodo POST
      "data": { opcion: opcion }, //enviamos opcion 4 para que haga un SELECT
      "dataSrc": ""
    },
    "columns": [
      { "data": "id" },
      { "data": "autor" },
      { "data": "nombre" },
      { "data": "fecha_registro" },
      { "defaultContent": "<div class='text-center'><div class='btn-group'><button class='btn btn-primary btn-sm btnEditar_img'><i class='fas fa-marker icono-acion'></i></button><button class='btn btn-danger btn-sm btnBorrar_img'><i class='fas fa-trash-alt icono-acion'></i></button></div></div>" }
    ]
  });

  $('#formImg').submit(function (evt) {
    evt.preventDefault();
    var formImg = new FormData(document.getElementById("formImg"));
    formImg.append('opcion', opcion);
    formImg.append('id', id);
    var ruta = 'tabla_imagenes.php';
    $.ajax({
      url: ruta,
      type: "POST",
      data: formImg,
      contentType: false,
      processData: false,
      beforeSend: function () {
        document.getElementById(`loader-send-img`).classList.remove('esconder');
        document.getElementById(`loader-send-img`).classList.add('loader-activo');
        document.getElementById(`send_img`).classList.add('esconder');
        document.getElementById(`row_archivos`).classList.remove('row');
        document.getElementById(`row_archivos`).classList.add('esconder');
        document.getElementById(`row_1`).classList.remove('row');
        document.getElementById(`row_1`).classList.add('esconder');
        document.getElementById(`row_4`).classList.remove('row');
        document.getElementById(`row_4`).classList.add('esconder');
      },

    }).done(function (resp) {
      if (resp !== 1) {
        Swal.fire({
          title: 'accion ejecutada con exito',
          text: '',
          icon: 'success',
          showConfirmButton: true,
          showClass: {
            popup: 'animate__animated animate__fadeInDown'
          },
          hideClass: {
            popup: 'animate__animated animate__fadeOutUp'
          }
        });
        tablaImg.ajax.reload(null, false);
        $('#modal_add_img').modal('hide');
        document.getElementById(`send_img`).classList.remove('esconder');
        document.getElementById(`loader-send-img`).classList.add('esconder');
        document.getElementById(`row_archivos`).classList.remove('row');
        document.getElementById(`row_archivos`).classList.add('esconder');
        document.getElementById(`row_1`).classList.remove('esconder');
        document.getElementById(`row_1`).classList.add('row');
        document.getElementById(`row_4`).classList.remove('esconder');
        document.getElementById(`row_4`).classList.add('row');

      } else {
        Swal.fire({
          icon: 'error',
          title: 'Oops...',
          text: 'error al ejecutar la accion, presione las teclas "Ctrl" + "f5" al mismo tiempo y vuelva a intentarlo!'
        })
        document.getElementById(`send_img`).classList.remove('esconder');
        document.getElementById(`loader-send-img`).classList.add('esconder');
      }

    });

  });




  //para limpiar los campos antes de dar de Alta una Persona
  $("#btnNueva_img").click(function () {

    var boxArchivo = document.querySelector('.boxArchivo');
    boxArchivo.classList.remove('attached');
    boxArchivo.innerHTML = 'Selecione la imagen';

    opcion = 1;
    id = null;
    document.getElementById(`row_archivos`).classList.remove('esconder');
    document.getElementById(`row_archivos`).classList.add('row');
    $("#formImg").trigger("reset");
    $(".modal-header").css("background-color", "#3F7FBF");
    $(".modal-header").css("color", "white");
    $(".modal-title").text("Registrar nueva imagen");
    $('#modal_add_img').modal('show');
  });

  //Editar        
  $(document).on("click", ".btnEditar_img", function () {
    opcion = 5;//editar
    fila = $(this).closest("tr");
    id = parseInt(fila.find('td:eq(0)').text()); //capturo el ID		            
    $.ajax({
      url: 'tabla_imagenes.php',
      type: 'POST',

      data: {
        opcion: opcion,
        id: id
      }
    }).done(function (resp) {
      var js = JSON.parse(resp);

      var autor, nombre, volumen, paginas, categoria, tags, reseña;
      //MAS ADELANTE ME SIRVE EST5O MISMO  PARA LAEDICION DE CATEGORTIAS TAGS ETC

      autor = js[0].autor;
      nombre = js[0].nombre;
      volumen = js[0].volumen;
      categoria = js[0].id_categoria;
      tags = js[0].tags;
      reseña = js[0].resena;

      $("#autor_img").val(autor);
      $("#nombre_img").val(nombre);
      $("#volumen_img").val(volumen);
      $("#paginas_img").val(paginas);
      $("#categoria_img").val(categoria);
      $("#tags_img").val(tags);
      $("#reseña_img").val(reseña);
      document.getElementById(`row_archivos`).classList.remove('row');
      document.getElementById(`row_archivos`).classList.add('esconder');
      $(".modal-header").css("background-color", "#007bff");
      $(".modal-header").css("color", "white");
      $(".modal-title").text("Editar imagen");
      $('#modal_add_img').modal('show');

    });
    opcion = 2;
  });

  //Borrar
  $(document).on("click", ".btnBorrar_img", function () {
    fila = $(this);
    id = parseInt($(this).closest('tr').find('td:eq(0)').text());
    opcion = 3; //eliminar
    Swal.fire({
      title: 'Seguro(a) que desea eliminar esta imagen?',
      showDenyButton: true,
      showCancelButton: false,
      confirmButtonText: `Aceptar`,
      denyButtonText: `Cancelar`,
    }).then((result) => {
      /* Read more about isConfirmed, isDenied below */
      if (result.isConfirmed) {
        $.ajax({
          url: "tabla_imagenes.php",
          type: "POST",
          datatype: "json",
          data: { opcion: opcion, id: id },
          success: function () {
            tablaImg.row(fila.parents('tr')).remove().draw();
            Swal.fire('eliminado!', '', 'success')
          }
        });

      } else if (result.isDenied) {
        Swal.fire('Accion cancelada', '', 'info')
      }
    })
  });

  document.querySelector('#img').addEventListener('change', function (e) {
    var boxArchivo = document.querySelector('.boxArchivo');
    boxArchivo.classList.remove('attached');
    boxArchivo.innerHTML = boxArchivo.getAttribute("data-text");
    if (this.value != '') {
      var allowedExtensions = /(\.jpg|\.jpeg|\.png)$/i;
      if (allowedExtensions.exec(this.value)) {
        boxArchivo.innerHTML = e.target.files[0].name;
        boxArchivo.classList.add('attached');
      } else {
        this.value = '';
        Swal.fire({
          icon: 'error',
          title: 'Oops...',
          text: 'solo se permite los siguintes formatos para imagenes (JPG/JPEG/PNG)!'
        });
        boxArchivo.classList.remove('attached');
      }
    }
  });


});