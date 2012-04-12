/* form auto searching */
$(function() {
    $('form.auto_search select, form.auto_search input[type=checkbox]').change(function() {
        alert('Response Detected!');
        $('.results').html('<div class="loading_box"></div>');
        var form = $(this).closest('form');
        $.ajax({
            dataType:'script',
            type:'get',
            url:form.attr('action'),
            data:form.serialize()
        });
    });

});


