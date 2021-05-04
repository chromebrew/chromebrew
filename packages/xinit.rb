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
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xinit/1.4.1_armv7l/xinit-1.4.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xinit/1.4.1_armv7l/xinit-1.4.1-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xinit/1.4.1_i686/xinit-1.4.1-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xinit/1.4.1_x86_64/xinit-1.4.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '269e5d57c7dbde243914bba10782a9b7a237840f132ff20b7037d264da1a1cea',
     armv7l: '269e5d57c7dbde243914bba10782a9b7a237840f132ff20b7037d264da1a1cea',
       i686: '46496e925ada2487dcb695fea39987fd2d96b962f623f3ccf8cf0184a49d10c5',
     x86_64: 'e26fee34f297ca45faff99054a6fbf84e019925326d3b45244f40cb70725c930',
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
