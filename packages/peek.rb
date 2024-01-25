require 'package'

class Peek < Package
  description 'Simple animated GIF screen recorder with an easy to use interface'
  homepage 'https://github.com/phw/peek'
  version '1.5.1'
  license 'GPL-3+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/phw/peek/archive/1.5.1.tar.gz'
  source_sha256 'd2b52297d3941db2f10ad4dd00a6d5606728c0fee6af5f1594a036f88e478237'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2e1bb8fd9bf25cec736ccd4417b7b1154b74371f50bdf4836401c15d758354f8',
     armv7l: '2e1bb8fd9bf25cec736ccd4417b7b1154b74371f50bdf4836401c15d758354f8',
     x86_64: 'be10108eca6b1520a137e0e70ca2401dc99176e1c573bdbbc16b1f9b47e7df85'
  })

  depends_on 'ffmpeg' => :build
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gtk3' # R
  depends_on 'harfbuzz' # R
  depends_on 'pango' # R
  depends_on 'vala' => :build
  depends_on 'gcc_lib' # R

  def self.build
    system "mold -run meson setup #{CREW_MESON_OPTIONS} \
      -Dbuild-tests=false \
      builddir"
    system 'meson configure --no-pager builddir'
    system "#{CREW_NINJA} -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
  end

  def self.postinstall
    # generate schemas
    system "glib-compile-schemas #{CREW_PREFIX}/share/glib-2.0/schemas"
    # update mime database
    system "update-mime-database #{CREW_PREFIX}/share/mime"
  end
end
