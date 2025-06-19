require 'buildsystems/autotools'

class Libbluray < Autotools
  description 'This library is simply a tool for playback of Blu-ray movies.'
  homepage 'https://www.videolan.org/developers/libbluray.html'
  version '1.3.4'
  compatibility 'aarch64 armv7l x86_64'
  license 'LGPL-2.1'
  source_url "https://download.videolan.org/pub/videolan/libbluray/#{version}/libbluray-#{version}.tar.bz2"
  source_sha256 '478ffd68a0f5dde8ef6ca989b7f035b5a0a22c599142e5cd3ff7b03bbebe5f2b'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bf82630d544040492dd6d8d9f835ef448c6cce5752a50958b564bc17517fec60',
     armv7l: 'bf82630d544040492dd6d8d9f835ef448c6cce5752a50958b564bc17517fec60',
     x86_64: '87b6906c40fd5064b8b66df2e396d251164a672b2b7e3c07f7b36f2857844c8d'
  })

  depends_on 'ant' => :build
  depends_on 'fontconfig'
  depends_on 'freetype'
  depends_on 'glibc' # R
  depends_on 'harfbuzz' # R
  depends_on 'libxml2'

  autotools_configure_options '--disable-examples'
end
