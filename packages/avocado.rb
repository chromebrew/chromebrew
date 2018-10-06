require 'package'

class Avocado < Package
  description 'Avocado is a next generation testing framework inspired by Autotest and modern development tools such as git.'
  homepage 'http://avocado-framework.github.io/'
  version '64.0'
  source_url 'https://github.com/avocado-framework/avocado/archive/64.0.tar.gz'
  source_sha256 'bf1434d61754f389771dc38beb66a62ee6cca95f5224b17eb2a4ca2f7abf22ab'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/avocado-64.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/avocado-64.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/avocado-64.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/avocado-64.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'a2659851c10f6b1d57bf55c6e15f035183a256951422004bff486eb1ec338222',
     armv7l: 'a2659851c10f6b1d57bf55c6e15f035183a256951422004bff486eb1ec338222',
       i686: 'd7c93778bdc3f7eeffca15e38fa2208f5dac6a2bce16aa6caee97aebf0dce375',
     x86_64: '223c4eccb8c646453f633ebb6b6c8b23bf52535ba4895999a029db7c92329ca3',
  })

  depends_on 'xdg_base'
  depends_on 'xzutils'
  depends_on 'setuptools'

  def self.install
    system "pip3 install -r requirements.txt --root #{CREW_DEST_DIR} --prefix #{CREW_PREFIX}"
    system "python3 setup.py install --root #{CREW_DEST_DIR} --prefix #{CREW_PREFIX}"
    system "mkdir -p $HOME/.config/avocado"
    system "ln -sf #{CREW_PREFIX}/etc/avocado/avocado.conf $HOME/.config/avocado/avocado.conf"
    system "mkdir -p #{CREW_DEST_HOME}/.config/avocado"
    system "ln -sf #{CREW_PREFIX}/etc/avocado/avocado.conf #{CREW_DEST_HOME}/.config/avocado/avocado.conf"
  end
end
