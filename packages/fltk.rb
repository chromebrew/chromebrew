require 'package'

class Fltk < Package
  description 'Fast Light Toolkit or FLTK (pronounced "fulltick") is a cross-platform C++ GUI toolkit'
  homepage 'https://www.fltk.org/'
  version '1.3.8'
  license 'FLTK and LGPL-2'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://www.fltk.org/pub/fltk/1.3.8/fltk-1.3.8-source.tar.bz2'
  source_sha256 '1d9832409fc08c908c64ab40ad9fd8b0e8af5d203651eb9690b810f41e2f412d'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/fltk/1.3.8_armv7l/fltk-1.3.8-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/fltk/1.3.8_armv7l/fltk-1.3.8-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/fltk/1.3.8_x86_64/fltk-1.3.8-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '0eb0447c12dc146a402b31c0b829d8b9bb74c148454a2b5bda1b7546291062ef',
     armv7l: '0eb0447c12dc146a402b31c0b829d8b9bb74c148454a2b5bda1b7546291062ef',
     x86_64: 'b6ae65a5a86c7ea727358a0333a261d4f67bfbfc1f51b68c81e099b1f0d2b614'
  })

  depends_on 'sommelier'

  def self.build
    system "cmake -B builddir \
      #{CREW_CMAKE_OPTIONS} \
      -DOPTION_BUILD_EXAMPLES=OFF \
      -DOPTION_BUILD_SHARED_LIBS=ON \
      -G Ninja"
    system "#{CREW_NINJA} -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
  end
end
