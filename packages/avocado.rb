require 'package'

class Avocado < Package
  description 'Avocado is a next generation testing framework inspired by Autotest and modern development tools such as git.'
  homepage 'http://avocado-framework.github.io/'
  version '57.0-1'
  source_url 'https://github.com/avocado-framework/avocado/archive/57.0.tar.gz'
  source_sha256 'c49fdf0946eed445fd8397354db3491869389ed4578ba477d447f105c99f15e4'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/avocado-57.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/avocado-57.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/avocado-57.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/avocado-57.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '7145a4b0c550c49abd7045d9964f49b35491fa17828339a5ee709daeebafd913',
     armv7l: '7145a4b0c550c49abd7045d9964f49b35491fa17828339a5ee709daeebafd913',
       i686: 'bc5a0fa2e7c18c382d69ad7be7f141074729c12e9723a7ce49a36b8586af937b',
     x86_64: 'c742ec98b24cf17d6709edecfa028a9ebedf80863fff6d075ef78e2dd4c1a632',
  })

  depends_on 'python27' unless File.exists? "#{CREW_PREFIX}/bin/pip"
  depends_on 'xzutils'

  def self.install
    system "pip install avocado-framework --root #{CREW_DEST_PREFIX} --prefix #{CREW_DEST_PREFIX}"
    system "pip install -r https://raw.githubusercontent.com/avocado-framework/avocado/master/requirements.txt --root #{CREW_DEST_PREFIX} --prefix #{CREW_DEST_PREFIX}"
    system "mv #{CREW_DEST_PREFIX}/usr/libexec #{CREW_DEST_PREFIX}"
    system "mv #{CREW_DEST_PREFIX}/usr/share #{CREW_DEST_PREFIX}"
    system "mv #{CREW_DEST_PREFIX}#{CREW_DEST_PREFIX}/* #{CREW_DEST_PREFIX}"
    system "rm -rf #{CREW_DEST_PREFIX}#{CREW_PREFIX}/tmp"
    system "mkdir -p $HOME/.config/avocado"
    system "ln -sf #{CREW_PREFIX}/etc/avocado/avocado.conf $HOME/.config/avocado/avocado.conf"
    system "mkdir -p #{CREW_DEST_DIR}/$HOME/.config/avocado"
    system "ln -sf #{CREW_PREFIX}/etc/avocado/avocado.conf #{CREW_DEST_DIR}/$HOME/.config/avocado/avocado.conf"
  end
end
