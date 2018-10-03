require 'package'

class Avocado < Package
  description 'Avocado is a next generation testing framework inspired by Autotest and modern development tools such as git.'
  homepage 'http://avocado-framework.github.io/'
  version '64.0'
  source_url 'https://github.com/avocado-framework/avocado/archive/64.0.tar.gz'
  source_sha256 'bf1434d61754f389771dc38beb66a62ee6cca95f5224b17eb2a4ca2f7abf22ab'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'python3'
  depends_on 'xzutils'
  depends_on 'setuptools'

  def self.build
    system "python3 setup.py build"
  end

  def self.install
    system "pip3 install avocado-framework -r requirements.txt --root #{CREW_DEST_DIR} --prefix #{CREW_PREFIX}"
    system "python3 setup.py install --root #{CREW_DEST_DIR} --prefix #{CREW_PREFIX}"
    system "mkdir -p $HOME/.config/avocado"
    system "ln -sf #{CREW_PREFIX}/etc/avocado/avocado.conf $HOME/.config/avocado/avocado.conf"
    system "mkdir -p #{CREW_DEST_HOME}/.config/avocado"
    system "ln -sf #{CREW_PREFIX}/etc/avocado/avocado.conf #{CREW_DEST_HOME}/.config/avocado/avocado.conf"
  end
end
