require 'package'

class Orc < Package
  description 'Optimized Inner Loop Runtime Compiler'
  homepage 'https://gitlab.freedesktop.org/gstreamer/orc'
  @_ver = '0.4.32'
  version @_ver
  compatibility 'all'
  source_url "https://github.com/GStreamer/orc/archive/#{@_ver}.tar.gz"
  source_sha256 '6a7349d2ab4a73476cd4de36212e8c3c6524998081aaa04cf3a891ef792dd50f'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/orc-0.4.32-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/orc-0.4.32-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/orc-0.4.32-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/orc-0.4.32-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'f1454d82feafc44e7925e22d43ebce845536ce8931b939ea5a0098dbe0f78880',
     armv7l: 'f1454d82feafc44e7925e22d43ebce845536ce8931b939ea5a0098dbe0f78880',
       i686: '2782668ca3e7d98ea1c5034560fa2e734dc1f5fdd868944999eeaf164a03c5ec',
     x86_64: '31c20cfc000b15c7bffceb6aec67bb337a7240eef8c62d74349cd553ed615b6d'
  })

  depends_on 'valgrind' => ':build'
  depends_on 'gtk_doc' => ':build'

  def self.build
    system "meson #{CREW_MESON_LTO_OPTIONS} \
      builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
