require 'package'

class Avocado < Package
  description 'Avocado is a next generation testing framework inspired by Autotest and modern development tools such as git.'
  homepage 'http://avocado-framework.github.io/'
  version '60.0'
  source_url 'https://github.com/avocado-framework/avocado/archive/60.0.tar.gz'
  source_sha256 'cadafe363a315a1dd3b332f66407da68748bcbe534153e20c59d588daa83a4ce'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/avocado-60.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/avocado-60.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/avocado-60.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/avocado-60.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'f434f34711084c9e425b6c6ea9f6a3412274cb41b2ab59027bc3919c811a2c7a',
     armv7l: 'f434f34711084c9e425b6c6ea9f6a3412274cb41b2ab59027bc3919c811a2c7a',
       i686: 'f8284b6aa7b57571759724904979a0052ff42abd0009b2b785c03440ad365437',
     x86_64: 'c8db96fe48bdade9f974931f6eac557f7e2d65292a335449b4fdbc6c47b4ee53',
  })

  depends_on 'python27' unless File.exists? "#{CREW_PREFIX}/bin/pip"
  depends_on 'xzutils'

  def self.install
    system "pip install avocado-framework -r requirements.txt --root #{CREW_DEST_DIR} --prefix #{CREW_PREFIX}"
    system "mkdir -p $HOME/.config/avocado"
    system "ln -sf #{CREW_PREFIX}/etc/avocado/avocado.conf $HOME/.config/avocado/avocado.conf"
    system "mkdir -p #{CREW_DEST_DIR}/$HOME/.config/avocado"
    system "ln -sf #{CREW_PREFIX}/etc/avocado/avocado.conf #{CREW_DEST_DIR}/$HOME/.config/avocado/avocado.conf"
  end

  def self.postinstall
    # For some reason, avocado is not executable.
    system "chmod +x #{CREW_PREFIX}/bin/avocado"
  end
end
