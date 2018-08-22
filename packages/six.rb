require 'package'

class Six < Package
  description 'Six is a Python 2 and 3 compatibility library.'
  homepage 'https://github.com/benjaminp/six'
  version '1.11.0'
  source_url 'https://github.com/benjaminp/six/archive/1.11.0.tar.gz'
  source_sha256 '927dc6fcfccd4e32e1ce161a20bf8cda39d8c9d5f7a845774486907178f69bd4'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/six-1.11.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/six-1.11.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/six-1.11.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/six-1.11.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '2eccdbb14fcef16c0a1d0c84e3ed80d49225ddc188d2d8ee7116a0572a9ba277',
     armv7l: '2eccdbb14fcef16c0a1d0c84e3ed80d49225ddc188d2d8ee7116a0572a9ba277',
       i686: '022a175322383509ac825b5727cd544af2c4b9e3b8f2a65b2c7c231cde13590f',
     x86_64: '9b3e2de8109ab192bd6b5522619fd6fe4b39b44beb0d89b45091d82805123b2c',
  })

  depends_on 'python3'
  depends_on 'python27'

  def self.build
    system "python2.7 setup.py build"
    system "python3 setup.py build"
  end

  def self.install
    system "python2.7 setup.py install --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR}"
    system "python3 setup.py install --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR}"
  end
end
