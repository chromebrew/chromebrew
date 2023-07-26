require 'package'

class Ctorrent < Package
  description 'CTorrent is a BitTorrent client implemented in C++ to be lightweight and quick.'
  homepage 'http://www.rahul.net/dholmes/ctorrent/'
  version '3.3.2'
  revision 1
  license 'GPL-2'
  compatibility 'all'
  source_url 'http://www.rahul.net/dholmes/ctorrent/ctorrent-dnh3.3.2.tar.gz'
  source_sha256 'c87366c91475931f75b924119580abd06a7b3cb3f00fef47346552cab1e24863'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ctorrent/3.3.2-1_armv7l/ctorrent-3.3.2-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ctorrent/3.3.2-1_armv7l/ctorrent-3.3.2-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ctorrent/3.3.2-1_i686/ctorrent-3.3.2-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ctorrent/3.3.2-1_x86_64/ctorrent-3.3.2-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '4f56ef37eccd39f4a2b410feaacd1d2904d789af45e72b3a7bdab3cda30d764e',
     armv7l: '4f56ef37eccd39f4a2b410feaacd1d2904d789af45e72b3a7bdab3cda30d764e',
       i686: '9fcf5a83b561500c4ec44dfbcedc0dc3fd51343221ae6a65d8496cb9a8f8b750',
     x86_64: '74fa2be2160fb2ffa7fe9fa2479d52636be246db4da7955518eed5fc1b7c2959'
  })

  def self.build
    system './configure'
  end

  def self.check
    system 'make', 'check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
