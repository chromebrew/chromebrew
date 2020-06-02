require 'package'

class Libxml2_python < Package
  description 'Libxml2 (python module) is the XML C parser and toolkit developed for the Gnome project.'
  homepage 'http://xmlsoft.org/'
  version '2.9.10'
  compatibility 'all'
  source_url 'ftp://xmlsoft.org/libxml2/libxml2-2.9.10.tar.gz'
  source_sha256 'aafee193ffb8fe0c82d4afef6ef91972cbaf5feea100edc2f262750611b4be1f'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libxml2_python-2.9.10-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libxml2_python-2.9.10-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libxml2_python-2.9.10-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libxml2_python-2.9.10-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'e4e0785991911d9a84fc6023345fb5bf1195b14ecff7ab32e2f5fc7e03301569',
     armv7l: 'e4e0785991911d9a84fc6023345fb5bf1195b14ecff7ab32e2f5fc7e03301569',
       i686: 'cd4f6ebe11023d88de1e9809fbfd4f1e85d4513cb34450dd9d67fa2f55d96f45',
     x86_64: 'a4e7d5428a898c545a2f97d41454d711224341b93782cc7e1a435c442b952ade',
  })

  def self.build
    Dir.chdir("python") do
      system "LDFLAGS=-L#{CREW_LIB_PREFIX} python2 setup.py build"
    end
  end

  def self.install
    Dir.chdir("python") do
      system "python2 setup.py install --prefix=#{CREW_PREFIX} --root=#{CREW_DEST_DIR}"
    end
  end
end
