require 'package'

class Podofo < Package
  description 'A PDF parsing, modification and creation library.'
  homepage 'https://sourceforge.net/projects/podofo/'
  version '0.10.1'
  license 'GPLv2'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/podofo/podofo/archive/0.10.1.tar.gz'
  source_sha256 '9b2bb5d54185a547e440413ca2e9ec3ea9c522fec81dfeb9a23dbc3d65fbaa55'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/podofo/0.10.1_armv7l/podofo-0.10.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/podofo/0.10.1_armv7l/podofo-0.10.1-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/podofo/0.10.1_x86_64/podofo-0.10.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '2bf578c3a6f230cb1831787c4dc0c0ad88ae28918b05eaf4b684b8d19a89fba4',
     armv7l: '2bf578c3a6f230cb1831787c4dc0c0ad88ae28918b05eaf4b684b8d19a89fba4',
     x86_64: '0250cbf80a3144858950666ae92ebc57d84a093c817a2191a9d326bbe5015091'
  })

  depends_on 'fontconfig'
  depends_on 'freetype'
  depends_on 'libidn'
  depends_on 'libjpeg'
  depends_on 'libpng'
  depends_on 'libtiff'
  depends_on 'libxml2'
  depends_on 'openssl'
  depends_on 'zlibpkg'

  def self.build
    system "cmake -G 'Unix Makefiles' \
      -B builddir #{CREW_CMAKE_OPTIONS} \
      -DPODOFO_BUILD_TOOLS=TRUE"
    system 'make -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} make -C builddir install"
  end
end
