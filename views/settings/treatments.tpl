{% extends 'base.tpl' %}

{% block styles %}
<!--<link rel='stylesheet' href='/css/flexigrid.min.css'>-->
<link rel='stylesheet' href='/css/jquery.dataTables.css'>
{% endblock %}

{% block scripts %}
<script src='/js/jquery.dataTables.js'></script>
<script src='/js/jquery.dataTables.editable.js'></script>
<script src='/js/jquery.jeditable.js'></script>
<script src='/js/jquery.validate.js'></script>
<script>
$(document).ready(function(){
    $('.btnConfirmDeletion').each(function(i) {
        $(this).click(function() {
            id = $(this).data('id');
            baseurl = '/api/settings/treatments/delete?id=';
            $('.modal-footer .table-action-deletelink').attr('href', baseurl + id);
        })
    });

    $.extend($.fn.dataTableExt.oStdClasses, {
        sWrapper: 'dataTables_wrapper form-inline',
    });

    $.fn.dataTableExt.oApi.fnPagingInfo = function (oSettings) {
        return {
            "iStart":         oSettings._iDisplayStart,
            "iEnd":           oSettings.fnDisplayEnd(),
            "iLength":        oSettings._iDisplayLength,
            "iTotal":         oSettings.fnRecordsTotal(),
            "iFilteredTotal": oSettings.fnRecordsDisplay(),
            "iPage":          Math.ceil(oSettings._iDisplayStart / oSettings._iDisplayLength),
            "iTotalPages":    Math.ceil(oSettings.fnRecordsDisplay() / oSettings._iDisplayLength),
        };
    };

    $.extend( $.fn.dataTableExt.oPagination, {
        "bootstrap": {
            "fnInit": function(oSettings, nPaging, fnDraw) {
                var oLang = oSettings.oLanguage.oPaginate;
                var fnClickHandler = function (e) {
                    e.preventDefault();
                    if (oSettings.oApi._fnPageChange(oSettings, e.data.action)) {
                        fnDraw(oSettings);
                    }
                };

                $(nPaging).addClass('pagination').append(
                    '<ul>'+
                    '<li class="prev disabled"><a href="#">&larr; '+oLang.sPrevious+'</a></li>'+
                    '<li class="next disabled"><a href="#">'+oLang.sNext+' &rarr; </a></li>'+
                    '</ul>'
                );
                var els = $('a', nPaging);
                $(els[0]).bind('click.DT', { action: "previous" }, fnClickHandler);
                $(els[1]).bind('click.DT', { action: "next" }, fnClickHandler);
            },

            "fnUpdate": function (oSettings, fnDraw) {
                var iListLength = 5;
                var oPaging = oSettings.oInstance.fnPagingInfo();
                var an = oSettings.aanFeatures.p;
                var i, j, sClass, iStart, iEnd, iHalf=Math.floor(iListLength/2);

                if (oPaging.iTotalPages < iListLength) {
                    iStart = 1;
                    iEnd = oPaging.iTotalPages;
                }
                else if (oPaging.iPage <= iHalf) {
                    iStart = 1;
                    iEnd = iListLength;
                } else if (oPaging.iPage >= (oPaging.iTotalPages-iHalf)) {
                    iStart = oPaging.iTotalPages - iListLength + 1;
                    iEnd = oPaging.iTotalPages;
                } else {
                    iStart = oPaging.iPage - iHalf + 1;
                    iEnd = iStart + iListLength - 1;
                }

                for (i=0, iLen=an.length ; i<iLen ; i++) {
                    // Remove the middle elements
                    $('li:gt(0)', an[i]).filter(':not(:last)').remove();

                    // Add the new list items and their event handlers
                    for (j=iStart ; j<=iEnd ; j++) {
                        sClass = (j==oPaging.iPage+1) ? 'class="active"' : '';
                        $('<li '+sClass+'><a href="#">'+j+'</a></li>')
                          .insertBefore( $('li:last', an[i])[0] )
                          .bind('click', function (e) {
                            e.preventDefault();
                            oSettings._iDisplayStart = (parseInt($('a', this).text(),10)-1) * oPaging.iLength;
                            fnDraw(oSettings);
                        });
                    }

                    // Add / remove disabled classes from the static elements
                    if (oPaging.iPage === 0) {
                        $('li:first', an[i]).addClass('disabled');
                    } else {
                        $('li:first', an[i]).removeClass('disabled');
                    }

                    if (oPaging.iPage === oPaging.iTotalPages-1 || oPaging.iTotalPages === 0) {
                        $('li:last', an[i]).addClass('disabled');
                    } else {
                        $('li:last', an[i]).removeClass('disabled');
                    }
                }
            }
        }
    });

    $.extend(true, $.fn.dataTable.defaults, {
        sDom: "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
        sPaginationType: 'bootstrap',
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

    $('#tblPrestazioni').dataTable({
        aaSorting: [
            [ 2, 'asc' ],
        ],
    }).makeEditable({
        sDeleteURL: '/api/settings/treatments/delete',
        sUpdateURL: '/api/settings/treatments/update',
        sAddURL: '/api/settings/treatments/add',
        oValidationOptions: null,
        aoColumns: [
            null,
            {
                cssclass: 'required',
                placeholder: 'Modifica',
            },
            {
                cssclass: 'required',
                placeholder: 'Modifica',
            },
            {
                cssclass: 'required',
                type: 'select',
                onblur: 'submit',
                loadurl: '/api/settings/categories',
                placeholder: 'Modifica',
            },
            {
                cssclass: 'number',
                placeholder: 'Modifica',
            },
            null
        ],
        fnOnDeleting: function(tr, id, fnDeleteRow) {
            $('#mdlConfirm').modal();
            $('#mdlConfirm').on('hidden', function() {
                // do something…
            })
            return false;
            //~ jConfirm('Please confirm that you want to delete row with id ' + id, 'Confirm Delete', function (confirmed) {
                //~ if (confirmed) {
                    //~ fnDeleteRow(id);
                //~ }
            //~ });
        }
    });
});
// http://code.google.com/p/jquery-datatables-editable/wiki/AddingNewRecords
</script> 
{% endblock %}

{% block content %}
<div class='page-header'>
	<h1>Elenco prestazioni</h1>
</div>
<table class='table table-hover' id='tblPrestazioni'>
    <thead>
        <tr>
            <th>#</th>
            <th>Codice</th>
            <th>Descrizione</th>
            <th>Categoria</th>
            <th>Prezzo</th>
            <th>Azioni</th>
        </tr>
    </thead>
    <tbody>
      {% for key, d in data %}
        <tr id='row{{key}}'>
            <td class='read_only'>{{key}}</td>
            <td>{{d.cod}}</td>
            <td>{{d.desc}}</td>
            <td>{{cat[d.cat_id].name}}</td>
            <td>{{d.prezzo}}</td>
            <td class='read_only'>
                <a class="btn btn-mini table-action-deletelink" href="/api/settings/treatments/delete?id={{key}}">
                    <i class='icon-remove'></i>
                </a>
            </td>
        </tr>
      {% endfor %}
    </tbody>
</table>
<div class='modal hide fade' id='mdlConfirm'>
    <div class='modal-header'>
        <button type='button' class='close' data-dismiss='modal' aria-hidden='true'>&times;</button>
        <h3>Conferma cancellazione</h3>
    </div>
    <div class='modal-body'>
        <p>Sicuro di voler cancellare questa riga?</p>
    </div>
    <div class='modal-footer'>
        <a href='#' class='btn btn-primary' data-dismiss='modal'>Sono sicuro</a>
        <a href='#' class='btn' data-dismiss='modal'>Annulla</a>
    </div>
</div>
{% endblock %}
