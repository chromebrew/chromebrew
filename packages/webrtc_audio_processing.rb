require 'package'

class Webrtc_audio_processing < Package
  description 'AudioProcessing library based on Googles implementation of WebRTC'
  homepage 'https://freedesktop.org/software/pulseaudio/webrtc-audio-processing/'
  @_ver = '1.0'
  version "#{@_ver}-8ac0"
  compatibility 'aarch64,armv7l,x86_64'
  source_url 'https://gitlab.freedesktop.org/pulseaudio/webrtc-audio-processing/-/archive/8ac052ad6ffd5ba1328c44160ec6571dfd9b930d/webrtc-audio-processing-8ac052ad6ffd5ba1328c44160ec6571dfd9b930d.tar.bz2'
  source_sha256 '70d56051f73e8e4ac95fb392ce15de6c633b2c3ae492359aecc72fc663c9bdda'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/webrtc_audio_processing-1.0-8ac0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/webrtc_audio_processing-1.0-8ac0-chromeos-armv7l.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew//webrtc_audio_processing-1.0-8ac0-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'e912396b63680e7a7fc0608310e420d6968a8cd0405e1bfea3111afd40d6786c',
     armv7l: 'e912396b63680e7a7fc0608310e420d6968a8cd0405e1bfea3111afd40d6786c',
     x86_64: '8570e9f6c376a0dd0b477ab87d80f65ebc3f5ab0414af499aeb82a4467876a1c'
  })

  depends_on 'abseil_cpp'

  def self.patch
    system "sed -i '/vector/a #include <memory>' webrtc/modules/audio_processing/aec3/reverb_model_estimator.h"
  end

  def self.build
    system "meson \
    #{CREW_MESON_LTO_OPTIONS} \
    -Dc_std=c17 \
    -Dcpp_std=c++17 \
     builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
