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
      <div class="nav-collapse collapse">
        <ul class='nav' role='navigation'>
          <li class="active"><a href="/"><i class="icon-calendar"></i> Home</a></li>
          <li class='dropdown'>
            <a class='dropdown-toggle' id='dPazienti' role='button' data-toggle='dropdown' data-target='#' href="#pazienti">
              <i class="icon-user"></i>
              Pazienti
              <b class='caret'></b>
            </a>
            <ul class='dropdown-menu' role='menu' aria-labelledby='dPazienti'>
              <li><a href='/pazienti/nuovo'><i class="icon-plus"></i> Aggiungi paziente</a></li>
              <li><a href='#'><i class="icon-search"></i> Visualizza pazienti</a></li>
              <li><a href='#'><i class="icon-time"></i> Lista d'attesa</a></li>
              <li><a href='#'><i class="icon-folder-open"></i> Pazienti con cure da effettuare</a></li>
              <li><a href='#'><i class="icon-tasks"></i> Pazienti con cure potenziali</a></li>
            </ul>
          </li>
          <li class='dropdown'>
            <a class='dropdown-toggle' id='dOperatori' role='button' data-toggle='dropdown' data-target='#' href="#operatori">
              <i class="myicon-group"></i>
              Operatori
              <b class='caret'></b>
            </a>
            <ul class='dropdown-menu' role='menu' aria-labelledby='dOperatori'>
              <li><a href='#'><i class="icon-plus"></i> Aggiungi operatore</a></li>
              <li><a href='#'><i class="icon-search"></i> Visualizza operatori</a></li>
              <li><a href='#'><i class="icon-th-list"></i> Gestione presenze</a></li>
            </ul>
          </li>
          <li class='dropdown'>
            <a class='dropdown-toggle' id='dFatturazione' role='button' data-toggle='dropdown' data-target='#' href="#fatturazione">
              <i class="myicon-euro"></i>
              Fatturazione
              <b class='caret'></b>
            </a>
            <ul class='dropdown-menu' role='menu' aria-labelledby='dFatturazione'>
              <li class='dropdown-submenu'>
                <a href='#'><i class="myicon-file"></i> Fatture</a>
                <ul class='dropdown-menu'>
                  <li><a href='#'><i class="icon-plus"></i> Aggiungi fattura</a></li>
                  <li><a href='#'><i class="icon-plus"></i> Aggiungi nota di credito</a></li>
                  <li><a href='#'><i class="icon-search"></i> Visualizza fatture</a></li>
                </ul>
              </li>
              <li class='dropdown-submenu'>
                <a href="#incassi"><i class="myicon-coins"></i> Incassi</a>
                <ul class='dropdown-menu'>
                  <li><a href='#'><i class="icon-plus"></i> Aggiungi incasso</a></li>
                  <li><a href='#'><i class="icon-search"></i> Visualizza incassi</a></li>
                </ul>
              </li>
            </ul>
          </li>
          <li class='dropdown'>
            <a class='dropdown-toggle' id='dStatistiche' role='button' data-toggle='dropdown' data-target='#' href="#statistiche">
              <i class="myicon-stats"></i>
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
              <i class="icon-cog"></i>
              Personalizza
              <b class='caret'></b>
            </a>
            <ul class='dropdown-menu' role='menu' aria-labelledby='dPersonalizza'>
              <li class='dropdown-submenu'>
                <a href='#'>Generale</a>
                <ul class='dropdown-menu'>
                  <li><a href='/preferenze/generale'>Preferenze studio</a></li>
                  <li><a href='/preferenze/sale'>Sale operatorie</a></li>
                  <li><a href='/preferenze/categorie'>Categorie prestazioni</a></li>
                  <li><a href='/preferenze/prestazioni'>Elenco prestazioni</a></li>
                  <li><a href='/preferenze/gravita'>Gravità interventi</a></li>
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
              <i class="icon-certificate"></i>
              Utilità
              <b class='caret'></b>
            </a>
            <ul class='dropdown-menu' role='menu' aria-labelledby='dUtilita'>
              <li class='dropdown-submenu'>
                <a href='#'><i class="myicon-cargo"></i> Backup</a>
                <ul class='dropdown-menu'>
                  <li><a href='#'><i class="icon-download"></i> Esporta backup</a></li>
                  <li><a href='#'><i class="icon-upload"></i> Ripristina backup</a></li>
                </ul>
              </li>
              <li><a href='#'><i class="myicon-keys"></i> Gestione permessi</a></li>
              <li><a href='#'><i class="icon-user"></i> Gestione utenti</a></li>
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
<script src="/js/jquery.min.js"></script>
<script src="/js/bootstrap.min.js"></script>
{% block scripts %}{% endblock %}
</body>
</html>
