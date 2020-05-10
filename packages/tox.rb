require 'package'

class Tox < Package
  description 'tox aims to automate and standardize testing in Python.'
  homepage 'https://tox.readthedocs.io/en/latest/'
  version '3.4.0'
  compatibility 'all'
  source_url 'https://github.com/tox-dev/tox/archive/3.4.0.tar.gz'
  source_sha256 '01171065c1628b5549c370a160979a04fef1de32aa9e39203aaa998057c03d11'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/tox-3.4.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/tox-3.4.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/tox-3.4.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/tox-3.4.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '39e24875f9ba6375d2bbc2d5318ad6b220209e38c2105d8fde3de7dc3f84ff1c',
     armv7l: '39e24875f9ba6375d2bbc2d5318ad6b220209e38c2105d8fde3de7dc3f84ff1c',
       i686: '2ff92015a93f1b8764d8b718fc74a8876090dd3ef3c847a90d400271cbfa2a47',
     x86_64: '42f63319cae5fe4d78c217a5d3326b735b42503cd5a431198aafcece31dbc60f',
  })

  def self.install
    system 'git clone https://github.com/tox-dev/tox.git'
    Dir.chdir 'tox' do
      system 'git checkout 3.4.0'
      system "pip install . --root #{CREW_DEST_DIR} --prefix #{CREW_PREFIX}"
    end
  end

  def self.postinstall
    puts
    puts "To generate a tox.ini configuration file automatically, run 'tox-quickstart' and answer a few simple questions.".lightblue
    puts
  end
end
