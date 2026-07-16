#import "/song_book/template.typ": (
  base-margin, continues-on-next-page, continues-on-next-page-inline,
  insert-virtual-pages, partition-page, skip-pages, song, song-notes,
)

// Title page
#partition-page[Sektionssånger][
  #show heading: pad.with(left: 6pt)
  #v(4.2mm)
  = Sektionssånger
  #v(20.2mm)
  #align(center, pad(
    x: -base-margin,
    image(width: 79.5mm, "/song_book/assets/images/andrasektioner.png"),
  ))
]

// Konglig Fysiks 💵-hymn :)
#place(song(<konglig_fysiks_parahymn>))
#pagebreak()

#song(<o_hemska_lab>)
#song(<moder_kista>)
#pagebreak()

#song(<stackars_teknis>)
#pagebreak()

#insert-virtual-pages(1)
#song(<emojisangen>, text-size: 16pt, text-leading: 0.5em, override-text-content: [
  #emoji.face.happy #emoji.face.cry #emoji.face.angry.red #emoji.thumb #emoji.thumb.down #linebreak()
  #emoji.bride #emoji.santa #emoji.baby #emoji.rabbit.face #emoji.mushroom #emoji.wave #linebreak()
  #emoji.watermelon #emoji.pizza #emoji.football #emoji.banana #linebreak()
  #emoji.pumpkin #emoji.beer #emoji.heart #emoji.snowman #emoji.horse.face #linebreak()
  #emoji.cooking #linebreak()
  #emoji.bomb #emoji.hamster #emoji.alien #linebreak()
  #emoji.tractor #emoji.shoe #emoji.scissors #emoji.chicken.male #linebreak()
  #emoji.clip #emoji.hat.top #emoji.car #emoji.hourglass #linebreak()
  #emoji.bread #emoji.fish #emoji.turtle #emoji.turtle #linebreak()
  #v(-0.6em)
  #image("/song_book/assets/images/woman_no.png", width: 1em)
  #v(-0.6em)
  #[#image("/song_book/assets/images/woman.png", width: 1em) #v(-1.7em) #h(1.48em) #emoji.flower.tulip]
])
#pagebreak()

#skip-pages(1)

#song(<mediehymnen>, after-spacing: 7.5mm)
#song(<nar_vi_festar>, add-after-nth-par: ((1, v(-2.43mm)),))
#pagebreak()

#insert-virtual-pages(2)
#song(
  <balladen_om_arkitektens_kak>,
  text-spacing: 0.21in,
)

#pagebreak()

#song(<en_bergsman_alskar>)
#pagebreak()

#song(<grabbarna_i_b>, text-notes-spacing: 9pt, after-spacing: 4.5mm)
#continues-on-next-page()
#song(
  <rovarvisan>,
  text-leading: 3pt,
  text-spacing: 4.55mm,
)
#pagebreak()

#song(<agdas_skal>, text-spacing: 3.4mm)
#pagebreak()

#insert-virtual-pages(2)
#song(<flygarsupen>)
#place[#v(6.1mm) #song(<blaa_ringar>)]
#pagebreak()

#place[#song(<veritas_hermetica>, override-text-content: [
  Kamrater, teknologer i Kemisternas sektion\
  Veritas Hermetica\
  gyllene valspråket ljuder\
  I livets kamp där kämpa vi, en tapper legion\
  och draga fram\
  i rök och damm\
  med syra, salt och bas\

  De gamla alkemister ha sin konst till oss lärt ut\
  #text(tracking: -0.55pt)[
    av torv och talg och skogens stam blir guld förutan prut
  ]\
  Potatisen blir brännvin, och av sand vi göra glas\
  när vi dra' fram\
  i rök och damm\
  med syra, salt och bas

  Och må vi aldrig spjälkas ens av starkaste zymas\
  Veritas Hermetica\
  Fränder, höjen nu glasen\
  Vi veta att vår vänskap ej är blott en vacker fras\
  när vi dra' fram\
  i rök och damm\
  med syra, salt och bas

  I arbete och glädje, uppå tentor och kalas\
  #text(tracking: -0.22pt)[
    vår vänskap vuxit stor och stark, kan aldrig gå i kras
  ]\
  Kamrater alltid vi förbli, nu tömmen edra glas\
  Vi draga fram\
  i rök och damm\
  med syra, salt och bas
])]
#pagebreak()

#song(<tjugotre>)
#pagebreak()

#song(<har_kommer_det_elektriker>)
#place(
  center + bottom,
  dx: -2mm,
  dy: 5mm,
  image(width: 110%, "/song_book/assets/images/Sid 67 electricmagic.svg"),
)
#pagebreak()

#song(<byggingenjorernas_bekannelse>)
#song(<jamvikt_rader>)
#pagebreak()

#song(<hela_m>)
#pagebreak()

#song(<ingenjorssektionens_sang>)
#pagebreak()

#song(<fanan_var>, text-spacing: 2.8mm)
#place[#v(3mm) #song(<s_ingenjoren>, text-spacing: 2.8mm)]
#pagebreak()

#song(<om_sanningen_ska_fram>, add-after-nth-par: (
  (3, pagebreak()),
  (
    7,
    {
      continues-on-next-page(dx: 1mm, dy: -2mm)
      pagebreak()
    },
  ),
))
#pagebreak()

#insert-virtual-pages(2)
#continues-on-next-page()
#song(<identitetskris>)
#song(
  <skolan_kth>,
  override-nth-par: ((
    1,
    context [
      Och så gjorde de så här\
      #box(grid(
        columns: 2,
        row-gutter: 4pt,
        column-gutter: 1em,
        [Telge bort], [(första gången)],
        [Kista bort], [(andra gången)],
        [Sälj bort L], [(tredje gången)],
        [Ta in fler], [(fjärde gången)],
      ))
    ],
  ),),
)

#pagebreak()

#skip-pages(2)

#song(<sang_om_tentor>, text-notes-spacing: 4mm, after-spacing: 3.5mm)
#song(<sektionssang_i>, text-spacing: 4.9mm)
#pagebreak()

#insert-virtual-pages(4)
#song(<mecken_gar>)
#song(
  <fader_abraham>,
  override-nth-par: ((
    1,
    [
      #box(grid(
        columns: 2,
        row-gutter: 4pt,
        column-gutter: 1em,
        [Høyre arm], [(Første gang)],
        [Venstre arm], [(Andre gang)],
        [Høyre fot Venstre fot], [(Tredje gang)],
        [Rumpa ut], [(Fjerde gang)],
        [Kroppen frem], [(Femte gang)],
        [Tunga ut], [(Sjette gang)],
      ))
    ]
  ),),
)
#continues-on-next-page(dx: 1mm, dy: -2mm)
#song(<dataloger>)
#song(<liljekonvaljen>)
#pagebreak()
#song(<open_ar_vart_val>)

#pagebreak()

#song(<skalmen>, after-spacing: 8mm)
// TODO: Figure out what's the deal with this songs owner, as it's inconsistent between the anniversary edition and songs.json.
#song(<hata_data_ltu>)
#pagebreak()

#box[
  #song(<javlaranammas_sittningsvisa>, text-spacing: 5.5mm, after-spacing: 5.1mm, text-notes-spacing: 3mm)
  #song(<d_sektionen_lth>)
]
#pagebreak()

#place[#song(<pa_data_ltu>, override-notes-content: [], add-after-nth-par: ((
  1,
  {
    set text(size: 9pt, style: "italic")
    v(-4pt)
    [DØ-94]
    v(-7pt)
  },
),))]
#pagebreak()
