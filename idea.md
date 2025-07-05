# Tower Defense Game in Godot

Strategická 2D tower defense hra postavená ve frameworku **Godot 4**, kde hráč brání svou základnu před vlnami nepřátel pomocí různých typů věží.

---

## Obsah

- [O projektu](#o-projektu)
- [Funkce](#funkce)
- [Jak hrát](#jak-hrát)
- [Inspirace](#inspirace)
- [Technologie](#technologie)
- [Plán vývoje](#plán-vývoje)
- [Autor](#autor)

---

## O projektu

Tato hra je navržena jako klasický tower defense s moderními prvky. Hráč má omezené zdroje a musí strategicky stavět věže, aby zastavil stále větší vlny nepřátel.

Cílem je vytvořit zábavnou, vizuálně přitažlivou a dobře vyváženou hru, která bude snadno rozšiřitelná o nové mapy, věže a nepřátele. Hlavním cílem je úspěšně uzavřít AK8PO.

---

## Funkce

-  **Stavění věží** – různé typy s unikátními schopnostmi (damage, radius).
-  **Strategie** – omezené zdroje, nutnost plánování a prioritizace.
-  **Mapy** – jedna předdefinovaná.
-  **UI/UX** – přehledné rozhraní, vizuální efekty.

---

## Jak hrát

1. Začínáš s určitou malým množstvím peněz a s plnými health barem.
2. Přibližně za 10 sekund se automaticky spustí postupné vlny nepřátel
2. Stavěj věže podél cesty, kterou procházejí nepřátelé.
3. Každá zabitá jednotka přináší zlato.
4. Pokud nepřítel projde, ztratíš životy.
5. Cílem je přežít co nejvíce vln.

---

## Inspirace

- **Kingdom Rush** – stylizace a rozmanitost věží.
- **Bloons TD** – jednoduchost a zábavnost.
- **Plants vs. Zombies** – přístupnost a tempo.
- **Dungeon Defenders** – kombinace akce a strategie.

---

## Technologie

| Nástroj        | Popis                          |
|----------------|--------------------------------|
| Godot 4        | Herní engine                   |
| GDScript       | Programovací jazyk             |
| Tiled          | Editor map (volitelně)         |
| Git & GitHub   | Správa verzí a spolupráce      |

---

##  Plán vývoje

| Fáze                | Popis                                      |
|---------------------|--------------------------------------------|
|  Prototyp           | Základní mechanika věží a nepřátel         |
|  UI a vlny          | Uživatelské rozhraní, generování vln       |
|  Grafika a zvuky    | Přidání vizuálů a zvukových efektů         |
|  Testování          | Vyvážení hry, oprava chyb                  |
|  MVP release        | První hratelná verze                       |

---

## Autor

**Jméno**: *Matěj Švarc*  
**GitHub**: [@Blacky911](https://github.com/Dlacky911)  
**Kontakt**: *m1_svarc@utb.cz*

---

## TO DO List

**Hlavní menu** - přidat tlačítko pro novou hru, které hráče nechá vybrat parametry (Quick game vs. New Game).
**Mapy** – generovat další mapy, navrhnout generátor.
**UI/UX** – dodělat zvuky / implementovat výbuchy; u věží typu Missile dodělat let rakety.
**Věže** - přidat další typy se speciálními schopnostmi (nejen DMG, ale i omezení pohybu)

---

## Poznámky

- Možnost přidat editor map pro hráče.
- Ukládání a načítání progresu.

---
