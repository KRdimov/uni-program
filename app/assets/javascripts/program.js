function clearSubjects() {
    $( ".subjects" ).empty();
  }

  function clearProgram() {
    $( "#program" ).empty();
  }

  function showLoading(message) {
    $("#program").append("<div class='alert alert-info text-center'><strong>" + message + "</strong></div>")
    $("#program").append("<img class='center-block' src='/loading.gif' alt='loading gif' />")
  }
  
  function formatSubjects(data) {
    var html_subjects = ""
    var subjects = data.split(",");
    subjects.forEach(function(subject) {
      html_subjects += '<label class="btn btn-secondary subj-label"><input type="radio" name="options" autocomplete="off" value="' + subject + '"><b>' + subject + '</b></label>';
    });

    return html_subjects;
  }

  function loadSubjectsHandler() {
    $(".list-group-item").click(function(){
      var valueSelected = this.value;
      disableButtons();
      $(this).toggleClass("active");
      disableSelect();
      clearProgram();
      showLoading("Създаване на програма за дисциплината");
      scrollToLoading();
      $.ajax({
        url: "https://uniprogram-186910.appspot.com/program/show/" + valueSelected,
        headers: { 'week':  $('select[name=week]').val()},
        type: "get",
        success: function(data) {
          clearProgram();
          $( "#program" ).append(data);
          enableSelect();
          enableButtons();
        },
        error: function (request) {
          $( "#program" ).append(request.responseText);
        }
      });
    });
  }

  $( document ).ready(function() {
    $('select[name=week]').change(function(){
      var valueSelected = this.value;
      if(valueSelected) {
        clearSubjects();
        clearProgram();
        showLoading("Извличане на дисциплините за седмицата");
        disableSelect();
        $.ajax({
          url: "https://uniprogram-186910.appspot.com/program/subjects/" + valueSelected,
          type: "get",
          success: function(data) {
            clearSubjects();
            clearProgram();
            $('.subjects').append(data);
            loadSubjectsHandler();
            enableSelect();
          },
          error: function (request) {
            $( "#program" ).append(request.responseText);
          }
        });
      }
    });
  });

  function disableSelect() {
    $('select[name=week]').prop('disabled', 'disabled');
  }

  function enableSelect() {
    $('select[name=week]').prop('disabled', false);
  }

  function disableButtons() {
    $(".list-group-item").each(function() {
      $( this ).removeClass( "active" );
      $( this ).prop("disabled", true);
    });
  }

  function enableButtons() {
    $(".list-group-item").each(function() {
      $( this ).prop("disabled", false);
    });
  }

  function scrollToLoading() {
    $('html, body').animate({
      scrollTop: $("#program").offset().top
    }, 1000);
  }
