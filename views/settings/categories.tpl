{% extends 'base.tpl' %}

{% block styles %}
<link rel='stylesheet' href='/css/jquery.dataTables.css'>
<link rel='stylesheet' href='/css/colorpicker.css'>
{% endblock %}

{% block scripts %}
<script src='/js/jquery.dataTables.min.js'></script>
<script src='/js/jquery.dataTables.editable.min.js'></script>
<script src='/js/jquery.jeditable.min.js'></script>
<script src='/js/jquery.validate.min.js'></script>
<script src='/js/bootstrap-colorpicker.min.js'></script>
<script src='/js/colorcontrast.js'></script>
<script>
$(document).ready(function(){
    // make readable colors
    $('#tblCategorie tr>td').each(function(index, value) {
        if (value.attributes.bgcolor != undefined) {
            bg = value.attributes.bgcolor.value.substring(1);
            value.style.color = getColorContrast(bg);
        }
    });

    $.editable.addInputType('colorpicker', {
        element: $.editable.types.text.element,
        plugin: function (settings, original) {
            $('input', this).colorpicker();
        }
    });

    $.extend(true, $.fn.dataTable.defaults, {
        sDom: "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
        //~ sPaginationType: 'bootstrap',
        oLanguage: {
            sLengthMenu: '_MENU_ righe per pagina',
            oPaginate: {
                sPrevious: 'Indietro',
                sNext: 'Avanti',
            },
            sInfo: 'Mostrate righe da _START_ a _END_ su _TOTAL_ totali',
            sInfoFiltered: '(filtrate da _MAX_ righe in tutto)',
            sSearch: 'Cerca:',
        }
    });

    $('#tblCategorie').dataTable({
        aaSorting: [
            [ 1, 'asc' ],
        ],
        bSortClasses: false,
    }).makeEditable({
        sDeleteURL: '/api/settings/categories/delete',
        sUpdateURL: '/api/settings/categories/update',
        sAddURL: '/api/settings/categories/add',
        oValidationOptions: null,
        oDeleteRowButtonOptions: null,
        sDeleteRowButtonId: '',
        aoColumns: [
            null,
            {
                cssclass: 'required',
                placeholder: 'Modifica',
            },
            {
                cssclass: 'required',
                placeholder: 'Modifica',
                type: 'colorpicker',
                onblur: 'submit',
            },
        ],
        // FIXME: usare una modal bootstrap.
        fnOnDeleting: function(tr, id, fnDeleteRow) {
            return confirm('Sicuro/a di voler cancellare questa riga?');
        },
        fnOnEdited: function(status, sOldValue, sNewCellDisplayValue, iRowIndex, iColumnIndex, iRealColumnIndex) {
            if (status == 'success') {
                if (iColumnIndex == 2) {
                    // color has been updated
                    $('#tblCategorie .last-updated-cell').attr('bgcolor', sNewCellDisplayValue);
                    $('#tblCategorie .last-updated-cell').attr('style', 'color: ' + getColorContrast(sNewCellDisplayValue));
                };
                return true;
            };
        },
    });
});
</script>
{% endblock %}

{% block content %}
<div class='page-header'>
    <h1>Categorie prestazioni</h1>
</div>
<table class='table table-hover' id='tblCategorie'>
    <thead>
        <tr>
            <th>#</th>
            <th>Descrizione</th>
            <th>Colore</th>
            <th>Azioni</th>
        </tr>
    </thead>
    <tbody>
      {% for key, d in data %}
        <tr id='row{{key}}'>
            <td class='read_only'>{{key}}</td>
            <td>{{d.name}}</td>
            <td bgcolor='#{{d.color}}' id='color{{key}}'>#{{d.color}}</td>
            <td class='read_only'>
                <button type='button' class='btn btn-mini table-action-deletelink'>
                    <i class='icon-remove'></i>
                </button>
            </td>
        </tr>
      {% endfor %}
    </tbody>
</table>
{% endblock %}
