(
var sax, synth, master, mute, currentInputVal, wind, text, textC, textB, textD, mapA, mapB, step, plus, minus, number, annotX, annotY, annotZ, time, start, myClock, input, meters, seqTask, offset = 0;
wind = Window.new("Main", Rect(128, 64, 620, 400)).front;
mapA = ControlSpec(0, 2, \linear, 0.01); // min, max, mapping, step
mapB = ControlSpec(0, 1, \linear, 0.01); // min, max, mapping, step

// Sax volume                                                                               
text = StaticText(wind, Rect(20, 20, 40, 20)).align_(\center);
annotX = StaticText(wind, Rect(15, 350, 50, 20)).align_(\center);
annotX.string_("PitchShift");
sax = Slider(wind, Rect(20, 50, 40, 300))
.value_(0.0)
.action_({
  text.string_(mapA.map(sax.value).asString);
  ~shiftVol.value(mapA.map(sax.value));  
});
sax.action.value;

// Input volume
textC = StaticText(wind, Rect(90, 20, 40, 20)).align_(\center);
annotZ = StaticText(wind, Rect(85, 350, 50, 20)).align_(\center);
annotZ.string_("Input");
input = Slider(wind, Rect(90, 50, 40, 300))
.value_(0.0)
.action_({
  textC.string_(mapA.map(input.value).asString);
  ~shiftInputVol.value(input.value);
});
input.action.value;

{
  SendPeakRMS.kr(Dust.ar(20), 20, 3, "/replyAddress")
}.play;

// Synth volume
textB = StaticText(wind, Rect(160, 20, 40, 20)).align_(\center);
annotY = StaticText(wind, Rect(155, 350, 50, 20)).align_(\center);
annotY.string_("Synth");
synth = Slider(wind, Rect(160, 50, 40, 300))
.value_(0.2)
.action_({
  textB.string_(mapB.map(synth.value).asString);
  //~globSynthVol.set(synth.value);
});
synth.action.value;

// Button
step = Button(wind, Rect(240, 50, 100, 100))
.states_([
  ["0"], ["1"], ["2"],["3"], ["4"],["5"], ["6"],["7"], ["8"],["9"], ["10"],["11"], ["12"],["B1"], ["B2"],["B3"], ["B4"],["C1"], ["C2"],["C3"], ["C4"], ["End"];
])
.action_({ arg butt;
  "Current event is: ".post;
  (butt.value - 1).postln;
  ~change.value(butt.value-1);
});
step.font = Font("Helvetica", 32, bold: true);

number = NumberBox(wind, Rect(240, 170, 100, 40)).align_(\center);
number.font  = Font("Helvetica", 26, bold: true);
number.string = 1;
number.action = {arg num;
  //    step.value = num.value-1;
  number.value = number.value-1;
};

// Goto
plus = Button(wind, Rect(240, 230, 45, 60))
.string_("+")
.action_({ arg butt;
  //    step.value = step.value+1;
  number.value = number.value+1;
});
plus.font = Font("Helvetica", 32, bold: true);

minus = Button(wind, Rect(295, 230, 45, 60))
.string_("-")
.action_({ arg butt;
  step.value = step.value-1;
});
minus.font = Font("Helvetica", 32, bold: true);

meters = Button(wind, Rect(420, 300, 160, 45))
.string_("Meter")
.action_({s.meter;});
meters.font = Font("Helvetica", 24, bold: true);
//myClock.value.postln;

time = StaticText(wind, Rect(420, 30, 200, 100)); //.align_(\center);
time.font = Font("Helvetica", 64, bold: true);
time.string_("00:00");

start = Button(wind, Rect(420, 140, 160, 45))
.string_("Start")
.action_({ arg butt;
  if(start.string == "Start",
        { myClock.value();
          start.string_("Stop");
          seqTask = ~runSequencer.value(number.value.asInteger);	  
        },
        {
          AppClock.clear;
          start.string_("Start");
          seqTask.stop;	  
        });
});
start.font = Font("Helvetica", 24, bold: true);

mute = Button(wind, Rect(420, 200, 160, 45))
.string_("Mute")
.action_({ arg butt;
  //    ~shiftInputVol.value(input.value);
  if(mute.string == "Mute",
        {
          currentInputVal = input.value;	  
          input.valueAction_(0);	  
          mute.string_("Unmute");
        },
        {
          mute.string_("Mute");
          input.valueAction_(currentInputVal);	  
        });

});
mute.font = Font("Helvetica", 24, bold: true);

myClock = {
  var countSec = 0, countMin = 0, secString, res;
  AppClock.sched(0.0, { arg tme;
        countSec = (countSec+1)%60;
        if(countSec == 0,
          { countMin = countMin+1 });
        if(countSec < 10,
          {secString = "0"++countSec; },
          {secString = countSec; });
        if(countMin < 10,
          {countMin = "0"++countMin; });
        //countMin.post; ".".post; secString.postln;
        time.string = countMin++":"++secString;
        1;
  });
};

~runSequencer = { arg offset = 0;
  var seqTask, items;
  items = ~sections.size - offset;

  seqTask = Task({
        items.do({ arg time, index;
          var ndx, section_length;
          AppClock.clear;
          myClock.value();
          // make sure ndx is in range of ~sections (time)
          if((index + offset) < ~sections.size,
                { ndx = index + offset; },
                { ndx = ~sections.size - 1; });
          section_length = ~sections[ndx];
          "*** Section ".post; ndx.post; " ***".postln;
          if(ndx != 0,
                { "Turn on sax".postln;
                  ~shiftInputVol.value(0.6);
                  ~globalRep = ~pBindReps[ndx];
                  ~change.value(~sectionOrder[ndx]);
                  //~change.value(ndx-1);
                },
                { "Turn off sax".postln;
                  ~shiftInputVol.value(0); });
          "  --- waiting for ".post; section_length.post; " seconds".postln;
          section_length.wait;
        });
        "Sequence end".postln;
  }).play;
  seqTask;
};
)
