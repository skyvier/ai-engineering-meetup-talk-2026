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

<p class="aside-joke">Annoin agentille neuvotteluhuoneen. En vielä tuotantotunnuksia.</p>

<img class="logo" src="/loihde-white.svg" alt="Loihde" />

<!--
[0:00–0:45]

Tervetuloa. Kaikki täällä ovat käyttäneet koodausagentteja, joten en esittele niitä.

Kysymys tänään: miten agentille voi antaa enemmän vapautta niin, että kontrolli säilyy? Vastaukseni ei ole "älä anna". Vastaus on: päätä ensin, millä hyväksyt tuloksen, ja anna vapaus sen rajan sisällä.

Vitsi (kuiva, ei odoteta naurua): "Annoin agentille neuvotteluhuoneen. En vielä tuotantotunnuksia." Siirtymä: demo on tosiaan yksi neuvotteluhuone.

Tärkeä rajaus heti alkuun: emme aja agenttia livenä. Näytän valmista koodia, tarkistuspisteitä ja tallennettuja tuloksia GitHubista.
-->

---

# Mistä tiedämme, että agentti on valmis?

<div class="cols" style="margin-top: 18px">
<div>

<span class="label-illustrative">Havainnollistus – ei oikean ajon tuloste</span>

<div class="terminal" style="margin-top: 10px">
<div><span class="prompt">agent›</span> Toteutin varauslogiikan.</div>
<div><span class="prompt">agent›</span> Lisäsin testit ja kaikki menevät läpi.</div>
<div><span class="prompt">agent›</span> Valmis! ✅</div>
</div>

</div>
<div>

<h2>Hyviä jatkokysymyksiä</h2>

- **Mitkä** testit? Kuka ne kirjoitti?
- Testaavatko ne sitä, **mitä tarkoitimme**?
- Saiko agentti muuttaa myös **testejä**?
- Ajoiko joku ne **uudelleen** ilman agenttia?

</div>
</div>

<div class="callout" style="margin-top: 26px">
"Valmis! ✅" on <strong>väite</strong>. Hyväksymiskriteeri on jotain, minkä päätimme <strong>ennen</strong> kuin delegoimme.
</div>

<!--
[0:45–2:00]

Terminaali on keksitty havainnollistus, ei oikean ajon tuloste. Sanon tämän ääneen.

Pointti: agentin raportti on hyödyllistä tietoa mutta ei hyväksymiskriteeri. Neljä kysymystä oikealla johtavat koko esityksen rakenteeseen:
- mitkä testit → mitä odotuksia on koodattu
- tarkoitus → ihmisen vastuu
- saiko muuttaa testejä → kirjoitusoikeuksien raja
- uudelleenajo → riippumaton varmennus

Siirtymä: ajatellaan hyväksyntää joukkona.
-->

---

# Rajataan hyväksyttävien ohjelmien joukkoa

<div class="cols-wide-left" style="align-items: center">
<div>
<svg class="diagram" viewBox="0 0 540 330" role="img" aria-label="Sisäkkäiset joukot: kaikki ohjelmat, sopimusta vasten kääntyvät, testit läpäisevät, sekä katkoviivalla tarkoitettu toiminta">
  <rect x="6" y="6" width="528" height="318" rx="14" fill="#F6F5F7" stroke="#C8C8CC"/>
  <text x="22" y="30" font-size="13" fill="#545459" font-weight="700">Kaikki ohjelmat</text>
  <ellipse cx="255" cy="190" rx="225" ry="122" fill="#F1EAF7" stroke="#B496CD" stroke-width="2"/>
  <text x="70" y="104" font-size="13" fill="#50375F" font-weight="700">Kääntyy sopimusta vasten</text>
  <ellipse cx="215" cy="208" rx="135" ry="82" fill="#E2D5EE" stroke="#866A9D" stroke-width="2"/>
  <text x="112" y="158" font-size="13" fill="#50375F" font-weight="700">Läpäisee testit</text>
  <ellipse cx="335" cy="215" rx="122" ry="70" fill="none" stroke="#00847F" stroke-width="2.5" stroke-dasharray="7 5"/>
  <text x="372" y="302" font-size="13" fill="#00847F" font-weight="700">Mitä tarkoitimme</text>
  <circle cx="290" cy="220" r="8" fill="#00847F"/>
  <text x="266" y="246" font-size="12" fill="#192D2D">hyväksyttävä</text>
  <circle cx="135" cy="225" r="8" fill="#F67B50"/>
  <text x="96" y="251" font-size="12" fill="#192D2D">vihreä, mutta väärä</text>
  <circle cx="415" cy="200" r="8" fill="#fff" stroke="#00847F" stroke-width="2.5"/>
  <text x="372" y="182" font-size="12" fill="#192D2D">oikein, mutta hylätään</text>
  <circle cx="470" cy="56" r="8" fill="#fff" stroke="#866A9D" stroke-width="2.5"/>
  <text x="300" y="60" font-size="12" fill="#192D2D">eri rajapinta, ei käänny</text>
</svg>
</div>
<div>

- Tyypit ja testit **eivät kirjoita** toteutusta. Ne päättävät, mitä **hyväksymme**.
- Agentin vapaus on se alue, joka **jää jäljelle**.
- Alueella on yhä **monta** ratkaisua, myös vääriä.
- Ihminen vastaa siitä, **osuvatko rajat** tarkoitukseen.

<p class="tiny" style="margin-top: 14px">Käsitteellinen malli hyväksynnästä. Ei väite siitä, että mallin generointia rajattaisiin muodollisesti.</p>

</div>
</div>

<!--
[2:00–4:00]

Tämä on esityksen pääkuva. Kerro se rauhassa.

- Ulompi laatikko: kaikki ohjelmat, joita agentti voisi kirjoittaa.
- Tyypit rajaavat: jäljelle jää se, mikä kääntyy sopimusta vasten.
- Testit rajaavat lisää: jäljelle jää se, mikä läpäisee tarkistukset.
- Katkoviiva: mitä oikeasti tarkoitimme. Se EI ole sama asia kuin "läpäisee testit".

Neljä pistettä:
- Teal: hyväksyttävä. Tätä toivomme.
- Oranssi: vihreä mutta väärä. Testit eivät kata kaikkea tarkoitettua.
- Ontto teal: oikein mutta hylätään. Testit tai tyypit voivat myös olla liian tiukkoja tai väärin.
- Ontto lila: toteutus, joka voi toimia, mutta ei käänny sopimusta vasten. Palaamme tähän PR #5:n kohdalla.

Varovaisuus: tämä on hyväksymisen malli, ei väite siitä, että kielimallin dekoodausta rajattaisiin muodollisesti. Agentti voi kirjoittaa mitä tahansa; me päätämme, mitä otamme vastaan.

Pääviesti: tyypit ja automaattiset testit rajaavat hyväksyttävien toteutusten joukkoa. Agentilla on vapaus etsiä toteutus sen sisältä. Ihminen vastaa siitä, ilmaisevatko rajat oikeat odotukset.
-->

---

# Yksi huone. Yllättävän monta sääntöä.

<svg class="diagram" viewBox="0 0 880 182" role="img" aria-label="Aikajana: first 9–10 varattu, second 10–11 vierekkäin sallittu, third 9:30–10:30 päällekkäin hylätty">
  <line x1="80" y1="156" x2="860" y2="156" stroke="#8A8A90" stroke-width="1.5"/>
  <g font-size="12" fill="#545459" text-anchor="middle">
    <line x1="80" y1="152" x2="80" y2="160" stroke="#8A8A90"/><text x="80" y="176">8:00</text>
    <line x1="275" y1="152" x2="275" y2="160" stroke="#8A8A90"/><text x="275" y="176">9:00</text>
    <line x1="470" y1="152" x2="470" y2="160" stroke="#8A8A90"/><text x="470" y="176">10:00</text>
    <line x1="665" y1="152" x2="665" y2="160" stroke="#8A8A90"/><text x="665" y="176">11:00</text>
    <line x1="860" y1="152" x2="860" y2="160" stroke="#8A8A90"/><text x="860" y="176">12:00</text>
  </g>
  <line x1="470" y1="6" x2="470" y2="150" stroke="#192D2D" stroke-width="1.5" stroke-dasharray="4 4"/>
  <g font-size="13" font-weight="700">
    <text x="0" y="35" fill="#545459">varattu</text>
    <rect x="275" y="14" width="195" height="32" rx="4" fill="#B496CD"/>
    <text x="287" y="35" fill="#fff">first  [9:00, 10:00)</text>
    <text x="0" y="81" fill="#545459">uusi</text>
    <rect x="470" y="60" width="195" height="32" rx="4" fill="#41B4AF"/>
    <text x="482" y="81" fill="#fff">second  [10:00, 11:00)</text>
    <text x="677" y="81" fill="#00847F">✓ booked – vierekkäin</text>
    <text x="0" y="127" fill="#545459">uusi</text>
    <rect x="372" y="106" width="195" height="32" rx="4" fill="#FFF3EE" stroke="#F67B50" stroke-width="2" stroke-dasharray="6 4"/>
    <text x="384" y="127" fill="#C4502A">third  [9:30, 10:30)</text>
    <text x="579" y="127" fill="#C4502A">✗ conflict – päällekkäin</text>
  </g>
</svg>

<div class="cols" style="margin-top: 8px; gap: 28px">
<div class="small">

- Puoliavoin väli `[start, end)`: alku kuuluu, loppu ei
- Ajat: safe integer -millisekunnit, `start < end`
- ID ei tyhjä, ja uniikki aktiivisten varausten kesken
- Peruutus vapauttaa sekä välin että ID:n

</div>
<div class="small">

- Epäonnistunut operaatio **ei muuta** kalenteria
- Järjestys: **validointi → ID-duplikaatti → päällekkäisyys**
- Rajattu pois: rinnakkaisuus, pysyvä tallennus, toistuvat varaukset, oikeudet, tuotantovalmius

<p class="aside-joke" style="margin-top: 8px">Enterprise-tason neuvotteluhuone. Huoneita: 1.</p>

</div>
</div>

<!--
[4:00–5:30]

Aikajana käyttää kellonaikoja luettavuuden vuoksi. Repossa ajat ovat Unix epoch -millisekunteja.

- first varaa 9–10.
- second alkaa tasan 10:00. Koska väli on puoliavoin, 10:00 ei kuulu firstille → vierekkäinen varaus on sallittu.
- third 9:30–10:30 menee päällekkäin → conflict.

Säännöt ovat README:stä. Nosta esiin yksi yllättävä: järjestys. Jos pyyntö on sekä virheellinen että duplikaatti, vastaus on "invalid". Tällainen yksityiskohta on helppo unohtaa, ja juuri sellaisen päätöksen haluamme tehdä ennen delegointia.

Rajaukset: yksi huone, peräkkäiset kutsut yhdessä prosessissa, muistissa. Ei rinnakkaisuustakuita. README sanoo erikseen, ettei repository ole atominen transaktioraja.

Vitsi: "Enterprise-tason neuvotteluhuone. Huoneita: 1." Siirtymä: miten nämä säännöt kirjoitetaan auki niin, että kone voi tarkistaa ne?
-->

---

# Sama tarkoitus, kolme ilmaisutapaa

<table>
<thead><tr><th style="width: 16%"></th><th>Gherkin</th><th>Property testing</th><th>Domain-tyypit</th></tr></thead>
<tbody>
<tr><td><strong>Kysymys</strong></td><td>Mitä tapahtuu tässä konkreettisessa tilanteessa?</td><td>Mikä sääntö pätee generoiduissa tilanteissa?</td><td>Mitä arvoja tämä rajapinta hyväksyy?</td></tr>
<tr><td><strong>Esimerkki</strong></td><td>Varaus päättyy 120:een, seuraava saa alkaa 120:stä.</td><td>Toisiaan koskettavat välit mahtuvat rinnakkain, kun ID:t eroavat.</td><td>Tallennettu varaus vaatii <code>ValidatedInterval</code>-arvon.</td></tr>
<tr><td><strong>Kieli</strong></td><td>Käyttäjän ja domainin kieli</td><td>Domainin sääntö + tarkka generaattori ja väite</td><td>Ohjelman arvot, rakenteet ja rajapinnat</td></tr>
<tr><td><strong>Hyöty</strong></td><td>Yhteinen ymmärrys, ajettavat esimerkit</td><td>Syötteiden vaihtelu, vastaesimerkkien löytäminen</td><td>Sopimuksen jatkuva tarkistus koodin muuttuessa</td></tr>
</tbody>
</table>

<div class="cols" style="margin-top: 16px">
<div class="card soft small">

**Ei jäykkä hierarkia.** Tyypit voivat ilmaista liiketoimintakäsitteitä, ja ominaisuudet voivat olla täysin toteutuksesta riippumattomia.

</div>
<div class="card soft small">

**Property vs. integraatio:** property testing kertoo, *miten* tapaukset tuotetaan. Integraatiotestaus kertoo, *mitkä* komponentit ajetaan yhdessä. Tässä demossa ne menevät päällekkäin.

</div>
</div>

<!--
[5:30–7:30]

Tämä on esityksen käsitteellinen runko. Kolme työkalua, jotka ovat eri etäisyydellä toteutuksen yksityiskohdista ja palvelevat eri tarkoituksia.

- Gherkin vastaa kysymykseen "mitä tässä tilanteessa tapahtuu". Kieli on lähellä käyttäjää.
- Property testing kysyy, mikä sääntö pätee kaikissa generoiduissa tilanteissa. Sääntö voi olla domainin, mutta generaattori ja väite ovat tarkkaa koodia.
- Tyypit kysyvät, mitä rajapinta suostuu ottamaan vastaan. Ne tarkistetaan jatkuvasti aina kun koodi muuttuu.

Älä esitä tätä hierarkiana "Gherkin ylhäällä, tyypit alhaalla". Domain-tyypit voivat olla hyvinkin liiketoiminnallisia, ja ominaisuus "vierekkäiset varaukset sallitaan" on täysin toteutuksesta riippumaton.

Sivuhuomio, joka usein sekoittuu: property testing on tapa tuottaa testitapauksia, integraatiotestaus kertoo testattavan kokonaisuuden. Demon property-testit käyttävät oikeaa muistirepositorya, joten ne ovat molempia.

Siirtymä: katsotaan kukin oikeasta reposta.
-->

---

# Gherkin: mitä käyttäjän pitäisi havaita?

<div class="cols code-sm" style="grid-template-columns: 1.05fr 1fr; gap: 16px">
<div>

```gherkin
Feature: Reserve one meeting room
  Intervals include their start and exclude their end.

  Scenario: Adjacent intervals are available
    Given booking "first" from 60 to 120 exists
    When I book "second" from 120 to 150
    Then the result is "booked"
```

<p class="src"><a href="https://github.com/skyvier/verification-driven-ai-demo/blob/98c0e1ee71cc6128aff75e1f3a083800aaded1c6/test/features/booking.feature#L1-L16">test/features/booking.feature</a> · lyhennetty (1 / 6 skenaariota)</p>

<svg class="diagram" viewBox="0 0 420 92" style="margin-top: 12px" role="img" aria-label="first 60–120 ja second 120–150 vierekkäin">
  <rect x="20" y="8" width="240" height="28" rx="4" fill="#B496CD"/>
  <text x="30" y="27" font-size="13" font-weight="700" fill="#fff">first [60, 120)</text>
  <rect x="260" y="42" width="120" height="28" rx="4" fill="#41B4AF"/>
  <text x="268" y="61" font-size="13" font-weight="700" fill="#fff">second ✓</text>
  <line x1="260" y1="2" x2="260" y2="76" stroke="#192D2D" stroke-dasharray="4 4"/>
  <g font-size="11" fill="#545459" text-anchor="middle"><text x="20" y="88">60</text><text x="140" y="88">90</text><text x="260" y="88">120</text><text x="380" y="88">150</text></g>
</svg>

</div>
<div>

<h3>Teksti ei yksin tarkista mitään</h3>

```ts
When('I book {string} from {int} to {int}',
  (id: string, start: number, end: number) => {
    result = service.book({ id, start, end }).status;
  });
Then('the result is {string}', (expected: string) => {
  assert.equal(result, expected);
});
```

<p class="src"><a href="https://github.com/skyvier/verification-driven-ai-demo/blob/98c0e1ee71cc6128aff75e1f3a083800aaded1c6/test/steps/booking.steps.ts#L12-L16">test/steps/booking.steps.ts</a> · rivitetty uudelleen</p>

<p class="small">Step-toteutukset kytkevät lauseet palveluun ja <strong>oikeaan</strong> muistirepositoryyn. Kuusi skenaariota: varaus, konflikti, vierekkäisyys, peruutus, tyhjä väli, duplikaatti-ID.</p>

</div>
</div>

<!--
[7:30–9:15]

Vasemmalla oikea skenaario reposta. Repossa skenaariot ovat englanniksi; pidän ne alkuperäisinä, koska tunnisteet ja step-lauseet täsmäävät koodiin. Suomennos ääneen: "Annettuna varaus first 60:stä 120:een, kun varaan second 120:stä 150:een, tulos on booked."

Gherkin on hyvä yhteinen kieli: tuoteomistaja voi lukea tämän ja sanoa "kyllä, näin sen pitää mennä".

Oikealla tärkeä huomio: Gherkin-teksti ei yksinään ole tarkistus. Ilman step-toteutuksia se on dokumentaatiota. Stepit kutsuvat BookingServiceä oikealla MemoryBookingRepositorylla ja vertaavat statusta.

Siirtymä: esimerkit ovat yksittäisiä pisteitä. Entä kaikki muut välit?
-->

---

# Property testing: sama sääntö monella syötteellä

```ts {1-2|4-5|9-10|11|*}
const epochMilliseconds = fc.integer({ min: 1_700_000_000_000, max: 1_700_000_010_000 });
const duration = fc.integer({ min: 1, max: 1000 });

test('a second interval is accepted exactly when it does not overlap', () => {
  fc.assert(fc.property(epochMilliseconds, duration, epochMilliseconds, duration,
    (firstStart, firstLength, secondStart, secondLength) => {
    const service = new BookingService(new MemoryBookingRepository());
    const firstEnd = firstStart + firstLength;
    const secondEnd = secondStart + secondLength;
    assert.equal(service.book({ id: 'a', start: firstStart, end: firstEnd }).status, 'booked');
    const overlaps = firstStart < secondEnd && secondStart < firstEnd;
    assert.equal(service.book({ id: 'b', start: secondStart, end: secondEnd }).status,
      overlaps ? 'conflict' : 'booked');
  }), { seed: 44, numRuns: 1000 });
});
```

<p class="src"><a href="https://github.com/skyvier/verification-driven-ai-demo/blob/98c0e1ee71cc6128aff75e1f3a083800aaded1c6/test/booking.test.ts#L13-L35">test/booking.test.ts</a> · rivitetty uudelleen</p>

<div class="cols-3" style="margin-top: 10px">
<div class="card accent"><h2>Generaattori</h2>Alut 10 sekunnin ikkunasta, kestot 1–1000 ms. Vain kelvollisia välejä.</div>
<div class="card accent"><h2>Väite</h2>Hyväksytään <em>täsmälleen</em> silloin, kun välit eivät mene päällekkäin.</div>
<div class="card teal"><h2>Otos, ei todistus</h2>1000 tapausta, kiinteä siemen 44. Muut kaksi ominaisuutta: 100 tapausta.</div>
</div>

<!--
[9:15–11:30]

Tämä on oikea testi tiedostosta test/booking.test.ts. Huom: ominaisuustestit ovat tässä tiedostossa, ei erillisessä booking.properties.test.ts-tiedostossa.

Klikkaukset korostavat osat järjestyksessä:
1. Generaattorit. Alku valitaan 10 sekunnin ikkunasta, kesto 1–1000 ms. Kapea ikkuna on tarkoituksellinen: kaksi satunnaista väliä osuvat usein päällekkäin, koskettavat tai ovat erillään, joten kaikki haarat tulevat käytyä.
2. Testin rakenne: fast-check valitsee neljä arvoa ja ajaa funktion.
3. Ensimmäinen varaus onnistuu aina tyhjään kalenteriin.
4. Väite: toinen varaus hyväksytään täsmälleen silloin, kun puoliavoimet välit eivät leikkaa.

Muut kaksi ominaisuutta samassa tiedostossa:
- "every positive interval can be booked and an overlap is rejected": sama väli kahdesti → conflict (siemen 42, oletus 100 ajoa)
- "adjacent bookings never overlap": koskettavat välit (siemen 43, 100 ajoa)

Rajoitukset ääneen: generaattorit tuottavat vain kelvollisia välejä. Virheelliset syötteet (NaN, Infinity, desimaali, tyhjä ID) katetaan esimerkkipohjaisessa integraatiotestissä, ei generoiden. Lisäksi ominaisuustesti ajaa otoksen, ei todista kaikkia tapauksia. Kiinteä siemen tekee ajosta toistettavan, mutta samalla se ajaa joka kerta saman otoksen.

Ominaisuustestin väite "overlaps"-lauseke on käytännössä toinen toteutus samasta säännöstä. Se on hyödyllinen, koska se on lyhyt ja luettava, mutta jos sääntö itse on väärin, se on väärin molemmissa.
-->

---

# Tyypit: mitä rajapinnalle saa antaa?

```ts {1-4|6-8|9-14}
/** A half-open interval in Unix epoch milliseconds. */
export interface Interval { readonly start: number; readonly end: number }
/** Untrusted request: the service must validate it before storage. */
export interface BookingRequest extends Interval { readonly id: string }

export class ValidatedInterval implements Interval {
  declare private readonly validatedIntervalBrand: void;
  private constructor(readonly start: EpochMilliseconds, readonly end: EpochMilliseconds) {}
  static create(start: EpochMilliseconds, end: EpochMilliseconds): ValidatedInterval | null {
    if (!Number.isSafeInteger(start) || !Number.isSafeInteger(end) || start >= end) return null;
    const interval = new ValidatedInterval(start, end);
    Object.freeze(interval);
    return interval;
  }
}
```

<p class="src"><a href="https://github.com/skyvier/verification-driven-ai-demo/blob/98c0e1ee71cc6128aff75e1f3a083800aaded1c6/src/booking.ts#L3-L29">src/booking.ts</a> · lyhennetty</p>

<div class="cols-3" style="margin-top: 10px">
<div class="card accent"><h2>1 · Ajonaikainen validointi</h2>toteaa arvosta faktan: päätepisteet kelpaavat ja ovat järjestyksessä.</div>
<div class="card accent"><h2>2 · Tyyppi</h2>kantaa faktan eteenpäin. Yksityinen konstruktori: muuta reittiä ei ole.</div>
<div class="card teal"><h2>3 · Rajapinta</h2>vaatii faktan. Tallennus ottaa vain validoidun välin (seuraava dia).</div>
</div>

<!--
[11:30–12:45]

Kaksi tyyppiä samasta asiasta:
- BookingRequest on raaka, epäluotettu pyyntö. Siinä on vain numeroita. book() ottaa tämän, jotta se voi palauttaa "invalid".
- ValidatedInterval on luokka, jolla on yksityinen konstruktori ja yksityinen nimellinen merkki. Rakenteellisesti samannäköinen objekti ei kelpaa.

create() tarkistaa, että molemmat päätepisteet ovat safe integereitä ja start < end, ja jäädyttää olion Object.freezellä.

Vastuunjako (tämä on dian ydin):
1. Ajonaikainen validointi toteaa faktan arvosta.
2. Tyyppi kantaa faktan seuraaviin rajapintoihin.
3. Tallennusrajapinta vaatii validoidun välin.

TypeScriptin tyypit häviävät käännöksessä. Siksi validointi on pakko tehdä ajon aikana; tyyppi vain muistaa, että se on tehty.

EpochMilliseconds on brändätty number, jonka konstruktori tarkistaa Number.isSafeInteger. Ei näy tässä, katso lähde.
-->

---

# Tyypit: tallennusraja

<div class="cols-wide-left" style="grid-template-columns: 2.15fr 1fr">
<div class="code-sm">

```ts {2-3|5-7|11}
export interface Booking {
  readonly id: string;
  readonly interval: ValidatedInterval;
}
export type BookResult =
  | { readonly status: 'booked'; readonly booking: Booking }
  | { readonly status: 'invalid' | 'conflict' | 'duplicate-id' };

export interface BookingRepository {
  list(): readonly Booking[];
  save(booking: Booking): void;
  remove(id: string): void;
}
```

<p class="src"><a href="https://github.com/skyvier/verification-driven-ai-demo/blob/98c0e1ee71cc6128aff75e1f3a083800aaded1c6/src/booking.ts#L37-L52">src/booking.ts</a> · lyhennetty</p>

```ts
// @ts-expect-error Raw requests cannot be persisted as validated bookings.
repository.save(request);
```

<p class="src"><a href="https://github.com/skyvier/verification-driven-ai-demo/blob/98c0e1ee71cc6128aff75e1f3a083800aaded1c6/test/interval.test.ts#L48-L50">test/interval.test.ts</a> · kääntäjä tarkistaa, testi ei aja</p>

<p class="small" style="margin-top: 8px">Jos tämä rivi joskus <strong>kääntyy</strong>, build kaatuu: raja on vuotanut.</p>

</div>
<div class="card soft small">

**Tyypit eivät todista** ID:n uniikkiutta eikä päällekkäisyyden puutetta. Ne riippuvat kalenterin tilasta → käyttäytymistestit.

**Pakotiet:** `as`, `any`, `@ts-ignore`. Kehote kieltää ne toteutuksessa, mutta **mikään lint-sääntö ei valvo** kieltoa.

Luotettu konstruktori käyttää itse `as`-muunnosta brändin lisäämiseen *validoinnin jälkeen*. Se on eri asia kuin validoinnin ohittaminen.

</div>
</div>

<!--
[12:45–14:00]

Kolme kohtaa, klikkaus kerrallaan:
- Booking kantaa ValidatedIntervalin. Tallennettu varaus ei voi sisältää validoimatonta väliä, ellei joku kierrä tyyppijärjestelmää.
- Onnistunut tulos sisältää varauksen. Kutsuja saa takaisin validoidun arvon.
- Repositoryn save vaatii Bookingin.

Vasen alakulma: negatiivinen käännöstarkistus. @ts-expect-error tarkoittaa: tämän rivin PITÄÄ olla tyyppivirhe. Jos se lakkaa olemasta virhe, kääntäjä valittaa käyttämättömästä direktiivistä ja build kaatuu. Funktiota ei kutsuta koskaan; tarkistus tapahtuu käännöksessä.

Oikealla rehellisyysosuus:
- Tyypit eivät kerro mitään uniikkiudesta tai päällekkäisyyksistä. Ne riippuvat tilasta.
- TypeScriptissä on pakoteitä. Toteutuskehote kieltää type assertionit, anyn ja suppression-direktiivit, mutta repossa ei ole lint-sääntöä, joka valvoisi sitä. Riippumaton varmennus ei siis automaattisesti havaitse tätä; se jää katselmoinnin varaan.
- createEpochMilliseconds tekee itse `value as EpochMilliseconds`. Se on luotettu konstruktori: tarkistus ensin, brändi sitten. Ongelma olisi, jos ehdokastoteutus tekisi saman ilman tarkistusta.
-->

---

# Kääntyy. Ei vielä toimi.

```ts
/** Validate and reserve an available interval. */
export function book(_repository: BookingRepository, _booking: BookingRequest): BookResult {
  return { status: 'invalid' }; // Deliberately incomplete for the demo.
}
```

<p class="src"><a href="https://github.com/skyvier/verification-driven-ai-demo/blob/98c0e1ee71cc6128aff75e1f3a083800aaded1c6/src/implementation/booking-service.ts">src/implementation/booking-service.ts</a> · cancel() vastaavasti</p>

<div class="cols" style="grid-template-columns: 1fr 1.3fr; align-items: center; margin-top: 12px">
<div>

<table>
<tr><td><code>npm run build</code></td><td class="ok">✓ kääntyy</td></tr>
<tr><td>käyttäytymistestit</td><td class="bad">✗ kaatuvat</td></tr>
<tr><td>osa tarkistuksista</td><td class="ok">✓ jo nyt</td></tr>
</table>

<p class="tiny">Lähtötila README:n mukaan, commit <code>98c0e1e</code>.</p>

</div>
<div class="callout teal">
Lähtöpiste: <strong>tarkistukset valmiina</strong>, toteutus tyhjä. Commit kirjataan ylös ennen delegointia.
</div>
</div>

<p class="aside-joke" style="margin-top: 14px">TypeScript hyväksyi. Huonetta ei silti saa.</p>

<!--
[14:00–15:00]

Tämä on tarkistuspiste, josta delegointi alkaa. Kaikki edellä nähty on olemassa ennen kuin agentti kirjoittaa riviäkään.

README kuvaa tilan: build menee läpi, käyttäytymistestit kaatuvat, osa yksittäisistä tarkistuksista menee jo läpi.

Koodin perusteella (en ajanut tätä esityksen valmistelussa): esimerkiksi skenaario "An empty interval is invalid" menee jo läpi, koska stub vastaa kaikkeen "invalid". Myös konstruktoritestit menevät läpi, koska konstruktorit ovat valmiina. Tämä on hyvä muistutus: vihreä yksittäinen testi ei kerro, että toteutus on olemassa.

Jos haluat näyttää tallennetun ajon, ota kuvakaappaus omasta ajosta etukäteen. Ei live-ajoa.

Vitsi: "TypeScript hyväksyi. Huonetta ei silti saa."
-->

---

# Sopimus pysyy, toteutus saa muuttua

<svg class="diagram" viewBox="0 0 880 262" role="img" aria-label="Kolme kopiota: lähtötila, työtila ja tarkistuskopio">
  <defs>
    <marker id="arr" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto-start-reverse"><path d="M0,0 L10,5 L0,10 z" fill="#50375F"/></marker>
  </defs>
  <rect x="8" y="30" width="250" height="160" rx="10" fill="#fff" stroke="#50375F" stroke-width="2.5"/>
  <text x="24" y="58" font-size="16" font-weight="900" fill="#50375F">1 · Lähtötila</text>
  <g font-size="13" fill="#1A1A1D"><text x="24" y="84">luotettu kopio tarkistuspisteestä</text><text x="24" y="104">git archive HEAD</text><text x="24" y="132" fill="#545459">sopimukset · testit · konfiguraatio</text><text x="24" y="160" fill="#00847F" font-weight="700">ei agentin kirjoitettavissa</text></g>
  <rect x="315" y="30" width="250" height="160" rx="10" fill="#F1EAF7" stroke="#B496CD" stroke-width="2.5"/>
  <text x="331" y="58" font-size="16" font-weight="900" fill="#50375F">2 · Työtila</text>
  <g font-size="13" fill="#1A1A1D"><text x="331" y="84">Codex toteuttaa tässä</text><text x="331" y="110" font-weight="700">kirjoitus: src/implementation/</text><text x="331" y="128" font-weight="700">kirjoitus: dist/</text><text x="331" y="150" fill="#545459">kaikki muu: vain luku</text><text x="331" y="170" fill="#545459">verkko pois</text></g>
  <rect x="622" y="30" width="250" height="160" rx="10" fill="#fff" stroke="#00847F" stroke-width="2.5"/>
  <text x="638" y="58" font-size="16" font-weight="900" fill="#00847F">3 · Tarkistuskopio</text>
  <g font-size="13" fill="#1A1A1D"><text x="638" y="84">tuore lähtötila</text><text x="638" y="104">+ ehdokkaan src/implementation/</text><text x="638" y="132" font-weight="700">npm test</text><text x="638" y="152" fill="#545459">verkko pois · vain dist/</text><text x="638" y="170" fill="#545459">kirjoitettava</text></g>
  <line x1="260" y1="92" x2="312" y2="92" stroke="#50375F" stroke-width="2" marker-end="url(#arr)"/>
  <text x="286" y="84" font-size="12" text-anchor="middle" fill="#545459">kopio</text>
  <line x1="567" y1="92" x2="619" y2="92" stroke="#50375F" stroke-width="2" marker-end="url(#arr)"/>
  <text x="593" y="20" font-size="12" text-anchor="middle" fill="#50375F" font-weight="700">vain toteutus siirtyy</text>
  <line x1="593" y1="24" x2="593" y2="84" stroke="#C8C8CC" stroke-dasharray="3 3"/>
  <path d="M133 192 V230 H747 V194" fill="none" stroke="#50375F" stroke-width="2" marker-end="url(#arr)"/>
  <text x="440" y="252" font-size="12" text-anchor="middle" fill="#545459">tuore kopio lähtötilasta: agentin muutokset testeihin eivät voi kulkea tätä reittiä</text>
</svg>

<div class="cols" style="margin-top: 6px">
<p class="small" style="margin: 0">Varmentaja ajaa <strong>lähtötilan</strong> tarkistukset ehdokasta vastaan. Agentin oma "testit menevät läpi" ei ratkaise.</p>
<p class="small" style="margin: 0">Raja: ehdokaskoodi ajetaan <strong>samassa prosessissa</strong> kuin testit. Demo rajoista, ei suojaus vihamielistä koodia vastaan.</p>
</div>

<!--
[15:00–17:00]

Näytä arkkitehtuuri, älä shell-skriptejä.

1. Lähtötila: scripts/run-demo.sh tekee git archive -kopion committed HEADistä. Tämä on luotettu kopio. Se on agentin kirjoitusoikeuksien ulkopuolella.
2. Työtila: kopio lähtötilasta. Codex ajetaan nimetyllä permission-profiililla: kirjoitus vain src/implementation/ ja dist/, kaikki muu luettavissa, verkko pois, hyväksyntäpyynnöt pois päältä.
3. Tarkistuskopio: verify-candidate.sh kopioi lähtötilan tuoreeseen hakemistoon, korvaa src/implementation/-hakemiston ehdokkaan versiolla ja ajaa npm test omassa sandboxissaan (vain dist/ kirjoitettava, verkko pois). Symlinkit ja muut erikoistiedostot hylätään.

Miksi kolme kopiota eikä yksi? Koska silloin ei tarvitse luottaa siihen, että agentti jätti testit rauhaan. Vaikka työtilan testit muuttuisivat, tarkistus ajetaan alkuperäisillä.

Rajat ääneen (README sanoo nämä itse):
- Ehdokaskoodi ajetaan samassa prosessissa kuin testit. Se voisi esimerkiksi lopettaa testiprosessin aikaisin tai muokata generoituja testejä dist/-hakemistossa.
- Tämä on paikallinen demo rajoista, ei kovennettu sandbox vihamielistä koodia vastaan.
- Ja kyllä: tämä on aivan liikaa infrastruktuuria kahden metodin ominaisuudelle. Siihen palataan.
-->

---

# Toteutus läpäisi sovitut tarkistukset

<div class="code-sm">

```ts {2-7|8-12|13-15}
export function book(repository: BookingRepository, booking: BookingRequest): BookResult {
  const { id, start, end } = booking;
  if (typeof id !== 'string' || id.length === 0) return { status: 'invalid' };
  const validatedStart = createEpochMilliseconds(start);
  const validatedEnd = createEpochMilliseconds(end);
  if (validatedStart === null || validatedEnd === null) return { status: 'invalid' };
  const interval = createInterval(validatedStart, validatedEnd);
  if (interval === null) return { status: 'invalid' };
  const existingBookings = repository.list();
  if (existingBookings.some(existing => existing.id === id)) return { status: 'duplicate-id' };
  if (existingBookings.some(existing =>
    interval.start < existing.interval.end && existing.interval.start < interval.end
  )) return { status: 'conflict' };
  const validatedBooking: Booking = { id, interval };
  repository.save(validatedBooking);
  return { status: 'booked', booking: validatedBooking };
}
```

<p class="src"><a href="https://github.com/skyvier/verification-driven-ai-demo/blob/9e1586fa4814394f4903cebb7ace020a0b77edff/src/implementation/booking-service.ts#L5-L27">PR #3 · src/implementation/booking-service.ts</a> · tyhjät rivit ja kommentti poistettu</p>

</div>

<div class="cols-4" style="margin-top: 10px; align-items: center">
<div><span class="reported">PR #3:n raportoima</span><p class="tiny" style="margin-top: 6px">Riippumaton varmennus tuoreessa lähtötilassa. Ei ajettu uudelleen tätä esitystä varten.</p></div>
<div><div class="stat">6</div><div class="stat-label">hyväksymisskenaariota</div></div>
<div><div class="stat">4</div><div class="stat-label">property/integraatiotestiä</div></div>
<div><div class="stat">4</div><div class="stat-label">konstruktoritestiä</div></div>
</div>

<!--
[17:00–18:30]

PR #3 (head 9e1586f): Codex-toteutus rajatussa työtilassa. Muutos koskee yhtä tiedostoa, src/implementation/booking-service.ts. Sopimukset ja testit ovat ennallaan.

Kolme kohtaa koodissa:
1. Validointi ensin, olemassa olevilla konstruktoreilla. Ei type assertioneita.
2. Sitten duplikaatti-ID, sitten päällekkäisyys. Juuri sovitussa järjestyksessä.
3. Tallennetaan Booking, jossa on ValidatedInterval, ja palautetaan se.

Tulokset ovat PR #3:n kuvauksen raportoimia: riippumaton varmennus läpäisi 6 hyväksymisskenaariota, 4 property/integraatiotestiä ja 4 konstruktoritestiä. Sanon ääneen: en ajanut näitä uudelleen esityksen valmistelussa; luen PR:n tallennettua tulosta.

PR:n omat rajaukset: tarkistukset kattavat peräkkäisen, yhden huoneen käyttäytymisen. Ei rinnakkaisuus- eikä pysyvyystakuita.

Siirtymä: tämä toimi, kun kaikki rajat olivat paikallaan. Mitä tapahtuu, jos niitä poistetaan?
-->

---

# Entä jos rajoja poistetaan?

<div class="cols-4" style="margin-top: 6px">
<div class="card accent">
<p class="kicker">PR #4</p>
<h2>Täysi kirjoitusoikeus</h2>
<p class="muted">Kaikki tarkistukset saatavilla, tiedostot kirjoitettavissa, sandbox pois.</p>
<p>Säilytti tarkistukset, lisäsi 6 esimerkkitestiä.</p>
<p class="ok">Läpäisi palautetun alkuperäisen sarjan.</p>
</div>
<div class="card accent" style="border-top-color: var(--l-red)">
<p class="kicker">PR #5</p>
<h2>Ei valmiita domain-tyyppejä</h2>
<p class="muted">Sopimukset, käännöstarkistukset ja konstruktoritestit poistettu.</p>
<p>Loi omat tyypit, läpäisi jäljelle jääneet tarkistukset.</p>
<p class="bad">Ei käänny alkuperäisiä sopimuksia vasten.</p>
</div>
<div class="card accent">
<p class="kicker">PR #6</p>
<h2>Ei property-testejä</h2>
<p class="muted">Kolme generoitua tarkistusta poistettu, muut jäljellä.</p>
<p>Lisäsi 5 esimerkkitestiä.</p>
<p class="ok">Läpäisi palautetun sarjan ominaisuuksineen.</p>
</div>
<div class="card accent">
<p class="kicker">PR #7</p>
<h2>Ei hyväksymistestejä</h2>
<p class="muted">Gherkin-skenaariot ja niiden ajokomento poistettu.</p>
<p>Lisäsi 5 esimerkkitestiä.</p>
<p class="ok">Läpäisi palautetun sarjan skenaarioineen.</p>
</div>
</div>

<div class="callout" style="margin-top: 16px; font-size: 15px">
<strong>Yksi ajo per asetelma.</strong> Ei tilastollisia eikä kausaalisia johtopäätöksiä. Asetelmat eivät ole täysin kontrolloituja: PR #5 muutti useita asioita kerralla.
</div>

<p class="tiny" style="margin-top: 6px">Tulokset PR-kuvauksista; testimäärät laskettu PR-haarojen tiedostosta <code>test/booking.test.ts</code>. Ei ajettu uudelleen.</p>

<!--
[18:30–20:30]

Neljä vertailuajoa. Vältä voittaja/häviäjä-kehystä; tämä ei ole benchmark.

- PR #4, täysi kirjoitusoikeus: agentti olisi voinut heikentää testejä. Se ei tehnyt niin tässä ajossa: alkuperäiset tarkistukset säilyivät ja se lisäsi kuusi omaa esimerkkitestiä. Riippumaton ajo palautettua alkuperäistä sarjaa vastaan meni läpi. Täysi kirjoitusoikeus luo MAHDOLLISUUDEN, ei näyttöä huijaamisesta.
- PR #6 ja #7: kun property- tai hyväksymistestit poistettiin, agentti kirjoitti esimerkkitestejä ja toteutus läpäisi silti palautetut alkuperäiset tarkistukset. Yhdessä ajossa ei siis havaittu regressiota. Tämä ei tarkoita, että tarkistukset olisivat turhia; ne myös menevät päällekkäin siinä, mitä ne rajaavat.
- PR #5 on kiinnostavin, koska tulos ei ole "läpi" tai "ei läpi" vaan "eri sopimus". Seuraava dia.

Rajoitukset ääneen: yksi ajo per skenaario, ei tilastoja, ei kausaalisuutta. PR #5 muutti useita asioita samaan aikaan, joten eroja ei voi pistää pelkästään tyyppien poistamisen tiliin. Lisätietoa varadialla.

Lisättyjen testien määrät (6, 5, 5) laskin PR-haarojen test/booking.test.ts-tiedostosta. PR #6:n ja #7:n kuvaukset sanovat myös viisi.
-->

---

# Testit vihreänä, sopimus eri

<div class="cols code-sm" style="gap: 18px">
<div>
<h3>Alkuperäinen sopimus</h3>

```ts
export interface Booking {
  readonly id: string;
  readonly interval: ValidatedInterval;
}
export type BookResult =
  | { readonly status: 'booked';
      readonly booking: Booking }
  | { readonly status:
      'invalid' | 'conflict' | 'duplicate-id' };
// save(booking: Booking): void
```

<p class="src"><a href="https://github.com/skyvier/verification-driven-ai-demo/blob/98c0e1ee71cc6128aff75e1f3a083800aaded1c6/src/booking.ts#L37-L52">main · src/booking.ts</a> · muotoiltu uudelleen</p>
</div>
<div>
<h3>PR #5: agentin oma sopimus</h3>

```ts
export interface Booking {
  readonly id: string;
  readonly start: number;
  readonly end: number;
}
export type BookingResult =
  | { readonly status: 'booked' }
  | { readonly status: 'invalid' }
  | { readonly status: 'duplicate-id' }
  | { readonly status: 'conflict' };
```

<p class="src"><a href="https://github.com/skyvier/verification-driven-ai-demo/blob/c2244f3200affef3bce5c501fe50f0a128e7b7a5/src/booking.ts#L1-L21">PR #5 · src/booking.ts</a> · lyhennetty</p>
</div>
</div>

<div class="cols-3 small" style="margin-top: 6px">
<div class="card soft">Onnistunut tulos ei enää sisällä <strong>varausta</strong>.</div>
<div class="card soft">Tallennettu varaus kantaa <strong>numeroita</strong>, ei validoitua väliä.</div>
<div class="card soft">Palvelu validoi, mutta <strong>tallennusrajapinta</strong> ei vaadi sitä.</div>
</div>

<div class="callout" style="margin-top: 10px; font-size: 15.5px">
Tyypit voivat koodata suunnittelupäätöksiä ja luottamusrajoja, joita käytettävissä olleet <strong>käyttäytymistestit eivät ilmaise</strong>.
</div>

<!--
[20:30–23:00]

Tämä on esityksen tärkein tekninen havainto. Anna sille aikaa.

PR #5:n asetelma: domain-sopimukset, käännöstarkistukset ja konstruktoritestit poistettiin; hyväksymisskenaariot ja property/integraatiotestit jäivät. Agentti kirjoitti omat tyyppinsä.

Ensin reilu kuvaus: agentti toteutti validoinnin. Sen parseBooking tarkistaa, että ID on ei-tyhjä merkkijono, päätepisteet safe integereitä ja start < end. book() ottaa vastaan jopa unknown-tyypin, mikä on ajonaikaisesti varovainen valinta. Tämä ei ole "huono toteutus ilman validointia".

Mutta kolme asiaa on eri:
1. Onnistunut tulos on vain { status: 'booked' }. Alkuperäinen palautti varauksen.
2. Tallennettu varaus sisältää paljaat start- ja end-numerot. Validoinnin fakta ei kulje arvon mukana.
3. Repository.save ottaa minkä tahansa Bookingin. Jos joku toinen koodipolku tallentaa suoraan, mikään tyyppi ei vaadi validointia. Takuu ei ole kadonnut toteutuksesta, mutta se ei enää näy rajapinnassa.

Jäljelle jääneet testit tarkistivat statuksia, konflikteja ja tilaa. Ne eivät huomanneet näitä eroja, koska ne eivät kysyneet niistä.

Kun alkuperäiset täydet tarkistukset palautetaan, tulos on käännösvirhe. Se näyttää, että sopimus on eri. Se EI anna täydellistä käyttäytymisarviota, koska testit eivät edes käänny.

Älä väitä, että vaihtoehto olisi yleisesti huonompi. Se ilmaisee eri asioita. Kysymys on: kumpi ilmaisee sen, mitä me halusimme?

Liittyy dian 3 kuvaan: "eri rajapinta, ei käänny".
-->

---

# Mitä vihreä tulos ei kerro?

<div class="cols" style="margin-top: 8px; gap: 16px">
<div class="card accent"><h2>Ovatko vaatimukset oikeat?</h2>Testit tarkistavat sen, mitä kirjoitimme. Eivät sitä, mitä olisi pitänyt kirjoittaa.</div>
<div class="card accent"><h2>Mitä ei ole katettu?</h2>Rinnakkaisuus, pysyvä tallennus, aikavyöhykkeet. Generaattorit tuottavat vain kelvollisia välejä.</div>
<div class="card accent"><h2>Luotammeko suoritukseen?</h2>Ehdokaskoodi ajetaan samassa prosessissa kuin testit. Pakoteitä ei valvo lint.</div>
<div class="card accent"><h2>Onko tämä tuotantoa?</h2>Ei. Muistissa, yksi huone, yksi prosessi. Tuotantovalmiutta ei väitetä.</div>
</div>

<div class="callout teal" style="margin-top: 20px">
Kyllä, tämä on <strong>paljon infrastruktuuria yhdelle huoneelle</strong>. Pieneen oikeaan tehtävään kaikki nämä mekanismit eivät olisi järkeviä.
</div>

<!--
[23:00–24:00]

Nopea rehellisyyskierros. Vihreä tarkoittaa: koodatut odotukset täyttyivät. Ei enempää.

- Vaatimukset: jos sääntö itse on väärin, kaikki tarkistukset ovat väärin samalla tavalla.
- Kattavuus: rajauksen ulkopuoliset asiat eivät ole testattuja. Property-generaattorit tuottavat vain kelvollisia välejä.
- Luottamus suoritukseen: ehdokas ajetaan samassa prosessissa kuin testit, ja kielletyt TypeScript-pakotiet nojaavat kehotteeseen ja katselmointiin.
- Tuotanto: ei väitetä.

Ja se ilmeinen: kolme kopiota, sandbox-profiilit, Gherkin, fast-check ja nimelliset tyypit kahden metodin ominaisuudelle on ylimitoitettua. Demo on tarkoituksella yksinkertainen, jotta mekanismit näkyvät. Oikeassa työssä mekanismit valitaan riskin mukaan.
-->

---
class: brand
---

<div class="arrow">↗</div>

# Mitä haluat päättää ennen delegointia?

<ul class="big-questions">
<li><span>1</span>Mitä pitää tapahtua?</li>
<li><span>2</span>Mitä ei saa tapahtua?</li>
<li><span>3</span>Millä hyväksymme tuloksen?</li>
</ul>

<p style="margin-top: 22px; font-size: 18px">Mekanismit <strong>riskin mukaan</strong>, ei kaikkea kaikkialle.</p>

<p style="margin-top: 18px; font-size: 15px">Demo: <a href="https://github.com/skyvier/verification-driven-ai-demo">github.com/skyvier/verification-driven-ai-demo</a></p>

<p class="aside-joke">Kiitos. Kysymyksiä?</p>

<img class="logo" src="/loihde-white.svg" alt="Loihde" />

<!--
[24:00–25:00, sitten kysymykset]

Kolme kysymystä, joihin kannattaa vastata ennen kuin agentti saa vapauden:
1. Mitä pitää tapahtua? → esimerkit ja säännöt.
2. Mitä ei saa tapahtua? → negatiiviset tapaukset, rajat, kirjoitusoikeudet.
3. Millä hyväksymme tuloksen? → riippumaton varmennus, ja ihminen arvioi, mitä näyttö kertoo ja mitä jää tuntemattomaksi.

Viisi vaihetta tiivistettynä: tarkoitus → odotukset ajettaviksi tarkistuksiksi → selkeä toteutusraja → riippumaton varmennus → arvio siitä, mitä näyttö osoittaa.

Mekanismit riskin mukaan: pieneen tehtävään riittää vähemmän, kriittiseen tarvitaan enemmän.

Ajoitus: tähän mennessä noin 25 min. Puskuria noin 2 min ennen kysymyksiä.
-->

---

# Varadia: lähteet

<p class="kicker">Repository: skyvier/verification-driven-ai-demo</p>

<table class="small">
<tr><th>Mikä</th><th>Commit</th><th>Huom.</th></tr>
<tr><td>Lähtötila (main)</td><td><a href="https://github.com/skyvier/verification-driven-ai-demo/tree/98c0e1ee71cc6128aff75e1f3a083800aaded1c6"><code>98c0e1e</code></a></td><td>Tarkoituksella keskeneräinen palvelu</td></tr>
<tr><td>PR #1 Verification-ready demo</td><td><a href="https://github.com/skyvier/verification-driven-ai-demo/pull/1"><code>32ed407</code></a></td><td>Alkuperäinen tarkistuspiste</td></tr>
<tr><td>PR #2 Isolated verification</td><td><a href="https://github.com/skyvier/verification-driven-ai-demo/pull/2"><code>7bba1b1</code></a></td><td>Kolmen kopion arkkitehtuuri (mergetty)</td></tr>
<tr><td>PR #3 Sandboxed implementation</td><td><a href="https://github.com/skyvier/verification-driven-ai-demo/pull/3"><code>9e1586f</code></a></td><td>Valmis toteutus, älä sekoita mainiin</td></tr>
<tr><td>PR #4 Full write access</td><td><a href="https://github.com/skyvier/verification-driven-ai-demo/pull/4"><code>03cff4e</code></a></td><td>+6 testiä</td></tr>
<tr><td>PR #5 No predefined types</td><td><a href="https://github.com/skyvier/verification-driven-ai-demo/pull/5"><code>c2244f3</code></a></td><td>Setup <code>18f02b0</code> + toteutus</td></tr>
<tr><td>PR #6 No property tests</td><td><a href="https://github.com/skyvier/verification-driven-ai-demo/pull/6"><code>7bbb1bd</code></a></td><td>Setup <code>e554bc4</code>, +5 testiä</td></tr>
<tr><td>PR #7 No acceptance tests</td><td><a href="https://github.com/skyvier/verification-driven-ai-demo/pull/7"><code>3d57b49</code></a></td><td>Setup <code>8e29564</code>, +5 testiä</td></tr>
</table>

<p class="tiny" style="margin-top: 8px">Refit tarkistettu 3.11.2026. Koodiotteet luettu näistä commiteista. Tulokset ovat PR-kuvausten raportoimia; demoa ei ajettu uudelleen esitystä varten.</p>

<!--
Varadia, ei esitetä normaalisti.

Mitä tätä esitystä varten tehtiin:
- Repon nykyiset refit tarkistettiin 3.11.2026. main = 98c0e1e (sama kuin aiemmin tarkasteltu lähtötila). PR #3 head = 9e1586f (sama kuin aiemmin tarkasteltu).
- Koodiotteet on luettu suoraan näistä commiteista. Osa on rivitetty tai lyhennetty, mikä on merkitty lähdeviitteeseen.
- PR-kuvausten tulokset luettiin GitHubista. Demoa ei ajettu uudelleen.

Inspiraatio: aiempi "Encoding Intent" -esitys (tyypit rajaavat ohjelmien joukkoa; ajonaikainen validointi toteaa faktan, jonka tyyppi kantaa luottamusrajan yli). Sen Haskell/GDP-esimerkit on jätetty tästä pois.
-->

---

# Varadia: vertailun rajoitukset

<div class="cols small" style="gap: 20px">
<div>

<h3>Kaikki vertailut</h3>

- **Yksi ajo** per asetelma. Ei tilastoja, ei kausaliteettia.
- Tarkistukset menevät **päällekkäin** siinä, mitä ne rajaavat. Yhden poistaminen ei välttämättä näy.
- Täysi kirjoitusoikeus (PR #4) loi **mahdollisuuden** heikentää testejä, ei näyttöä siitä.
- PR #4: kääreskriptin lokitusvirhe esti Codex-prosessin exit-statuksen tallennuksen. Toteutus ja riippumaton varmennus ovat silti saatavilla.

</div>
<div>

<h3>PR #5 erityisesti</h3>

- Setup-commit muutti **useita asioita**: sopimukset, käännöstarkistukset, konstruktoritestit, stubin sijainnin ja test-skriptin.
- `IMPLEMENTATION_AGENT_PROMPT.md`, `AGENTS.md` ja README muuttuvat **toteutuscommitissa** `c2244f3`, eivät setupissa. Setup-hetken kehote viittasi yhä `ValidatedInterval`-tyyppiin, jota ei enää ollut.
- Historiasta ei näe, tekikö muutokset agentti vai operaattori.
- → Ei "sama kehote, yksi muuttuja" -koe.

</div>
</div>

<!--
Varadia kysymyksiä varten.

PR #5:n kehotemuutos: alkuperäinen ohje "Convert raw BookingRequest input into a Booking containing a ValidatedInterval using the existing constructors" korvattiin muotoon "Validate unknown booking input before it reaches the repository". Muutos on toteutuscommitissa c2244f3. Setup-commit 18f02b0 ei koskenut kehotteeseen, joten agentin saamassa kehotteessa luultavasti viitattiin tyyppeihin, joita ei enää ollut. Tarkista tämä ennen kuin sanot sen ääneen varmana; commit-historia ei kerro, kuka muutoksen teki.

PR #4:n lokitusvirhe: wrapper ei tallentanut Codexin exit-statusta shell-muuttujavirheen takia agentin viimeisen vastauksen jälkeen (PR:n kuvauksen mukaan).
-->
