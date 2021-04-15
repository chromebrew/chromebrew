require 'package'

class Xinit < Package
  description 'The xinit package contains a usable script to start the xserver.'
  homepage 'https://www.x.org'
  version '1.4.1'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://www.x.org/archive/individual/app/xinit-1.4.1.tar.gz'
  source_sha256 'ca33ec3de6c39589c753620e5b3bcbc8277218b949bfa2df727779b03a8d2357'

  binary_url ({
    aarch64: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/xinit-1.4.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/xinit-1.4.1-chromeos-armv7l.tar.xz',
       i686: 'https://downloads.sourceforge.net/project/chromebrew/i686/xinit-1.4.1-chromeos-i686.tar.xz',
     x86_64: 'https://downloads.sourceforge.net/project/chromebrew/x86_64/xinit-1.4.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '5a2f573c38e0600253daad127d3b97835f2a51ba38ea8256aa8f3ee4198c4762',
     armv7l: '5a2f573c38e0600253daad127d3b97835f2a51ba38ea8256aa8f3ee4198c4762',
       i686: '4105018036e9ca0604f2daea0a1c0e60c372fc7465b4a3cc6c694736e0f9f30d',
     x86_64: 'aa1549d8e68349f51b810caecf94c4677fa410c47d1c56735ccb142ad7f9ddc1',
  })

  depends_on 'xauth'
  depends_on 'xterm'

  def self.build
    system "env #{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
