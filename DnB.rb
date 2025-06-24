

use_debug false
use_bpm 78
synth1_play = 1

big_bass = "/home/student/Desktop/Samples/Stings 'n' Pads/Looped/Wonder02_L.wav"

V1 = "/home/student/Desktop/Samples/Chaos/voice/vox06.wav"

V2 = "/home/student/Desktop/Samples/Chaos/voice/vox13.wav"

live_loop :met do
sleep 1
end

live_loop :foo do
sleep 2
end

### drums

live_loop :sample_amen_full, sync: :met do

with_fx :hpf, cutoff: 65, amp: 0.9 do

sample :loop_amen_full, beat_stretch: 8
sleep 8

sample :loop_amen_full, beat_stretch: 8, start: 0, finish: 0.75, sustain: bt(1)
sleep 6
end
sleep 2
end

live_loop :dnb, sync: :met do

sleep 8
with_fx :hpf, cutoff: 20, amp: 1 do
with_fx :bitcrusher, bits: 6 do
32.times do
sample :loop_amen, onset: pick, release: 0.2, sustain: 0
sleep 0.250

end
end
end
end

live_loop :voice, sync: :met do

sleep 8
sample V1, beat_stretch: 2, amp: 0.5
sleep 8
sample V2, beat_stretch: 2, amp: 0.5

end

live_loop :drum_splash, sync: :met do
sample :drum_splash_soft
sleep 16
end
### melodie
sleep 8
melody_chain = {}
last_notes = [60, 62]

live_loop :evolving_melody1, sync: :met do
with_fx :wobble, invert_wave: [1,0].tick, phase: 16, wave: 0, mix: 0.2 do
use_synth :dsaw
next_note = melody_chain[last_notes] || scale(:c3, :minor_pentatonic).choose
play next_note, release: 2.125, amp: 0.125, sustain: rrand(2,4)
melody_chain[last_notes] = scale(:c3, :minor_pentatonic).choose
last_notes = [last_notes[1], next_note]
sleep 8
end
end
###
sleep 16
live_loop :synth1, sync: :met do
if synth1_play < 1 then stop end
use_synth_defaults release: 0.3, sustain: 8, amp: rrand(1.5,2), attack: 0.12, cutoff: 90

key = :c3

with_fx :bpf, centre: 80, mix: 0.9 do
with_fx :wobble, invert_wave: [1,0].tick, phase: 16, wave: 0, mix: 0.2 do

with_fx :slicer, phase: 0.125, mix: 0.5 do
synth :dark_ambience, note: chord(key, :m7, invert: -1)
##| synth :subpulse, note: chord(key, :m7, invert: 2)
sleep 8

synth :dark_ambience, note: chord(:eb3, :m7, invert: -1)
##| synth :subpulse, note: chord(key-2, :m7, invert: 2)
sleep 8

synth :dark_ambience, note: chord(:g3, :M7, invert: -1)
##| synth :subpulse, note: chord(key+2, :M7, invert: 2)
sleep 8

synth :dark_ambience, note: chord(:bb3, :M7, invert: -1)
##| synth :subpulse, note: chord(key+3, :M7, invert: 2)
sleep 8
end
end
end
end

sleep 128

live_loop :fade_out_sample, sync: :met do
with_fx :reverb, mix: 0.4 do
sample big_bass,
rate: 0.7,
amp: 1, # direkt fett reinkommen
attack: 0,
sustain: 0.5,
release: 64
end
sleep 48
end

