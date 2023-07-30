\score {
  \layout {
    \context {
      \Score
    }
  }
  <<
    \new Staff {
      \override Staff.BarLine.stencil = ##f
      \new Voice {
        \accidentalStyle "dodecaphonic"
        %% 1
        \mark \markup \box {\sans \bold { A} } 
    <aoaa eoaa' c'>1\laissezVibrer^\markup \box {
      \pad-around #0.5 {
        { \div
          \halign #1
          \center-column {
            15/8
            3/2
            5/4
          }}
      }
    }
    \space
      }
    }
    \new Staff {
      \override Staff.BarLine.stencil = ##f
      \new Voice {
        \accidentalStyle "dodecaphonic"
        \clef bass
        f\laissezVibrer^\markup
        \box {
          \pad-around #0.5 {
            { \div
              \halign #1
              \center-column {
                1/1
              }}}}
        \space
      }
    }
  >>
  %%  \midi {}
}
