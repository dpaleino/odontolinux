{% extends 'base.tpl' %}

{% block styles %}
<link href="/css/fullcalendar.css" rel="stylesheet" media="screen" />
<link href="/css/fullcalendar.print.css" rel="stylesheet" media="print" />
{% endblock %}

{% block content %}
<!--
<div class='page-header'>
  <h1>OdontoLinux</h1>
</div>
<p>Bla bla</p>
<div class="alert">
  <button type="button" class="close" data-dismiss="alert">×</button>
  <strong>Warning!</strong> Best check yo self, you're not looking too good.
</div>
-->
<div class='row-fluid'>
<div class="btn-toolbar span1 pull-right">
  <div class="btn-group btn-group-vertical">
    <a class="btn" href="#mdlAggiungi" role='button' data-toggle='modal'><i class="icon-plus"></i> Aggiungi</a>
    <a class="btn" href="#"><i class="icon-remove"></i> Rimuovi</a>
  </div>
</div>

  <div id='calendar' class='span11'></div>
</div>

<div id="mdlAggiungi" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="mdlLabel" aria-hidden="true">
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
    <h3 id="mdlLabel">Nuovo appuntamento</h3>
  </div>
  <div class="modal-body">
    <div class='row'>
      <div class='span8'>foo</div>
      <div class='span4'>bla</div>
    </div>
    <p>Bla bla</p>
  </div>
  <div class="modal-footer">
    <button class="btn" data-dismiss="modal" aria-hidden="true">Chiudi</button>
    <button class="btn btn-primary">Salva</button>
  </div>
</div>
{% endblock %}

{% block scripts %}
<script src="/js/jquery.ui.core.js"></script>
<script src="/js/jquery.ui.widget.js"></script>
<script src="/js/jquery.ui.mouse.js"></script>
<script src="/js/jquery.ui.position.js"></script>
<script src="/js/jquery.ui.draggable.js"></script>
<script src="/js/jquery.ui.resizable.js"></script>
<script src="/js/fullcalendar.js"></script>
<script>
$(document).ready(function() {
    $('#calendar').fullCalendar({
        aspectRatio: 2,
        header: {
            left: 'prev,next today',
            center: 'title',
            right: 'month,agendaWeek,agendaDay'
        },
        monthNames: ['Gennaio', 'Febbraio', 'Marzo', 'Aprile', 'Maggio',
            'Giugno', 'Luglio', 'Agosto', 'Settembre', 'Ottobre', 'Novembre',
            'Dicembre'],
        monthNamesShort: ['Gen', 'Feb', 'Mar', 'Apr', 'Mag', 'Giu', 'Lug',
            'Ago', 'Set', 'Ott', 'Nov', 'Dic'],
        dayNames: ['Domenica', 'Lunedì', 'Martedì', 'Mercoledì', 'Giovedì',
            'Venerdì', 'Sabato'],
        dayNamesShort: ['Dom', 'Lun', 'Mar', 'Mer', 'Gio', 'Ven', 'Sab'],
        firstDay: 1, // monday
        buttonText: {
            today: 'oggi',
            month: 'mese',
            week: 'settimana',
            day: 'giorno',
        },
        weekMode: 'liquid',
        allDaySlot: false,
        allDayText: 'intero giorno',
        axisFormat: 'H:mm',
        firstHour: '8',
        defaultView: 'agendaDay',
        editable: true,
        selectable: true,
        events: '/calendario/appuntamenti',
        timeFormat: 'H:mm{ - H:mm}',
        columnFormat: {
            month: 'dddd',
            week: 'dddd d/M',
            day: ''
        },
        titleFormat: {
            month: 'MMMM yyyy',
            week: "d [ MMM][ yyyy]{ '&#8212;' d MMM yyyy}",
            day: 'dddd d MMMM yyyy'
        }
        //lazyFetching: false,
    })
});
</script>
{% endblock %}
