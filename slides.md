---
theme: default
title: Ohjelmistokehitys autonomisten agenttien aikakaudella
info: |
  Miten annamme tekoälylle enemmän autonomiaa menettämättä kontrollia?
  Joonas Laukka, Loihde. Demo: github.com/skyvier/verification-driven-ai-demo
author: Joonas Laukka
colorSchema: light
aspectRatio: 16/9
canvasWidth: 980
lineNumbers: false
transition: fade
drawings:
  enabled: false
fonts:
  sans: Arial, Helvetica
  mono: Fira Code, JetBrains Mono, Consolas, Menlo
  provider: none
exportFilename: ohjelmistokehitys-agenttien-aikakaudella
layout: cover
---

<div class="arrow">↗</div>

<p class="kicker" style="color: var(--l-teal)">AI × Software Engineering</p>

# Ohjelmistokehitys autonomisten agenttien aikakaudella

<p class="subtitle">Miten annamme tekoälylle enemmän autonomiaa menettämättä kontrollia?</p>

<p class="speaker"><strong>Joonas Laukka</strong> · Senior Consultant, Loihde</p>

<p class="aside-joke">Määrittele järjestelmä, eristä agentti, päästä se irti.</p>

<img class="logo" src="/loihde-white.svg" alt="Loihde" />

<!--
[0:00–0:30]

Terve kaikille, olen Joonas Laukka. Puhun tänään siitä, miten ohjelmistokehitystä kannattaa tehdä autonomisten agenttien aikakaudella.

Kysymys on: miten annamme tekoälylle enemmän autonomiaa menettämättä kontrollia, niin että voimme edelleen luottaa sen tuotokseen?

Vastaukseni on kolme askelta: määrittele järjestelmä, eristä agentti tarkistuksesta ja päästä se irti.

Emme aja agenttia livenä. Näytän mekanismin yksinkertaisella esimerkillä. *Aloitetaan siitä, miten agentti oikein toimii.*
-->

---

# Agentti työskentelee silmukassa

<svg class="diagram" viewBox="0 0 876 310" style="margin-top: 16px" role="img" aria-label="Agentin silmukka ympyränä: muokkaa koodia, aja työkalut, lue palaute ja takaisin muokkaamaan, kunnes agentti päättää itse, että työ on valmis.">
  <!-- the loop -->
  <circle cx="380" cy="150" r="105" fill="none" stroke="#866A9D" stroke-width="2"/>
  <g fill="#866A9D">
    <polygon points="387,45 373,51 373,39"/>
    <polygon points="467.4,208.6 469.2,193.4 479.6,199.4"/>
    <polygon points="285.6,196.4 297.8,205.6 287.4,211.6"/>
  </g>
  <text x="380" y="146" text-anchor="middle" fill="#8A8A90" font-style="italic" style="font-size:12px">toistuu</text>
  <text x="380" y="162" text-anchor="middle" fill="#8A8A90" font-style="italic" style="font-size:12px">kymmeniä kertoja</text>
  <text x="268" y="218" text-anchor="end" fill="#866A9D" font-style="italic" style="font-size:12.5px">ei vielä</text>
  <!-- nodes -->
  <rect x="20" y="74.5" width="110" height="46" rx="10" fill="#F6F5F7" stroke="#C8C8CC"/>
  <rect x="209" y="74.5" width="160" height="46" rx="10" fill="#fff" stroke="#866A9D" stroke-width="2"/>
  <rect x="391" y="70.5" width="160" height="54" rx="10" fill="#fff" stroke="#41B4AF" stroke-width="2.5"/>
  <rect x="300" y="232" width="160" height="46" rx="10" fill="#fff" stroke="#866A9D" stroke-width="2"/>
  <rect x="660" y="232" width="170" height="46" rx="10" fill="#50375F"/>
  <g font-weight="700" text-anchor="middle" style="font-size:15px">
    <text x="75" y="103" fill="#545459">Tehtävä</text>
    <text x="289" y="103" fill="#192D2D">Muokkaa koodia</text>
    <text x="471" y="94" fill="#192D2D">Aja työkalut</text>
    <text x="380" y="260" fill="#192D2D">Lue palaute</text>
    <text x="745" y="261" fill="#fff">”Valmis! ✅”</text>
  </g>
  <text x="471" y="113" text-anchor="middle" fill="#545459" style="font-size:12px">kääntäjä, testit</text>
  <!-- entry -->
  <line x1="132" y1="97.5" x2="197" y2="97.5" stroke="#866A9D" stroke-width="2"/>
  <polygon points="197,91.5 209,97.5 197,103.5" fill="#866A9D"/>
  <!-- exit -->
  <line x1="462" y1="255" x2="648" y2="255" stroke="#50375F" stroke-width="2.5"/>
  <polygon points="648,248 660,255 648,262" fill="#50375F"/>
  <text x="560" y="245" text-anchor="middle" fill="#50375F" font-weight="700" style="font-size:12.5px">agentti päättää itse</text>
  <!-- annotations -->
  <text x="570" y="92" fill="#00847F" font-weight="700" style="font-size:13px">Palaute on vain niin hyvää</text>
  <text x="570" y="110" fill="#00847F" font-weight="700" style="font-size:13px">kuin tarkistukset</text>
  <text x="745" y="300" text-anchor="middle" fill="#866A9D" style="font-size:12.5px">lopetusehto: agentin oma arvio</text>
</svg>

<!--
[0:30–1:15]

Tämä on varmaan kaikille tuttua, mutta päästään samaan ajatukseen aluksi.

1. Agentille annetaan tehtävä.
2. Se muokkaa koodia.
3. Se ajaa työkaluja kuten kääntäjää ja testejä.
4. Se lukee palautteen ja päättää, onko se valmis vai jatketaanko.

Kaksi asiaa tästä kuvasta:
1. Agentti on vain niin hyvä kuin palaute, jonka se saa.
2. Silmukasta poistutaan agentin oman arvion perusteella.

*Mistä me tiedämme, että se on oikeasti valmis?*
-->

---

# Mistä tiedämme, että agentti on valmis?

<div class="cols" style="margin-top: 18px">
<div>

<span class="label-illustrative">Havainnollistus – ei oikean ajon tuloste</span>

<div class="terminal" style="margin-top: 10px">
<div><span class="prompt">agent›</span> Toteutin alennuslogiikan.</div>
<div><span class="prompt">agent›</span> Lisäsin testit ja kaikki menevät läpi.</div>
<div><span class="prompt">agent›</span> Valmis! ✅</div>
</div>

</div>
<div>

<h2>Mikä tässä voi mennä pieleen?</h2>

- **Sama väärinkäsitys kahdesti.** Agentti kirjoitti sekä toteutuksen että testit, joten väärinkäsitys päätyy molempiin, ja testit menevät silti läpi.
- **Testejä voi muuttaa.** Jos agentti saa muokata testejä, se voi saada tarkistuksen läpi muuttamalla tarkistusta eikä koodia.
- **Agentti voi erehtyä omasta valmiudestaan.** Se voi jättää testin ajamatta tai selittää epäonnistumisen pois, ja raportti näyttää silti samalta.

</div>
</div>

<div class="callout" style="margin-top: 26px">
"Valmis! ✅" on <strong>väite</strong>. Hyväksymiskriteeri on jotain, minkä päätimme <strong>ennen</strong> kuin delegoimme.
</div>

<!--
[1:15–3:25]

Vasemmalla keksitty esimerkki tilanteesta, johon moni on törmännyt. Agentti kertoo toteuttaneensa alennuslogiikan ja lisänneensä testit, kaikki menevät läpi, ja se on valmis. *Mikä tässä voi mennä pieleen?*

1. Sama väärinkäsitys kahdesti: jos agentti ymmärsi tehtävän väärin, **sama virhe on sekä toteutuksessa että testeissä**, eikä kukaan huomaa sitä.
2. Testejä voi muuttaa: **agentti voi päätellä, että testi on virheellinen, ja säätää sitä, kunnes se menee läpi**.
3. Agentti voi erehtyä omasta valmiudestaan: **se selittää virheen asiaan kuulumattomaksi tai ratkaisun riittävän hyväksi**.

Kysy yleisöltä: **"Kuinka monella on käynyt niin, että Claude tai Codex on sanonut työn olevan valmis, vaikka sitä ei ollut edes yritetty?"** Odota käsiä hetki.

Pohjimmainen syy on sama: "valmis" on mallin oma arvio, väite eikä tarkistus. *Miten valmis määritellään oikein?*
-->

---

# Rajataan ratkaisua jättäen agentille liikkumavaraa

<svg class="diagram" viewBox="0 0 876 270" style="margin-top: 20px" role="img" aria-label="Janan vasemmassa päässä liian löysä valmis, jossa agentin oma arvio riittää. Oikeassa päässä liian tiukka valmis, jossa testit lukitsevat toteutuksen. Keskellä tavoite: järjestelmä toimii odotetusti ja agentti saa päättää, miten.">
  <!-- sweet spot frame -->
  <rect x="309" y="48" width="258" height="160" rx="14" fill="#41B4AF" fill-opacity="0.08" stroke="#41B4AF" stroke-width="1.5" stroke-dasharray="5 4"/>
  <!-- zone labels -->
  <g font-weight="700" text-anchor="middle" style="font-size:15px">
    <text x="172" y="75" fill="#C4502A">Liian löysä</text>
    <text x="438" y="75" fill="#00847F">Järjestelmän ehdoilla</text>
    <text x="703" y="75" fill="#866A9D">Liian tiukka</text>
  </g>
  <!-- the bar -->
  <rect x="40" y="88" width="265" height="26" fill="#F67B50" fill-opacity="0.35"/>
  <rect x="305" y="88" width="266" height="26" fill="#41B4AF" fill-opacity="0.6"/>
  <rect x="571" y="88" width="265" height="26" fill="#B496CD" fill-opacity="0.45"/>
  <!-- descriptions -->
  <g text-anchor="middle" style="font-size:13px" fill="#545459">
    <text x="172" y="144">”Valmis” on agentin oma arvio</text>
    <text x="172" y="164">Agentti voi olla valmis</text>
    <text x="172" y="182">mistä tahansa</text>
    <text x="438" y="144" fill="#192D2D" font-weight="700">Järjestelmä toimii odotetusti</text>
    <text x="438" y="164" fill="#192D2D" font-weight="700">Agentti saa päättää, miten</text>
    <text x="703" y="144">Testit lukitsevat toteutuksen:</text>
    <text x="703" y="164">mockit, sisäinen rakenne,</text>
    <text x="703" y="182">tarkat tulosteet</text>
  </g>
  <!-- axis -->
  <line x1="52" y1="232" x2="824" y2="232" stroke="#8A8A90" stroke-width="1.5"/>
  <polygon points="52,226 40,232 52,238" fill="#8A8A90"/>
  <polygon points="824,226 836,232 824,238" fill="#8A8A90"/>
  <text x="40" y="256" fill="#545459" style="font-size:12.5px">enemmän vapautta agentille</text>
  <text x="836" y="256" text-anchor="end" fill="#545459" style="font-size:12.5px">enemmän rajoja toteutukselle</text>
</svg>

<div class="callout teal" style="margin-top: 12px">
Tavoite: <strong>tarpeeksi tiukka</strong>, että järjestelmä toimii odotetusti, ja <strong>tarpeeksi löysä</strong>, että agentti saa päättää, miten.
</div>

<!--
[3:25–4:25]

Rajataan ratkaisua jättäen agentille liikkumavaraa.

Janalla on kolme kohtaa:
1. Liian löysä: **"valmis" on agentin oma arvio**, kuten edellisellä dialla. Agentti voi olla valmis mistä tahansa.
2. Liian tiukka: lisätään testejä, jotka **tuntevat toteutuksen**. Silloin agentilla ei ole liikkumavaraa, ja **teemme itse sen työn, jonka halusimme delegoida**.
3. Tavoite on keskellä: **järjestelmän ominaisuudet on määritelty, mutta toteutukseen ei oteta kantaa**. Agentti saa päättää, miten.

*Miten tämmönen tapahtuu käytännössä?*
-->

---

# Deterministisiä tarkistuksia on monenlaisia

<div class="check-grid">
  <div class="chk on"><b>Tyypit</b><span>ms</span><p>Pakottavat sopimuksen ja ohjaavat toteutusta</p><i>demossa: TypeScript</i></div>
  <div class="chk"><b>Lint</b><span>ms</span><p>Kielletyt rakenteet ja tyyli</p></div>
  <div class="chk"><b>Yksikkötestit</b><span>s</span><p>Yksittäisen funktion toiminta</p></div>
  <div class="chk on"><b>Ominaisuustestit</b><span>s</span><p>Käytös, johon muut järjestelmät luottavat</p><i>demossa: fast-check</i></div>
  <div class="chk on"><b>Hyväksymistestit</b><span>s</span><p>Täyttyykö tarve, jonka vuoksi työ tehtiin</p><i>demossa: Gherkin</i></div>
  <div class="chk"><b>Golden-testit</b><span>s</span><p>Tuloste vastaa hyväksyttyä</p></div>
  <div class="chk"><b>Arkkitehtuuritestit</b><span>s</span><p>Kuka saa riippua kenestä</p></div>
  <div class="chk"><b>Kontraktitestit</b><span>min</span><p>Palveluiden välinen sopimus</p></div>
  <div class="chk"><b>Integraatiotestit</b><span>min</span><p>Komponentit toimivat yhdessä</p></div>
  <div class="chk"><b>Tietoturvaskannaus</b><span>min</span><p>Tunnetut haavoittuvuudet ja vaaralliset rakenteet</p></div>
  <div class="chk"><b>E2E / UI-testit</b><span>min–h</span><p>Koko polku käyttäjän silmin</p></div>
  <div class="chk"><b>Fuzzing</b><span>min–h</span><p>Kaatuuko satunnaisella syötteellä</p></div>
</div>

<p class="muted" style="margin-top: 14px">Tänään <strong>kolme</strong>, jotka kirjoittavat järjestelmän <strong>lait</strong>. Ne kuvaavat järjestelmää eivätkä koodia, joten ne pysyvät totena, vaikka toteutus vaihtuu.</p>

<style>
.check-grid { display: grid; grid-template-columns: repeat(4, 1fr); grid-auto-rows: 1fr; gap: 10px; margin-top: 14px; }
.chk { position: relative; border: 1px solid var(--l-gray-300); border-radius: 8px; padding: 9px 12px 8px; background: var(--l-gray-50); opacity: 0.5; }
.chk b { font-size: 15px; color: var(--l-ink); }
.chk span { position: absolute; top: 9px; right: 10px; font-size: 11px; font-family: ui-monospace, Menlo, monospace; color: var(--l-gray-700); }
.chk p { margin: 3px 0 0; font-size: 12.5px; line-height: 1.3; color: var(--l-gray-700); }
.chk.on { opacity: 1; background: #fff; border: 2px solid var(--l-teal); }
.chk.on b { color: var(--l-teal-deep); }
.chk i { display: block; margin-top: 3px; font-size: 11px; font-style: normal; font-family: ui-monospace, Menlo, monospace; color: var(--l-gray-500); }
</style>

<!--
[4:25–5:25]

Käytännössä deterministisillä tarkistuksilla. Niitä on paljon, ja kaikilla on paikkansa. Tänään keskityn kolmeen:
1. **Tyypit**: mitä voi olla olemassa.
2. **Ominaisuustestit**: mikä pätee aina.
3. **Hyväksymistestit**: mitä pitää tapahtua.

Miksi juuri nämä? **Ne kuvaavat järjestelmää eivätkä koodia**, joten ne pysyvät totena, vaikka toteutus vaihtuu, ja ihminen voi päättää ne ennen delegointia.

Itse olen suuri tyyppijärjestelmien ystävä, ja agenttiaikana ne ovat entistä tärkeämpiä. **Tyypit lyövät rajapinnan lukkoon**, ja siksi kaksi muuta voi kirjoittaa ennen toteutusta.

*Miten nämä kolme yhdessä rajaavat agentin ratkaisua?*
-->

---

# Rajataan hyväksyttävien ohjelmien joukkoa

<div class="cols-wide-left" style="align-items: center">
<div>
<svg class="diagram" viewBox="0 0 540 360" role="img" aria-label="Kaikkien ohjelmien sisällä kolme toisiaan leikkaavaa joukkoa: tyyppitarkistuksen läpäisevät, ominaisuudet täyttävät ja hyväksymiskriteerit täyttävät ohjelmat. Hyväksytään vain kolmen joukon leikkaus, joka on agentin vapaus.">
  <rect x="6" y="6" width="528" height="348" rx="14" fill="#F6F5F7" stroke="#C8C8CC"/>
  <text x="22" y="30" style="font-size:13px" fill="#545459" font-weight="700">Kaikki ohjelmat</text>
  <!-- the three sets -->
  <circle cx="200" cy="145" r="100" fill="#B496CD" fill-opacity="0.28" stroke="#866A9D" stroke-width="2"/>
  <circle cx="340" cy="145" r="100" fill="#41B4AF" fill-opacity="0.24" stroke="#00847F" stroke-width="2"/>
  <circle cx="270" cy="245" r="100" fill="#F67B50" fill-opacity="0.18" stroke="#C4502A" stroke-width="2"/>
  <g font-weight="700" style="font-size:13px">
    <text x="118" y="104" fill="#50375F">Tyypit</text>
    <text x="352" y="104" fill="#00847F">Ominaisuudet</text>
    <text x="270" y="316" text-anchor="middle" fill="#C4502A">Hyväksymiskriteerit</text>
  </g>
  <g fill="#545459" style="font-size:11.5px">
    <text x="118" y="120">kääntyy</text>
    <text x="352" y="120">lait pätevät</text>
    <text x="270" y="332" text-anchor="middle">skenaariot läpi</text>
  </g>
  <!-- the intersection -->
  <circle cx="270" cy="182" r="8" fill="#192D2D"/>
  <line x1="277" y1="188" x2="392" y2="280" stroke="#192D2D" stroke-width="1.2"/>
  <text x="396" y="292" fill="#192D2D" font-weight="700" style="font-size:12.5px">hyväksytään</text>
  <text x="396" y="308" fill="#545459" style="font-size:11.5px">agentin vapaus</text>
</svg>
</div>
<div>

- Jokainen tarkistus **rajaa** hyväksyttävien ohjelmien joukkoa.
- Hyväksytään vain **leikkaus**: kääntyy, lait pätevät ja skenaariot menevät läpi.
- Leikkauksessa on yhä **monta** ratkaisua. Se on agentin vapaus.
- Ihminen vastaa siitä, **osuvatko rajat** tarkoitukseen.

<p class="tiny" style="margin-top: 14px">Käsitteellinen malli hyväksynnästä. Ei väite siitä, että mallin generointia rajattaisiin muodollisesti.</p>

</div>
</div>

<!--
[5:25–6:10]

**Eiköhän lyödä Venn-diagrammia pöytään.**

Ilman rajauksia agentti voi generoida **mitä tahansa ohjelmaa**. Todennäköisesti se osuu lähelle, mutta deterministiset tarkistukset varmistavat, että hyväksytyt ohjelmat ovat sitä, mitä haluamme.

Jokainen tarkistus rajaa joukkoa:
1. **Tyypit**: ohjelma kääntyy.
2. **Ominaisuudet**: lait pätevät.
3. **Hyväksymiskriteerit**: skenaariot menevät läpi.

Hyväksytään vain **leikkaus**. Sen sisällä on yhä monta toteutusta, ja se on agentin vapaus. Ihminen vastaa siitä, **osuvatko rajat siihen, mitä oikeasti tarkoitimme**.

Palaamme tähän kuvaan, kun kaikki kolme on nähty. *Ensin kuitenkin esimerkki, johon loppuesitys nojaa.*
-->

---

# Esimerkki: alennus verkkokaupan kassalla

<div class="cols" style="grid-template-columns: 1fr 1.15fr; gap: 34px; margin-top: 14px; align-items: start">
<div>

<span class="label-illustrative">Keksitty esimerkki</span>

<div class="checkout">
<div class="co-row"><span>Ostoskori</span><span>100,00&nbsp;€</span></div>
<div class="co-code"><span class="co-input">AUTUMN20</span><span class="co-ok">✓ −20&nbsp;%</span></div>
<div class="co-code"><span class="co-input">SUMMER10</span><span class="co-bad">✗ vanhentunut</span></div>
<div class="co-row co-total"><span>Maksettava</span><span>80,00&nbsp;€</span></div>
</div>

</div>
<div>

<h2>Mitä esimerkissä on</h2>

<ul>
<li><strong>Hinta ja alennus.</strong> <code>Money</code> sentteinä, <code>Percent</code> välillä 0&#8288;–&#8288;100.</li>
<li><strong>Yksi funktio.</strong> <code>applyDiscount(price, discount)</code></li>
<li><strong>Kampanjakoodit.</strong> Voimassa oleva koodi alentaa hintaa, vanhentunut hylätään.</li>
</ul>

<p class="tiny">Jätetty pois: verot, valuutat, tuotekohtaiset alennukset, palautukset.</p>

</div>
</div>

<div class="callout teal" style="margin-top: 22px">
Esimerkki on <strong>tarkoituksella äärimmäisen yksinkertainen</strong>. Se näyttää mekanismin. Oikeassa työssä tarkistusten määrä riippuu muutoksen riskistä.
</div>

<style>
.checkout { margin-top: 12px; border: 1px solid var(--l-gray-300); border-radius: 10px; padding: 14px 18px; background: #fff; box-shadow: 0 4px 18px rgba(80, 55, 95, 0.07); font-size: 17px; }
.co-row, .co-code { display: flex; justify-content: space-between; align-items: center; padding: 8px 0; }
.co-code { border-top: 1px dashed var(--l-gray-300); }
.co-input { font-family: ui-monospace, Menlo, monospace; font-size: 15px; border: 1px solid var(--l-gray-300); border-radius: 6px; padding: 3px 10px; background: var(--l-gray-50); }
.co-ok { color: var(--l-teal-deep); font-weight: 700; }
.co-bad { color: #C4502A; font-weight: 700; }
.co-total { border-top: 2px solid var(--l-ink); margin-top: 4px; font-weight: 700; font-size: 19px; }
</style>

<!--
[6:10–7:10]

Esimerkki, johon loppuesitys nojaa. **Se on tarkoituksella todella yksinkertainen.**

Verkkokaupan ostoskoriin voi syöttää alennuskoodin:
1. **AUTUMN20** on voimassa: sadan euron korista maksetaan 80 euroa.
2. **SUMMER10** on vanhentunut: se hylätään, eikä summa muutu.

Koodissa tämä on:
- **Money** on rahaa sentteinä.
- **Percent** on prosenttiluku nollasta sataan.
- Yksi funktio: **applyDiscount**, joka laskee alennetun hinnan.

Samat nimet palaavat seuraavilla dioilla.

Haluan vielä toistaa: **tämä on tarkoituksella yksinkertainen esimerkki**, jotta mekanismi näkyy. Oikeassa työssä kaikki on monimutkaisempaa, ja tarkistuksia rakennetaan sen mukaan, kuinka riskialtis muutos on. Samoja periaatteita voi silti soveltaa. Palaan riskiin lopussa.

*Lähdetään liikkeelle tyypeistä.*
-->

---

# Tyypit

<p class="h1-sub"><span class="step">1 / 3</span> · Tyyppi kantaa todisteen</p>

<svg class="diagram" viewBox="0 0 876 262" style="margin-top: 14px" role="img" aria-label="Luottamusraja: ulkomaailman raa'at luvut tarkistetaan kerran percent-konstruktorissa. Hylätyt palautuvat nullina. Hyväksytyt kulkevat järjestelmän sisälle Percent-tyyppisinä, eikä kukaan tarkista niitä uudelleen.">
  <!-- outside -->
  <rect x="20" y="30" width="280" height="200" rx="12" fill="#F6F5F7" stroke="#C8C8CC"/>
  <text x="40" y="58" fill="#545459" font-weight="700" style="font-size:15px">Ulkomaailma</text>
  <g fill="#545459" style="font-size:13px">
    <text x="40" y="92">kampanjan hallintanäkymä</text>
    <text x="40" y="118">API-pyyntö</text>
    <text x="40" y="144">agentin kirjoittama koodi</text>
  </g>
  <text x="40" y="200" fill="#545459" style="font-size:12px; font-family: ui-monospace, Menlo, monospace">discount: number</text>
  <!-- gate -->
  <line x1="300" y1="130" x2="330" y2="130" stroke="#50375F" stroke-width="2"/>
  <polygon points="330,124 340,130 330,136" fill="#50375F"/>
  <rect x="340" y="92" width="170" height="76" rx="10" fill="#fff" stroke="#50375F" stroke-width="2"/>
  <text x="425" y="124" text-anchor="middle" fill="#50375F" font-weight="700" style="font-size:14px; font-family: ui-monospace, Menlo, monospace">percent()</text>
  <text x="425" y="148" text-anchor="middle" fill="#545459" style="font-size:13px">0 ≤ arvo ≤ 100 ?</text>
  <line x1="425" y1="168" x2="425" y2="204" stroke="#C4502A" stroke-width="2"/>
  <polygon points="419,204 425,214 431,204" fill="#C4502A"/>
  <text x="425" y="234" text-anchor="middle" fill="#C4502A" style="font-size:13px">✗ null: hylätään rajalla</text>
  <!-- trust boundary -->
  <line x1="542" y1="22" x2="542" y2="248" stroke="#866A9D" stroke-width="1.5" stroke-dasharray="6 5"/>
  <text x="542" y="14" text-anchor="middle" fill="#866A9D" font-weight="700" style="font-size:12.5px">luottamusraja</text>
  <line x1="510" y1="130" x2="565" y2="130" stroke="#00847F" stroke-width="2.5"/>
  <polygon points="565,123 576,130 565,137" fill="#00847F"/>
  <text x="522" y="120" fill="#00847F" font-weight="700" style="font-size:14px">✓</text>
  <!-- inside -->
  <rect x="576" y="30" width="280" height="200" rx="12" fill="#41B4AF" fill-opacity="0.08" stroke="#41B4AF"/>
  <text x="596" y="58" fill="#00847F" font-weight="700" style="font-size:15px">Järjestelmän sisällä</text>
  <g fill="#192D2D" style="font-size:12.5px; font-family: ui-monospace, Menlo, monospace">
    <text x="596" y="92">applyDiscount(price, d: Percent)</text>
    <text x="596" y="118">formatDiscount(d: Percent)</text>
    <text x="596" y="144">saveCampaign(c: Campaign)</text>
  </g>
  <text x="596" y="186" fill="#545459" font-style="italic" style="font-size:13px">Kukaan ei tarkista uudelleen:</text>
  <text x="596" y="206" fill="#00847F" font-weight="700" style="font-size:13px">tyyppi on todiste</text>
</svg>

<div class="callout teal" style="margin-top: 12px">
Tarkistus tehdään <strong>kerran rajalla</strong>. Tyyppi kantaa todisteen eteenpäin.
</div>

<p class="tiny" style="margin-top: 6px">Ajatus tunnetaan nimellä ”Parse, don't validate” (Alexis King, 2019).</p>

<!--
[7:10–7:55]

Tämä on monelle tuttua, mutta mitä tyypit oikeastaan tekevät? **Tyyppi voi kantaa todisteen.**

1. Raaka luku tulee ulkomaailmasta, esimerkiksi API:sta tai agentin kirjoittamasta koodista.
2. **percent()** tarkistaa kerran rajalla, onko luku nollan ja sadan välissä.
3. Vain ehdot täyttävä arvo pääsee läpi ja muuttuu **Percent**-arvoksi.

Sen jälkeen **tyyppi on todiste siitä, että validointi on tehty**, eikä kenenkään tarvitse tarkistaa sitä uudelleen. Agentti ei ohita rajaa vahingossa.

*Miltä tämä näyttää koodissa?*
-->

---

# Tyypit

<p class="h1-sub"><span class="step">1 / 3</span> · Sopimus koodin sisällä</p>

<div class="cols code-md" style="grid-template-columns: 1.3fr 1fr; gap: 22px; margin-top: 6px">
<div>

```ts {1-2|4-8|10-13|14-15|all}{at:1}
type Money   = number & { __brand: 'Money' };
type Percent = number & { __brand: 'Percent' };

function percent(value: number): Percent | null {
  return value >= 0 && value <= 100
    ? (value as Percent)
    : null;
}

declare function applyDiscount(
  price: Money,
  discount: Percent,
): Money;
applyDiscount(price, 20);
// ✗ 'number' is not assignable to 'Percent'
```

<p class="src">Yksinkertaistettu esimerkki</p>

</div>
<div>

<h2>Miksi agentille?</h2>

<ul>
<li><strong>Domain-tyypit ohjaavat toteutusta.</strong> <code>Money</code> ja <code>Percent</code> kertovat, mitä luku tarkoittaa.</li>
<li v-click="1"><strong>Yksi tie sisään.</strong> <code>Percent</code>-arvon saa vain konstruktorista, joka tarkistaa rajat.</li>
<li v-click="2"><strong>Testit voi kirjoittaa etukäteen.</strong> Ne nojaavat sopimukseen, eivät koodiin.</li>
<li v-click="3"><strong>Väärää ei kirjoiteta vahingossa.</strong> Kääntäjä kertoo heti, missä validointi puuttuu.</li>
</ul>

<p class="tiny" v-click="4">Ohitus (<code>as</code>, <code>any</code>) vaatii tahallisen teon, ja sen voi kieltää lint-säännöllä. Tyyppi ei todista, että validointi on oikein.</p>

</div>
</div>

<div class="callout teal" style="margin-top: 14px" v-click="4">
Älä pyydä agenttia muistamaan. <strong>Tee unohtamisesta virhe.</strong>
</div>

<!--
[7:55–9:10]

Sama TypeScriptinä. Koodi etenee osa kerrallaan.

1. **Domain-tyypit**: Money ja Percent ovat brändättyjä lukuja. Ajon aikana ne ovat pelkkiä lukuja, mutta kääntäjä erottaa ne.

[click] 2. **Konstruktori** on ainoa tapa luoda Percent-arvo. Jos luku on väärä, ulos tulee null. Yksi tie sisään.

[click] 3. **Sopimus**: applyDiscount ottaa validoidun hinnan ja validoidun prosentin ja palauttaa rahaa. Tätä vasten voi kirjoittaa loput testit ennen toteutusta.

[click] 4. **Virhe**: jos agentti unohtaa validoinnin, kääntäjä kertoo siitä.

[click] **Älä pyydä agenttia muistamaan. Tee unohtamisesta virhe.**

*Entä ominaisuustestit?*
-->

---

# Ominaisuustestit

<p class="h1-sub"><span class="step">2 / 3</span> · Esimerkki vai laki?</p>

<table class="laws-table">
<thead>
<tr><th>Yksi tapaus: tavallinen testi</th><th>Kaikki tapaukset: ominaisuustesti</th></tr>
</thead>
<tbody>
<tr><td><code>2 + 3 = 3 + 2</code></td><td><code>a + b = b + a</code> kaikilla luvuilla <code>a</code>, <code>b</code></td></tr>
<tr v-click="1"><td><code>sort(sort([3, 1, 2])) = sort([3, 1, 2])</code></td><td><code>sort(sort(xs)) = sort(xs)</code> kaikilla listoilla <code>xs</code></td></tr>
<tr class="domain" v-click="2"><td>0 %:n alennus hinnasta 100 € → 100 €</td><td>Nollan prosentin alennus <strong>ei koskaan</strong> muuta hintaa</td></tr>
</tbody>
</table>

<p class="edge-note" v-click="3"><strong>Reunatapaukset.</strong> Ominaisuustestit löytävät usein reunatapauksia, jotka eivät käy agentin tai ohjelmistokehittäjän mielessä.</p>

<div class="callout teal" style="margin-top: 14px" v-click="4">
Esimerkki näyttää <strong>yhden tapauksen</strong>. Laki sanoo, mikä pätee <strong>kaikille</strong>.
</div>

<style>
.laws-table { margin-top: 18px; font-size: 16px; }
.laws-table th { font-size: 14px; }
.laws-table th:nth-child(2) { color: var(--l-teal-deep); border-bottom-color: var(--l-teal); }
.laws-table td { padding: 10px 8px; width: 50%; }
.laws-table td:first-child { color: var(--l-gray-700); }
.laws-table tr.slidev-vclick-hidden td { border-color: transparent !important; }
.slidev-layout .edge-note { margin: 14px 0 0; padding: 8px 14px; border-left: 4px solid var(--l-teal); background: rgba(65, 180, 175, 0.08); border-radius: 0 6px 6px 0; font-size: 15px; }
.laws-table tbody tr:nth-child(3) td { border-top: 2px solid var(--l-gray-300); }
</style>

<!--
[9:10–10:30]

**Kuinka monelle ominaisuustestit eli property testit on ennestään tuttuja?**

Lähdetään liikkeelle matematiikasta.

Tavallinen testi tarkistaa yhden tapauksen: 2 + 3 = 3 + 2. Ominaisuustesti sanoo saman kaikille luvuille. Tämän lain nimi on **vaihdannaisuus eli kommutatiivisuus**: järjestyksellä ei ole väliä. *Onko muita tällaisia lakeja?*

[click] Lajittelu kahdesti on sama kuin kerran. Tämä on **idempotenssi**: operaation toistaminen ei muuta tulosta. *Entä meidän kassamme?*

[click] Kassallakin on lakeja: nollan prosentin alennus ei koskaan muuta hintaa. Tämä on **neutraalialkio**, sama ajatus kuin a + 0 = a. *Miksi kirjoittaa laki, kun esimerkkikin riittäisi?*

[click] Koska ominaisuustesti kokeilee lakia **satunnaisesti generoiduilla arvoilla**. Siksi se löytää helpommin **reunatapauksia, joita kukaan ei tule kirjoittaneeksi testiin**. Juuri niissä bugit asuvat.

[click] Esimerkki näyttää yhden tapauksen, laki pätee kaikille. *Katsotaan tuota nollan prosentin lakia koodina.*
-->

---

# Ominaisuustestit

<p class="h1-sub"><span class="step">2 / 3</span> · Laki koodina</p>

<div class="cols code-md" style="grid-template-columns: 1.3fr 1fr; gap: 22px; margin-top: 6px">
<div>

```ts
test('0 % discount never changes the price', () => {
  fc.assert(fc.property(anyMoney, (price) =>
    applyDiscount(price, percent(0)!) === price,
  ));
});
```

<div v-click="1">

<p class="impl-label">Virheellinen toteutus</p>

```ts
const DEFAULT_PERCENT = percent(10)!;

function applyDiscount(price: Money, d: Percent) {
  const p = d || DEFAULT_PERCENT; // ✗ 0 on epätosi
  return money(Math.floor(price * (100 - p) / 100));
}
```

</div>

<p class="src">Yksinkertaistettu esimerkki · fast-check</p>

</div>
<div v-click="2">

<span class="label-illustrative">Havainnollistus – ei oikean ajon tuloste</span>

<div class="terminal" style="margin-top: 10px; font-size: 12.5px">
<div><span class="prompt">✗</span> 0 % discount never changes the price</div>
<div>&nbsp;&nbsp;Property failed after 12 tests</div>
<div>&nbsp;&nbsp;Shrunk 4 time(s)</div>
<div>&nbsp;&nbsp;Counterexample:</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;price = 1</div>
<div>&nbsp;&nbsp;Expected 1, got 0</div>
</div>

<p class="tiny" style="margin-top: 10px">Otos, ei todistus: tuhat läpäistyä tapausta ei takaa, ettei vastaesimerkkiä ole.</p>

</div>
</div>

<div class="callout teal" style="margin-top: 14px" v-click="2">
Vastaesimerkki on agentille <strong>tarkkaa palautetta</strong>: mikä laki, millä syötteellä, mikä tulos.
</div>

<style>
.slidev-layout .impl-label { font-size: 12px; font-weight: 700; text-transform: uppercase; letter-spacing: 0.06em; color: #C4502A; margin: 12px 0 2px; }
</style>

<!--
[10:30–11:40]

Testin nimi on laki: **kaikilla hinnoilla nollan prosentin alennus palauttaa saman hinnan**. *Miltä näyttää toteutus, joka rikkoo tämän?*

[click] Tämä näyttää järkevältä. **Huomaatteko bugin?** (tauko) Nolla on JavaScriptissä epätosi, joten nolla prosenttia vaihtuu kymmenen prosentin oletusalennukseksi.

[click] **Tämä on keksitty tuloste.** Testi löysi bugin: yhden sentin hinnasta tuli nolla. Juuri tällaista palautetta agentti saa: **mikä laki, millä syötteellä, mikä tulos**. *Riittääkö yksi laki? Ei, ja siksi tarvitaan vielä hyväksymistestit.*
-->

---

# Hyväksymistestit

<p class="h1-sub"><span class="step">3 / 3</span> · Hyväksymiskriteerit kirjoitetaan jo nyt</p>

<div class="ticket">
<div class="ticket-head"><span class="ticket-key">SHOP-42</span><span class="ticket-type">Story</span><span class="ticket-status">Työn alla</span></div>
<div class="ticket-title">Kampanjakoodi kassalla</div>
<p class="ticket-story">Asiakkaana haluan syöttää kampanjakoodin kassalla, jotta saan mainostetun alennuksen.</p>
<div class="ticket-section">Hyväksymiskriteerit</div>
<ol class="ticket-ac">
<li>Voimassa oleva koodi alentaa maksettavaa summaa koodin prosentin verran.</li>
<li>Vanhentunut koodi hylätään, eikä summa muutu.</li>
</ol>
</div>

<div class="callout teal" style="margin-top: 20px">
Kriteerit ovat jo olemassa. Hyväksymistesti tekee niistä <strong>ajettavia</strong>.
</div>

<style>
.ticket { margin-top: 16px; max-width: 700px; border: 1px solid var(--l-gray-300); border-radius: 10px; padding: 16px 20px; background: #fff; box-shadow: 0 4px 18px rgba(80, 55, 95, 0.07); }
.ticket-head { display: flex; gap: 10px; align-items: center; font-size: 12px; }
.ticket-key { font-family: ui-monospace, Menlo, monospace; color: var(--l-gray-700); }
.ticket-type { background: var(--l-purple-50); color: var(--l-purple-dark); border-radius: 4px; padding: 1px 7px; font-weight: 700; }
.ticket-status { background: var(--l-gray-100); color: var(--l-gray-700); border-radius: 4px; padding: 1px 7px; font-weight: 700; text-transform: uppercase; letter-spacing: 0.04em; font-size: 11px; }
.ticket-title { font-size: 22px; font-weight: 700; color: var(--l-ink); margin: 8px 0 4px; }
.ticket-story { font-size: 15px; color: var(--l-gray-700); margin: 4px 0 12px !important; }
.ticket-section { font-size: 12px; font-weight: 700; text-transform: uppercase; letter-spacing: 0.06em; color: var(--l-purple-dark); }
.slidev-layout .ticket-ac { list-style: decimal; margin: 6px 0 0; padding-left: 1.4em; font-size: 16px; }
</style>

<!--
[11:40–12:20]

Hyväksymistestit kuulostavat raskailta, mutta hyvässä ohjelmistokulttuurissa **ne ovat jo olemassa: tiketin hyväksymiskriteereinä**.

Tässä keksitty esimerkkitiketti: user story kampanjakoodista asiakkaan näkökulmasta ja kaksi kriteeriä:
1. Voimassa oleva koodi alentaa summaa.
2. Vanhentunut koodi hylätään.

Ongelma: **tiketti ei testaa itseään**. Agentti lukee sen, tulkitsee sen ja sanoo olevansa valmis, eikä kukaan tarkista, vastaako tulkinta kriteerejä.

*Miltä nämä kriteerit näyttävät ajettavina?*
-->

---

# Hyväksymistestit

<p class="h1-sub"><span class="step">3 / 3</span> · Täyttyykö tarve</p>

<div class="cols code-md" style="grid-template-columns: 1.25fr 1fr; gap: 22px; margin-top: 6px">
<div>

```gherkin
Scenario: A valid code lowers the price
  Given the cart total is 100.00
  When the customer enters the code "AUTUMN20"
  Then the amount to pay is 80.00

Scenario: An expired code is rejected
  Given the cart total is 100.00
  And the code "SUMMER10" has expired
  When the customer enters the code "SUMMER10"
  Then the code is rejected
  And the amount to pay is 100.00
```

<p class="src">Yksinkertaistettu esimerkki · Gherkin (BDD)</p>

</div>
<div>

<h2>Miksi agentille?</h2>

<ul>
<li><strong>Tarpeen kielellä.</strong> Tuoteomistaja voi hyväksyä skenaarion ennen koodia.</li>
<li><strong>Agentti ei kirjoita omaa tavoitettaan.</strong> Se pienentää riskiä, että sama väärinkäsitys päätyy koodiin ja testiin.</li>
<li><strong>Esimerkki, ei laki.</strong> Skenaario tarkistaa vain nämä luvut.</li>
</ul>

</div>
</div>

<div class="callout teal" style="margin-top: 14px">
Hyväksymistesti kertoo, milloin työ on valmis <strong>sen mielestä, joka sitä tarvitsi</strong>.
</div>

<!--
[12:20–13:15]

Tiketin kaksi kriteeriä **ajettavina testeinä**. Tässä on käytetty Gherkiniä, jolla kriteerit kirjoitetaan tarpeen kielellä. Tämä on BDD:n ydin: **käytös sovitaan esimerkkeinä tarpeen omistajan kanssa ennen toteutusta**, ja esimerkeistä tulee ajettavia testejä.

1. **Tuoteomistaja voi tarkistaa** skenaariot ennen kuin koodia on.
2. **Agentti voi ajaa ne** ja tarkistaa itse, onko tavoitteeseen päästy. Se ei kirjoita omaa tavoitettaan, mikä pienentää riskiä mutta ei poista sitä: hyväksytty skenaariokin voi olla väärä.
3. **Skenaario on esimerkki, ei laki**: se tarkistaa vain nämä luvut. Siksi esimerkit ja lait täydentävät toisiaan.

Hyväksymistesti kertoo, milloin työ on valmis **sen mielestä, joka työn tilasi**.

*Mitä nämä kolme yhdessä sulkevat pois?*
-->

---

# Mikä jää leikkauksen ulkopuolelle?

<div class="cols-wide-left" style="align-items: center">
<div>
<svg class="diagram" viewBox="0 0 540 360" role="img" aria-label="Sama kolmen joukon kuva. Kolme väärää ohjelmaa esimerkeistä: raaka luku ei käänny ja jää kaikkien joukkojen ulkopuolelle. Nollan prosentin alennusta väärin käsittelevä toteutus kääntyy ja läpäisee skenaariot mutta rikkoo lain. Toteutus, joka ei alenna lainkaan, kääntyy ja täyttää lait mutta ei skenaariota. Vain leikkaus hyväksytään.">
  <rect x="6" y="6" width="528" height="348" rx="14" fill="#F6F5F7" stroke="#C8C8CC"/>
  <text x="22" y="30" style="font-size:13px" fill="#545459" font-weight="700">Kaikki ohjelmat</text>
  <circle cx="200" cy="145" r="100" fill="#B496CD" fill-opacity="0.28" stroke="#866A9D" stroke-width="2"/>
  <circle cx="340" cy="145" r="100" fill="#41B4AF" fill-opacity="0.24" stroke="#00847F" stroke-width="2"/>
  <circle cx="270" cy="245" r="100" fill="#F67B50" fill-opacity="0.18" stroke="#C4502A" stroke-width="2"/>
  <g font-weight="700" style="font-size:13px">
    <text x="118" y="104" fill="#50375F">Tyypit</text>
    <text x="352" y="104" fill="#00847F">Ominaisuudet</text>
    <text x="270" y="316" text-anchor="middle" fill="#C4502A">Hyväksymiskriteerit</text>
  </g>
  <circle cx="270" cy="182" r="8" fill="#192D2D"/>
  <line x1="277" y1="188" x2="392" y2="280" stroke="#192D2D" stroke-width="1.2"/>
  <text x="396" y="292" fill="#192D2D" font-weight="700" style="font-size:12.5px">hyväksytään</text>
  <text x="396" y="308" fill="#545459" style="font-size:11.5px">agentin vapaus</text>
  <g v-click="1">
    <circle cx="60" cy="70" r="14" fill="#fff" stroke="#50375F" stroke-width="2.5"/>
    <text x="60" y="75" text-anchor="middle" fill="#50375F" font-weight="700" style="font-size:14px">1</text>
  </g>
  <g v-click="2">
    <circle cx="215" cy="228" r="14" fill="#fff" stroke="#00847F" stroke-width="2.5"/>
    <text x="215" y="233" text-anchor="middle" fill="#00847F" font-weight="700" style="font-size:14px">2</text>
  </g>
  <g v-click="3">
    <circle cx="270" cy="112" r="14" fill="#fff" stroke="#C4502A" stroke-width="2.5"/>
    <text x="270" y="117" text-anchor="middle" fill="#C4502A" font-weight="700" style="font-size:14px">3</text>
  </g>
</svg>
</div>
<div>

<div class="miss" v-click="1"><b class="n1">1</b><div><strong>Ei käänny.</strong> Väärä arvo, kuten 120&nbsp;%:n alennus.</div></div>
<div class="miss" v-click="2"><b class="n2">2</b><div><strong>Laki kaatuu.</strong> 0&nbsp;%:n alennus muuttaa hintaa.</div></div>
<div class="miss" v-click="3"><b class="n3">3</b><div><strong>Skenaario kaatuu.</strong> Alennusta ei tule lainkaan.</div></div>

</div>
</div>

<div class="callout teal" style="margin-top: 12px">
Yksikään tarkistus ei riitä yksin. Hyväksytään vain <strong>leikkaus</strong>.
</div>

<style>
.miss { display: grid; grid-template-columns: 28px 1fr; gap: 10px; align-items: start; margin: 0 0 16px; font-size: 15px; line-height: 1.4; }
.miss > b { display: inline-flex; width: 26px; height: 26px; border-radius: 50%; align-items: center; justify-content: center; font-size: 14px; border: 2.5px solid; background: #fff; }
.miss .n1 { color: #50375F; border-color: #50375F; }
.miss .n2 { color: #00847F; border-color: #00847F; }
.miss .n3 { color: #C4502A; border-color: #C4502A; }
.miss code { white-space: nowrap; }
</style>

<!--
[13:15–14:15]

**Sama kuva kuin aiemmin, nyt vähän konkreettisemmin.** Jokainen tarkistus sulkee pois erilaisen väärän ohjelman.

[click] 1. **Väärä arvo**, kuten 120 prosentin alennus, ei edes käänny. Tyypit hoitavat sen ennen yhtäkään testiä.

[click] 2. Ohjelma, joka kääntyy ja läpäisee skenaariot, mutta **jossa nollan prosentin alennus muuttaa hintaa**, rikkoo lain. Sen löytää vain ominaisuustesti. Tämä on edellisten diojen bugi.

[click] 3. Ohjelma, joka täyttää lait, mutta **ei alenna hintaa lainkaan**, ei täytä tarvetta. Sen löytää vain hyväksymistesti.

**Yksikään tarkistus ei riitä yksin.** Hyväksytään vain leikkaus, ja sen sisällä agentti saa valita vapaasti.

*Miksi tyypit kannattaa määritellä ensin?*
-->

---

# Vakaa rajapinta ensin

<svg class="diagram" viewBox="0 0 876 305" style="margin-top: 10px" role="img" aria-label="Keskellä tyypit eli sopimus, joka päätetään ensin. Vasemmalla ominaisuus- ja hyväksymistestit, jotka kirjoitetaan sopimusta vastaan ennen toteutusta. Oikealla toteutus, jonka agentti kirjoittaa ja saa muuttaa. Alla työjärjestys: tyypit, testit, agentti toteuttaa.">
  <!-- phase labels -->
  <path d="M20 34 V24 H540 V34" fill="none" stroke="#50375F" stroke-width="1.5"/>
  <text x="280" y="16" text-anchor="middle" fill="#50375F" font-weight="700" style="font-size:13px">Ennen delegointia</text>
  <path d="M640 34 V24 H850 V34" fill="none" stroke="#866A9D" stroke-width="1.5"/>
  <text x="745" y="16" text-anchor="middle" fill="#866A9D" font-weight="700" style="font-size:13px">Delegoinnin jälkeen</text>
  <!-- tests -->
  <g fill="#fff" stroke="#41B4AF" stroke-width="2">
    <rect x="20" y="62" width="230" height="70" rx="10"/>
    <rect x="20" y="172" width="230" height="70" rx="10"/>
  </g>
  <g fill="#00847F"><circle cx="42" cy="84" r="11"/><circle cx="42" cy="194" r="11"/></g>
  <g fill="#fff" font-weight="700" text-anchor="middle" style="font-size:12.5px"><text x="42" y="88.5">2</text><text x="42" y="198.5">2</text></g>
  <g fill="#00847F" font-weight="700" style="font-size:15px">
    <text x="62" y="89">Ominaisuustestit</text>
    <text x="62" y="199">Hyväksymistestit</text>
  </g>
  <g fill="#545459" style="font-size:12.5px">
    <text x="62" y="114">mikä pätee aina</text>
    <text x="62" y="224">täyttyykö tarve</text>
  </g>
  <g stroke="#00847F" stroke-width="2">
    <line x1="252" y1="97" x2="320" y2="118"/>
    <line x1="252" y1="207" x2="320" y2="186"/>
  </g>
  <g fill="#00847F">
    <polygon points="319,112 331,121 317,124"/>
    <polygon points="317,180 331,183 319,192"/>
  </g>
  <text x="290" y="156" text-anchor="middle" fill="#00847F" style="font-size:11.5px">vastaan</text>
  <!-- contract -->
  <rect x="332" y="50" width="208" height="204" rx="12" fill="#50375F"/>
  <circle cx="354" cy="72" r="11" fill="#fff"/>
  <text x="354" y="76.5" text-anchor="middle" fill="#50375F" font-weight="700" style="font-size:12.5px">1</text>
  <text x="436" y="96" text-anchor="middle" fill="#fff" font-weight="700" style="font-size:20px">Tyypit</text>
  <text x="436" y="118" text-anchor="middle" fill="#DACAE6" style="font-size:13px">sopimus</text>
  <g fill="#DACAE6" text-anchor="middle" style="font-size:12.5px; font-family: ui-monospace, Menlo, monospace">
    <text x="436" y="150">Money, Percent</text>
    <text x="436" y="174">applyDiscount(</text>
    <text x="436" y="192">price, discount)</text>
  </g>
  <text x="436" y="230" text-anchor="middle" fill="#B496CD" font-style="italic" style="font-size:11.5px">ei agentin kirjoitettavissa</text>
  <!-- implementations -->
  <rect x="670" y="64" width="180" height="150" rx="10" fill="#fff" stroke="#C8C8CC" stroke-dasharray="5 4"/>
  <rect x="655" y="82" width="180" height="150" rx="10" fill="#fff" stroke="#B496CD" stroke-dasharray="5 4"/>
  <rect x="640" y="100" width="180" height="150" rx="10" fill="#F6F5F7" stroke="#866A9D" stroke-width="2"/>
  <circle cx="662" cy="122" r="11" fill="#866A9D"/>
  <text x="662" y="126.5" text-anchor="middle" fill="#fff" font-weight="700" style="font-size:12.5px">3</text>
  <text x="730" y="166" text-anchor="middle" fill="#192D2D" font-weight="700" style="font-size:15px">Toteutus</text>
  <text x="730" y="188" text-anchor="middle" fill="#545459" style="font-size:12px">agentti kirjoittaa</text>
  <text x="730" y="205" text-anchor="middle" fill="#545459" style="font-size:12px">ja saa muuttaa</text>
  <line x1="638" y1="175" x2="552" y2="160" stroke="#866A9D" stroke-width="2"/>
  <polygon points="552,154 542,159 552,166" fill="#866A9D"/>
  <text x="596" y="152" text-anchor="middle" fill="#866A9D" style="font-size:12px">toteuttaa</text>
  <!-- order of work -->
  <text x="438" y="292" text-anchor="middle" fill="#192D2D" style="font-size:14px"><tspan fill="#50375F" font-weight="700">1</tspan> Tyypit ensin   →   <tspan fill="#00847F" font-weight="700">2</tspan> Testit sopimusta vastaan   →   <tspan fill="#866A9D" font-weight="700">3</tspan> Agentti toteuttaa</text>
</svg>

<div class="callout teal" style="margin-top: 10px">
Tyypit antavat testeille <strong>vakaan rajapinnan</strong>, joten testit voi kirjoittaa ennen kuin toteutusta on olemassa.
</div>

<!--
[14:15–15:00]

Tyypit määrittelevät **rajapinnan, jota vasten ominaisuus- ja hyväksymistestit kirjoitetaan**. Siksi järjestys on:
1. **Tyypit ensin**: mitä arvoja on olemassa ja mitä funktioita voi kutsua.
2. **Testit sopimusta vasten**, ennen kuin toteutusta on olemassa.
3. **Vasta sitten agentti toteuttaa.** Se saa muuttaa toteutusta niin monta kertaa kuin tarvitsee, koskematta kriteereihin tai rajapintaan.

Jos tarkistus kirjoitettaisiin suoraan toteutusta vasten, **se rikkoutuisi heti, kun agentti muuttaa toteutusta**.

*Mistä nämä tarkistukset sitten käytännössä tulevat?*
-->

---

# Mistä tarkistukset tulevat?

<p class="h1-sub">Kuka kirjoittaa, ja mistä?</p>

<p class="muted" style="margin-top: -6px">Ylhäältä alas: epämääräisestä tarpeesta yksityiskohtiin.</p>

<div class="cols-3" style="margin-top: 18px; align-items: stretch">
<div class="card accent">

<h3>Hyväksymiskriteerit</h3>

<p class="src-line">Lähde: tiketti ja vaatimusmäärittely</p>

- Tuoteomistaja ja tiimi sopivat
- Mitä tarpeen omistaja odottaa näkevänsä
- Kirjoitetaan jo nyt, kuten dialla 12

</div>
<div class="card teal">

<h3>Ominaisuudet</h3>

<p class="src-line">Lähde: insinöörin päättely</p>

- Abstrakteja, teknisiä lakeja: invariantit, idempotenssi, monotonisuus
- Lait, joita kukaan ei kirjoittanut tikettiin, mutta joihin kaikki luottavat

</div>
<div class="card accent">

<h3>Tyypit</h3>

<p class="src-line">Lähde: ohjelmoija</p>

- **Turvallisuus rakenteella:** mahdottomat tilat mahdottomiksi esittää
- **Vakaa rajapinta**, jota vastaan testit kirjoitetaan

</div>
</div>

<div class="callout" style="margin-top: 22px">
Kaikki kolme päätetään <strong>ennen</strong> kuin agentti aloittaa toteutuksen.
</div>

<style>
.slidev-layout .src-line { font-size: 13px; color: var(--l-gray-700); margin: 2px 0 6px; font-style: italic; }
</style>

<!--
[15:00–16:10]

Ylhäältä alas, epämääräisestä tarpeesta yksityiskohtiin:
1. **Hyväksymiskriteerit** määrittelee tuoteomistaja yhdessä stakeholdereiden kanssa: mitä tarpeen omistaja odottaa näkevänsä. Ne kirjoitetaan tiketteihin jo tänä päivänä.
2. **Ominaisuudet** ovat abstraktimpia ja teknisempiä: **ääneen lausumattomia lakeja**, joita stakeholderit eivät välttämättä tule ajatelleeksi, mutta joihin kaikki luottavat. Ne tulevat insinöörin päättelystä.
3. **Tyypit** päättää ohjelmoija. Ajattelutapa on **turvallisuus rakenteella**: mahdottomat tilat tehdään mahdottomiksi esittää, ja testeille syntyy vakaa rajapinta.

**Kaikki kolme päätetään ennen kuin agentti aloittaa toteutuksen.**

*Katsotaan jokaista tarkemmin, alkaen hyväksymiskriteereistä.*
-->

---

# Mistä tarkistukset tulevat?

<p class="h1-sub"><span class="step">Hyväksymiskriteerit</span> · Tiketistä ja vaatimusmäärittelystä</p>

<div class="exmap">
<div class="exmap-vague">
<div class="exmap-label">Vaatimus</div>
<div class="exmap-card vague">”Kampanjakoodit toimivat kassalla.”</div>
</div>
<div class="exmap-arrow">→</div>
<div class="exmap-rules">
<div class="exmap-col">
<div class="exmap-label">Sääntö</div>
<div class="exmap-card rule">Voimassa oleva koodi alentaa summaa koodin prosentin verran</div>
<div class="exmap-card example">100 € + AUTUMN20 → 80 €</div>
<div class="exmap-card example">0,97 € + AUTUMN20 → 0,77 € vai 0,78 €?</div>
</div>
<div class="exmap-col">
<div class="exmap-label">Sääntö</div>
<div class="exmap-card rule">Vanhentunut koodi hylätään, eikä summa muutu</div>
<div class="exmap-card example">100 € + SUMMER10 (vanhentunut) → hylätään, 100 €</div>
</div>
<div class="exmap-col">
<div class="exmap-label">Avoin kysymys</div>
<div class="exmap-card question">Pyöristetäänkö alas vai lähimpään senttiin?</div>
<div class="exmap-card question">Voiko kahta koodia käyttää yhtä aikaa?</div>
</div>
</div>
</div>

<p class="tiny" style="margin-top: 8px">Tekniikka: Example Mapping (Matt Wynne). Sääntö, konkreettiset esimerkit ja avoimet kysymykset.</p>

<div class="callout teal" style="margin-top: 10px">
Konkreettiset esimerkit paljastavat kysymykset <strong>ennen</strong> kuin agentti joutuu arvaamaan.
</div>

<style>
.exmap { display: grid; grid-template-columns: 190px 28px 1fr; align-items: start; gap: 8px; margin-top: 12px; }
.exmap-arrow { font-size: 28px; color: var(--l-gray-500); margin-top: 34px; text-align: center; }
.exmap-rules { display: grid; grid-template-columns: repeat(3, 1fr); gap: 10px; }
.exmap-label { font-size: 11px; font-weight: 700; text-transform: uppercase; letter-spacing: 0.06em; color: var(--l-gray-700); margin-bottom: 6px; }
.exmap-card { border-radius: 6px; padding: 8px 10px; font-size: 13.5px; line-height: 1.35; margin-bottom: 8px; }
.exmap-card.vague { background: var(--l-gray-100); color: var(--l-gray-700); font-style: italic; font-size: 15px; }
.exmap-card.rule { background: var(--l-purple-dark); color: #fff; font-weight: 700; }
.exmap-card.example { background: rgba(65, 180, 175, 0.16); color: var(--l-ink); border-left: 3px solid var(--l-teal); }
.exmap-card.question { background: rgba(246, 123, 80, 0.14); color: var(--l-ink); border-left: 3px solid var(--l-red); }
</style>

<!--
[16:10–16:45]

Hyväksymiskriteerit tulevat tiketistä ja vaatimusmäärittelystä, mutta **ne eivät synny itsestään**. Niihin pitää käyttää aikaa.

Tämä on BDD:n keskusteluvaihe, tekniikkana Example Mapping:
1. Epämääräinen vaatimus pilkotaan **säännöiksi**.
2. Jokainen sääntö saa **konkreettiset esimerkit**.
3. Samalla löytyy **avoimia kysymyksiä**: miten pyöristetään? Voiko kahta koodia käyttää yhtä aikaa?

**Nämä ovat ratkaisevia päätöksiä, eikä agentti voi tehdä niitä puolestasi.** Jos niihin ei vastata ennen delegointia, agentti arvaa, eikä kerro arvanneensa.

*Entä ominaisuudet?*
-->

---

# Mistä tarkistukset tulevat?

<p class="h1-sub"><span class="step">Ominaisuudet</span> · Abstraktit lait insinöörin päättelystä</p>

<div class="law-grid">
<div class="law-card"><span class="tag">invariantti</span><p>Alennettu hinta on <strong>aina</strong> nollan ja alkuperäisen välissä.</p><code>0 ≤ apply(p, d) ≤ p</code></div>
<div class="law-card"><span class="tag">invariantti</span><p>Summa on <strong>aina</strong> kokonaisia senttejä.</p><code>total(cart) ∈ ℕ senttiä</code></div>
<div class="law-card focus"><span class="tag">idempotenssi</span><p>Saman koodin syöttäminen uudelleen ei muuta mitään. <em>Tämä on päätös.</em></p><code>use(use(c, k), k) = use(c, k)</code></div>
<div class="law-card"><span class="tag">monotonisuus</span><p>Suurempi alennus ei <strong>koskaan</strong> anna suurempaa hintaa.</p><code>d₁ ≤ d₂ ⇒ apply(p, d₂) ≤ apply(p, d₁)</code></div>
<div class="law-card"><span class="tag">järjestys&shy;riippumattomuus</span><p>Tuotteiden järjestys korissa ei vaikuta summaan.</p><code>total(shuffle(items)) = total(items)</code></div>
<div class="law-card"><span class="tag">edestakaisuus</span><p>Uuden koodin lisääminen ja poistaminen palauttaa korin ennalleen.</p><code>k ∉ c ⇒ remove(use(c, k), k) = c</code></div>
</div>

<div class="callout teal" style="margin-top: 14px">
Kriteeri kertoo, mitä asiakas <strong>näkee</strong>. Ominaisuus kertoo, mitä järjestelmä <strong>ei koskaan riko</strong>.
</div>

<style>
.law-grid { display: grid; grid-template-columns: repeat(3, 1fr); grid-auto-rows: 1fr; gap: 10px; margin-top: 12px; }
.law-card { border: 1px solid var(--l-gray-100); border-top: 3px solid var(--l-teal); border-radius: 8px; padding: 9px 12px; background: #fff; box-shadow: 0 4px 18px rgba(80, 55, 95, 0.06); }
.law-card .tag { display: inline-block; font-size: 10.5px; font-weight: 700; text-transform: uppercase; letter-spacing: 0.05em; color: var(--l-teal-deep); }
.slidev-layout .law-card p { font-size: 14px; line-height: 1.35; margin: 4px 0 6px; }
.slidev-layout .law-card code { font-size: 11.5px; white-space: nowrap; }
.law-card:not(.focus) { opacity: 0.55; }
.law-card.focus { border: 2px solid var(--l-teal); border-top-width: 4px; background: rgba(65, 180, 175, 0.08); }
</style>

<!--
[16:45–17:45]

Tiketissä lukee, mitä asiakas näkee. **Insinööri lisää lait, joihin muut järjestelmän osat luottavat**, vaikka kukaan ei kirjoittanut niitä tikettiin.

Esimerkkinä korostettu **idempotenssi**: saman koodin syöttäminen uudelleen ei muuta mitään.
1. Harva asiakas tulee ajatelleeksi sitä.
2. Teknisesti se on oleellinen: jos frontendissä on **retry-logiikka**, se ei voi tietää, menikö ensimmäinen syöttö jo läpi backendissä.
3. Laki on kuitenkin **päätös, ei luonnonlaki**, joten se kirjoitetaan vasta, kun päätös on tehty.

**Agentti voi ehdottaa lakeja, mutta ihminen päättää**, mitkä niistä järjestelmän pitää täyttää.

*Entä tyypit?*
-->

---

# Mistä tarkistukset tulevat?

<p class="h1-sub"><span class="step">Tyypit</span> · Mahdottomat tilat mahdottomiksi</p>

<div class="cols code-md" style="gap: 22px; margin-top: 6px">
<div>

<h3 style="color: var(--l-red)">✗ Sallii mahdottomat tilat</h3>

```ts {1-6|8-10}{at:1,finally:'all'}
type Campaign = {
  code: string;
  percent: number;
  expired: boolean;
  expiredAt?: Date;
};

// Kääntyy: tyhjä koodi, 120 %, ei päivää
const c: Campaign =
  { code: '', percent: 120, expired: true };
```

</div>
<div>

<h3 style="color: var(--l-teal-deep)">✓ Mahdoton tila ei käänny</h3>

```ts {none|1-5|7-10|all}{at:2}
type Campaign =
  | { status: 'active';
      code: Code; percent: Percent }
  | { status: 'expired';
      code: Code; expiredAt: Date };

declare function applyCode(
  price: Money,
  campaign: Campaign,
): Money;
```

</div>
</div>

<p class="src">Yksinkertaistettu esimerkki · Code ja Percent ovat brändättyjä tyyppejä kuten dialla 9</p>

<div class="callout teal" style="margin-top: 12px" v-click="4">
Mitä ei voi esittää, sitä <strong>agentti ei kirjoita vahingossa</strong>. Rajapinta pysyy, toteutus saa vaihtua.
</div>

<!--
[17:45–19:00]

Lopuksi vielä vähän konkreettisemmin tyypeistä. **Tyypit suunnitellaan niin, että vain järkeviä arvoja voi kirjoittaa.**

1. Tavallinen tyyppi: koodi, alennus, onko kampanja vanhentunut ja milloin. Jokainen kenttä näyttää järkevältä.

[click] 2. Silti tämä kääntyy: **tyhjä koodi, 120 prosentin alennus ja vanhentunut kampanja, josta ei tiedetä, milloin se vanheni.**

[click] 3. Paremmin **union-tyyppinä**: kampanja on joko aktiivinen tai vanhentunut, koodi on validoitu, ja kaikki kolme virhettä ovat käännösvirheitä.

[click] 4. Rajapinta käyttää vain tuttuja tyyppejä. Vanhentuneella kampanjalla ei ole prosenttia, joten sitä ei voi käyttää alennukseen vahingossa.

[click] **Mitä ei voi esittää, sitä agentti ei kirjoita vahingossa.** Rajapinta pysyy, toteutus saa vaihtua.

*Kaikki tähänastinen yhdellä lauseella:*
-->

---
layout: center
class: brand statement
---

<div class="arrow">↗</div>

# Määrittele järjestelmä,<br>älä toteutusta.

<p class="subtitle">Tyypit, ominaisuudet ja hyväksymiskriteerit kertovat, mitä järjestelmä lupaa. <strong>Miten</strong> se tehdään, jää agentille.</p>

<!--
[19:00–19:15]

**Määrittele järjestelmä, älä toteutusta.**

Tyypit, ominaisuudet ja hyväksymiskriteerit kertovat, **mitä järjestelmä lupaa**. **Miten** se tehdään, jää agentille, ja juuri siinä on agentin vapaus.

*Toinen askel: miten agentti eristetään tarkistuksista?*
-->

---

# Eristä agentti tarkistuksesta

<p class="h1-sub"><span class="step">1 / 3</span> · Agentin työtila</p>

<div class="cols" style="margin-top: 8px; gap: 22px; align-items: start; grid-template-columns: 1.05fr 1fr">
<div>

<pre class="tree">
checkout/
├── README.md               <i>vaatimukset</i>
├── package.json            <i>skriptit</i>
├── tsconfig.json           <i>kääntäjä</i>
├── src/
│   ├── contracts.ts        <i>tyypit ja rajapinnat</i>
│   ├── constructors.ts     <i>percent(), money()</i>
│   └── <b>implementation/</b>     <b>✎ kirjoitus</b>
│       └── <b>apply-code.ts</b>
├── test/
│   ├── properties.test.ts  <i>ominaisuustestit</i>
│   └── features/           <i>hyväksymistestit</i>
│       ├── campaign-codes.feature
│       └── steps.ts
└── <b>dist/</b>                   <b>✎ kirjoitus</b>
</pre>

<p class="src">Demorepon rakenne alennusesimerkin nimillä · kaikki muu kuin <b style="color: var(--l-teal-deep)">✎</b>: vain luku</p>

</div>
<div class="code-ws">

```toml
# Nimetty käyttöoikeusprofiili (Codex CLI)
approval_policy = "never"

[permissions.demo.filesystem]
":root" = "read"

[permissions.demo.filesystem.":workspace_roots"]
"." = "read"
"src/implementation" = "write"
"dist" = "write"

[permissions.demo.network]
enabled = false
```

<p class="src">Demorepon profiili, muotoiltu uudelleen</p>

</div>
</div>

<div class="callout teal" style="margin-top: 12px">
Agentti saa muuttaa toteutusta vapaasti, mutta <strong>ei sopimusta</strong>.
</div>

<style>
.slidev-layout .tree { margin: 0; padding: 12px 14px; background: var(--l-gray-50); border-radius: 6px; font-family: ui-monospace, Menlo, Consolas, monospace; font-size: 14px; line-height: 1.45; color: var(--l-gray-700); white-space: pre; }
.code-ws pre, .code-ws pre code { font-size: 13.5px !important; line-height: 20px !important; }
.slidev-layout .tree i { font-style: normal; color: var(--l-gray-500); }
.slidev-layout .tree b { color: var(--l-teal-deep); font-weight: 700; }
</style>

<!--
[19:15–20:15]

Agentti saa **oman kopion** repositoriosta:
1. Se saa **lukea kaikki tiedostot**.
2. Se saa **kirjoittaa vain toteutukseen** ja dist-kansioon. Testejä, tyyppejä tai rajapintoja se ei voi muokata.
3. **Otetaan vaikka verkkoyhteyskin pois**, eikä se voi pyytää lisäoikeuksia.

Agentti ajaa testit itse ja korjaa niiden perusteella. Tämä on dian 2 silmukka, nyt meidän päättämillämme tarkistuksilla.

Oikealla näkyy, miltä tämä näyttää Codex CLI:n profiilissa. Sama onnistuu muillakin koodausagenteilla: tiedosto-oikeuksilla, konteilla tai CI-säännöillä.

**Agentti saa muuttaa toteutusta vapaasti, mutta ei sopimusta.** *Mitä agentille sitten sanotaan?*
-->

---

# Eristä agentti tarkistuksesta

<p class="h1-sub"><span class="step">2 / 3</span> · Ohje agentille</p>

<div class="prompt-card">

<p class="prompt-task"><b>Tehtävä:</b> Toteuta <strong>SHOP-42 ”Kampanjakoodi kassalla”</strong>. Vaatimukset ovat tiedostossa <code>README.md</code> ja sopimukset tiedostossa <code>src/contracts.ts</code>.</p>

<p class="prompt-head">Säännöt</p>

1. Aja ensin käännös ja testit, ja raportoi lähtötilan virheet.
2. Toteuta olemassa olevia sopimuksia vasten. Käytä tarkistusten palautetta korjaamiseen.
3. **Älä heikennä, poista, ohita tai muuta** tarkistuksia, sopimuksia tai vaatimuksia saadaksesi testit läpi.
4. Jos tarkistus on mielestäsi väärä, **pysähdy ja merkitse se ihmisen arvioitavaksi**.
5. Operaattori ajaa tarkistukset **uudelleen itsenäisesti**.
6. Kuvaa jäljellä olevat riskit ja näytön rajat.

</div>

<p class="src">Lyhennetty ja suomennettu demorepon kehotteesta · tehtävärivi mukautettu esimerkkiin</p>

<div class="callout" style="margin-top: 14px">
Ohje kertoo säännöt. <strong>Työtila ja tarkistus</strong> pakottavat ne.
</div>

<style>
.prompt-card { margin-top: 8px; background: var(--l-gray-50); border-left: 4px solid var(--l-purple); border-radius: 8px; padding: 12px 20px 10px 18px; font-size: 16px; }
.slidev-layout .prompt-card .prompt-task { margin: 0 0 8px; }
.slidev-layout .prompt-card .prompt-task b { color: var(--l-purple-dark); }
.slidev-layout .prompt-card .prompt-head { margin: 0; font-size: 12px; font-weight: 700; text-transform: uppercase; letter-spacing: 0.06em; color: var(--l-purple-dark); }
.slidev-layout .prompt-card ol { margin: 2px 0 0; padding-left: 1.6em; }
.slidev-layout .prompt-card li { margin: 3px 0; }
</style>

<!--
[20:15–21:15]

Kehote lyhennettynä ja suomennettuna. Ensin itse tehtävä: **toteuta tiketti SHOP-42**. Sen jälkeen säännöt.

**Kerromme agentille säännöt, jotka tarkistusjärjestelmä joka tapauksessa pakottaa.** Silloin agentti ei tuhlaa aikaa niiden kiertämiseen, vaan keskittyy toteutukseen. Kolme kohtaa on tärkeimpiä:
1. **Älä heikennä tarkistuksia** saadaksesi ne läpi. Testit ovat joka tapauksessa lukittuja.
2. **Jos tarkistus on mielestäsi väärä, pysähdy ja merkitse se.** Tätä järjestelmä ei voi pakottaa: agentti voi olla oikeassa, vaatimus voi olla väärin, mutta sen ratkaisee ihminen, ei agentti hiljaa.
3. **Tarkistukset ajetaan uudelleen.** Raportti ei ole hyväksyntä, ja agentti tietää sen etukäteen.

**Ohje kertoo säännöt. Työtila ja tarkistus pakottavat ne.**

*Mitä koko asetelma sitten ratkaisee?*
-->

---

# Eristä agentti tarkistuksesta

<p class="h1-sub"><span class="step">3 / 3</span> · Mitä asetelma ratkaisee</p>

<div class="fix-grid">
<div class="fix-row" v-click="1"><div class="fix-problem"><b>1</b>Sama väärinkäsitys kahdesti</div><div class="fix-arrow">→</div><div class="fix-solution"><strong>Agentti ei kirjoita tarkistuksia</strong><span>Ihminen päättää ne ennen delegointia</span></div></div>
<div class="fix-row" v-click="2"><div class="fix-problem"><b>2</b>Testejä voi muuttaa</div><div class="fix-arrow">→</div><div class="fix-solution"><strong>Testit ovat vain luku -tilassa</strong><span>Käyttöoikeusprofiili lukitsee ne</span></div></div>
<div class="fix-row" v-click="3"><div class="fix-problem"><b>3</b>Agentti erehtyy valmiudestaan</div><div class="fix-arrow">→</div><div class="fix-solution"><strong>Tarkistukset ajetaan uudelleen</strong><span>Puhtaassa kopiossa, kuten CI:ssä. Agentilta tulee mukaan vain toteutus.</span></div></div>
</div>

<p class="src" style="margin-top: 6px">Ongelmat dialta 3</p>

<div class="callout teal" style="margin-top: 14px" v-click="3">
Valmis = agentti lopetti <strong>ja</strong> riippumaton tarkistus meni läpi. Agentin oma ”testit menevät läpi” ei ratkaise.
</div>

<style>
.fix-grid { margin-top: 14px; }
.fix-row { display: grid; grid-template-columns: 1fr 40px 1.25fr; align-items: center; padding: 12px 0; border-bottom: 1px solid var(--l-gray-100); }
.fix-problem { font-size: 18px; color: var(--l-gray-700); display: flex; align-items: center; gap: 12px; }
.fix-problem b { display: inline-flex; width: 28px; height: 28px; border-radius: 50%; align-items: center; justify-content: center; font-size: 14px; border: 2px solid var(--l-gray-500); color: var(--l-gray-700); flex: none; }
.fix-arrow { font-size: 24px; color: var(--l-teal); text-align: center; }
.fix-solution strong { display: block; font-size: 19px; color: var(--l-teal-deep); }
.fix-solution span { display: block; font-size: 14px; color: var(--l-gray-700); margin-top: 2px; }
</style>

<!--
[21:15–22:00]

**Muistatteko dian 3 kolme ongelmaa?** Tässä, miten asetelma ratkaisee ne.

[click] 1. Sama väärinkäsitys kahdesti: **agentti ei kirjoita tarkistuksia**. Ihminen päättää ne ennen delegointia.

[click] 2. Testejä voi muuttaa: testit ovat **vain luku -tilassa**, ja käyttöoikeusprofiili lukitsee ne.

[click] 3. Erehtyy valmiudestaan: **tarkistukset ajetaan uudelleen puhtaassa kopiossa**, kuten CI:ssä. Agentilta tulee mukaan vain toteutus.

**Valmis tarkoittaa kahta asiaa: agentti lopetti, ja riippumaton tarkistus meni läpi.**

*Mihin ihmisen työ sitten siirtyy?*
-->

---

# Missä ihmisen työ on?

<p class="h1-sub">Rakennustelineet ennen rakennusta</p>

<svg class="diagram" viewBox="150 82 726 232" role="img" aria-label="Piirros: kaksi kypäräpäistä ihmistä rakentaa aitausta, jonka laidoissa lukee tyypit, ominaisuudet, hyväksymiskriteerit ja työtila. Ulos pääsee vain riippumattoman tarkistuksen portista. Aitauksen sisällä robotti istuu kannettavan ääressä ja kysyy: saanko jo aloittaa? Toinen ihminen kantaa uutta aitaelementtiä ja sanoo: hetki, vielä yksi laki.">
  <!-- ground -->
  <ellipse cx="500" cy="292" rx="335" ry="18" fill="#ECECEF"/>
  <!-- the pen -->
  <rect x="320" y="112" width="280" height="172" rx="6" fill="#41B4AF" fill-opacity="0.07" stroke="#866A9D" stroke-width="5"/>
  <rect x="320" y="112" width="280" height="172" rx="6" fill="none" stroke="#fff" stroke-width="1.5"/>
  <g fill="#50375F">
    <rect x="313" y="105" width="14" height="14" rx="2"/><rect x="453" y="105" width="14" height="14" rx="2"/><rect x="593" y="105" width="14" height="14" rx="2"/>
    <rect x="313" y="191" width="14" height="14" rx="2"/><rect x="593" y="191" width="14" height="14" rx="2"/>
    <rect x="313" y="277" width="14" height="14" rx="2"/><rect x="453" y="277" width="14" height="14" rx="2"/><rect x="593" y="277" width="14" height="14" rx="2"/>
  </g>
  <!-- signs on the fence -->
  <g fill="#fff" stroke="#866A9D" stroke-width="1.5">
    <rect x="345" y="90" width="90" height="24" rx="4"/>
    <rect x="482" y="90" width="104" height="24" rx="4"/>
    <rect x="385" y="272" width="150" height="24" rx="4"/>
    <rect x="560" y="142" width="80" height="24" rx="4"/>
  </g>
  <g fill="#50375F" font-weight="700" text-anchor="middle" style="font-size:12.5px">
    <text x="390" y="106">Tyypit</text>
    <text x="534" y="106">Ominaisuudet</text>
    <text x="460" y="288">Hyväksymiskriteerit</text>
    <text x="600" y="158">Työtila</text>
  </g>
  <!-- the gate: the only way out goes through independent verification -->
  <rect x="546" y="279" width="40" height="10" rx="2" fill="#00847F"/>
  <text x="566" y="306" text-anchor="middle" fill="#00847F" font-weight="700" style="font-size:11.5px">riippumaton tarkistus</text>
  <!-- the robot -->
  <line x1="460" y1="146" x2="460" y2="160" stroke="#00847F" stroke-width="3"/>
  <circle cx="460" cy="143" r="5" fill="#F67B50"/>
  <rect x="434" y="160" width="52" height="38" rx="9" fill="#41B4AF"/>
  <circle cx="449" cy="177" r="6" fill="#fff"/><circle cx="471" cy="177" r="6" fill="#fff"/>
  <circle cx="451" cy="178" r="2.6" fill="#192D2D"/><circle cx="473" cy="178" r="2.6" fill="#192D2D"/>
  <path d="M449 189 Q460 196 471 189" fill="none" stroke="#192D2D" stroke-width="2.2" stroke-linecap="round"/>
  <rect x="440" y="200" width="40" height="30" rx="6" fill="#00847F"/>
  <rect x="428" y="216" width="64" height="34" rx="4" fill="#192D2D"/>
  <text x="460" y="238" text-anchor="middle" fill="#41B4AF" font-weight="700" style="font-size:13px; font-family: ui-monospace, Menlo, monospace">{ }</text>
  <rect x="420" y="250" width="80" height="6" rx="2" fill="#545459"/>
  <!-- robot speech -->
  <rect x="330" y="124" width="126" height="28" rx="14" fill="#fff" stroke="#192D2D" stroke-width="1.5"/>
  <polygon points="430,151 442,151 446,162" fill="#fff" stroke="#192D2D" stroke-width="1.5" stroke-linejoin="round"/>
  <rect x="429" y="148" width="14" height="4" fill="#fff"/>
  <text x="393" y="142" text-anchor="middle" fill="#192D2D" style="font-size:12px">Saanko jo aloittaa?</text>
  <!-- human 1: hammering a post -->
  <g stroke="#1A1A1D" stroke-width="2.6" stroke-linecap="round" fill="none">
    <circle cx="262" cy="176" r="12" fill="#fff"/>
    <line x1="262" y1="188" x2="262" y2="236"/>
    <line x1="262" y1="236" x2="250" y2="270"/><line x1="262" y1="236" x2="274" y2="270"/>
    <line x1="262" y1="200" x2="248" y2="220"/>
    <line x1="262" y1="200" x2="288" y2="186"/>
    <line x1="288" y1="186" x2="300" y2="203"/>
  </g>
  <path d="M248 174 Q262 152 276 174 Z" fill="#F67B50"/>
  <line x1="244" y1="174" x2="280" y2="174" stroke="#C4502A" stroke-width="3" stroke-linecap="round"/>
  <rect x="293" y="196" width="18" height="10" rx="2" fill="#545459" transform="rotate(-35 302 201)"/>
  <g stroke="#8A8A90" stroke-width="1.6" stroke-linecap="round" fill="none">
    <path d="M300 214 q5 4 0 8"/><path d="M306 212 q6 5 0 11"/>
  </g>
  <!-- human 2: carrying another panel -->
  <rect x="630" y="186" width="40" height="62" rx="3" fill="#F1EAF7" stroke="#866A9D" stroke-width="2"/>
  <text x="650" y="213" text-anchor="middle" fill="#50375F" font-weight="700" style="font-size:11px">uusi</text>
  <text x="650" y="227" text-anchor="middle" fill="#50375F" font-weight="700" style="font-size:11px">laki</text>
  <g stroke="#1A1A1D" stroke-width="2.6" stroke-linecap="round" fill="none">
    <circle cx="700" cy="176" r="12" fill="#fff"/>
    <line x1="700" y1="188" x2="700" y2="236"/>
    <line x1="700" y1="236" x2="688" y2="270"/><line x1="700" y1="236" x2="712" y2="270"/>
    <line x1="700" y1="202" x2="672" y2="206"/>
    <line x1="700" y1="212" x2="672" y2="226"/>
  </g>
  <path d="M686 174 Q700 152 714 174 Z" fill="#F67B50"/>
  <line x1="682" y1="174" x2="718" y2="174" stroke="#C4502A" stroke-width="3" stroke-linecap="round"/>
  <!-- human 2 speech -->
  <rect x="664" y="108" width="190" height="28" rx="14" fill="#fff" stroke="#192D2D" stroke-width="1.5"/>
  <polygon points="694,135 706,135 700,150" fill="#fff" stroke="#192D2D" stroke-width="1.5" stroke-linejoin="round"/>
  <rect x="693" y="132" width="14" height="4" fill="#fff"/>
  <text x="759" y="126" text-anchor="middle" fill="#192D2D" style="font-size:12px">Hetki, vielä yksi laki!</text>
  <!-- labels -->
  <g fill="#545459" text-anchor="middle" style="font-size:12px" font-style="italic">
    <text x="262" y="306">ihminen rakentaa rajoja</text>
    <text x="740" y="306">ihminen rakentaa lisää rajoja</text>
  </g>
</svg>

<div class="callout teal" style="margin-top: 8px">
Suurin osa ihmisen työstä ja huomiosta menee <strong>tarkistusten rakentamiseen</strong>. Agentin työ on kaikki aitauksen sisällä.
</div>

<!--
[22:00–22:45]

Ihmisen työ siirtyy **toteutuksen kirjoittamisesta rakennustelineisiin**. Ennen kuin rakennusta voi pystyttää, telineiden pitää olla kunnossa:
1. Tyypit
2. Lait
3. Hyväksymiskriteerit
4. Työtilan rajat
5. **Riippumaton tarkistus**, joka on aitauksen ainoa portti ulos

**Suurin osa työstä ja huomiosta menee sinne**, ei toteutuksen kirjoittamiseen.

Kuva on vähän kärjistetty: agentti kysyy jo, saako aloittaa, ja ihmiset kantavat vielä yhtä aitaelementtiä. Agentti saa aloittaa vasta, kun aitaus on pystyssä.

*Ja kun aitaus on valmis?*
-->

---
layout: center
class: brand statement
---

<div class="arrow">↗</div>

# Päästä agentti irti

<p class="subtitle">Aitauksen sisällä agentti saa tehdä mitä haluaa. Ulos pääsee vain tarkistuksen portista.</p>

<!--
[22:45–22:55]

**Aitaus on valmis. Kolmas askel: päästä agentti irti.**

Robotti kysyi edellisessä kuvassa, saako se jo aloittaa. Nyt saa. **Aitauksen sisällä agentti saa tehdä mitä haluaa**: valita toteutuksen ja kokeilla niin monta kertaa kuin haluaa. **Ulos pääsee vain tarkistuksen portista.**

*Miltä tulos sitten näyttää?*
-->

---

<span class="label-illustrative">Havainnollistus – keksitty PR</span>

<div class="pr">
<div class="pr-head">
<span class="pr-state">● Open</span>
<span class="pr-title">Implement campaign codes at checkout <span class="pr-num">#42</span></span>
</div>
<div class="pr-meta"><b>agent</b> wants to merge 1 commit into <code>main</code> from <code>agent/shop-42</code></div>
<div class="pr-body">
<p>Implements <code>applyCode()</code> against the agreed contract in <code>src/contracts.ts</code>. All checks pass. Done! ✅</p>
</div>
<div class="pr-grid">
<div class="pr-checks">
<div class="pr-checks-head">✓ All checks have passed</div>
<div>✓ Build and type check</div>
<div>✓ Property tests · 6 / 6</div>
<div>✓ Acceptance tests · 2 scenarios</div>
<div>✓ Independent verification in a fresh copy</div>
</div>
<div class="pr-files">
<div class="pr-checks-head">2 files changed</div>
<div><code>src/implementation/apply-code.ts</code> <span class="add">+187</span></div>
<div><code>src/implementation/rounding.ts</code> <span class="add">+41</span></div>
<div class="pr-merge">Merge pull request</div>
</div>
</div>
</div>

<div v-click class="pr-question">Mergeäisitkö tämän lukematta diffiä?</div>

<style>
.pr { margin-top: 10px; border: 1px solid var(--l-gray-300); border-radius: 10px; padding: 14px 18px; background: #fff; box-shadow: 0 4px 18px rgba(80, 55, 95, 0.07); font-size: 14px; }
.pr-head { display: flex; align-items: center; gap: 12px; }
.pr-state { background: #1F883D; color: #fff; border-radius: 999px; padding: 3px 12px; font-size: 13px; font-weight: 700; }
.pr-title { font-size: 21px; font-weight: 700; color: var(--l-ink); }
.pr-num { color: var(--l-gray-500); font-weight: 400; }
.pr-meta { color: var(--l-gray-700); font-size: 13px; margin: 6px 0 10px; }
.pr-body { border-top: 1px solid var(--l-gray-100); padding-top: 4px; }
.slidev-layout .pr-body p { margin: 6px 0 10px; }
.pr-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 14px; }
.pr-checks, .pr-files { border: 1px solid var(--l-gray-100); border-radius: 8px; padding: 8px 12px; line-height: 1.6; }
.pr-checks div { color: #1F883D; }
.pr-checks-head { font-weight: 700; color: var(--l-ink) !important; margin-bottom: 2px; }
.pr-files .add { color: #1F883D; font-weight: 700; font-size: 12.5px; }
.pr-merge { display: inline-block; margin-top: 8px; background: #1F883D; color: #fff; border-radius: 6px; padding: 4px 12px; font-weight: 700; font-size: 13px; }
.pr-question { margin-top: 18px; font-size: 34px; font-weight: 900; letter-spacing: -0.03em; color: var(--l-purple-dark); }
</style>

<!--
[22:55–23:40]

**Ja sitten sun pöydälle tulee tällainen PR.**

Kaikki on tehty oikein:
1. Tyypit, ominaisuustestit ja hyväksymistestit päätettiin ennen delegointia.
2. Agentti kirjoitti vain toteutushakemistoon.
3. Tarkistukset ajettiin uudelleen puhtaassa kopiossa, ja kaikki on vihreää.

Ja agentti sanoo taas: "Done! ✅"

[click] **Mergeäisitkö tämän lukematta diffiä?** Kädet ylös. (tauko)

Oma vastaukseni: **se riippuu riskistä**. Tarkistukset kertovat paljon, ja ne muuttavat sitä, mitä diffistä luetaan: enää ei tarkisteta, toimiiko alennus, vaan sitä, **mitä tarkistukset eivät kerro**.

*Mitä vihreä tulos sitten ei kerro?*
-->

---

# Mitä vihreä tulos ei kerro?

<div class="cols-3 small" style="margin-top: 8px; gap: 12px">
<div class="card accent"><h2>Ovatko vaatimukset oikeat?</h2>Tarkistukset tarkistavat sen, mitä kirjoitimme. Eivät sitä, mitä olisi pitänyt kirjoittaa.</div>
<div class="card accent"><h2>Mitä ei ole katettu?</h2>Mitä sopimus ja lait eivät mainitse, sitä ei ole tarkistettu. Generaattorit tuottavat vain sen, mitä niille kerrottiin.</div>
<div class="card accent"><h2>Luotammeko suoritukseen?</h2>Ehdokaskoodi ajetaan samassa prosessissa kuin testit. Kielletyt pakotiet, kuten <code>as</code> ja <code>any</code>, nojaavat ohjeeseen ja katselmointiin.</div>
<div class="card accent"><h2>Onko tämä tuotantoa?</h2>Vihreä kertoo, että koodatut odotukset täyttyivät. Ei sitä, että järjestelmä on valmis tuotantoon.</div>
<div class="card teal"><h2>Onko koodi ylläpidettävää?</h2>Onko se helppo ymmärtää ja muuttaa? Seuraako se tiimin tapoja? Toimiiko se riittävän nopeasti?</div>
<div class="card teal"><h2>Onko ratkaisu järkevä?</h2>Onko se turhan monimutkainen? Toiko se uusia riippuvuuksia? Sopiiko se muuhun arkkitehtuuriin?</div>
</div>

<div class="callout teal" style="margin-top: 20px">
Tarkistukset eivät poista katselmointia. Ne kertovat, <strong>mihin</strong> katselmointi kannattaa käyttää.
</div>

<!--
[23:40–24:50]

**Nopea rehellisyyskierros.** Vihreä tarkoittaa: koodatut odotukset täyttyivät. Ei enempää. Se ei kerro:
1. **Ovatko vaatimukset oikeat.** Jos sääntö itse on väärin, kaikki tarkistukset ovat väärin samalla tavalla.
2. **Mitä ei ole katettu.** Mitä sopimus ja lait eivät mainitse, sitä ei ole tarkistettu.
3. **Voiko suoritukseen luottaa.** Tyyppijärjestelmän pakoteitä voi kiertää, ja siinä nojataan yhä ohjeeseen ja katselmointiin.
4. **Onko muutos tuotantovalmis.**
5. **Onko koodi ylläpidettävää**: helppo ymmärtää ja muuttaa, seuraako se tiimin tapoja?
6. **Onko ratkaisu järkevä**: ei turhia riippuvuuksia, sopii arkkitehtuuriin?

**Tarkistukset eivät poista katselmointia. Ne kertovat, mihin katselmointia kannattaa käyttää.**

*Kuinka paljon huomiota yksittäinen muutos sitten ansaitsee?*
-->

---

# Kuinka paljon huomiota muutos ansaitsee?

<div class="att-head"><span>vähemmän huomiota</span><span>enemmän huomiota</span></div>
<div class="att-bar"></div>

<div class="att-row"><b>Verifioitavuus</b><span>tarkistukset kattavat muutoksen</span><span>ei koneellisesti tarkistettavissa</span></div>
<div class="att-row"><b>Vaikutusalue</b><span>yksi sisäinen moduuli</span><span>maksut, tietoturva, data</span></div>
<div class="att-row"><b>Peruttavuus</b><span>yksi revert, feature flag</span><span>migraatio, lähetetty viesti</span></div>
<div class="att-row"><b>Uutuus</b><span>toistuva, tuttu muutos</span><span>uusi arkkitehtuuripäätös</span></div>

<div class="callout teal" style="margin-top: 22px; font-size: 20px">
Mitoita ihmisen huomio <strong>muutoksen</strong> mukaan, ei sen mukaan, kuka sen kirjoitti.
</div>

<style>
.att-row { display: grid; grid-template-columns: 190px 1fr 1fr; gap: 16px; align-items: center; }
.att-head { display: flex; justify-content: space-between; margin-left: 206px; }
.att-bar { height: 12px; border-radius: 6px; margin: 6px 0 4px 206px; background: linear-gradient(90deg, var(--l-teal) 0%, var(--l-purple-50) 50%, var(--l-red) 100%); }
.att-head { margin-top: 18px; font-size: 14px; font-weight: 700; text-transform: uppercase; letter-spacing: 0.06em; }
.att-head span:nth-child(1) { color: var(--l-teal-deep); }
.att-head span:nth-child(2) { color: #C4502A; }
.att-row { border-bottom: 1px solid var(--l-gray-100); padding: 13px 0; font-size: 19px; line-height: 1.25; }
.att-row b { font-size: 21px; }
.att-row b { color: var(--l-purple-dark); }
.att-row span:nth-of-type(1) { color: var(--l-gray-700); }
.att-row span:nth-of-type(2) { color: var(--l-gray-700); text-align: right; }
</style>

<!--
[24:50–26:50]

Kuinka paljon ihmisen huomiota yksittäinen muutos ansaitsee? **Ei aina samaa määrää.** Neljä tekijää:
1. **Verifioitavuus**: kattavatko tarkistukset muutoksen? Jos sitä ei voi tarkistaa koneellisesti, se vaatii enemmän ihmisen huomiota.
2. **Vaikutusalue**: yksi sisäinen moduuli vai maksut, tietoturva tai luottamuksellinen data?
3. **Peruttavuus**: riittääkö revert tai feature flagin kytkeminen pois, vai onko kyse tunteja kestävästä migraatiosta tai asiakkaille jo lähteneestä viestistä?
4. **Uutuus**: toistuva muutos, josta agentti löytää koodista esimerkkejä, vai täysin uusi arkkitehtuuripäätös?

Mitä enemmän oikealle, sitä enemmän ihmisen huomiota.

**Tämä vastaa PR-dian kysymykseen:** mergeäisitkö lukematta? Riippuu siitä, missä kohtaa näitä janoja muutos on.

Ja sama vastaa alun rajaukseen: **alennusesimerkki oli tarkoituksella pieni**. Samat neljä tekijää kertovat, kuinka paljon tarkistuksia kannattaa rakentaa ennen delegointia.

*Kolme askelta tiivistettynä:*
-->

---
class: brand
---

<div class="arrow">↗</div>

# Kolme askelta

<ul class="big-questions">
<li><span>1</span>Määrittele järjestelmä, älä toteutusta</li>
<li><span>2</span>Eristä agentti tarkistuksesta</li>
<li><span>3</span>Päästä agentti irti</li>
</ul>

<p class="closing-thanks">Kiitos! Kysymyksiä?</p>

<style>
.slidev-layout.brand .big-questions li { font-size: 36px; margin: 16px 0 !important; }
.slidev-layout .closing-thanks { margin-top: 40px; font-size: 30px; font-weight: 700; color: var(--l-teal); }
</style>

<img class="logo" src="/loihde-white.svg" alt="Loihde" />

<!--
[26:50–27:20, sitten kysymykset]

1. **Määrittele järjestelmä, älä toteutusta.** Tyypit, ominaisuudet ja hyväksymiskriteerit kertovat, mitä järjestelmä lupaa.
2. **Eristä agentti tarkistuksesta.** Agentti kirjoittaa vain toteutusta, ja tarkistus ajetaan uudelleen puhtaassa kopiossa.
3. **Päästä agentti irti.** Aitauksen sisällä agentti saa tehdä mitä haluaa.

**Kiitos! Kysymyksiä?**
-->
