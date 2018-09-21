require 'package'

class Setuptools < Package
  description 'Easily download, build, install, upgrade, and uninstall Python packages'
  homepage 'https://pypi.org/project/setuptools/'
  version '40.4.2'
  source_url 'https://github.com/pypa/setuptools/archive/v40.4.2.tar.gz'
  source_sha256 'a3e1de84f6adf9fe387343752009fb48353d469f2c9b5f7025786d810557d9c8'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/setuptools-40.4.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/setuptools-40.4.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/setuptools-40.4.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/setuptools-40.4.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '2714cea18c390ee6f6ea37b9df5bfef7d6bf2b0edc9c6c7a08979356beb5a54d',
     armv7l: '2714cea18c390ee6f6ea37b9df5bfef7d6bf2b0edc9c6c7a08979356beb5a54d',
       i686: '366cec28989b1eedac33b484c739ef4b156a2e57aa2fd79207f6f7176598be17',
     x86_64: 'aaacaa06bc21e765772d65995f2c1a3d14609ce7a8da49539448c47e284c8d0d',
  })

  depends_on 'python27'
  depends_on 'python3'

  def self.build
    system 'python3 bootstrap.py'
  end

  def self.install
    system "python2 setup.py install --root #{CREW_DEST_DIR} --prefix #{CREW_PREFIX}"
    system "python3 setup.py install --root #{CREW_DEST_DIR} --prefix #{CREW_PREFIX}"
  end
end
