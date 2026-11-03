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
[0:00–0:45]

Tervetuloa. Kaikki täällä ovat käyttäneet koodausagentteja, joten en esittele niitä.

Kysymys tänään: miten agentille voi antaa enemmän vapautta niin, että kontrolli säilyy? Vastaukseni ei ole "älä anna". Vastaus on: päätä ensin, millä hyväksyt tuloksen, ja anna vapaus sen rajan sisällä.

Tänään kolme askelta: määrittele järjestelmä, eristä agentti tarkistuksesta ja päästä se irti. Järjestelmä määritellään kolmella deterministisellä tarkistuksella: tyypeillä, ominaisuustesteillä (property testing) ja hyväksymistesteillä (Gherkin). Esimerkkinä on verkkokaupan alennus.

Tärkeä rajaus heti alkuun: emme aja agenttia livenä. Esimerkit ovat yksinkertaistettuja, ja agentin työnkulku näytetään demorepon asetuksista ja kehotteesta.
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
[0:45–1:30]

Kaikki tuntevat tämän, joten lyhyesti. Agentti saa tehtävän, muokkaa koodia, ajaa työkalut, lukee palautteen ja jatkaa, kunnes se päättää itse, että työ on valmis.

Kaksi kohtaa kuvasta:
- Palaute: agentti on vain niin hyvä kuin palaute, jonka sen työkalut antavat. Tähän esitys palaa tarkistusten kautta.
- Lopetus: silmukasta poistutaan agentin oman arvion perusteella.

Siirtymä: entä se "valmis"? Mistä tiedämme, että agentti on oikeasti valmis?
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
[1:30–3:15]

Terminaali on keksitty havainnollistus, ei oikean ajon tuloste. Sanon tämän ääneen.

Pointti: agentin raportti on hyödyllistä tietoa mutta ei hyväksymiskriteeri. Kolme ongelmaa oikealla:
- Sama väärinkäsitys kahdesti: jos agentti ymmärsi tehtävän väärin, se kirjoittaa saman väärinkäsityksen sekä koodiin että testeihin. Testit vahvistavat väärinkäsityksen sen sijaan, että paljastaisivat sen.
- Testejä voi muuttaa: kun tarkistus ja tarkistettava ovat saman kirjoittajan käsissä, helpoin tie vihreään voi olla tarkistuksen heikentäminen.
- Erehtyy omasta valmiudestaan: agentti voi jättää testin ajamatta, selittää epäonnistuneen testin epävakaaksi tai asiaan kuulumattomaksi, tai lopettaa "riittävän hyvään". Raportti näyttää silti samalta: "Valmis! ✅". Syy on se, että "valmis" on mallin arvio eikä toistettava tarkistus.

Siirtymä: mitä "valmis" oikeastaan tarkoittaa?
-->

---

# Kuinka tiukka "valmis"?

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
[3:15–4:45]

Edellisellä dialla "valmis" oli agentin oma arvio. Se on janan vasen pää: liian löysä. Agentti voi olla valmis mistä tahansa.

Ilmeinen vastaus on kiristää: lisää testejä. Mutta jos testit tuntevat toteutuksen, eli mockit, sisäisen rakenteen ja tarkat tulosteet, ollaan oikeassa päässä. Jokainen muutos rikkoo testit, ja agentilla ei ole enää liikkumavaraa. Silloin sen voisi yhtä hyvin kirjoittaa itse.

Tavoite on keskellä: "valmis" määritellään järjestelmän ehdoilla. Tarpeeksi tiukka, että järjestelmä toimii odotetusti, ja tarpeeksi löysä, että agentti saa päättää, miten.

Siirtymä: millä tarkistuksilla tällainen "valmis" kirjoitetaan?
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
[4:45–6:00]

Deterministisiä tarkistuksia on paljon. Tänään valitaan kolme, ja valinnan peruste on, että ne kirjoittavat järjestelmän lait:

- Tyypit: sopimus koodin sisällä. Ne pakottavat sopimuksen ja ohjaavat toteutusta: väärää arvoa ei voi edes kirjoittaa. Mitä voi olla olemassa.
- Ominaisuustestit: mihin muut luottavat. Käytös, josta järjestelmän muut osat ja ulkoiset järjestelmät riippuvat: säännöt, jotka pätevät kaikilla syötteillä. Mikä pätee aina.
- Hyväksymistestit: täyttyykö tarve. Sovitut esimerkit sen ihmisen näkökulmasta, joka työn tarvitsi. Mitä pitää tapahtua.

Järjestys kulkee koodista ulospäin: koodi → muut järjestelmät → käyttäjä.

Ne kuvaavat järjestelmää eivätkä koodia, joten ihminen päättää ne ennen delegointia. Agentti saa muuttaa sitä, miten, mutta ei lakeja.

Himmennetyt testaavat useimmiten juuri tätä toteutusta (yksikkötestit mockeilla, golden-tiedostot sisäisestä tulosteesta) tai ajetaan agentin oman silmukan ulkopuolella (E2E, CI:n integraatiotestit). E2E-testit tarkistavat nekin järjestelmän käytöstä, joten rehellinen toissijainen syy on nopeus. Arkkitehtuuritestit ja tietoturvaskannaus ovat hyviä ja deterministisiä, mutta ne vartioivat koodin rakennetta, eivät järjestelmän käytöstä.
-->

---

# Tyypit

<p class="h1-sub"><span class="step">1 / 3</span> · Tyyppi kantaa todisteen</p>

<p class="muted" style="margin-top: -6px">Esimerkkinä verkkokaupan alennus.</p>

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
[6:00–7:15]

Ennen esimerkkiä ajatus: tyyppi voi kantaa todisteen arvosta.

Esimerkkinä verkkokaupan alennus. Ulkomaailmasta tulee raakoja lukuja: kampanjan hallintanäkymästä, API:sta tai agentin kirjoittamasta koodista. Niistä ei tiedetä mitään. Rajalla on yksi konstruktori, percent(), joka tarkistaa kerran, että luku on 0 ja 100 välissä. Jos ei ole, tulos on null ja arvo hylätään rajalla.

Jos tarkistus menee läpi, arvo saa tyypin Percent. Rajan sisäpuolella kaikki funktiot ottavat Percentin, eikä kenenkään tarvitse tarkistaa uudelleen. Tyyppi on todiste siitä, että tarkistus on tehty.

Tämä on myös luottamusraja agentille: agentti voi kirjoittaa mitä tahansa sisäpuolelle, mutta se ei voi ohittaa rajaa ilman, että kääntäjä huomaa.

Nimi niille, jotka tuntevat sen: "Parse, don't validate", Alexis Kingin kirjoitus vuodelta 2019.

Siirtymä: miltä tämä näyttää koodissa?
-->

---

# Tyypit

<p class="h1-sub"><span class="step">1 / 3</span> · Sopimus koodin sisällä</p>

<div class="cols code-sm" style="grid-template-columns: 1.15fr 1fr; gap: 22px; margin-top: 6px">
<div>

```ts
type Money = number & { readonly __brand: 'Money' };
type Percent = number & { readonly __brand: 'Percent' };

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
// ✗ Argument of type 'number' is not
//   assignable to parameter of type 'Percent'.
```

<p class="src">Yksinkertaistettu esimerkki</p>

</div>
<div>

<h2>Miksi agentille?</h2>

- **Väärää ei voi kirjoittaa.** Validoimaton prosentti ei käänny, joten agentin ei tarvitse muistaa validointia.
- **Ohjaa toteutusta.** Kääntäjä kertoo heti ja tarkasti, mikä puuttuu.
- **Testit voi kirjoittaa etukäteen.** Kun rajapinta on lyöty lukkoon, ominaisuus- ja hyväksymistestit voi kirjoittaa ennen toteutusta. Ne nojaavat sopimukseen, eivät koodiin.

<p class="tiny">Tyyppi pakottaa validoinnin tapahtumaan. Se ei todista, että validointi on oikein.</p>

</div>
</div>

<div class="callout teal" style="margin-top: 14px">
Älä pyydä agenttia muistamaan. <strong>Tee unohtamisesta virhe.</strong>
</div>

<!--
[7:15–8:30]

Ensimmäinen kolmesta: tyypit. Esimerkkinä verkkokaupan alennus, ei demon aihe. Demo tulee myöhemmin omana osionaan.

Money ja Percent ovat brändättyjä tyyppejä: ajonaikaisesti pelkkiä lukuja, mutta kääntäjä erottaa ne. Percent-arvon saa vain percent()-funktiosta, joka tarkistaa rajat. applyDiscount ottaa vain Percentin, joten pelkkä 20 ei käänny.

Miksi tämä toimii agentille:
- Agentin ei tarvitse muistaa validoida. Unohtaminen on käännösvirhe.
- Palaute on nopea ja tarkka: kääntäjä kertoo rivin ja syyn.
- Tärkein havainto käytännöstä: kun tyypit ovat kiinni, voimme kirjoittaa ominaisuus- ja hyväksymistestit etukäteen, ennen kuin toteutusta on olemassa. Testit nojaavat sopimukseen, eivätkä riko, kun toteutus muuttuu.

Rajaus: tyyppi pakottaa validoinnin tapahtumaan, se ei todista, että validointi on oikein. Oikeellisuus tulee testeistä.

"Älä pyydä agenttia muistamaan. Tee unohtamisesta virhe."
-->

---

# Ominaisuustestit

<p class="h1-sub"><span class="step">2 / 3</span> · Esimerkki vai laki?</p>

<table class="laws-table">
<thead>
<tr><th>Esimerkki: tavallinen testi</th><th>Laki: ominaisuustesti</th></tr>
</thead>
<tbody>
<tr><td><code>2 + 3 = 5</code></td><td><code>a + b = b + a</code> kaikilla luvuilla <code>a</code>, <code>b</code></td></tr>
<tr><td><code>sort([3, 1, 2]) = [1, 2, 3]</code></td><td><code>sort(sort(xs)) = sort(xs)</code> kaikilla listoilla <code>xs</code></td></tr>
<tr class="domain"><td>20 %:n alennus hinnasta 100 € → 80 €</td><td>Alennettu hinta on <strong>aina</strong> nollan ja alkuperäisen hinnan välissä</td></tr>
<tr class="domain"><td>0 %:n alennus hinnasta 100 € → 100 €</td><td>Nollan prosentin alennus <strong>ei koskaan</strong> muuta hintaa</td></tr>
</tbody>
</table>

<div class="callout teal" style="margin-top: 20px">
Esimerkki näyttää <strong>yhden tapauksen</strong>. Laki sanoo, mikä pätee <strong>kaikille</strong>.
</div>

<style>
.laws-table { margin-top: 18px; font-size: 16px; }
.laws-table th { font-size: 14px; }
.laws-table th:nth-child(2) { color: var(--l-teal-deep); border-bottom-color: var(--l-teal); }
.laws-table td { padding: 10px 8px; width: 50%; }
.laws-table td:first-child { color: var(--l-gray-700); }
.laws-table tr.domain:first-of-type td, .laws-table tr.domain + tr.domain td { }
.laws-table tbody tr:nth-child(3) td { border-top: 2px solid var(--l-gray-300); }
</style>

<!--
[8:30–10:00]

Moni ei ole kuullut ominaisuustestauksesta, joten lähdetään matematiikasta.

2 + 3 = 5 on esimerkki. a + b = b + a on laki: se pätee kaikille luvuille. Samoin sort([3, 1, 2]) on esimerkki, mutta "lajittelu kahdesti on sama kuin kerran" on laki.

Tavallinen testi tarkistaa esimerkkejä. Ominaisuustesti tarkistaa lakeja.

Järjestelmälläkin on lakeja. Verkkokaupassa alennettu hinta on aina nollan ja alkuperäisen välissä. Se on invariantti. Nollan prosentin alennus ei koskaan muuta hintaa. Se on neutraalialkio, sama ajatus kuin a + 0 = a.

Nämä ovat juuri niitä asioita, joihin muut järjestelmän osat luottavat.

Siirtymä: miten työkalu tarkistaa lain, jos syötteitä on äärettömän monta?
-->

---

# Ominaisuustestit

<p class="h1-sub"><span class="step">2 / 3</span> · Miten työkalu etsii vastaesimerkin</p>

<div class="cols-4" style="margin-top: 14px">
<div class="card soft small"><h3>1 · Generoi</h3>Satoja satunnaisia syötteitä, esim. hinta- ja alennuspareja</div>
<div class="card soft small"><h3>2 · Tarkista</h3>Päteekö laki jokaiselle?</div>
<div class="card soft small"><h3>3 · Kutista</h3>Epäonnistunut syöte pienennetään pienimmäksi, joka yhä kaataa testin</div>
<div class="card accent small"><h3>4 · Raportoi</h3>Pienin vastaesimerkki, jonka ihminen ymmärtää yhdellä silmäyksellä</div>
</div>

<div class="cols" style="margin-top: 18px; align-items: start">
<div>

<span class="label-illustrative">Havainnollistus – ei oikean ajon tuloste</span>

<div class="terminal" style="margin-top: 10px; font-size: 13px">
<div><span class="prompt">✗</span> discounted price is within [0, price]</div>
<div>&nbsp;&nbsp;Property failed after 37 tests</div>
<div>&nbsp;&nbsp;Shrunk 6 time(s)</div>
<div>&nbsp;&nbsp;Counterexample:</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;price = 0, discount = 1</div>
<div>&nbsp;&nbsp;Expected 0 ≤ result ≤ price, got -1</div>
</div>

</div>
<div>

<h2>Mitä tästä näkee?</h2>

- Toteutus vähensi alennuksen hinnasta **sentteinä** eikä prosentteina.
- Pienillä hinnoilla tulos meni **negatiiviseksi**.
- Satunnainen syöte, esim. <code>price = 37, discount = 81</code>, kutistui pienimpään mahdolliseen.

</div>
</div>

<!--
[10:00–11:30]

Miten laki tarkistetaan, kun syötteitä on äärettömän monta? Ei tarkisteta kaikkia. Työkalu generoi satoja satunnaisia syötteitä ja etsii yhtä, joka rikkoo lain.

Kun se löytyy, työkalu kutistaa sen: kokeilee pienempiä lukuja ja lyhyempiä listoja niin kauan kuin testi yhä kaatuu. Tulos on pienin vastaesimerkki.

Terminaali on keksitty havainnollistus, ei oikean ajon tuloste. Sanon tämän ääneen. Bugi: toteutus vähensi alennuksen hinnasta sentteinä eikä prosentteina. Esimerkkitesti 100 € ja 20 % paljastaisi tämän, jos joku kirjoittaa sen. Ominaisuustesti löytää virheen ilman, että kenenkään tarvitsee keksiä oikeaa esimerkkiä: pienillä hinnoilla tulos menee negatiiviseksi, ja kutistus kertoo pienimmän tapauksen, hinta 0 ja alennus 1 %.

Agentille tämä on erityisen hyvää palautetta: pieni, konkreettinen vastaesimerkki kertoo tarkasti, mikä on vialla.

Siirtymä: miltä tällainen testi näyttää koodissa?
-->

---

# Ominaisuustestit

<p class="h1-sub"><span class="step">2 / 3</span> · Mihin muut luottavat</p>

<div class="cols code-sm" style="grid-template-columns: 1.15fr 1fr; gap: 22px; margin-top: 6px">
<div>

```ts
test('discounted price is within [0, price]', () => {
  fc.assert(
    fc.property(anyMoney, anyPercent,
      (price, discount) => {
        const discounted = applyDiscount(price, discount);
        return discounted >= 0 && discounted <= price;
      }),
  );
});
```

<p class="src">Yksinkertaistettu esimerkki · fast-check · generaattorit rakennetaan tyyppien konstruktoreista</p>

</div>
<div>

<h2>Miksi agentille?</h2>

- **Sääntö, ei esimerkki.** Testi generoi satoja syötteitä ja etsii vastaesimerkin. Yhtä tapausta kovakoodaamalla sitä ei läpäise.
- **Muut riippuvat tästä.** Kassa, laskutus ja raportointi olettavat, ettei alennettu hinta ole koskaan negatiivinen.
- **Kirjoitettu ennen toteutusta.** Testi käyttää vain tyyppejä `Money` ja `Percent` sekä julkista `applyDiscount()`-rajapintaa.

<p class="tiny">Otos, ei todistus: tuhat läpäistyä tapausta ei takaa, ettei vastaesimerkkiä ole.</p>

</div>
</div>

<div class="callout teal" style="margin-top: 14px">
Ominaisuustesti ei kerro, <strong>miten</strong>. Se kertoo, mikä pätee <strong>aina</strong>.
</div>

<!--
[11:30–12:30]

Toinen: ominaisuustestit. Sama alennusesimerkki.

Testi ei listaa esimerkkejä vaan säännön: millä tahansa hinnalla ja millä tahansa sallitulla alennuksella alennettu hinta on nollan ja alkuperäisen välissä. fast-check generoi syötteet ja kutistaa löytämänsä vastaesimerkin pienimpään muotoon.

Miksi tämä toimii agentille:
- Agentti ei voi läpäistä testiä erikoistapauksilla. Sääntö pätee kaikkiin syötteisiin tai ei mihinkään.
- Valitaan säännöt, joihin järjestelmän muut osat luottavat. Juuri ne ovat kalleimpia rikkoa.
- Testi on kirjoitettu ennen toteutusta, koska se tarvitsee vain tyypit. Generaattorit rakennetaan samoista konstruktoreista, joita tuotantokoodi käyttää.

Rajaus: otos, ei todistus.
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
[12:30–13:15]

Hyväksymistestit kuulostavat raskailta, mutta useimmilla on ne jo, vain eri muodossa: tiketin hyväksymiskriteereinä.

Tässä tyypillinen user story kampanjakoodista ja kaksi kriteeriä. Voimassa oleva koodi alentaa summaa, ja vanhentunut koodi hylätään.

Ongelma: tiketti ei aja itseään. Agentti lukee sen, tulkitsee sen ja sanoo "valmis". Kukaan ei tarkista, vastaako tulkinta kriteerejä.

Hyväksymistesti on sama asia ajettavana. Seuraavalla dialla nämä kaksi kriteeriä ovat kaksi skenaariota.

(Tiketti on keksitty esimerkki, ei mistään oikeasta järjestelmästä.)
-->

---

# Hyväksymistestit

<p class="h1-sub"><span class="step">3 / 3</span> · Täyttyykö tarve</p>

<div class="cols code-sm" style="grid-template-columns: 1.15fr 1fr; gap: 22px; margin-top: 6px">
<div>

```gherkin
Feature: Campaign codes

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

<p class="src">Yksinkertaistettu esimerkki · Gherkin</p>

</div>
<div>

<h2>Miksi agentille?</h2>

- **Tarpeen kielellä.** Tuoteomistaja voi lukea ja hyväksyä skenaarion ennen kuin koodia on.
- **Agentti ei kirjoita omaa tavoitettaan.** Skenaariot sovitaan etukäteen, joten sama väärinkäsitys ei pääse sekä koodiin että testiin.
- **Vakaa, koska rajapinta on vakaa.** Askelten toteutukset kutsuvat tyypitettyä rajapintaa, joten nekin voi kirjoittaa etukäteen.

</div>
</div>

<div class="callout teal" style="margin-top: 14px">
Hyväksymistesti kertoo, milloin työ on valmis <strong>sen mielestä, joka sitä tarvitsi</strong>.
</div>

<!--
[13:15–14:15]

Kolmas: hyväksymistestit. Sama alennusesimerkki: edellisen dian tiketin kaksi kriteeriä ovat tässä kaksi skenaariota. Gherkin on tässä vain kirjoitustapa; olennaista on, että esimerkit on sovittu tarpeen omistajan kanssa.

Miksi tämä toimii agentille:
- Skenaariot ovat sen kielellä, joka työn tarvitsi. Ne voi hyväksyä ennen toteutusta.
- Ne ratkaisevat dian 3 ensimmäisen ongelman: kun agentti ei kirjoita omaa hyväksymiskriteeriään, sama väärinkäsitys ei päädy sekä koodiin että testiin.
- Step-toteutukset kutsuvat tyypitettyä rajapintaa. Koska rajapinta on kiinni, nekin voi kirjoittaa etukäteen, ja ne kestävät toteutuksen muutokset.

Siirtymä: miten nämä kolme liittyvät toisiinsa?
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
[14:15–15:30]

Yhteenveto kolmesta. Ne eivät ole rinnakkaisia vaihtoehtoja, vaan ne rakentuvat toistensa päälle.

1. Tyypit ensin. Ne määrittelevät rajapinnan: mitä arvoja on olemassa ja mitä funktioita voi kutsua. Agentti ei saa muuttaa niitä.
2. Testit sopimusta vastaan. Ominaisuus- ja hyväksymistestit kirjoitetaan tyyppejä vastaan, ennen kuin toteutusta on olemassa. Tämä on käytännön havainto: kun tyypit ovat kiinni, testit voi kirjoittaa etukäteen, eivätkä ne riko, kun toteutus muuttuu.
3. Vasta sitten agentti toteuttaa. Toteutus saa vaihtua sopimuksen takana niin monta kertaa kuin tarvitaan.

Jos tarkistus kirjoitettaisiin suoraan toteutusta vastaan, se rikkoutuisi heti, kun agentti muuttaa toteutusta.

Siirtymä: mistä nämä tarkistukset käytännössä tulevat?
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
[15:30–16:30]

Kolme tarkistusta kuvana.

- Ulompi laatikko: kaikki ohjelmat, joita agentti voisi kirjoittaa.
- Lila: ohjelmat, jotka kääntyvät sopimusta vasten. Tyypit rajaavat.
- Teal: ohjelmat, joissa lait pätevät. Ominaisuustestit rajaavat.
- Oranssi: ohjelmat, jotka täyttävät hyväksymiskriteerit. Skenaariot rajaavat.

Jokainen yksinään jättää paljon väärää sisään. Kääntyvä ohjelma voi rikkoa lain. Lain täyttävä ohjelma voi silti olla väärä tarpeen kannalta. Skenaariot läpäisevä ohjelma voi toimia vain juuri niillä esimerkeillä.

Hyväksytään vain leikkaus. Sen sisällä agentti saa valita vapaasti: siinä on yhä monta erilaista toteutusta. Se on juuri se "tarpeeksi tiukka ja tarpeeksi löysä" -alue dialta 4.

Varovaisuus: tämä on hyväksymisen malli, ei väite siitä, että kielimallin dekoodausta rajattaisiin muodollisesti. Agentti voi kirjoittaa mitä tahansa; me päätämme, mitä otamme vastaan.

Ihminen vastaa siitä, osuvatko rajat siihen, mitä oikeasti tarkoitimme. Leikkaus voi olla väärässä paikassa, jos tyypit, lait tai kriteerit on kirjoitettu väärin.
-->

---

# Mistä tarkistukset tulevat?

<p class="muted" style="margin-top: -6px">Ylhäältä alas: epämääräisestä tarpeesta yksityiskohtiin.</p>

<div class="cols-3" style="margin-top: 18px; align-items: stretch">
<div class="card accent">

<h3>Hyväksymiskriteerit</h3>

<p class="src-line">Lähde: tiketti ja vaatimusmäärittely</p>

- Tuoteomistaja ja tiimi sopivat
- Mitä tarpeen omistaja odottaa näkevänsä
- Kirjoitetaan jo nyt, kuten dialla 11

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
[16:30–17:15]

Mistä nämä kolme tulevat käytännössä? Eri lähteistä, eri ihmisiltä, ja ylhäältä alas: epämääräisestä asiakkaan tarpeesta yhä tarkempiin yksityiskohtiin.

Hyväksymiskriteerit tulevat tiketistä ja vaatimusmäärittelystä. Ne ovat tuoteomistajan ja tiimin sopimus siitä, mitä tarpeen omistaja odottaa näkevänsä. Useimmilla ne ovat jo olemassa, kuten dian 11 tiketissä.

Ominaisuudet tulevat insinöörin päättelystä. Ne ovat abstraktimpia ja teknisempiä kuin kriteerit: lait, joita kukaan ei kirjoittanut tikettiin, mutta joihin kaikki luottavat. Kriteerit voivat inspiroida niitä, mutta ne eivät toista kriteerejä.

Tyypit tulevat ohjelmoijalta. Ajattelutapa on turvallisuus rakenteella: suunnitellaan tyypit niin, että mahdottomia tiloja ei voi edes esittää. Samalla syntyy vakaa rajapinta, jota vastaan testit kirjoitetaan.

Kaikki kolme lukitaan ennen kuin agentti aloittaa toteutuksen.
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
[17:15–18:45]

Hyväksymiskriteerit tulevat tiketistä ja vaatimusmäärittelystä. Mutta hyvät kriteerit eivät synny itsestään: ne syntyvät, kun epämääräinen vaatimus pilkotaan säännöiksi ja konkreettisiksi esimerkeiksi.

Vasemmalla tyypillinen vaatimus: "kampanjakoodit toimivat kassalla". Se ei kerro, mitä pitää tapahtua.

Oikealla sama Example Mapping -tekniikalla (Matt Wynne). Jokainen sääntö saa konkreettiset esimerkit. Esimerkeistä tulee hyväksymistestien skenaariot, kuten dialla 12.

Tärkein osa on oikea sarake: avoimet kysymykset. Kun esimerkkiin pitää kirjoittaa oikea luku, kysymykset tulevat esiin. 0,97 euron tuote ja 20 prosentin alennus: 0,776 euroa. Alas pyöristettynä 0,77, lähimpään 0,78. Kumpi? Entä kaksi koodia samaan aikaan?

Agentille tämä on ratkaiseva: jokainen kysymys, johon ei vastata ennen delegointia, on kohta, jossa agentti arvaa. Ja se arvaa hiljaa, eikä kerro arvanneensa.
-->

---

# Mistä tarkistukset tulevat?

<p class="h1-sub"><span class="step">Ominaisuudet</span> · Abstraktit lait insinöörin päättelystä</p>

<div class="law-grid">
<div class="law-card"><span class="tag">invariantti</span><p>Alennettu hinta on <strong>aina</strong> nollan ja alkuperäisen välissä.</p><code>0 ≤ apply(p, d) ≤ p</code></div>
<div class="law-card"><span class="tag">invariantti</span><p>Summa on <strong>aina</strong> kokonaisia senttejä.</p><code>total(cart) ∈ ℕ senttiä</code></div>
<div class="law-card"><span class="tag">idempotenssi</span><p>Saman koodin käyttäminen kahdesti on sama kuin kerran.</p><code>use(use(c, k), k) = use(c, k)</code></div>
<div class="law-card"><span class="tag">monotonisuus</span><p>Suurempi alennus ei <strong>koskaan</strong> anna suurempaa hintaa.</p><code>d₁ ≤ d₂ ⇒ apply(p, d₂) ≤ apply(p, d₁)</code></div>
<div class="law-card"><span class="tag">järjestys&shy;riippumattomuus</span><p>Tuotteiden järjestys korissa ei vaikuta summaan.</p><code>total(shuffle(items)) = total(items)</code></div>
<div class="law-card"><span class="tag">edestakaisuus</span><p>Koodin lisääminen ja poistaminen palauttaa korin ennalleen.</p><code>remove(use(c, k), k) = c</code></div>
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
</style>

<!--
[18:45–20:15]

Ominaisuudet ovat abstraktimpia kuin hyväksymiskriteerit. Kriteeri kertoo, mitä asiakas näkee tietyssä tilanteessa. Ominaisuus kertoo, mitä järjestelmä ei koskaan riko, millä tahansa syötteellä.

Nämä tulevat insinöörin päättelystä. Niitä ei yleensä lue tiketissä, mutta kassa, laskutus ja raportointi luottavat niihin:
- Invariantit: hinta pysyy nollan ja alkuperäisen välissä, summa on kokonaisia senttejä.
- Idempotenssi: saman koodin käyttäminen toiseen kertaan ei muuta mitään.
- Monotonisuus: isompi alennus ei koskaan nosta hintaa.
- Järjestysriippumattomuus: korin sisällön järjestys ei vaikuta summaan.
- Edestakaisuus: koodin lisääminen ja poistaminen palauttaa korin ennalleen.

Kaavat ovat merkintätapa, eivät koodia. Jokaisesta tulee yksi ominaisuustesti.

Päällekkäisyyttä kriteerien kanssa on luonnostaan: esimerkiksi edellisen dian avoin kysymys pyöristyksestä ratkeaa lopulta sekä kriteerinä että "kokonaisia senttejä" -invarianttina. Ero on näkökulmassa: kriteeri on asiakkaan esimerkki, ominaisuus on tekninen lupaus.

Agentti voi ehdottaa lakeja, mutta ihminen päättää, mitkä niistä järjestelmän pitää täyttää.
-->

---

# Mistä tarkistukset tulevat?

<p class="h1-sub"><span class="step">Tyypit</span> · Mahdottomat tilat mahdottomiksi</p>

<div class="cols code-sm" style="gap: 22px; margin-top: 6px">
<div>

<h3 style="color: var(--l-red)">✗ Sallii mahdottomat tilat</h3>

```ts
type Campaign = {
  code: string;
  percent: number;
  expired: boolean;
  expiredAt?: Date;
};

// Kaikki nämä kääntyvät:
const a: Campaign =
  { code: '', percent: 150, expired: false };
const b: Campaign =
  { code: 'X', percent: 10, expired: true };
```

</div>
<div>

<h3 style="color: var(--l-teal-deep)">✓ Mahdoton tila ei käänny</h3>

```ts
type Campaign =
  | { status: 'active';
      code: Code; percent: Percent }
  | { status: 'expired';
      code: Code; expiredAt: Date };

declare function applyCode(
  cart: Cart,
  code: Code,
): CheckoutResult;
```

</div>
</div>

<p class="src">Yksinkertaistettu esimerkki · Code ja Percent ovat brändättyjä tyyppejä kuten dialla 7</p>

<div class="callout teal" style="margin-top: 12px">
Mitä ei voi esittää, sitä <strong>agentti ei voi kirjoittaa</strong>. Rajapinta pysyy, toteutus saa vaihtua.
</div>

<!--
[20:15–21:30]

Tyypit tulevat ohjelmoijalta, ja ajattelutapa on turvallisuus rakenteella.

Vasemmalla tavallinen tyyppi. Se sallii tiloja, joita ei pitäisi olla: tyhjä koodi, 150 prosentin alennus, tai vanhentunut kampanja ilman vanhenemispäivää. Kaikki kääntyvät, joten jokaisen funktion pitää muistaa tarkistaa ne. Ja agentin pitää muistaa.

Oikealla sama asia unionityyppinä. Aktiivisella kampanjalla on prosentti, vanhentuneella on vanhenemispäivä. Vanhentunutta ilman päivää ei voi edes kirjoittaa. Code ja Percent ovat brändättyjä tyyppejä, joten tyhjää koodia tai 150 prosenttia ei saa läpi rajasta.

Alla vakaa rajapinta: applyCode ottaa ostoskorin ja koodin ja palauttaa tuloksen. Tätä vastaan ominaisuus- ja hyväksymistestit kirjoitetaan. Toteutus sen takana saa vaihtua.

Tämä on taas "Älä pyydä agenttia muistamaan" -ajatus: mahdottomat tilat ovat käännösvirheitä.
-->

---
layout: center
class: brand statement
---

<div class="arrow">↗</div>

# Määrittele järjestelmä,<br>älä toteutusta.

<p class="subtitle">Tyypit, ominaisuudet ja hyväksymiskriteerit kertovat, mitä järjestelmä lupaa. <strong>Miten</strong> se tehdään, jää agentille.</p>

<!--
[21:30–21:45]

Tiivistys tähänastisesta yhteen lauseeseen: määrittele järjestelmä, älä toteutusta.

Kaikki kolme tarkistusta kuvaavat sitä, mitä järjestelmä lupaa: mitä voi olla olemassa, mikä pätee aina ja mitä tarpeen omistaja näkee. Yksikään niistä ei kerro, miten se tehdään. Se jää agentille, ja juuri siinä on agentin vapaus.

Siirtymä: toinen askel. Miten agentti eristetään tarkistuksesta?
-->

---

# Eristä agentti tarkistuksesta

<p class="h1-sub"><span class="step">1 / 3</span> · Agentin työtila</p>

<div class="cols" style="margin-top: 8px; gap: 22px; align-items: start; grid-template-columns: 1.15fr 1fr">
<div>

<pre class="tree">
checkout/
├── README.md                  <i>vaatimukset</i>
├── package.json               <i>skriptit</i>
├── tsconfig.json              <i>kääntäjä</i>
├── src/
│   ├── contracts.ts           <i>tyypit ja rajapinnat</i>
│   ├── constructors.ts        <i>percent(), money()</i>
│   └── <b>implementation/</b>        <b>✎ kirjoitus</b>
│       └── <b>apply-code.ts</b>
├── test/
│   ├── properties.test.ts     <i>ominaisuustestit</i>
│   └── features/              <i>hyväksymistestit</i>
│       ├── campaign-codes.feature
│       └── steps.ts
└── <b>dist/</b>                      <b>✎ kirjoitus</b>
</pre>

<p class="src">Demorepon rakenne alennusesimerkin nimillä · kaikki muu kuin <b style="color: var(--l-teal-deep)">✎</b>: vain luku</p>

</div>
<div class="code-sm">

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

<p class="small" style="margin-top: 10px">Verkko pois. Ei hyväksyntäpyyntöjä. Agentti ajaa käännöksen ja testit <strong>itse</strong> ja korjaa niiden palautteen perusteella.</p>

</div>
</div>

<div class="callout teal" style="margin-top: 12px">
Agentti saa muuttaa toteutusta vapaasti, mutta <strong>ei sopimusta</strong>.
</div>

<style>
.slidev-layout .tree { margin: 0; padding: 12px 14px; background: var(--l-gray-50); border-radius: 6px; font-family: ui-monospace, Menlo, Consolas, monospace; font-size: 12.5px; line-height: 1.5; color: var(--l-gray-700); white-space: pre; }
.slidev-layout .tree i { font-style: normal; color: var(--l-gray-500); }
.slidev-layout .tree b { color: var(--l-teal-deep); font-weight: 700; }
</style>

<!--
[21:45–23:15]

Toinen askel: eristä agentti tarkistuksesta. Ensin: missä agentti työskentelee.

Agentti saa oman kopion lähtötilasta. Puussa näkyy, mitä se saa kirjoittaa: vain src/implementation/ ja dist/. Kaikki muu on vain luku -tilassa: vaatimukset README:ssä, tyypit ja rajapinnat contracts.ts:ssä, validoivat konstruktorit, testit, skriptit ja kääntäjäasetukset. Rakenne on sama kuin demorepossa, nimet alennusesimerkistä. Verkko on pois, eikä agentti voi pyytää lisäoikeuksia.

Tämä on se raja, joka erottaa "määritelty järjestelmä" ja "agentin vapaus" toisistaan. Sopimus pysyy, toteutus saa muuttua.

Agentti ajaa itse käännöksen ja testit ja korjaa niiden perusteella. Tämä on dian 2 silmukka: nyt palaute tulee tarkistuksista, jotka me päätimme.

Oikealla demorepon oikea profiili Codex CLI:lle, muotoiltu uudelleen luettavaksi. Sama onnistuu muillakin agenteilla: tiedosto-oikeuksilla, konttiin rajaamalla tai CI-säännöillä.
-->

---

# Eristä agentti tarkistuksesta

<p class="h1-sub"><span class="step">2 / 3</span> · Ohje agentille</p>

<div class="cols-wide-left" style="margin-top: 8px; grid-template-columns: 1.5fr 1fr; gap: 22px">
<div>

<div class="prompt-card">

1. Aja ensin käännös ja testit, ja raportoi lähtötilan virheet.
2. Toteuta olemassa olevia sopimuksia vasten. Käytä tarkistusten palautetta korjaamiseen.
3. **Älä heikennä, poista, ohita tai muuta** tarkistuksia, sopimuksia tai vaatimuksia saadaksesi testit läpi.
4. Jos tarkistus on mielestäsi väärä, **pysähdy ja merkitse se ihmisen arvioitavaksi**.
5. Operaattori ajaa tarkistukset **uudelleen itsenäisesti**.
6. Kuvaa jäljellä olevat riskit ja näytön rajat.

</div>

<p class="src">Lyhennetty ja suomennettu demorepon kehotteesta</p>

</div>
<div>

<h3>Vastaa dian 3 ongelmiin</h3>

<div class="map-row"><span>Sama väärinkäsitys kahdesti</span><b>Agentti ei kirjoita tarkistuksia</b></div>
<div class="map-row"><span>Testejä voi muuttaa</span><b>Kielletty ja lukittu</b></div>
<div class="map-row"><span>Erehtyy valmiudestaan</span><b>Ajetaan uudelleen</b></div>

</div>
</div>

<div class="callout" style="margin-top: 14px">
Ohje kertoo säännöt. <strong>Työtila ja tarkistus</strong> pakottavat ne.
</div>

<style>
.prompt-card { background: var(--l-gray-50); border-left: 4px solid var(--l-purple); border-radius: 8px; padding: 10px 16px 10px 8px; font-size: 15px; }
.slidev-layout .prompt-card ol { margin: 0; padding-left: 1.8em; }
.slidev-layout .prompt-card li { margin: 4px 0; }
.map-row { border-bottom: 1px solid var(--l-gray-100); padding: 7px 0; font-size: 14px; line-height: 1.3; }
.map-row span { display: block; color: var(--l-gray-700); font-size: 12.5px; }
.map-row b { color: var(--l-teal-deep); }
</style>

<!--
[23:15–24:30]

Toinen asia: mitä agentille sanotaan.

Vasemmalla demorepon kehote lyhennettynä ja suomennettuna. Kolme kohtaa on tärkeimpiä:
- Älä heikennä tarkistuksia saadaksesi ne läpi. Helpoin tie vihreään ei saa olla tarkistuksen muuttaminen.
- Jos tarkistus on mielestäsi väärä, pysähdy ja merkitse se. Agentti voi olla oikeassa: vaatimus voi olla väärin. Mutta sen ratkaisee ihminen, ei agentti hiljaa.
- Kerro agentille, että tarkistukset ajetaan uudelleen. Raportti ei ole hyväksyntä.

Oikealla sama kytkettynä dian 3 kolmeen ongelmaan. Sama väärinkäsitys ei pääse kahdesti, koska agentti ei kirjoita tarkistuksia. Testejä ei voi muuttaa, koska se on sekä kielletty että lukittu. Ja agentin omaa valmiusarviota ei tarvita, koska tarkistukset ajetaan uudelleen.

Ohje yksin ei riitä. Siksi työtila lukitsee tiedostot ja tarkistus ajetaan erikseen.
-->

---

# Eristä agentti tarkistuksesta

<p class="h1-sub"><span class="step">3 / 3</span> · Luota tarkistukseen, ei raporttiin</p>

<svg class="diagram" viewBox="0 0 880 262" style="margin-top: 6px" role="img" aria-label="Kolme kopiota: lähtötila, agentin työtila ja tarkistuskopio. Tarkistuskopioon siirtyy vain toteutus.">
  <defs>
    <marker id="arr-wf" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto-start-reverse"><path d="M0,0 L10,5 L0,10 z" fill="#50375F"/></marker>
  </defs>
  <rect x="8" y="30" width="250" height="160" rx="10" fill="#fff" stroke="#50375F" stroke-width="2.5"/>
  <text x="24" y="58" style="font-size:16px" font-weight="900" fill="#50375F">1 · Lähtötila</text>
  <g style="font-size:13px" fill="#1A1A1D"><text x="24" y="84">luotettu kopio tarkistuspisteestä</text><text x="24" y="104">sopimus · testit · asetukset</text><text x="24" y="132" fill="#545459">toteutus vielä tynkä</text><text x="24" y="160" fill="#00847F" font-weight="700">ei agentin kirjoitettavissa</text></g>
  <rect x="315" y="30" width="250" height="160" rx="10" fill="#F1EAF7" stroke="#B496CD" stroke-width="2.5"/>
  <text x="331" y="58" style="font-size:16px" font-weight="900" fill="#50375F">2 · Työtila</text>
  <g style="font-size:13px" fill="#1A1A1D"><text x="331" y="84">agentti toteuttaa tässä</text><text x="331" y="110" font-weight="700">kirjoitus: vain toteutus</text><text x="331" y="132" fill="#545459">kaikki muu: vain luku</text><text x="331" y="152" fill="#545459">verkko pois</text><text x="331" y="172" fill="#545459">ajaa testit itse</text></g>
  <rect x="622" y="30" width="250" height="160" rx="10" fill="#fff" stroke="#00847F" stroke-width="2.5"/>
  <text x="638" y="58" style="font-size:16px" font-weight="900" fill="#00847F">3 · Tarkistuskopio</text>
  <g style="font-size:13px" fill="#1A1A1D"><text x="638" y="84">tuore lähtötila</text><text x="638" y="104">+ ehdokkaan toteutus</text><text x="638" y="132" font-weight="700">kaikki tarkistukset</text><text x="638" y="152" fill="#545459">verkko pois</text></g>
  <line x1="260" y1="92" x2="312" y2="92" stroke="#50375F" stroke-width="2" marker-end="url(#arr-wf)"/>
  <text x="286" y="84" style="font-size:12px" text-anchor="middle" fill="#545459">kopio</text>
  <line x1="567" y1="92" x2="619" y2="92" stroke="#50375F" stroke-width="2" marker-end="url(#arr-wf)"/>
  <text x="593" y="20" style="font-size:12px" text-anchor="middle" fill="#50375F" font-weight="700">vain toteutus siirtyy</text>
  <line x1="593" y1="24" x2="593" y2="84" stroke="#C8C8CC" stroke-dasharray="3 3"/>
  <path d="M133 192 V230 H747 V194" fill="none" stroke="#50375F" stroke-width="2" marker-end="url(#arr-wf)"/>
  <text x="440" y="252" style="font-size:12px" text-anchor="middle" fill="#545459">tuore kopio lähtötilasta: agentin muutokset testeihin eivät voi kulkea tätä reittiä</text>
</svg>

<div class="callout teal" style="margin-top: 10px">
Valmis = agentti lopetti <strong>ja</strong> riippumaton tarkistus meni läpi. Agentin oma ”testit menevät läpi” ei ratkaise.
</div>

<!--
[24:30–26:00]

Kolmas asia: miten tulos tarkistetaan.

1. Lähtötila: luotettu kopio tarkistuspisteestä. Sopimus ja testit ovat valmiina, toteutus on vielä tynkä. Tämä on agentin kirjoitusoikeuksien ulkopuolella.
2. Työtila: kopio lähtötilasta. Agentti toteuttaa tässä ja ajaa testit itse. Kirjoittaa saa vain toteutukseen.
3. Tarkistuskopio: tuore kopio lähtötilasta, johon siirretään vain ehdokkaan toteutus. Kaikki tarkistukset ajetaan siellä, verkko pois.

Miksi kolme kopiota eikä yksi? Koska silloin ei tarvitse luottaa siihen, että agentti jätti testit rauhaan. Vaikka työtilan testit olisivat muuttuneet, tarkistus ajetaan alkuperäisillä.

Valmis tarkoittaa kahta asiaa yhtä aikaa: agentti lopetti onnistuneesti, ja riippumaton tarkistus meni läpi. Agentin raportti on hyödyllistä tietoa, mutta ei hyväksyntä.

Demorepossa tämä on yksi skripti: se tekee kopiot, käynnistää agentin rajatulla profiililla ja ajaa tarkistukset tuoreessa kopiossa.
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
[26:00–27:00]

Mitä tämä tarkoittaa ihmisen työlle? Se siirtyy.

Kun agentti kirjoittaa toteutuksen, ihmisen työ on rakennustelineet: tyypit, lait, hyväksymiskriteerit, työtilan rajat ja riippumaton tarkistus, joka on aitauksen ainoa portti ulos. Suurin osa työstä ja huomiosta menee sinne, ei toteutuksen kirjoittamiseen.

Kuva on vähän kärjistetty: agentti istuu valmiina koneen ääressä ja kysyy, saako jo aloittaa, ja ihmiset kantavat vielä yhtä aitaelementtiä. Mutta juuri näin sen kuuluukin mennä: agentti saa aloittaa vasta, kun aitaus on pystyssä.

Ja aitauksen sisällä agentti saa tehdä mitä haluaa. Se on agentin vapaus.

Siirtymä: aitaus on valmis. Kolmas askel.
-->

---
layout: center
class: brand statement
---

<div class="arrow">↗</div>

# Päästä agentti irti

<p class="subtitle">Aitauksen sisällä agentti saa tehdä mitä haluaa. Ulos pääsee vain tarkistuksen portista.</p>

<!--
[27:00–27:15]

Kolmas askel: päästä agentti irti.

Robotti kysyi edellisessä kuvassa, saako se jo aloittaa. Nyt saa. Aitauksen sisällä agentti saa valita toteutuksen vapaasti ja kokeilla niin monta kertaa kuin haluaa. Ulos pääsee vain riippumattoman tarkistuksen kautta.

Siirtymä: tässä sen tulos.
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
[27:15–28:15]

Kaikki on tehty oikein. Tyypit, ominaisuustestit ja hyväksymistestit on päätetty ennen delegointia. Agentti on kirjoittanut vain toteutushakemistoon. Tarkistukset on ajettu uudelleen tuoreessa kopiossa, ja kaikki ovat vihreänä. Ja agentti sanoo taas: "Done! ✅".

PR on keksitty havainnollistus. Sanon tämän ääneen.

[klikkaus] Mergeäisitkö tämän lukematta diffiä?

Kysy salilta, kädet ylös. Anna hetki aikaa.

Oma vastaukseni: se riippuu riskistä. Tarkistukset kertovat paljon, ja ne muuttavat sitä, mitä diffistä luetaan: enää ei tarkisteta, toimiiko alennus, vaan sitä, mitä tarkistukset eivät kata. Siihen seuraava dia.
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
[28:15–29:15]

Nopea rehellisyyskierros. Vihreä tarkoittaa: koodatut odotukset täyttyivät. Ei enempää.

- Vaatimukset: jos sääntö itse on väärin, kaikki tarkistukset ovat väärin samalla tavalla.
- Kattavuus: mitä sopimus ja lait eivät mainitse, sitä ei ole tarkistettu. Ominaisuustestien generaattorit tuottavat vain sen, mitä niille kerrottiin.
- Luottamus suoritukseen: ehdokas ajetaan samassa prosessissa kuin testit. Se voisi esimerkiksi lopettaa testiprosessin aikaisin. Ja TypeScriptin pakotiet, as, any ja @ts-ignore, nojaavat ohjeeseen ja katselmointiin, ellei lint-sääntö valvo niitä. Tämä on rajojen demo, ei suojaus vihamielistä koodia vastaan.
- Tuotanto: vihreä ei väitä tuotantovalmiutta.
- Ei-toiminnalliset vaatimukset: onko koodi ylläpidettävää, helppo ymmärtää ja muuttaa, seuraako se tiimin tapoja, onko se riittävän nopea. Onko ratkaisu järkevä: ei turhaa monimutkaisuutta, ei uusia riippuvuuksia ilman syytä, sopii muuhun arkkitehtuuriin. Tarkistukset eivät kerro näistä mitään, ellei niitä ole erikseen kirjoitettu tarkistuksiksi, esimerkiksi lint- tai arkkitehtuurisäännöiksi. Muuten ne jäävät katselmoinnille. Juuri tähän diffiä luetaan.

Siirtymä: kuinka paljon huomiota yksittäinen muutos sitten ansaitsee?
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
[29:15–30:30]

Viimeinen ajatus ennen yhteenvetoa: kuinka paljon ihmisen huomiota yksittäinen muutos ansaitsee?

Ei aina samaa määrää. Neljä kysymystä:
- Verifioitavuus: kattavatko tarkistukset muutoksen, vai onko siinä semantiikkaa, jota ei voi tarkistaa koneellisesti?
- Vaikutusalue: mitä rikkoutuu, jos muutos on väärin? Yksi sisäinen moduuli vai maksut ja asiakkaiden data?
- Peruttavuus: voiko muutoksen perua yhdellä revertillä tai feature flagilla, vai onko se tietokantamigraatio tai jo lähetetty sähköposti?
- Uutuus: onko tämä tuttu, toistuva muutos vai uusi arkkitehtuuripäätös?

Mitä enemmän oikealle, sitä enemmän ihmisen huomiota: tarkempi katselmointi, vaiheistettu käyttöönotto, canary-julkaisu, toinen katselmoija.

Tämä vastaa myös PR-dian kysymykseen. Mergeäisitkö lukematta? Riippuu siitä, missä kohtaa näitä janoja muutos on.
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
[30:30–31:30, sitten kysymykset]

Kolme askelta tiivistettynä:
1. Määrittele järjestelmä, älä toteutusta: tyypit, ominaisuudet ja hyväksymiskriteerit kertovat, mitä järjestelmä lupaa.
2. Eristä agentti tarkistuksesta: agentti kirjoittaa vain toteutusta, ja tarkistus ajetaan uudelleen tuoreessa kopiossa.
3. Päästä agentti irti: aitauksen sisällä agentti saa tehdä mitä haluaa.

Jos aikaa jää, paluu tyyppiosion lauseeseen: "Älä pyydä agenttia muistamaan. Tee unohtamisesta virhe." Sama pätee kaikkiin kolmeen: jokainen sovittu laki, joka on kirjoitettu tarkistukseksi, on yksi asia vähemmän, jonka agentin pitää muistaa.

Ajoitus: tähän mennessä noin 31 min. Sitten kysymykset.
-->
