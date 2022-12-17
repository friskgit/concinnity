(
o = Server.local.options; // Get the local server's options
o.numInputBusChannels = 2; // Set Input to number of Inputs
o.numOutputBusChannels = 64; // lets start after chan 36 so as not to see the mic input
o.numAudioBusChannels = 1024; // default is 1024
o.blockSize = 256;
o.numWireBufs = 64 * 16;  // for more complex SynthDefs
o.memSize = 2.pow(16);  // default 2.pow(13)
o.sampleRate = 48000;
s.boot;
)
(
// Default settings
~order = 3;
~hoaNumChannels =  ((~order+1).pow(2)).asInteger;
~decoderNumChannels = 31;
~decoderOrder = 1;
~defaultChordSize = 3;
// this indicates where the decoder is reading the signal From
~defaultChOffset = 0;
// ~audioBusses = Array.new(~defaultChordSize);
~audioInBus = 12;
~fadeTime = 4;
~baseFreq = 174.61;
~baseFifth = ~baseFreq*3/2;
~baseSecond = ~baseFreq*9/8;
~baseSeven = ~baseFreq*7/4;
~inFormat = \ACN_N3D;
~outFormat = \ACN_SN3D;
~globalRep = 3;
~sectionOrder = [0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 14, 13, 15, 16, 18, 17, 19];
~sections = [50,
  20, 30, 20, 30,
  20, 30, 20, 50,
  20, 10, 30, 20,
  10, 5, 5, 15,
  5, 5, 5, 50];
~pBindReps = [0,
  4, 3, 4, 6,
  4, 3, 4, 4,
  4, 3, 4, 6,
  1, 1, 1, 2,
  1, 1, 2, 2,
  0, 0];

// Load Synth
~globSynthVol = Bus.control(s, 1);
~globSynthVol.set(0.05);
SynthDef("chordPlayer", { |out, freq, amp, length=20, az=0, el=0, rad=2, spherical=1, combv = 0.1 |
  var envS = Env.new(levels: [0, 1, 0.9, 0], times: [0.3*length, 0.3*length*0.5, 0.7*length*0.5], curve: [-3, -1, -1]);
  var envO = Env.new(levels: [0, 1, 0.9, 0.5, 0], times: [0.3*length, 0.1*length, 0.4*length, 0.4*length], curve: [-3, 1, 2, -2]);
  var sig = Mix.ar(
        [SyncSaw.ar(freq, ((freq*2) * (rad / 3)), 0.1) * EnvGen.kr(envS),
          SinOsc.ar(freq, 0.0, amp, 0.0) * EnvGen.kr(envO, doneAction: Done.freeSelf)]
  );
  var flt = CombN.ar(sig, 0.01, (az.abs / 3.14 * 0.002), combv);
  var main = XFade2.ar(flt, sig, (rad/4.5)-1, 1) * 0.2;
  var volume = In.kr(~globSynthVol);
  Out.ar(out, HOAEncoder.ar(~order, main * volume, az, el, 0.2, spherical, rad, 1.07));
}).add;
// Load Array
~notesArrays = MatrixArray.with([[15/8, 3/2, 5/4], [8/5, 3/2, 6/5], [16/15, 8/5, 4/3], [5/4, 5/3, 4/3], [7/4, 12/7, 7/6], [7/4, 12/7, 8/7], [15/8, 15/14, 3/2], [40/21, 5/3, 4/3], [32/21, 16/9, 4/3], [64/49, 96/49, 4/3], [32/27, 10/9, 16/9], [10/9, 40/21, 5/3], [15/8, 3/2, 5/4], [5/4, 1/1, 5/3], [10/9, 5/3, 4/3], [64/45, 15/14, 12/7], [5/4, 5/3, 4/3], [5/3, 9/8, 7/4], [9/8, 3/2, 6/5], [64/45, 27/14, 5/3]]);
~spatArrays = MatrixArray.with([[0.78539816, 1.5707963, 0.0], [3.1415927, 1.5707963, 2.3561945], [-2.3561945, 3.1415927, -1.5707963], [0.0, -0.78539816, -1.5707963], [0.78539816, 2.3561945, -0.78539816], [0.78539816, 2.3561945, -2.3561945], [0.78539816, 0.39269908, 1.5707963], [-0.52359878, -0.78539816, -1.5707963], [-1.727876, -1.5707963, -1.5707963], [-2.7488936, 2.7488936, -1.5707963], [-1.5707963, -0.78539816, -1.5707963], [-0.78539816, -0.52359878, -0.78539816], [0.78539816, 1.5707963, 0.0], [0.0, 0.0, -0.78539816], [-0.78539816, -0.78539816, -1.5707963], [-2.5132741, 0.39269908, 2.3561945], [0.0, -0.78539816, -1.5707963], [-0.78539816, 1.5707963, 0.78539816], [1.5707963, 1.5707963, 2.3561945], [-2.5132741, 1.727876, -0.78539816]]);
~elArrays = MatrixArray.with([[0.62831853, 0, 0], [0, 0, 0.62831853], [0.62831853, 0, 0], [0, 0.78539816, 0], [0.4712389, 0.4712389, 0.4712389], [0.4712389, 0.4712389, 0.4712389], [0.62831853, 0.62831853, 0], [0.9424778, 0.78539816, 0], [0.78539816, 0.62831853, 0], [0.62831853, 0.62831853, 0], [0.9424778, 0.9424778, 0.62831853], [0.9424778, 0.9424778, 0.78539816], [0.62831853, 0, 0], [0, 0, 0.78539816], [0.9424778, 0.78539816, 0], [0.9424778, 0.62831853, 0.4712389], [0, 0.78539816, 0], [0.78539816, 0.62831853, 0.4712389], [0.62831853, 0, 0.62831853], [0.9424778, 0.78539816, 0.78539816]]);
~radArrays = MatrixArray.with([[6, 3, 3], [3, 3, 6], [6, 3, 3], [3, 6, 3], [3, 3, 3], [3, 3, 3], [6, 3, 3], [6, 6, 3], [6, 6, 3], [3, 3, 3], [9, 9, 6], [9, 6, 6], [6, 3, 3], [3, 3, 6], [9, 6, 3], [9, 3, 3], [3, 6, 3], [6, 6, 3], [6, 3, 6], [9, 6, 6]]);
~notesArrayFunc = { arg ndx, out, base;
  var chord, outs, size, amps;
  var gate = 2.rand;
  ~expandArray = { |out, chord, spat, el, rad, amp|
    "called expandArray".postln;
    fork {
          [\out, out, \freq, chord, \az, spat, \el, el, \rad, rad, \amp, amp].flop.do { |args|
            var mArray = ~multichannelArray.value(args[3], args[11], 16);
            // put it in the third argument, 'chord'	  
            args.put(3, mArray[0]);
            // put it in the 11th argument, 'amp'	  
            args.put(11, mArray[1]);
            args.postln;	  
            Synth("chordPlayer", args);
          }
    };
  };
  // ~expandArray.value([0,1, 0, 1], [220,440, 540, 640]);
  ~freqs = { arg pitches, base;
    var new_array = Array.new(pitches.size);
    pitches.do({ arg item, i;
          new_array.add((item*base));
    });
    new_array;
  };
  //  ~freqs.value([2/1, 3/2], 100).postln;
  ~distExpandA.value([ 0, 0, 0 ], [ 558.768, 523.845, 419.076 ], [ 0.78539816, 1.5707963, 0.0 ], [ 0.62831853, 0, 0 ], [ 6, 3, 3 ], [ 0.1, 0.1, 0.1 ]);
  amps = Array.with(0.1, 0.1, 0.1);
  // Arrays for notes and spatialization.
  chord = ~freqs.value(~notesArrays.rowAt(ndx), base);
  "Chord array: ".post; chord.postln;
  "Azimuth array: ".post; ~spatArrays.rowAt(ndx).postln;
  "Elevation array: ".post; ~elArrays.rowAt(ndx).postln;
  "Radius array: ".post; ~radArrays.rowAt(ndx).postln;
  outs = Array.new(3);
  if(chord.size > ~defaultChordSize,
        { 
          size = ~defaultChordSize - 1  ;
        },
        {
          size = chord.size;	  
        });
  // Set the output to the offset
  (0..2).do({ arg item;
        outs.add(~defaultChOffset);
  });
  "Amps array: ".post; amps.postln;
  "Outputs array: ".post; outs.postln;
  //       ~expandArray.value(outs, chord, ~spatArrays.rowAt(ndx), ~elArrays.rowAt(ndx), ~radArrays.rowAt(ndx), amps);
  // ~pbindExpand.value(outs, chord, ~spatArrays.rowAt(ndx), ~elArrays.rowAt(ndx), ~radArrays.rowAt(ndx), amps);
  if(gate == 0,
        {
          "Playing Pbind A".postln;
          "Global rep is ".post; ~globalRep.postln;
          ~distExpandA.value(outs, chord, ~spatArrays.rowAt(ndx), ~elArrays.rowAt(ndx), ~radArrays.rowAt(ndx), amps, ~globalRep);	  
        },
        {
          "Playing Pbind B".postln;
          "Global rep is ".post; ~globalRep.postln;
          ~distExpandB.value(outs, chord, ~spatArrays.rowAt(ndx), ~elArrays.rowAt(ndx), ~radArrays.rowAt(ndx), amps, ~globalRep);
        }
  );
};
//~notesArrayFunc.value(1, 0, 400);
~multichannelArray = { |freq=200, amp=1, iter=8, mode=1|
  var freqArray = Array.new(iter);
  var ampArray = Array.new(iter);
  if(mode == 0,
        {
          iter = iter*2;	  
          iter.do({  arg item, int;
                if(int % 2 == 0,
                  { freqArray.add(freq * (int + 1));
                        ampArray.add(amp / (int + 1)); });	  
          });
        },
        {
          iter.do({  arg item, int;
                freqArray.add(freq * (int + 1));
                ampArray.add(amp / (int + 1)); });	  
        });
  ~return = [freqArray, ampArray];
};
/*
  Setting reps=3 makes a 25 second event, to 5 a 35 second event (delta * reps).
*/
~distExpandA = { |out, chord, spat, el, rad, amp, reps|
  var pbA, pbB, timeA = 0.009, timeB = 0.01, len = 3, mChordExp, mChord, mAmp;
  mChordExp = ~multichannelArray.value(chord, amp, 8, 1);
  mChord = mChordExp[0];
  mAmp = mChordExp[1];
  "called distExpand".postln;
  fork {
        pbA = Pbind(\instrument, "chordPlayer",
          \out, Pseq(out, reps),
          \freq, Pseq(mChord, reps) * Prand([1,2], reps),
          \az, Pseq(spat, reps),
          \el, Pseq(el, reps),
          \rad, Pseq(rad, reps),
          \amp, Pseq(mAmp, reps),
          \length, Pseq([len, len], reps) * Prand([(1..3)], reps),
          \combv, Prand([0.1, 0.11, 0.12, 0.13, 0.15, 0.17, 0.19, 0.2], reps),
          \dur, Prand(chord, reps) * timeA,
          \delta, 7;	  
        ).play;
        4.wait;
        pbB = Pbind(\instrument, "chordPlayer",
          \out, Pseq(out, reps),
          \freq, Pseq(mChord, reps) * Prand([1,2], reps),
          \az, Pseq(spat, reps),
          \el, Pseq(el, reps),
          \rad, Pseq(rad, reps),
          \amp, Pseq(mAmp, reps),
          \length, Pseq([len, len], inf) * Prand([(2..3)], reps),
          \combv, Prand([0.1, 0.11, 0.12, 0.13, 0.15, 0.17, 0.19, 0.2], reps),	  
          \dur, Prand(chord, reps) * timeB,
          \delta, 5;	  
        ).play;
  };
};
//~distExpandA.value([ 0, 0, 0 ], [ 558.768, 523.845, 419.076 ], [ 0.78539816, 1.5707963, 0.0 ], [ 0.62831853, 0, 0 ], [ 6, 3, 3 ], [ 0.1, 0.1, 0.1 ]);
    /*
Setting rep = 3 yields 25s, 5 yields 44s.
*/
~distExpandB = { |out, chord, spat, el, rad, amp, rep = 2|
  var pbA, pbB, pbC, timeA = 0.005, timeB = 0.007, eventLength = 40, len = 3, mChordExp, mChord, mAmp;
  mChordExp = ~multichannelArray.value(chord, amp, 8, 1);
  mChord = mChordExp[0];
  mAmp = mChordExp[1];
  "called distExpand".postln;
  fork {
        pbA = Pbind(\instrument, "chordPlayer",
          \out, out[0],
          \freq, mChord[0] * Prand([0.5, 1, 2,], rep),
          \az, spat[0],
          \el, el[0],
          \rad, rad[0],
          \amp, amp[0],
          \length, Prand([1, 1.5, 1.7, 1.9, 2.1, 2.5], rep) * len,
          \combv, Prand([0.1, 0.11, 0.12, 0.13, 0.15, 0.17, 0.19, 0.2], rep),
          \dur, chord[0] * timeA,
          \delta, 5 * Prand([1, 1.5, 1.7, 1.9, 2.1, 2.5], rep);
        ).play;
        3.wait;
        pbB = Pbind(\instrument, "chordPlayer",
          \out, out[1],
          \freq, mChord[1] * Prand([0.5, 1, 2,], rep),
          \az, spat[1],
          \el, el[1],
          \rad, rad[1],
          \amp, amp[1],
          \length, Prand([1, 1.5, 1.7, 1.9, 2.1, 2.5], rep) * len,
          \combv, Prand([0.1, 0.11, 0.12, 0.13, 0.15, 0.17, 0.19, 0.2], rep),
          \dur, chord[1] * timeA,
          \delta, 3 * Prand([1, 1.5, 1.7, 1.9, 2.1, 2.5], rep);
        ).play;
        6.wait;
        pbC = Pbind(\instrument, "chordPlayer",
          \out, out[2],
          \freq, mChord[2] * Prand([0.5, 1, 2,], rep),
          \az, spat[2],
          \el, el[2],
          \rad, rad[2],
          \amp, amp[2],
          \length, Prand([1, 1.5, 1.7, 1.9, 2.1, 2.5], rep) * len,
          \combv, Prand([0.1, 0.11, 0.12, 0.13, 0.15, 0.17, 0.19, 0.2], rep),
          \dur, chord[2] * timeA,
          \delta, 3 * Prand([1, 1.5, 1.7, 1.9, 2.1, 2.5], rep);
        ).play;
        eventLength.wait;
        pbA.stop;
        pbB.stop;
        pbC.stop;
  };
};
~change = { arg index = 0;
  var root;
  "*** Current section played is ".post; index.postln;
  ~changeChord.value(index);
  switch(index,
        13, {root = ~baseFifth},
        14, {root = ~baseSecond},
        15, {root = ~baseSeven},
        17, {root = ~baseFifth},
        18, {root = ~baseSecond},
        19, {root = ~baseSeven},
        root = ~baseFreq
  );
  ~notesArrayFunc.value(index, ~defaultChOffset, root);
};
//~change.value(19);
//     s.meter;
// 6 dominant 7 avspänning 9 öppet 
// 3 -> 4 ->  0 -> 4 | 8
//  s.meter;
// Load decoder and connect
//  ~decoder = NodeProxy.new(s, \audio, ~decoderNumChannels);
//  // In this case the KMH108AE1h1p is used, taking four inputs from the encoded signal.
//  ~decoder.source = {
//    KMHLSDome1h1pNormal6.ar(In.ar(~defaultChOffset),
//          In.ar(~defaultChOffset+1),
//          In.ar(~defaultChOffset+2),
//          In.ar(~defaultChOffset+3), gain:0)
//  };
//  ~decoder.fadeTime = 1;
//  ~decoder.play;
  fork {
    //    
    ~encoders = Array.new(~maxNotes);
    ~maxNotes.do({ arg item, int;
      ~encoders.add(NodeProxy.new(s, \audio, ~hoaNumChannels, 1));
    });
    
    ~encoders.do({ arg obj, int;
      var az, el, rad;
      az = ~spatArrays.rowAt(0);
      el = ~elArrays.rowAt(0);
      rad = ~radArrays.rowAt(0);
      obj.fadeTime = ~fadeTime;
      obj.source = {
            HOAEncoder.ar(~order, \in.ar(0), \az.kr(az[int]), \el.kr(el[int]), 0.5, \spherical.ir(1), \rad.kr(rad[int]), 1.07);
      };
    });
    
    ~encoderSum = NodeProxy.new(s, \audio, ~hoaNumChannels, ~hoaNumChannels);
    ~encoders.do({ arg obj, int;
      ~encoderSum.add(~encoders[int], 0);
    });
    ~maxNotes = 3;
    ~shifters = Array.new(~maxNotes);
    ~panners = Array.new(~maxNotes);
    ~globPAVol = Bus.control(s, 1);
    ~globPAVol.set(1.0);
    
    // Add nodeproxys to the shifter and pan arrays
    ~maxNotes.do({ arg item, int;
      ~shifters.add(NodeProxy.new(s, \audio, 1, 1));
      ~panners.add(NodeProxy.new(s, \audio, 2, 1));
    });
    
    // Create the PitchShifter synths                                                                               
    ~shifters.do({ arg obj, int;
      obj.fadeTime = ~fadeTime;
      obj.source = {
            var freq, hasFreq;
            #freq, hasFreq = Pitch.kr(
              SoundIn.ar(\micIn.kr(~audioInBus), 1);	  
            );
            //          freq.poll;
            PitchShiftPA.ar(
              SoundIn.ar(\micIn.kr(~audioInBus), 1) * \shiftInputVol.kr(1),	  
              freq, \pitchRatio.kr(1.1),
              \formantRatio.kr(1), \minFreq.kr(10),
              \maxFormantRatio.kr(10), \grainsPeriod.kr(2)) * \shiftVol.kr(0);
      };
    });
    //    ~decoder = NodeProxy.new(s, \audio, ~decoderNumChannels);
    //    switch (~order,
    //      1, {
    //            ~decoder.source = {
    //              var in; in = \in.ar(0!~hoaNumChannels);
    //              in.add(6);
    //              KMHLSDome1h1pNormal6.ar(*in)
    //            };
    //      },
    //      3, {
    //            ~decoder.source = {
    //              var in; in = \in.ar(0!~hoaNumChannels);
    //              in.add(6);
    //              KMHLSDome3h3pNormal6.ar(*in)
    //            };
    //      };
    //      //   "Order not implemented".postln;
    //    ).postln;
    //    ~decoder.fadeTime = 1;
    //    // Create the panner synths and connect them to the shifters.
    //    ~panners.do({ arg obj, int;
    //      obj.source = {
    //            Pan2.ar(\in.ar, \panPos.kr(0), \amp.kr(1));
    //      };
    //    });
    0.5.wait;
    //    ~panners.do({ arg obj, int;
    //      obj.play;
    //      "Connecting shifter ".post; int.post; " to panner ".post; int.postln;
    //      ~shifters[int] <>> obj;
    //    });
    ~encoders.do({ arg obj, int;
      ~shifters[int] <>> obj;
    });
    //  ~encoderSum <>> ~decoder;
    //  ~decoder.play;
    ~encoderSum.play;
    //    
    ~changeChord = { arg index;
      var harm = ~notesArrays.rowAt(index);
      var spat = ~spatArrays.rowAt(index);
      var el = ~elArrays.rowAt(index);
      var rad = ~radArrays.rowAt(index);
      "Current chord array is: ".postln;
      " ->  ".post; ~notesArrays.rowAt(index).postln;
      "Current spat is: ".postln;
      "->  ".post; ~spatArrays.rowAt(index).postln;
      "Current elevation is: ".postln;
      "->  ".post; ~elArrays.rowAt(index).postln;
      "Current radius is: ".postln;
      "->  ".post; ~radArrays.rowAt(index).postln;
    
      ~shiftersNewChord.value(harm, spat, el, rad);	
    };
    ~shiftersNewChord = { arg ratio, az, el, rad;
      ~shifters.do({ arg obj, int;
        obj.fadeTime = ~fadeTime;
        obj.source = {
              var freq, hasFreq;
              #freq, hasFreq = Pitch.kr(
                    SoundIn.ar(\micIn.kr(~audioInBus), 1);
              );
              PitchShiftPA.ar(
                    SoundIn.ar(\micIn.kr(~audioInBus), 1)  * \shiftInputVol.kr(1),
                    freq, \pitchRatio.kr(ratio[int]),
                    \formantRatio.kr(1), \minFreq.kr(10),
                    \maxFormantRatio.kr(10), \grainsPeriod.kr(2)) * \shiftVol.kr(0);
        };
            ~encoders[int].source = {
              HOAEncoder.ar(~order, \in.ar(0), \az.kr(az[int]), \el.kr(el[int]), 0.5, \spherical.ir(1), \rad.kr(rad[int]), 1.07);
              };
            });
    };
//    ~notesArrays = MatrixArray.with([[15/8, 3/2, 5/4], [8/5, 3/2, 6/5], [16/15, 8/5, 4/3], [5/4, 5/3, 4/3], [7/4, 12/7, 7/6], [7/4, 12/7, 8/7], [15/8, 15/14, 3/2], [40/21, 5/3, 4/3], [32/21, 16/9, 4/3], [64/49, 96/49, 4/3], [32/27, 10/9, 16/9], [10/9, 40/21, 5/3], [15/8, 3/2, 5/4], [5/4, 1/1, 5/3], [10/9, 5/3, 4/3], [64/45, 15/14, 12/7], [5/4, 5/3, 4/3], [5/3, 9/8, 7/4], [9/8, 3/2, 6/5], [64/45, 27/14, 5/3]]);
//    ~spatArrays = MatrixArray.with([[0.78539816, 1.5707963, 0.0], [3.1415927, 1.5707963, 2.3561945], [-2.3561945, 3.1415927, -1.5707963], [0.0, -0.78539816, -1.5707963], [0.78539816, 2.3561945, -0.78539816], [0.78539816, 2.3561945, -2.3561945], [0.78539816, 0.39269908, 1.5707963], [-0.52359878, -0.78539816, -1.5707963], [-1.727876, -1.5707963, -1.5707963], [-2.7488936, 2.7488936, -1.5707963], [-1.5707963, -0.78539816, -1.5707963], [-0.78539816, -0.52359878, -0.78539816], [0.78539816, 1.5707963, 0.0], [0.0, 0.0, -0.78539816], [-0.78539816, -0.78539816, -1.5707963], [-2.5132741, 0.39269908, 2.3561945], [0.0, -0.78539816, -1.5707963], [-0.78539816, 1.5707963, 0.78539816], [1.5707963, 1.5707963, 2.3561945], [-2.5132741, 1.727876, -0.78539816]]);
//    ~elArrays = MatrixArray.with([[0.62831853, 0, 0], [0, 0, 0.62831853], [0.62831853, 0, 0], [0, 0.78539816, 0], [0.4712389, 0.4712389, 0.4712389], [0.4712389, 0.4712389, 0.4712389], [0.62831853, 0.62831853, 0], [0.9424778, 0.78539816, 0], [0.78539816, 0.62831853, 0], [0.62831853, 0.62831853, 0], [0.9424778, 0.9424778, 0.62831853], [0.9424778, 0.9424778, 0.78539816], [0.62831853, 0, 0], [0, 0, 0.78539816], [0.9424778, 0.78539816, 0], [0.9424778, 0.62831853, 0.4712389], [0, 0.78539816, 0], [0.78539816, 0.62831853, 0.4712389], [0.62831853, 0, 0.62831853], [0.9424778, 0.78539816, 0.78539816]]);
//    ~radArrays = MatrixArray.with([[6, 3, 3], [3, 3, 6], [6, 3, 3], [3, 6, 3], [3, 3, 3], [3, 3, 3], [6, 3, 3], [6, 6, 3], [6, 6, 3], [3, 3, 3], [9, 9, 6], [9, 6, 6], [6, 3, 3], [3, 3, 6], [9, 6, 3], [9, 3, 3], [3, 6, 3], [6, 6, 3], [6, 3, 6], [9, 6, 6]]);
    ~shiftVol = { arg vol;
      ~shifters.do({arg obj, int;
            ~shifters[int].set(\shiftVol, vol);
      });
    };
    ~shiftInputVol = { arg vol;
      ~shifters.do({arg obj, int;
            ~shifters[int].set(\shiftInputVol, vol);
      });
    };
  };
~change = { arg index = 0;
  var root;
  "*** Current section played is ".post; index.postln;
  ~changeChord.value(index);
  switch(index,
        13, {root = ~baseFifth},
        14, {root = ~baseSecond},
        15, {root = ~baseSeven},
        17, {root = ~baseFifth},
        18, {root = ~baseSecond},
        19, {root = ~baseSeven},
        root = ~baseFreq
  );
  ~notesArrayFunc.value(index, ~defaultChOffset, root);
};
//~change.value(19);
//     s.meter;
// 6 dominant 7 avspänning 9 öppet 
// 3 -> 4 ->  0 -> 4 | 8
)
