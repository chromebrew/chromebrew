require 'package'

class Libxv < Package
  description 'X.org X Window System video extension library'
  homepage 'https://www.x.org'
  version '1.0.12'
  license 'X11'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/xorg/lib/libxv.git'
  git_hashtag "libXv-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4e5f88214475460f9bd909012086c1a57b833168aca923fbab396abaf0589be4',
     armv7l: '4e5f88214475460f9bd909012086c1a57b833168aca923fbab396abaf0589be4',
       i686: 'dd6099a25f76a939900986088134d79bd052f8cf5606a4bd2830cc2cf89b5fe5',
     x86_64: 'cddf3a775a03649be663cd00d605461f4d7eb4975630cf4cebee4d65b7828b06'
  })

  depends_on 'glibc' # R
  depends_on 'libbsd' # R
  depends_on 'libmd' # R
  depends_on 'libx11' # R
  depends_on 'libxau' # R
  depends_on 'libxcb' # R
  depends_on 'libxdmcp' # R
  depends_on 'libxext' # R

  def self.build
    system '[ -x configure ] || NOCONFIGURE=1 ./autogen.sh'
    system "./configure #{CREW_OPTIONS} \
      --sysconfdir=#{CREW_PREFIX}/etc"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
