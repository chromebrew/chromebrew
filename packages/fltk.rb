require 'package'

class Fltk < Package
  description 'Fast Light Toolkit or FLTK (pronounced "fulltick") is a cross-platform C++ GUI toolkit'
  homepage 'https://www.fltk.org/'
  version '1.3.9'
  license 'FLTK and LGPL-2'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://www.fltk.org/pub/fltk/1.3.9/fltk-1.3.9-source.tar.bz2'
  source_sha256 '103441134915402808fd45424d4061778609437e804334434e946cfd26b196c2'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/fltk/1.3.9_armv7l/fltk-1.3.9-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/fltk/1.3.9_armv7l/fltk-1.3.9-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/fltk/1.3.9_x86_64/fltk-1.3.9-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'dba8dab43b88e317c70b674d84cf787ed56f5e7ff81e66b51056be549a85bcec',
     armv7l: 'dba8dab43b88e317c70b674d84cf787ed56f5e7ff81e66b51056be549a85bcec',
     x86_64: '3f46ea64f96026a3b8c62f4ea8951a69365c7c2340e9d3c64885978980946159'
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
