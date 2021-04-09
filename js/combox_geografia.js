$(document).ready(function () {
    $.ajax({
        type: 'POST',
        url: '../modelo/q_pais.php'
    })
        .done(function (lista_pais) {
            $('#pais').html(lista_pais)
        })
        .fail(function () {
            alert('Hubo un errror al cargar las listas')
        })
    $('#pais').on('change', function () {
        var id = $('#pais').val()
        $.ajax({
            type: 'POST',
            url: '../modelo/q_departamento.php',
            data: { 'id': id }
        })
            .done(function (lista_departamento) {
                $('#departamento').html(lista_departamento),
                    $('#municipio').html('')
            })
            .fail(function () {
                alert('Hubo un errror al cargar las listas')
            })
    })
    $('#departamento').on('change', function () {
        var id = $('#departamento').val()
        $.ajax({
            type: 'POST',
            url: '../modelo/q_municipio.php',
            data: { 'id': id }
        })
            .done(function (lista_municipio) {
                $('#municipio').html(lista_municipio)
            })
            .fail(function () {
                alert('Hubo un errror al cargar las listas')
            })

    })
})
