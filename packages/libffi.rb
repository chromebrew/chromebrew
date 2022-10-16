require 'package'

class Libffi < Package
  description 'The libffi library provides a portable, high level programming interface to various calling conventions.'
  homepage 'https://github.com/libffi/libffi/'
  @_ver = '3.4.2'
  version "#{@_ver}-1"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/libffi/libffi.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libffi/3.4.2-1_armv7l/libffi-3.4.2-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libffi/3.4.2-1_armv7l/libffi-3.4.2-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libffi/3.4.2-1_i686/libffi-3.4.2-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libffi/3.4.2-1_x86_64/libffi-3.4.2-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'd975c1b4764f7108d1c3ede80a34d1cfaddf6a293ca0a6a4348c071d6a8ed22a',
     armv7l: 'd975c1b4764f7108d1c3ede80a34d1cfaddf6a293ca0a6a4348c071d6a8ed22a',
       i686: '5558c0372d20b5cb54bc75aa7fbc2ca24be8166e1515f4b91cffb26032a4a071',
     x86_64: 'fec954fcb51b1186ab2d084e29edf05773cf31b0543ad947bf9f325186022ab5'
  })

  depends_on 'glibc' # R

  def self.build
    system 'autoreconf -fiv'
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    # system "make check"         # DejaGNU required
  end
end
