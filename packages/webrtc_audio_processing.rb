require 'buildsystems/meson'

class Webrtc_audio_processing < Meson
  description 'AudioProcessing library based on Googles implementation of WebRTC'
  homepage 'https://freedesktop.org/software/pulseaudio/webrtc-audio-processing/'
  version '2.1'
  license 'BSD'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/pulseaudio/webrtc-audio-processing.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '683a9719e7bcf34dbfdd57225fe1a9aa717509eeee62e7ec64dbde93e40e2197',
     armv7l: '683a9719e7bcf34dbfdd57225fe1a9aa717509eeee62e7ec64dbde93e40e2197',
       i686: 'c03f83448134a4c6b9a647a1ac10d14455c3500b8b661d506265ba3ecf1364c0',
     x86_64: '9b9328d5b0a74ac11ff1a08240918bc70e17e3a728423fc967475da7a4664859'
  })

  depends_on 'abseil_cpp' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  def self.patch
    patches = [
      # Fix build with abseil-cpp 202508
      ['https://gitlab.freedesktop.org/pulseaudio/webrtc-audio-processing/-/merge_requests/60.diff', '4562c231f1051bd327cf27b6940445e5c0d83e5d8427a6ca36c9f0853b3e4a6d'],
      # Fix build with GCC 15
      ['https://gitlab.freedesktop.org/pulseaudio/webrtc-audio-processing/-/merge_requests/58.diff', '5562c231f1051bd327cf27b6940445e5c0d83e5d8427a6ca36c9f0853b3e4a6d']
    ]
    ConvenienceFunctions.patch(patches)
  end
end
