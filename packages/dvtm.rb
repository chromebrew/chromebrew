require 'package'

class Dvtm < Package
  description 'dynamic virtual terminal manager'
  homepage 'https://www.brain-dump.org/projects/dvtm/'
  version '0.15'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/martanne/dvtm/releases/download/v0.15/dvtm-0.15.tar.gz'
  source_sha256 '8f2015c05e2ad82f12ae4cf12b363d34f527a4bbc8c369667f239e4542e1e510'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/dvtm/0.15_armv7l/dvtm-0.15-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/dvtm/0.15_armv7l/dvtm-0.15-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/dvtm/0.15_i686/dvtm-0.15-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/dvtm/0.15_x86_64/dvtm-0.15-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '572ac426b7ab0e524663f1379bcad050bcb83461d23c362dad52726a97c18c1a',
     armv7l: '572ac426b7ab0e524663f1379bcad050bcb83461d23c362dad52726a97c18c1a',
       i686: '3c583a0044d4715fb239461a77f74ec5e5dbfb0d26eee2e2fbbdbe8135fc391c',
     x86_64: 'b9933b25910f69410b25b3d0e771d3daff8454c9e7bdb52a394e661acd2a3012'
  })

  depends_on 'ncurses'

  def self.build
    system "PREFIX=#{CREW_PREFIX} \
            CFLAGS='-I#{CREW_PREFIX}/include/ncursesw' \
            LDFLAGS='-ltinfow' \
            make"
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
