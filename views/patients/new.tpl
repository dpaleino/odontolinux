{% extends 'base.tpl' %}

{% block content %}
<div class='page-header'>
	<h1>Nuovo paziente</h1>
</div>
<div class='tabbable'>
	<ul class='nav nav-tabs'>
		<li class='active'><a href='#anagrafica' data-toggle='tab'>Anagrafica</a></li>
		<li><a href='#contatti' data-toggle='tab'>Contatti</a></li>
		<li><a href='#apr' data-toggle='tab'>Anamnesi pat. rem.</a></li>
		<li><a href='#allergie' data-toggle='tab'>Allergie/Vaccinazioni</a></li>
		<li><a href='#anamnesi' data-toggle='tab'>Anamnesi generale</a></li>
		<li><a href='#clinica' data-toggle='tab'>Clinica</a></li>
	</ul>
	<form class='form-horizontal' action='#' id='formNuovoPaziente'>
		<div id='tabContent' class='tab-content'>
			<div class='tab-pane fade active in' id='anagrafica'>
				<div class='control-group'>
					<label class='control-label' for='inputNome'>Nome e Cognome</label>
					<div class='controls'>
						<input type='text' id='inputNome' placeholder='Nome'>
						<input type='text' id='inputCognome' placeholder='Cognome'>
					</div>
				</div>
				<div class='control-group'>
					<label class='control-label' for='optionSesso'>Sesso</label>
					<div class='controls'>
						<label class='radio'>
							<input type='radio' name='optionSesso' id='optionUomo' value='uomo' checked><i class="myicon-male"></i> Uomo
						</label>
						<label class='radio'>
							<input type='radio' name='optionSesso' id='optionDonna' value='donna'><i class="myicon-female"></i> Donna
						</label>
					</div>
				</div>
				<div class='control-group'>
					<label class='control-label' for='bdayGiorno'>Data di nascita</label>
					<div class='controls'>
						<input type='text' id='bdayGiorno' class='input-mini' placeholder='Giorno'>
						<select class='input-medium' id='bdayMese'>
							<option value='1'>Gennaio</option>
							<option value='2'>Febbraio</option>
							<option value='3'>Marzo</option>
							<option value='4'>Aprile</option>
							<option value='5'>Maggio</option>
							<option value='6'>Giugno</option>
							<option value='7'>Luglio</option>
							<option value='8'>Agosto</option>
							<option value='9'>Settembre</option>
							<option value='10'>Ottobre</option>
							<option value='11'>Novembre</option>
							<option value='12'>Dicembre</option>
						</select>
						<input type='text' id='bdayAnno' class='input-mini' placeholder='Anno'>
					</div>
				</div>
				<div class='control-group'>
					<label class='control-label' for='inputComuneNascita'>Comune di nascita</label>
					<div class='controls'>
						<input type='text' id='inputComuneNascita' placeholder='Comune di nascita'>
					</div>
				</div>
				<div class='control-group'>
					<label class='control-label' for='inputCodiceFiscale'>Codice Fiscale</label>
					<div class='controls'>
						<input type='text' id='inputCodiceFiscale' placeholder='Codice Fiscale' maxlength='16'>
					</div>
				</div>
			</div>
			<div class='tab-pane fade' id='contatti'>
				<div class='control-group'>
					<label class='control-label' for='inputVia'>Indirizzo</label>
					<div class='controls controls-row'>
						<input type='text' id='inputVia' placeholder='Via' class='span3'>
						<input type='text' id='inputCivico' placeholder='Civico' class='span1'>
					</div>
					<div class='controls controls-row'>
					<input type='text' id='inputCAP' placeholder='C.A.P.' class='span1'>
					<input type='text' id='inputComune' placeholder='Città' class='span3'>
					</div>
				</div>
				<div class='control-group'>
					<label class='control-label' for='inputTelefono'>Telefono</label>
					<div class='controls'>
						<input type='text' id='inputTelefono' placeholder='Telefono' class='span4'>
					</div>
				</div>
				<div class='control-group'>
					<label class='control-label' for='inputCellulare'>Cellulare</label>
					<div class='controls'>
						<input type='text' id='inputCellulare' placeholder='Cellulare' class='span4'>
						<label class='checkbox' for='checkContattoCellulare'>
							<input type='checkbox' id='checkContattoCellulare' checked> Contatta via SMS
						</label>
					</div>
				</div>
				<div class='control-group'>
					<label class='control-label' for='inputEmail'>E-mail</label>
					<div class='controls'>
						<input type='text' id='inputEmail' placeholder='E-mail' class='span4'>
						<label class='checkbox' for='checkContattoMail'>
							<input type='checkbox' id='checkContattoMail' checked> Contatta via E-mail
						</label>
					</div>
				</div>
			</div>
			<div class='tab-pane fade' id='apr'>
				<div class='controls-row'>
					<fieldset class='span4'>
						<legend>Malattie cardiovascolari</legend>
						<label class="checkbox">
							<input type="checkbox" id='checkIpertensione'>Ipertensione
						</label>
						<label class="checkbox">
							<input type="checkbox" id='checkAritmie'>Aritmie
						</label>
						<label class="checkbox">
							<input type="checkbox" id='checkAngina'>Angina pectoris
						</label>
						<label class="checkbox">
							<input type="checkbox" id='checkInfarto'>Pregresso infarto
						</label>
						<label class="checkbox">
							<input type="checkbox" id='checkEndocardite'>Endocardite
						</label>
						<label class="checkbox">
							<input type="checkbox" id='checkPacemaker'>Portatore di Bypass o Pacemaker
						</label>
					</fieldset>
					<fieldset class='span3'>
						<legend>Malattie infettive</legend>
						<label class="checkbox">
							<input type="checkbox" id='checkHIV'>HIV
						</label>
						<label class="checkbox">
							<input type="checkbox" id='checkEpatiteB'>Epatite B
						</label>
						<label class="checkbox">
							<input type="checkbox" id='checkEpatiteC'>Epatite C
						</label>
						<label class="checkbox">
							<input type="checkbox" id='checkHerpes'>Herpes labiale
						</label>
						<label class="checkbox">
							<input type="checkbox" id='checkCandidosi'>Candidosi
						</label>
						<label class="checkbox">
							<input type="checkbox" id='checkMononucleosi'>Mononucleosi
						</label>
						<label class="checkbox">
							<input type="checkbox" id='checkTubercolosi'>Tubercolosi
						</label>
					</fieldset>
					<fieldset class='span4'>
						<legend>Altre malattie</legend>
						<div class='row'>
							<div class='span2'>
								<label class="checkbox">
									<input type="checkbox" id='checkEmofilia'>Emofilia
								</label>
								<label class="checkbox">
									<input type="checkbox" id='checkEmorragie'>Emorragie
								</label>
								<label class="checkbox">
									<input type="checkbox" id='checkFlebite'>Flebite
								</label>
								<label class="checkbox">
									<input type="checkbox" id='checkDiabete'>Diabete
								</label>
								<label class="checkbox">
									<input type="checkbox" id='checkEpatiche'>Epatiche
								</label>
								<label class="checkbox">
									<input type="checkbox" id='checkRenali'>Renali
								</label>
								<label class="checkbox">
									<input type="checkbox" id='checkGastointestinali'>Gastrointestinali
								</label>
								<label class="checkbox">
									<input type="checkbox" id='checkBroncopolmonari'>Broncopolmonari
								</label>
							</div>
							<div class='span2'>
								<label class="checkbox">
									<input type="checkbox" id='checkCefalee'>Cefalee
								</label>
								<label class="checkbox">
									<input type="checkbox" id='checkVertigini'>Vertigini
								</label>
								<label class="checkbox">
									<input type="checkbox" id='checkNeurologiche'>Neurologiche
								</label>
								<label class="checkbox">
									<input type="checkbox" id='checkCutanee'>Cutanee
								</label>
								<label class="checkbox">
									<input type="checkbox" id='checkVeneree'>Veneree
								</label>
								<label class="checkbox">
									<input type="checkbox" id='checkGlaucoma'>Glaucoma
								</label>
								<label class="checkbox">
									<input type="checkbox" id='checkTiroide'>Pat. tiroide
								</label>
								<label class="checkbox">
									<input type="checkbox" id='checkArtriteReumatoide'>Artrite reumatoide
								</label>
							</div>
							<div class='span4'>
								<label for='textAltreMalattie'>Altro</label>
								<textarea rows="3" id='textAltreMalattie' style='width: 100%'></textarea>
							</div>
						</div>
					</fieldset>
					<fieldset class='span11'>
						<legend>Terapie in atto</legend>
						<textarea rows="3" id='textTerapie' style='width: 100%'></textarea>
					</fieldset>
				</div>
			</div>
			<div class='tab-pane fade' id='allergie'>
				<div class='controls-row'>
					<fieldset class='span5'>
						<legend>Allergie</legend>
						<div class='control-group'>
							<label class='control-label' for='textAllergiaMonomeri'>Monomeri</label>
							<div class='controls'>
								<textarea rows='3' id='textAllergiaMonomeri'></textarea>
							</div>
						</div>
						<div class='control-group'>
							<label class='control-label' for='textAllergiaMetalli'>Metalli</label>
							<div class='controls'>
								<textarea rows='3' id='textAllergiaMetalli'></textarea>
							</div>
						</div>
						<div class='control-group'>
							<label class='control-label' for='textAllergiaFarmaci'>Farmaci</label>
							<div class='controls'>
								<textarea rows='3' id='textAllergiaFarmaci'></textarea>
							</div>
						</div>
						<div class='control-group'>
							<label class='control-label' for='textAllergiaAlimenti'>Alimenti</label>
							<div class='controls'>
								<textarea rows='3' id='textAllergiaAlimenti'></textarea>
							</div>
						</div>
						<div class='control-group'>
							<label class='control-label' for='checkAllergiaPolline'>Polline</label>
							<div class='controls'>
								<input type="checkbox" id='checkAllergiaPolline'>
							</div>
						</div>
						<div class='control-group'>
							<label class='control-label' for='textAllergiaAltro'>Altro</label>
							<div class='controls'>
								<textarea rows='3' id='textAllergiaAltro'></textarea>
							</div>
						</div>
					</fieldset>
					<fieldset class='span5'>
						<legend>Vaccinazioni</legend>
						<label class='checkbox'>
							<input type="checkbox" id='checkVaccinoTetano'>Tetano
						</label>
						<label class='checkbox'>
							<input type="checkbox" id='checkVaccinoEpatiteB'>Epatite B
						</label>
						<label class='checkbox'>
							<input type="checkbox" id='checkVaccinoInfluenza'>Influenza
						</label>
						<label class='checkbox'>
							<input type="checkbox" id='checkVaccinoMeningite'>Meningite
						</label>
						<label class='checkbox'>
							<input type="checkbox" id='checkVaccinoBCG'>Tubercolosi (BCG)
						</label>
						<label class='checkbox'>
							<input type="checkbox" id='checkVaccinoEpatiteA'>Epatite A
						</label>
						<label class='checkbox'>
							<input type="checkbox" id='checkVaccinoRabbia'>Rabbia
						</label>
						<label for='textAltreMalattie'>Altro</label>
						<textarea rows="3" id='textVaccinoAltro' style='width: 100%'></textarea>
					</fieldset>
				</div>
			</div>
			<div class='tab-pane fade' id='anamnesi'>
				<div class='controls-row'>
					<fieldset class='span4'>
						<legend>Igiene orale</legend>
						<label class='checkbox'>
							<input type="checkbox" id='checkSpazzolino'>Usa correttamente lo spazzolino
						</label>
						<label class='checkbox'>
							<input type="checkbox" id='checkFilo'>Usa il filo interdentale
						</label>
						<label class='checkbox'>
							<input type="checkbox" id='checkCollutorio'>Usa il collutorio
						</label>
					</fieldset>
					<fieldset class='span3'>
						<legend>Abitudini</legend>
						<label class='checkbox'>
							<input type="checkbox" id='checkBruxista'>Bruxista
						</label>
						<label class='checkbox'>
							<input type="checkbox" id='checkMordeOggetti'>Morde oggetti
						</label>
						<label class='checkbox'>
							<input type="checkbox" id='checkAlcolismo'>Alcolismo
						</label>
						<label class='checkbox'>
							<input type="checkbox" id='checkFumatore'>Fumatore
						</label>
					</fieldset>
					<fieldset class='span4'>
						<legend>Primo incontro</legend>
						<label class='checkbox'>
							<input type="checkbox" id='checkAnestesie'>Già subito anestesie
						</label>
						<label class='checkbox'>
							<input type="checkbox" id='checkGravidanza'>Stato di gravidanza
						</label>
						<label class='checkbox'>
							<input type="checkbox" id='checkTossicodipendenza'>Tossicodipendenza
						</label>
						<label for='radioGruppoSanguigno' style='margin-bottom: 0px'>Gruppo sanguigno</label>
						<label class='radio inline'>
							<input type="radio" name='radioGruppoSanguigno' id='radioGSA'>A
						</label>
						<label class='radio inline'>
							<input type="radio" name='radioGruppoSanguigno' id='radioGSB'>B
						</label>
						<label class='radio inline'>
							<input type="radio" name='radioGruppoSanguigno' id='radioGSAB'>AB
						</label>
						<label class='radio inline'>
							<input type="radio" name='radioGruppoSanguigno' id='radioGS0'>0
						</label>
						<label for='textAnamnesiAltro'>Altro</label>
						<textarea rows="3" id='textAnamnesiAltro' style='width: 100%'></textarea>
					</fieldset>
				</div>
			</div>
			<div class='tab-pane fade' id='clinica'>
				<p>Foo</p>
			</div>
			<div class="form-actions">
				<button type="submit" class="btn btn-primary">Salva</button>
				<button type="button" class="btn">Annulla</button>
			</div>
		</div>
	</form>
</div>
{% endblock %}
