$(function() {
    // Remote save new agent
    $('#new_feedback').on('ajax:success', new_feedback_save);

    // Remote save edited agent
    $('.edit_feedback').on('ajax:success', edit_feedback_save);
});

/**
 *  Redirect on feedback save.
 **/
function new_feedback_save(e, data, status, xhr) {
    if (status === 'success') {
        $('#feedback_message').animate({opacity:0}, function(e) {
            $('#feedback_message').html('Thank you! If needed, we will be in touch shortly.').animate({opacity:1});
        });
    }
}

/**
 *  Redirect on feedback edit.
 **/
function edit_feedback_save(e, data, status, xhr) {
    if (status === 'success') {
        feedback = JSON.parse(xhr.responseText);
        window.location = '../feedbacks/' + feedback.id;
    }
}