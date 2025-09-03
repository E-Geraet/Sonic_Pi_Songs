use_bpm 44
chords = [2,4,6,5,2,4,1,3]
sc1 = :G3
sc2 = :major
no  = 4
set :g_amp, 0.125
set :good_amp, 0.085

git = "/home/student/Desktop/Samples/meinesongs/sad_guitar-359666.mp3"
loui = "/home/student/Desktop/Samples/meinesamples/loui.wav"
piano = "/home/student/Desktop/Samples/meinesamples/nostalgic-piano-396511.mp3"



live_loop :ticktack do
  sleep 1
end



# ======================
# DRUM SAMPLE SETUP
# ======================
drums = {
  kick:  "/home/student/Desktop/Samples/Beats/triphop/drum/tr hrk bd 01 a.wav",
  snare: "/home/student/Desktop/Samples/Beats/hiphop/hhd1snr08.wav",
  hh_c:  "/home/student/Desktop/Samples/Beats/hiphop/hi_c_06b.wav",
  hh_o:  "/home/student/Desktop/Samples/Beats/triphop/drum/ohh4.wav",
}

# Sequencer-Patterns
# ======================
# LOFI DRUM SEQUENCER
# ======================

kick_rhythm  = [0,0,0,1, 0,0,0,1,  0,0,0,1, 0,1,0,1,
                0,0,0,1, 0,0,0,1,  0,0,0,1, 0,1,0,1]

snare_rhythm = [0,0,0,0, 1,0,0,0,  0,0,0,0, 1,0,0,0,
                0,0,0,0, 1,0,0,0,  0,0,0,0, 1,0,0,0]

hh_rhythm    = [2,0,0,0, 0,0,0,0,  0,0,0,0, 1,0,1,0,
                0,0,0,0, 0,0,0,0,  0,0,0,0, 1,0,1,0]


# ======================
# DRUM LOOPS
# ======================

live_loop :klav, sync: :ticktack do
  stop
  with_fx :echo, max_phase: 0.1 do
    sample piano, amp: 0.2
    sleep 42069
  end
end

sleep 16

live_loop :louis, sync: :ticktack do
  stop
  sample loui, amp: 0.8
  sleep 42069
end

sleep 64


live_loop :hihat, sync: :ticktack do
  stop
  for step in hh_rhythm
    if step == 1
      sample drums[:hh_c], amp: 0.7
    elsif step == 2
      sample drums[:hh_o], amp: 0.7
    end
    sleep 0.25
  end
end
sleep 4

live_loop :kick, sync: :ticktack do
  #stop
  for step in kick_rhythm
    sample drums[:kick] if step == 1
    sleep 0.25
  end
end
sleep 4

live_loop :snare, sync: :ticktack do
  #stop
  for step in snare_rhythm
    sample drums[:snare] if step == 1
    sleep 0.25
  end
end


sleep 8
live_loop :metro, sync: :ticktack do
  stop
  use_synth :cnoise
  use_synth_defaults attack: 0, sustain: 4, release: 0, amp: 0.5
  with_fx :slicer, phase: 0.25, pulse_width: 0.3 do
    with_fx :hpf, cutoff: 130 do
      
      64. times do
        play 60, amp: rrand(0.125,0.225)
        
        sleep 1
      end
      sleep 1024
    end
  end
end




sleep 16

# ======================
# MAIN LOOPS
# ======================

live_loop :guitar, sync: :ticktack do
  stop
  use_real_time
  g_amp = get(:g_amp)
  with_fx :flanger, phase: 2 do
    sample git, beat_stretch: 32, amp: g_amp
  end
  set :g_amp, g_amp + 0.25
  sleep 148
end

sleep 24
# ======================
# CHORDS + BASS
# ======================
live_loop :chord, sync: :ticktack do
  stop
  with_fx :vowel do
    for i in chords
      inv = if i < 3
        0
      elsif i < 5
        -1
      elsif i < 7
        -2
      else
        -3
      end
      2.times do
        use_synth :fm
        play (chord_degree i, sc1, sc2, no)[0]-12, cutoff: 60, decay: 1.2, release: 0.8
        use_synth :dpulse
        play_chord (chord_degree i, sc1, sc2, no, invert: inv),
          cutoff: 50, decay: 1.2, sustain_level: 0.8
        sleep 2
      end
    end
  end
end
sleep 16
live_loop :bass, sync: :ticktack do
  stop
  with_fx :slicer do
    with_fx :level, amp: 0.5 do
      synth :sine, note: :d1, sustain: rrand(1.5,2), release: rrand(1.5,2), amp: 0.5
      sleep 4
      synth :sine, note: :c1, sustain: rrand(1.5,2), release: rrand(1.5,2), amp: 0.5
      sleep 4
      synth :sine, note: :b1, sustain: rrand(1.5,2), release: rrand(1.5,2), amp: 0.5
      sleep 4
      synth :sine, note: :as1, sustain: rrand(1.5,2), release: rrand(1.5,2), amp: 0.5
      sleep 4
    end
  end
end
sleep 16
live_loop :bass2, sync: :ticktack do
  stop
  with_fx :wobble do
    with_fx :slicer do
      with_fx :level, amp: 0.1 do
        synth :hoover, note: :d1, sustain: rrand(1.5,2), release: rrand(1.5,2), amp: 0.125
        sleep 4
        synth :hoover, note: :c1, sustain: rrand(1.5,2), release: rrand(1.5,2), amp: 0.15
        sleep 4
        synth :hoover, note: :b1, sustain: rrand(1.5,2), release: rrand(1.5,2), amp: 0.175
        sleep 4
        synth :hoover, note: :as1, sustain: rrand(1.5,2), release: rrand(1.5,2), amp: 0.125
        
        sleep 4
      end
    end
  end
  sleep 32
end


