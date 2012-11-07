{% extends 'base.tpl' %}

{% block content %}
<div class='page-header'>
    <h1>Categorie prestazioni</h1>
</div>
<table class='table table-hover'>
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
        <tr>
            <td>{{key}}</td>
            <td>{{d.name}}</td>
            <td bgcolor='#{{d.color}}'>#{{d.color}}</td>
            <td></td>
        </tr>
      {% endfor %}
    </tbody>
</table>
{% endblock %}
