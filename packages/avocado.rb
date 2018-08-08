require 'package'

class Avocado < Package
  description 'Avocado is a next generation testing framework inspired by Autotest and modern development tools such as git.'
  homepage 'http://avocado-framework.github.io/'
  version '63.0'
  source_url 'https://github.com/avocado-framework/avocado/archive/63.0.tar.gz'
  source_sha256 '5c650b16fac705968306039865e8b08e87663cd0036b670b257d931e237d187c'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'python27' unless File.exists? "#{CREW_PREFIX}/bin/pip"
  depends_on 'xzutils'
  depends_on 'setuptools'

  def self.install
    system "pip install avocado-framework -r requirements.txt --root #{CREW_DEST_DIR} --prefix #{CREW_PREFIX}"
    system "mkdir -p $HOME/.config/avocado"
    system "ln -sf #{CREW_PREFIX}/etc/avocado/avocado.conf $HOME/.config/avocado/avocado.conf"
    system "mkdir -p #{CREW_DEST_DIR}/$HOME/.config/avocado"
    system "ln -sf #{CREW_PREFIX}/etc/avocado/avocado.conf #{CREW_DEST_DIR}/$HOME/.config/avocado/avocado.conf"
    system "chmod a+x #{CREW_DEST_PREFIX}/bin/avocado"
  end
end
