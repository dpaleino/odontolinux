<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>OdontoLinux</title>
<link href="/css/bootstrap.min.css" rel="stylesheet">
<link href="/css/bootstrap-responsive.min.css" rel="stylesheet">
<link href="/css/local.css" rel="stylesheet">
{% block styles %}
{% endblock %}
<!--[if lt IE 9]>
<script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
</head>
<body>
<div class='navbar navbar-fixed-top'>
  <div class='navbar-inner'>
    <div class='container'>
      <button type='button' class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <a class="brand" href="/">OdontoLinux</a>
      <div class="nav-collapse">
        <ul class='nav' role='navigation'>
          <li class="active"><a href="#">Calendario</a></li>
          <li class='dropdown'>
            <a class='dropdown-toggle' id='dPazienti' role='button' data-toggle='dropdown' data-target='#' href="#pazienti">
              Pazienti
              <b class='caret'></b>
            </a>
            <ul class='dropdown-menu' role='menu' aria-labelledby='dPazienti'>
              <li><a href='#'>Aggiungi paziente</a></li>
              <li><a href='#'>Visualizza pazienti</a></li>
              <li><a href='#'>Lista d'attesa</a></li>
              <li><a href='#'>Pazienti con cure da effettuare</a></li>
              <li><a href='#'>Pazienti con cure potenziali</a></li>
            </ul>
          </li>
          <li class='dropdown'>
            <a class='dropdown-toggle' id='dOperatori' role='button' data-toggle='dropdown' data-target='#' href="#operatori">
              Operatori
              <b class='caret'></b>
            </a>
            <ul class='dropdown-menu' role='menu' aria-labelledby='dOperatori'>
              <li><a href='#'>Aggiungi operatore</a></li>
              <li><a href='#'>Visualizza operatori</a></li>
              <li><a href='#'>Gestione presenze</a></li>
            </ul>
          </li>
          <li class='dropdown'>
            <a class='dropdown-toggle' id='dFatturazione' role='button' data-toggle='dropdown' data-target='#' href="#fatturazione">
              Fatturazione
              <b class='caret'></b>
            </a>
            <ul class='dropdown-menu' role='menu' aria-labelledby='dFatturazione'>
              <li class='dropdown-submenu'>
                <a href='#'>Fatture</a>
                <ul class='dropdown-menu'>
                  <li><a href='#'>Aggiungi fattura</a></li>
                  <li><a href='#'>Aggiungi nota di credito</a></li>
                  <li><a href='#'>Visualizza fatture</a></li>
                </ul>
              </li>
              <li class='dropdown-submenu'>
                <a href="#incassi">Incassi</a>
                <ul class='dropdown-menu'>
                  <li><a href='#'>Aggiungi incasso</a></li>
                  <li><a href='#'>Visualizza incassi</a></li>
                </ul>
              </li>
            </ul>
          </li>
          <li class='dropdown'>
            <a class='dropdown-toggle' id='dStatistiche' role='button' data-toggle='dropdown' data-target='#' href="#statistiche">
              Statistiche
              <b class='caret'></b>
            </a>
            <ul class='dropdown-menu' role='menu' aria-labelledby='dStatistiche'>
              <li class='dropdown-submenu'>
                <a href='#'>Report pazienti</a>
                <ul class='dropdown-menu'>
                  <li><a href='#'>Pazienti/fatturato</a></li>
                  <li><a href='#'>Esporta cod. fiscale</a></li>
                  <li><a href='#'>Tracciabilità cure</a></li>
                </ul>
              </li>
              <li class='dropdown-submenu'>
                <a href="#incassi">Report contabili</a>
                <ul class='dropdown-menu'>
                  <li><a href='#'>Studi settore fatt.</a></li>
                  <li><a href='#'>Studi settore prev.</a></li>
                  <li><a href='#'>Preventivi aperti</a></li>
                  <li><a href='#'>Stato preventivi</a></li>
                  <li><a href='#'>Compenso operatori</a></li>
                  <li><a href='#'>Situazione debitoria</a></li>
                </ul>
              </li>
              <li class='dropdown-submenu'>
                <a href='#'>Statistiche</a>
                <ul class='dropdown-menu'>
                  <li><a href='#'>Incassi</a></li>
                  <li><a href='#'>Fatturato</a></li>
                  <li><a href='#'>Cure effettuate</a></li>
                </ul>
              </li>
              <li class='dropdown-submenu'>
                <a href='#'>Grafici</a>
                <ul class='dropdown-menu'>
                  <li><a href='#'>Cruscotto</a></li>
                  <li><a href='#'>Prime visite</a></li>
                  <li><a href='#'>Produzione</a></li>
                  <li><a href='#'>Preventivi</a></li>
                  <li><a href='#'>Fatturato</a></li>
                  <li><a href='#'>Anagrafiche</a></li>
                </ul>
              </li>
            </ul>
          </li>
          <li class='dropdown'>
            <a class='dropdown-toggle' id='dPersonalizza' role='button' data-toggle='dropdown' data-target='#' href="#personalizza">
              Personalizza
              <b class='caret'></b>
            </a>
            <ul class='dropdown-menu' role='menu' aria-labelledby='dPersonalizza'>
              <li class='dropdown-submenu'>
                <a href='#'>Calendario</a>
                <ul class='dropdown-menu'>
                  <li><a href='#'>Preferenze studio</a></li>
                  <li><a href='#'>Sale operatorie</a></li>
                  <li><a href='#'>Colori interventi</a></li>
                  <li><a href='#'>Gravità interventi</a></li>
                </ul>
              </li>
              <li class='dropdown-submenu'>
                <a href="#incassi">Anagrafica</a>
                <ul class='dropdown-menu'>
                  <li><a href='#'>Anestesie</a></li>
                  <li><a href='#'>Domande anamnesi</a></li>
                  <li><a href='#'>Fasce orarie</a></li>
                  <li><a href='#'>Tipologie eventi</a></li>
                </ul>
              </li>
              <li class='dropdown-submenu'>
                <a href='#'>Preventivi</a>
                <ul class='dropdown-menu'>
                  <li><a href='#'>Tariffario</a></li>
                  <li><a href='#'>Frasi preventivo</a></li>
                  <li><a href='#'>Pagamento preventivo</a></li>
                </ul>
              </li>
              <li class='dropdown-submenu'>
                <a href='#'>Fatture</a>
                <ul class='dropdown-menu'>
                  <li><a href='#'>Frasi fatture</a></li>
                  <li><a href='#'>Pagamento fatture</a></li>
                </ul>
              </li>
              <li class='dropdown-submenu'>
                <a href='#'>Template</a>
                <ul class='dropdown-menu'>
                  <li><a href='#'>Template carosello</a></li>
                  <li><a href='#'>Template documento</a></li>
                </ul>
              </li>
            </ul>
          </li>
          <li class='dropdown'>
            <a class='dropdown-toggle' id='dUtilita' role='button' data-toggle='dropdown' data-target='#' href="#utilita">
              Utilità
              <b class='caret'></b>
            </a>
            <ul class='dropdown-menu' role='menu' aria-labelledby='dUtilita'>
              <li class='dropdown-submenu'>
                <a href='#'>Backup</a>
                <ul class='dropdown-menu'>
                  <li><a href='#'>Esporta backup</a></li>
                  <li><a href='#'>Ripristina backup</a></li>
                </ul>
              </li>
              <li><a href='#'>Gestione permessi</a></li>
              <li><a href='#'>Gestione utenti</a></li>
            </ul>
          </li>
        </ul>
        <ul class='nav pull-right'>
          <li><p class='navbar-text'>20:18</p></li>
        </ul>
      </div>
    </div>
  </div>
</div>
<div class='container' id='main'>
{% block content %}
{% endblock %}
</div>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="/js/bootstrap.min.js"></script>
{% block scripts %}{% endblock %}
</body>
</html>
