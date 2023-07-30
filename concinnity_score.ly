% [[file:chords.org::*Score][Score:1]]
\version "2.22.0"
  \language "english"

  \include "ekme-heji.ily"

  #(define-markup-command (div layout props m) (markup?)
    (interpret-markup layout props
     #{ \markup \tiny \sans #m #}))

  space = {s1*4}
  small_sp = {s1}

  %% 1
  harmony = {
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
    %% 2
    <afuaa c' dfuaa' >1\laissezVibrer^\markup  \box {
      \pad-around #0.5 {
        { \div
          {
            \halign #1
            \center-column {
              8/5
              3/2
              6/5
            }}}}}
    \space
  
    %% 3
    <bf dfuaa' goea' >1\laissezVibrer^\markup \box {
      \pad-around #0.5 {
        { \div {
          \halign #1
          \center-column {
            16/15
            8/5
            4/3
          }}}}}
    \space
    \revert Staff.BarLine.stencil
    \bar "'"
    %% 4
    \override Staff.BarLine.stencil = ##f
    <bf aoaa' doaa'>1\laissezVibrer^\markup \box {
      \pad-around #0.5 {
        { \div {
          \halign #1
          \center-column {
            5/4
            5/3
            4/3
          }}}}}
    \space \break
    %% 5
    %% 7 limit chord up right
    <afoba doba' efoba' >1\laissezVibrer^\markup \box {
      \pad-around #0.5 {
        { \div {
          \halign #1
          \center-column {
            7/4
            12/7
            7/6
          }}}}}
    \space
    %% 6
    %% 7 limit chord down left
    <goba doba' eoba' >1\laissezVibrer^\markup \box {
      \pad-around #0.5 {
        { \div {
          \halign #1
          \center-column {
            7/4
            12/7
            8/7
          }}}}}
    \space
    %% 7
    %% 7 limit chord right up down left
    <c' gfoba' eoba' >1\laissezVibrer^\markup  \box {
      \pad-around #0.5 {
        { \div {
          \halign #1
          \center-column {
            15/8
            15/14
            3/2
          }}}}}
    \revert Staff.BarLine.stencil
    \override Staff.BarLine.stencil = ##f
    \space
    %% 8
    %% 7 limit chord left up down left
    <bf doaa' eoaauba'>1\laissezVibrer^\markup \box {
      \pad-around #0.5 {
        { \div {
          \halign #1
          \center-column {
            40/21
            5/3
            4/3
          }}}}}
    \space \break
    %% 9
    %% 7 limit chord left left down left
    <bf ef' fuba'>1\laissezVibrer^\markup \box {
      \pad-around #0.5 {
        { \div {
          \halign #1
          \center-column {
            32/21
            16/9
            4/3
          }}}}}
    \space
    \bar "||"
    %% 10
    %% 7 limit chord left down right
    <bf eoab' bfoab'>1\laissezVibrer^\markup \box {
      \pad-around #0.5 {
        { \div {
          \halign #1
          \center-column {
            64/49
            96/49
            4/3
          }}}}}
    \space
    %% 11
    %% 5 limit chord two left, up, down left
    <ef' goaa' afuea'>1\laissezVibrer^\markup \box {
      \pad-around #0.5 {
        { \div {
          \halign #1
          \center-column {
            32/27
            10/9
            16/9
          }}}}}
    \space
    \revert Staff.BarLine.stencil
    \bar "'"
    \override Staff.BarLine.stencil = ##f
    %% 12
    %% 5 limit chord two left, up, down left
    <goaa' eoaauba' doaa'>1\laissezVibrer^\markup \box {
      \pad-around #0.5 {
        { \div {
          \halign #1
          \center-column {
            10/9
            40/21
            5/3
          }}}}}
    \space \break
    %% 13
    \revert Staff.BarLine.stencil
    \bar "||"
    \mark \markup \box {\sans \bold { B } } 
    <aoaa eoaa' c'>1\laissezVibrer^\markup \box {
      \pad-around #0.5 {
        { \div
          \halign #1
          \center-column {
            15/8
            3/2
            5/4
          }}}}
    \override Staff.BarLine.stencil = ##f
    \small_sp
    %% 14
    <aoaa c' eoaa'>1\laissezVibrer^\markup \box {
      \pad-around #0.5 {
        { \div
          \halign #1
          \center-column {
            5/4
            1/1
            5/3
          }}}}
    \small_sp
    %% 15
    <c' eoaa' aoaa'>1\laissezVibrer^\markup \box {
      \pad-around #0.5 {
        { \div
          \halign #1
          \center-column {
            10/9
            5/3
            4/3
          }}}}
    \small_sp
    %% 16
    <cuba' euaa' aoea'>1\laissezVibrer^\markup \box {
      \pad-around #0.5 {
        { \div
          \halign #1
          \center-column {
            64/45
            15/14
            12/7
          }}}}
    \small_sp \break
    %% 17
    \revert Staff.BarLine.stencil
    \bar "||"
    \mark \markup \box {\sans \bold { C } } 
    <bf aoaa' doaa'>1\laissezVibrer^\markup \box {
      \pad-around #0.5 {
        { \div {
          \halign #1
          \center-column {
            5/4
            5/3
            4/3
          }}}}}
    \override Staff.BarLine.stencil = ##f
    \small_sp
    %% 18
    <bfuba aoaa' d'>1\laissezVibrer^\markup \box {
      \pad-around #0.5 {
        { \div {
          \halign #1
          \center-column {
            5/3
            9/8
            7/4
          }}}}}
    \small_sp
    %% 19
    <bfuaa d' a'>1\laissezVibrer^\markup \box {
      \pad-around #0.5 {
        { \div {
          \halign #1
          \center-column {
            9/8
            3/2
            6/5
          }}}}}
    \small_sp
    %%20
    <bf duba' aoea'>1\laissezVibrer^\markup \box {
      \pad-around #0.5 {
        { \div {
          \halign #1
          \center-column {
            64/45
            27/14
            5/3
          }}}}}
    \small_sp
    \revert Staff.BarLine.stencil
    \bar "||"}
  bass = {
    f\laissezVibrer^\markup
    \box {
      \pad-around #0.5 {
        { \div
          \halign #1
          \center-column {
            1/1
          }}}}
    \space
    f\laissezVibrer^\markup
    \box {
      \pad-around #0.5 {
        { \div
          \halign #1
          \center-column {
            1/1
          }}}}
    \space
    f\laissezVibrer^\markup
    \box {
      \pad-around #0.5 {
        { \div
          \halign #1
          \center-column {
            1/1
          }}}}
    \space
    f\laissezVibrer^\markup
    \box {
      \pad-around #0.5 {
        { \div
          \halign #1
          \center-column {
            1/1
          }}}}
    \space
    f\laissezVibrer^\markup
    \box {
      \pad-around #0.5 {
        { \div
          \halign #1
          \center-column {
            1/1
          }}}}
    \space
    f\laissezVibrer^\markup
    \box {
      \pad-around #0.5 {
        { \div
          \halign #1
          \center-column {
            1/1
          }}}}
    \space
    f\laissezVibrer^\markup
    \box {
      \pad-around #0.5 {
        { \div
          \halign #1
          \center-column {
            1/1
          }}}}
    \space
    f\laissezVibrer^\markup
    \box {
      \pad-around #0.5 {
        { \div
          \halign #1
          \center-column {
            1/1
          }}}}
    \space
    f\laissezVibrer^\markup
    \box {
      \pad-around #0.5 {
        { \div
          \halign #1
          \center-column {
            1/1
          }}}}
    \space
    f\laissezVibrer^\markup
    \box {
      \pad-around #0.5 {
        { \div
          \halign #1
          \center-column {
            1/1
          }}}}
    \space
    f\laissezVibrer^\markup
    \box {
      \pad-around #0.5 {
        { \div
          \halign #1
          \center-column {
            1/1
          }}}}
    \space
    f\laissezVibrer^\markup
    \box {
      \pad-around #0.5 {
        { \div
          \halign #1
          \center-column {
            1/1
          }}}}
    \space
    \revert Staff.BarLine.stencil
    \bar "||"
    f\laissezVibrer^\markup
    \box {
      \pad-around #0.5 {
        { \div
          \halign #1
          \center-column {
            1/1
          }}}}
    \override Staff.BarLine.stencil = ##f
    \small_sp
    c'\laissezVibrer^\markup
    \box {
      \pad-around #0.5 {
        { \div
          \halign #1
          \center-column {
            1/1 (3/2)
          }}}}
    \small_sp
    g\laissezVibrer^\markup
    \box {
      \pad-around #0.5 {
        { \div
          \halign #1
          \center-column {
            1/1 (9/8)
          }}}}
    \small_sp
    efoba'\laissezVibrer^\markup
    \box {
      \pad-around #0.5 {
        { \div
          \halign #1
          \center-column {
            1/1 (7/4)
          }}}}
    \small_sp
    \revert Staff.BarLine.stencil
    \bar "||"
    f\laissezVibrer^\markup
    \box {
      \pad-around #0.5 {
        { \div
          \halign #1
          \center-column {
            1/1
          }}}}
    \override Staff.BarLine.stencil = ##f
    \small_sp
    c'\laissezVibrer^\markup
    \box {
      \pad-around #0.5 {
        { \div
          \halign #1
          \center-column {
            1/1 (3/2)
          }}}}
    \small_sp
    g\laissezVibrer^\markup
    \box {
      \pad-around #0.5 {
        { \div
          \halign #1
          \center-column {
            1/1 (9/8)
          }}}}
    \small_sp
    efoba'\laissezVibrer^\markup
    \box {
      \pad-around #0.5 {
        { \div
          \halign #1
          \center-column {
            1/1 (7/4)
          }}}}
    \small_sp
    \revert Staff.BarLine.stencil
    \bar "||"
  }

\header {
  tagline = ##f
  title = \markup { \override #'((font-name . "Helvetica") (font-size . 8)) "Concinnity" }
  subtitle = \markup { \override #'((font-name . "Helvetica") (font-size . 1)) "for saxophone and electronics" }
  composer = \markup { \override #'((font-name . "Helvetica") (font-size . -1)) "Henrik Frisk" }
}

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
          \harmony
        }
      }
      \new Staff {
        \override Staff.BarLine.stencil = ##f
        \new Voice {
          \accidentalStyle "dodecaphonic"
          \clef bass
          \bass
        }
      }
    >>
    %%  \midi {}
  }
% Score:1 ends here
