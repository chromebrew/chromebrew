require 'package'

class Xinit < Package
  description 'The xinit package contains a usable script to start the xserver.'
  homepage 'https://www.x.org'
  version '1.4.1'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://www.x.org/archive/individual/app/xinit-1.4.1.tar.gz'
  source_sha256 'ca33ec3de6c39589c753620e5b3bcbc8277218b949bfa2df727779b03a8d2357'

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
