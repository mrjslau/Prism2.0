# Prism2.0
Ruby/Ruby on Rails university project for Agile Development course 2018 .

### Prerequisites
Ruby 2.5.x ---- Rails 5.1.6 ---- Bundler 1.16.x

## Rails :
### Getting started

To get started with the app, clone the repo and then install the needed gems:

```
$ bundle install --without production
```

Next, migrate the database:

```
$ rails db:migrate
```

Finally, run the test suite to verify that everything is working correctly:

```
$ rails test
```

If the test suite passes, you'll be ready to run the app in a local server:

```
$ rails server
```

## Ruby :
### Run UI
```
ruby lib/ui.rb
```

### Running
Install all gems:
```
bundle install
```
Run rspec tests:
```
rspec
```
Style guide check:
```
rubocop
```
Run reek for code smells:
```
reek
```
Run Mutant:
Main classes:
```
bundle exec mutant --include lib --use rspec Building City Identity Location Map Neighborhood Person Pet Phone Police TrafficLight Vehicle
```
All classes:
```
bundle exec mutant --include lib --use rspec Ambulance Brigade Building City Drone GateBarrier Identity Intersection Location Map Neighborhood Notification Person Pet Phone Police TrafficLight User Vehicle
```
Test coverage:
/coverage/index.html


### Užduoties tema:
Miesto stebėjimo sistema

### Sistemos esybės:
1.  Miestas 
2.  Vartotojas
3.  Žemėlapis
4.  Rajonas
5.  Teritorija
6.  Asmuo
7.  Automobilis
8.  Telefonas
9.  Gyvūnas
10. Pastatas
11. Lokacija
12. Tiltas
13. Bollard’as
14. Šviesoforas
15. Sankryža
16. Švieslentė
17. Užkarda
18. Greičio matuoklis
19. Sirena
20. Banko sąskaita
21. Bankomatas
22. Pagalbos tarnyba 
23. Vaizdo kamera 
24. Daviklis
25. Išmanusis prietaisas
26. Apsaugos sistema

### Sistemos savybės:
// Sistema naudosis dviejų tipų asmenys: administratoriai ir darbuotojai.  
// Administratorius gali atlikti viską tą patį, ką ir darbuotojas gali.  
[User] - darbuotojas  
[Admin] - administratorius  
[System] - sistema  

	1)   [User]   Prisijungti prie sistemos
	2)   [Admin]  Prisijungti prie sistemos kaip administratorius
	3)   [User]   Pasiekti žemėlapį, rodantį viską vykstančio mieste
	4)   [User]   Pasirinkti rajoną, kurį nori stebėti
	5)   [User]   Pamatyti mieste esančių asmenų sąrašą
	6)   [User]   Surasti asmens dabartinę lokaciją
	7)   [User]   Surasti automobilio dabartinę lokaciją
	8)   [User]   Surasti gyvūno dabartinę lokaciją
	9)   [User]   Filtruoti konkrečioje teritorijoje esančių asmenis
	10)  [User]   Filtruoti konkrečioje teritorijoje esančių automobilių sąrašą
	11)  [User]   Filtruoti konkrečioje teritorijoje esančius gyvūnus
	12)  [User]   Atvaizduoti pasirinktame rajone esančių tiltų sąrašą
	13)  [User]   Atvaizduoti pasirinktame rajone esančių kylančių bollard sąrašą
	14)  [User]   Atvaizduoti pasirinktame rajone esančių šviesoforų sąrašą
	15)  [User]   Atvaizduoti pasirinktame rajone esančių švieslenčių sąrašą
	16)  [User]   Atvaizduoti pasirinktame rajone esančių užkardų sąrašą (šlagbaumų)
	17)  [User]   Atvaizduoti pasirinktame rajone esančių greičio matuoklių sąrašą
	18)  [User]   Atvaizduoti pasirinktame rajone esančių sirenų sąrašą
	19)  [User]   Pamatyti automobilio valstybinį numerį
	20)  [User]   Pamatyti sąrašą asmenų gyvenančių pastatuose duomenis
	21)  [User]   Gauti automobilio savininko duomenis
	22)  [User]   Gauti informaciją apie automobilį pagal valstybinį automobilio numerį
	23)  [User]   Gauti informaciją kas vairuoja automobilį
	24)  [Admin]  Pamatyti nuteistųjų sąrašą pasirinktame rajone
	25)  [User]   Gauti ieškomų/dingusių žmonių sąrašą pasirinktame rajone
	26)  [User]   Gauti taksi automobilių sąrašą mieste
	27)  [User]   Gauti taksi automobilių koordinates mieste
	28)  [User]   Gauti duomenis apie taksi vairuotojus (asm. duom., teistumas)
	29)  [Admin]  Pakelti/nuleisti pasirinktą miesto tiltą
	30)  [Admin]  Pakelti/nuleisti pasirinktą kilnojantį bollard’ą
	31)  [Admin]  Įjungti/išjungti pasirinktą šviesoforą
	32)  [Admin]  Įjungti/išjungti pasirinktą švieslentę
	33)  [Admin]  Įkelti vaizdo įrašą/paveikslėlį, kad rodytų per pasirinktą švieslentę
	34)  [Admin]  Pakelti/nuleisti pasirinktą užkardą
	35)  [Admin]  Įjungti/išjungti pasirinktą sireną
	36)  [User]   Sužinoti gyvūno savininką
	37)  [User]   Sužinoti ar gyvūnas yra pavojingas
	38)  [User]   Iškviesti policiją į pažymėtą vietą žemėlapyje
	39)  [User]   Iškviesti medikus į pažymėtą vietą žemėlapyje
	40)  [User]   Iškviesti gaisrinę į pažymėtą vietą žemėlapyje
	41)  [Admin]  Prisijungti prie miesto kamerų
	42)  [Admin]  Prisijungti prie parduotuvių kamerų
	43)  [Admin]  Prisijungti prie bankomatų kamerų
	44)  [User]   Patikrinti pastato savininką
	45)  [Admin]  Patikrinti ar pastate yra apsaugos sistema
	46)  [Admin]  Išjungti/įjungti pastato apsaugos sistemą
	47)  [User]   Žemėlapyje matyti, kokia temperatūra yra tam tikrose miesto vietose
	48)  [Admin]  Pasiekti asmens išmaniųjų prietaisų duomenis (fitbit, etc.)
	49)  [User]   Stebėti pagalbos tarnybų ekipažų judėjimą
	50)  [User]   Gauti informaciją apie pagalbos tarnybas
	51)  [User]   Susisiekti su pagalbos tarnyba
	52)  [Admin]  Prisijungti prie kamerų automobiliuose (dashcam) 
	53)  [Admin]  Sustabdyti automobilį
	54)  [Admin]  Užblokuoti/atblokuoti bankomatą 
	55)  [Admin]  Užblokuoti/atblokuoti bankinę sąskaitą
	56)  [Admin]  Pervesti pinigus iš/į pasirinktą banko sąskaitą
	57)  [Admin]  Prisijungti prie gyventojo telefono
	58)  [Admin]  Klausytis gyventojo telefono mikrofono įrašomo garso
	59)  [Admin]  Matyti gyventojo telefono kameros rodomą vaizdą
	60)  [Admin]  Pakeisti degančią šviesą pasirinktame šviesofore
	61)  [User]   Gauti pasirinktame rajone esančių gatvės žibintų sąrašą
	62)  [Admin]  Įjungti/išjungti pasirinktą gatvės žibintą
	63)  [User]   Gauti pasirinktame rajone esančių dronų sąrašą
	64)  [Admin]  Išjungti/įjungti pasirinktą droną
	65)  [Admin]  Gauti gyvą transliaciją pasirinktos greičio kameros
	66)  [Admin]  Išjungti/įjungti pasirinktą greičio kamerą
	67)  [User]   Gauti pasirinktame rajone esančių autobusų stotelių sąrašą
	68)  [Admin]  Išjungti/įjungti apšvietimą pasirinktoje autobusų stotelėje
	69)  [Admin]  Gauti pasirinktame rajone esančių elektros skydinių sąrašą
	70)  [System] Atpažinti ar automobilio vairuotojas yra automobilio savininkas
	71)  [System] Aptikti ar šalia gyvūno yra jo savininkas
	72)  [System] Atpažinti ar vairuotojas turi teisę vairuoti
	73)  [Admin]  Pasiklausyti žmogaus pokalbio telefonu
	74)  [Admin]  Perskaityti žmogaus pranešimus telefone
	75)  [Admin]  Blokuoti žmogaus telefono ryšį
	76)  [User]   Gauti pastate esančių žmonių sąrašą 
	77)  [System] Rodomas įspėjamasis pranešimas, kad tam tikroje vietoje vyksta neįprasti temperatūros pokyčiai
	78)  [System] Į vietą, kur vyksta neįprasti temperatūros pokyčiai, pasiųsti apžvalgos droną
	79)  [User]   Peržiūrėti dėl temperatūros pokyčių įtartinoje vietoje esančių kamerų rodomą vaizdą
	80)  [User]   Iškviesti skubiąsias tarnybas į dėl temperatūros pokyčių įtartiną vietą
	81)  [System] Automatiškai iškviečia priešgaisrinės tarnybos komandą į vietą, kur temperatūra pakilo virš normos
	82)  [System] Automatiškai iškviečia greitosios pagalbos komandą į vietą, kur temperatūra pakilo virš normos
	83)  [System] Automatiškai iškviečia policijos komandą į vietą, kur temperatūra pakilo virš normos
	84)  [System] Žemėlapyje rodyti, kur vyksta netikėti temperatūros pokyčiai
	85)  [System] Žemėlapyje rodyti, iš kurių vietų galima dabar gauti kokybišką garso atvaizdą
	86)  [System] Žemėlapyje rodyti, kurios vietos yra gerai matomos miesto kamerų ir kurios ne
	87)  [System] Žemėlapyje rodyti, kuriose vietose dabar yra skirtingi policijos patruliai
	88)  [System] Žemėlapyje rodyti, kokiose miesto vietose šiuo metu yra greitosios pagalbos komandos
	89)  [System] Automatiškai atpažinamos didelės žmonių sankaupos
	90)  [System] Perspėti vartotoją, kad tam tikroje vietoje susikaupė daug žmonių
	91)  [Admin]  Iškviesti policiją apžvalgai į vietą, kur susikaupė daug žmonių
	92)  [Admin]  Iškviesti apžvalgos dronus į susibūrimo vietą
	93)  [User]   Didelės žmonių sankaupos situacijoje, peržiūrėti sankaupoje esančių žmonių sąrašą
	94)  [User]   Didelės žmonių sankaupos situacijoje, peržiūrėti toje vietoje esančių kamerų vaizdą
	95)  [Admin]  Didelės žmonių sankaupos situacijoje, pamatyti sąrašą sankaupoje esančių žmonių turimų įrenginių, kurie turi mikrofonus
	96)  [Admin]  Didelės žmonių sankaupos situacijoje, pamatyti sąrašą sankaupoje esančių žmonių turimų įrenginių, kurie turi kameras
	97)  [Admin]  Didelės žmonių sankaupos situacijoje, išsiųsti visiem sankaupoje esantiems žmonėms žinutę
	98)  [Admin]  Didelės žmonių sankaupos situacijoje, rašyti visus arba tam tikrus sankaupoje esančius į tam tikro lygio pavojų keliančių asmenų sąrašą
	99)  [Admin]  Didelės žmonių sankaupos situacijoje, uždrausti pasirinktiems žmonėms išvažiuoti iš miesto/šalies
	100) [Admin]  Didelės žmonių sankaupos situacijoje, perduoti policijos tarnybai atlikti patikrą pasirinktų susibūrime dalyvaujančių žmonių namuose/darbo vietose
	101) [Admin]  Didelės žmonių sankaupos situacijoje, iškviesti tam tikro lygio policijos pastiprinimą
	102) [Admin]  Didelės žmonių sankaupos situacijoje, perduoti policijai nurodymą imtis veiksmų
	103) [System]  Žemėlapyje rodyti, kur yra legaliai įsigyti-pažymėti ginklai
	104) [System]  Įspėti, jei mieste esančių kamerų stebimame vaizde pastebimas nelegalus ginklas
	105) [System]  Žemėlapyje rodyti, jei mieste esančių daviklių įrašytas garsas yra garsesnis nei įprastai 
	106) [System]  Automatinis ginklų atpažinimas aplink esančiomis (žmonių telefonų, stacionariomis) kameromis
	107) [System]  Automatinis šūvių atpažinimas aplink esančiais mikrofonais
	108) [System]  Žemėlapio filtravimas pagal pasirinktą kriterijų (automobiliai, žmonės, gyvūnai, kameros etc.)
	109) [System]  Istoriniai žemėlapio duomenys, galima peržiūrėti lokaciją bet kuriuo praeities laiku
	110) [System]  Automatinis žmogaus sekimas miesto kameromis, jei žmogus nesinešioja telefono.
	111) [Admin]  Iš praeities informacijos ištraukti vieno asmens/automobilio/gyvūno istoriją
	112) [Admin]  Tokius istorinius duomenis grupuoti keliems asmenims (matyti kada jie susitiko, išsiskyrė etc.)
	113) [Admin]  Asmens/automobilio sekimo pažymėjimas (įrašomas visas jo telefono/mikrofono kamera, išsaugomas visas vaizdas, visų aplink jį esančių kamerų vaizdas ir mikrofonų garsas)
	114) [Admin]  Informacijos apie žmogaus/automobilio sekimą grupavimas (pvz. nuo laiko taško A iki laiko taško B visi įrašyti pokalbiai, nebūtinai tik to žmogaus/automobilio mikrofono, bet ir aplinkinių)
	115) [Admin]  Galimybė valdyti visas apsaugos sistemas (pvz. užrakinti automobilį)
	116) [Admin]  Galimybė įjungti aplinkines sirenas/automobilių garsinius signalus bet kuriame taške
	117) [System] Automatinis įtartinų pranešimų sekimas, perspėjimas pranešimu
	118) [System] Automatinis fizinio smurto atpažinimas
	119) [System] Automatinis atpažinimas žmogaus gyvybiškai svarbių organų sutrikimo
	120) [System] Automatinis greitosios iškvietimas žmogui kuriam sutriko gyvybiškai svarbūs organai
	121) [System] Asmens pinigų transakcijų sekimas
	122) [System] Asmens pinigų transakcijų kategorizavimas
	123) [System] Bendrųjų aplinkos duomenų rinkimas analitiniams tikslams (kritulių, temperatūros, drėgnumo)
	124) [System] Asmens duomenų rinkimas analitiniams tikslams (kiek žmonių lankosi vietoje per dieną etc.)
	125) [System] Automobilių duomenų rinkimas analitiniams tikslams
	126) [System] Automatizuoti miesto šviesoforai mažinantys spūstis, naudojantis automobilių analitinius duomenis
	127) [Admin]  Į visus prietaisus išsiųsti garso/tekstinį pranešimą
	128) [System] Automatinis asmens profilio kaupimas (darbovietė, lankytiniausios vietos, namai, draugai, pavojingumo nuspėjimas, etc.)
	129) [System] Automatinis griežto rėžimo asmenų siekimas su didelio pavojaus tikimybe (sekami viso pokalbiai, vaizdas)
	130) [System] Riboto režimo informacinis naudojimas įprastiems asmenims (galima matyti, kur yra automobilis, gyvūnas, elektroniniais prietaisai, stebėti kameras ar mikrofonus savo namuose)
	131) [System] Automatinis asmenų bandančių išvengti stebėjimo atpažinimas
	132) [System] Miesto teritorijos suskirstymas pagal nusikaltimų dažnumą
	133) [System] Pirštų antspaudų sekimas (panaudojus pirštų antspaudus gaunamas pranešimas)
	134) [Admin]  Prisijungti prie automobilių kompiuterių
	135) [Admin]  Sutrikdyti automobilio darbą (sukelti techninius defektus naudojantis automobilio valdymo kompiuteriu)
	136) [Admin]  Sukurti netikrą iškvietimą taksi automobiliui
	137) [Admin]  Pakeisti siūlomą važiavimo maršrutą taksi automobiliui
	138) [Admin]  Užblokuoti galimybę priimti naujus keleivius (užblokuoti telefoną, anketą, išjungti šviesas, užrakinti duris)
	139) [Admin]  Prisijungti prie viešbučių administracijos sistemų
	140) [Admin]  Galimybė atrakinti/užblokuoti viešbučio kambario duris, išjungti šviesą
	141) [Admin]  Naujų asmenų registravimas atvykstančiu per oro/jūros uostą ar stotį
	142) [Admin]  Dažniausiai asmens vykdomų mokėjimų sąrašo gavimas
	143) [Admin]  Gavimas sąrašo asmenų, kurie dažniausiai perveda/gauna pinigus į tam tikrą sąskaitą
	144) [System] Pranešimo gavimas kai pervedama didelė pinigų suma, kai vienas iš asmenų yra padidintos rizikos sąraše
	145) [Admin]  Galimybė blokuoti tokius pavedimus iškart gavus pranešimą
	146) [Admin]  Prisijungti prie asmens socialinių tinklų
	147) [Admin]  Gauti asmens socialinio tinklo susirašinėjimų išklotinę
	148) [Admin]  Rašyti/gauti žinutes, naudojantis asmens soc. tinklais
	149) [Admin]  Skelbti įrašus asmens anketoje
	150) [Admin]  Ištrinti/užblokuoti asmens socialinę anketą
	151) [System] Asmenų atpažinimas iš nuotraukų, kurios įkeltos miesto teritorijoje, soc. tinkluose
	152) [Admin]  Pasirinktų nuotraukų ištrynimas iš soc. tinklų anketų
