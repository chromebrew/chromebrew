require 'package'

class Libxfont2 < Package
  description 'X.org X font library'
  homepage 'http://www.x.org'
  version '2.0.6'
  license 'MIT'
  compatibility 'all'
  source_url 'https://www.x.org/archive/individual/lib/libXfont2-2.0.6.tar.xz'
  source_sha256 '74ca20017eb0fb3f56d8d5e60685f560fc85e5ff3d84c61c4cb891e40c27aef4'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ab1e630f1c5a7a5917620dfb5bd34feeea7fdc002f73166d2ef8ed7674a1c537',
     armv7l: 'ab1e630f1c5a7a5917620dfb5bd34feeea7fdc002f73166d2ef8ed7674a1c537',
       i686: '24fb09e7a20f00a144c3c96b329243c0ea7c0d6eaa365d1025a9c29e9a6a5152',
     x86_64: '4a72ab2f2da91acfff1ff03d0b7c47ac37ad9d0d3c5adc1d6ad1e98448f24200'
  })

  depends_on 'fop' => :build
  depends_on 'libxtrans'
  depends_on 'libfontenc'
  depends_on 'libx11'
  depends_on 'harfbuzz' => :build
  depends_on 'xmlto' => :build

  def self.build
    system '[ -x configure ] || NOCONFIGURE=1 ./autogen.sh'
    system "./configure #{CREW_OPTIONS} \
      --disable-selective-werror"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
