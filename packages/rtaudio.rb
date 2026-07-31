require 'buildsystems/autotools'

class Rtaudio < Autotools
  description 'RtAudio is a set of C++ classes that provide a common API (Application Programming Interface) for realtime audio input/output'
  homepage 'https://github.com/thestk/rtaudio'
  version '6.0.1'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/thestk/rtaudio.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '770a125f507cfb03c6244c9d35b2b9a2479ba28364482d8c025abe04ec655fc9',
     armv7l: '770a125f507cfb03c6244c9d35b2b9a2479ba28364482d8c025abe04ec655fc9',
     x86_64: 'cb1d1eb3e165c7cb76c6eef9abc62974add54378459e797c0de578a76f4fcf23'
  })

  depends_on 'alsa_lib' => :library
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'jack' => :library
  depends_on 'pulseaudio' => :library

  autotools_configure_options '--with-alsa --with-jack --with-pulse'
end
