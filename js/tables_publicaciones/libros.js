$(document).ready(function() {
var id, opcion;
opcion = 4;
    
tablaLibros = $('#tablaLibros').DataTable({  
    "ajax":{            
        "url": "tabla_libros.php", 
        "method": 'POST', //usamos el metodo POST
        "data":{opcion:opcion}, //enviamos opcion 4 para que haga un SELECT
        "dataSrc":""
    },
    "columns":[
        {"data": "id"},
        {"data": "autor"},
        {"data": "nombre"},
        {"data": "paginas"},
        {"data": "fecha_registro"},
        {"defaultContent": "<div class='text-center'><div class='btn-group'><button class='btn btn-primary btn-sm btnEditar'><i class='fas fa-marker icono-acion'></i></button><button class='btn btn-danger btn-sm btnBorrar'><i class='fas fa-trash-alt icono-acion'></i></button></div></div>"}
    ]/* ,
    "columnDefs": [ 
        {
            targets: [ 0 ],
             "visible": false,
 
        }
      ] */
});     

$('#formLibro').submit(function(evt){
    evt.preventDefault();
    var formLibro = new FormData(document.getElementById("formLibro"));
    formLibro.append('opcion',opcion);
    formLibro.append('id',id);
    var ruta = 'tabla_libros.php';
    $.ajax({
        url: ruta,
        type: "POST",
        data: formLibro,
        contentType: false,
        processData: false,
        beforeSend: function() 
        {
            document.getElementById(`loader-send-libro`).classList.remove('esconder');
            document.getElementById(`loader-send-libro`).classList.add('loader-activo');
            document.getElementById(`send_libro`).classList.add('esconder');
            document.getElementById(`row_archivos`).classList.remove('row');
            document.getElementById(`row_archivos`).classList.add('esconder');
            document.getElementById(`row_1`).classList.remove('row');
            document.getElementById(`row_1`).classList.add('esconder');
            document.getElementById(`row_2`).classList.remove('row');
            document.getElementById(`row_2`).classList.add('esconder');
            document.getElementById(`row_3`).classList.remove('row');
            document.getElementById(`row_3`).classList.add('esconder');
            document.getElementById(`row_4`).classList.remove('row');
            document.getElementById(`row_4`).classList.add('esconder');
        },

    }).done(function (resp) {
        if(resp !== 1)
        {
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
          tablaLibros.ajax.reload(null, false);
          $('#modal_add_libro').modal('hide');
          document.getElementById(`send_libro`).classList.remove('esconder');
          document.getElementById(`loader-send-libro`).classList.add('esconder');
          document.getElementById(`row_archivos`).classList.remove('row');
          document.getElementById(`row_archivos`).classList.add('esconder');
          document.getElementById(`row_1`).classList.remove('esconder');
          document.getElementById(`row_1`).classList.add('row');
          document.getElementById(`row_2`).classList.remove('esconder');
          document.getElementById(`row_2`).classList.add('row');
          document.getElementById(`row_3`).classList.remove('esconder');
          document.getElementById(`row_3`).classList.add('row');
          document.getElementById(`row_4`).classList.remove('esconder');
          document.getElementById(`row_4`).classList.add('row');
          
        }else
        {
            Swal.fire({
                icon: 'error',
                title: 'Oops...',
                text: 'error al ejecutar la accion, presione las teclas "Ctrl" + "f5" al mismo tiempo y vuelva a intentarlo!'
              })
              document.getElementById(`send_libro`).classList.remove('esconder');
              document.getElementById(`loader-send-libro`).classList.add('esconder');
            }

    });
   
});


   

//para limpiar los campos antes de dar de Alta una Persona
$("#btnNuevo").click(function(){
  opcion = 1;
  id = null;

  var boxArchivo = document.querySelector('.boxArchivo');
  boxArchivo.classList.remove('attached');
  boxArchivo.innerHTML = 'Selecione el libro';
  var boxCaratula = document.querySelector('.boxCaratula');
  boxCaratula.classList.remove('attached');
  boxCaratula.innerHTML = 'Selecione imagen';

  document.getElementById(`row_archivos`).classList.remove('esconder');
  document.getElementById(`row_archivos`).classList.add('row');
  $("#formLibro").trigger("reset");
  $(".modal-header").css("background-color", "#3F7FBF");
  $(".modal-header").css("color", "white");
  $(".modal-title").text("Registrar nuevo libro");
    $('#modal_add_libro').modal('show');	    
});

//Editar        
$(document).on("click", ".btnEditar", function(){		        
    opcion = 5;//editar
    fila = $(this).closest("tr");	        
    id = parseInt(fila.find('td:eq(0)').text()); //capturo el ID		            
    $.ajax({
      url: 'tabla_libros.php',
      type: 'POST',

      data: {
          opcion:opcion,
          id: id
      }
  }).done(function (resp) {
      var js = JSON.parse(resp);
      var autor, nombre, volumen, paginas, categoria, tags, reseña;
      //MAS ADELANTE ME SIRVE EST5O MISMO  PARA LAEDICION DE CATEGORTIAS TAGS ETC

      autor = js[0].autor;
      nombre = js[0].nombre;
      volumen = js[0].volumen;
      paginas = js[0].paginas;
      categoria = js[0].id_categoria;
      tags = js[0].tags;
      reseña = js[0].resena;


      $("#autor").val(autor);
      $("#nombre").val(nombre);
      $("#volumen").val(volumen);
      $("#paginas").val(paginas);
      $("#categoria").val(categoria);
      $("#tags").val(tags);
      $("#reseña").val(reseña);
      document.getElementById(`row_archivos`).classList.remove('row');
      document.getElementById(`row_archivos`).classList.add('esconder');
      $(".modal-header").css("background-color", "#007bff");
      $(".modal-header").css("color", "white" );
      $(".modal-title").text("Editar libro");		
      $('#modal_add_libro').modal('show');	

  });
	   opcion = 2;
});

//Borrar
$(document).on("click", ".btnBorrar", function(){
    fila = $(this);           
    id = parseInt($(this).closest('tr').find('td:eq(0)').text()) ;		
    opcion = 3; //eliminar
    Swal.fire({
      title: 'Seguro(a) que desea eliminar este libro?',
      showDenyButton: true,
      showCancelButton: false,
      confirmButtonText: `Aceptar`,
      denyButtonText: `Cancelar`,
    }).then((result) => {
      /* Read more about isConfirmed, isDenied below */
      if (result.isConfirmed) {
        $.ajax({
          url: "tabla_libros.php",
          type: "POST",
          datatype:"json",    
          data:  {opcion:opcion, id:id},    
          success: function() {
              tablaLibros.row(fila.parents('tr')).remove().draw();   
              Swal.fire('eliminado!', '', 'success')               
           }
        });	
        
      } else if (result.isDenied) {
        Swal.fire('Accion cancelada', '', 'info')
      }
    })       
 });

 document.querySelector('#caratula').addEventListener('change', function(e) {
    var boxCaratula = document.querySelector('.boxCaratula');
    boxCaratula.classList.remove('attached');
    boxCaratula.innerHTML = boxCaratula.getAttribute("data-text");
    if(this.value != '') {
      var allowedExtensions = /(\.jpg|\.jpeg|\.png)$/i;
      if(allowedExtensions.exec(this.value)) {
        boxCaratula.innerHTML = e.target.files[0].name;
        boxCaratula.classList.add('attached');
      } else {
        this.value = '';
        Swal.fire({
            icon: 'error',
            title: 'Oops...',
            text: 'la portada del libro debe de ser una imagen (JPG/JPEG/PNG)!'
          });
        boxCaratula.classList.remove('attached');
      }
    }
  });      
 

document.querySelector('#libro').addEventListener('change', function(e) {
    var boxArchivo = document.querySelector('.boxArchivo');
    boxArchivo.classList.remove('attached');
    boxArchivo.innerHTML = boxArchivo.getAttribute("data-text");
    if(this.value != '') {
      var allowedExtensions = /(\.pdf)$/i;
      if(allowedExtensions.exec(this.value)) {
        boxArchivo.innerHTML = e.target.files[0].name;
        boxArchivo.classList.add('attached');
        Swal.fire(
            'archivo analizado con exito!',
            'archivo PDF cargado y listo para registrar!',
            'success'
          );
      } else {
        this.value = '';
        Swal.fire({
            icon: 'error',
            title: 'Oops...',
            text: 'el libro solo se admite en formato PDF (.pdf)!'
          });
        boxArchivo.classList.remove('attached');
      }
    }
  });
     
});    