require 'package'

class Sphinx < Package
  description 'Sphinx is a tool that makes it easy to create intelligent and beautiful documentation'
  homepage 'http://www.sphinx-doc.org/en/master/'
  version '1.8.1'
  source_url 'https://github.com/sphinx-doc/sphinx/archive/v1.8.1.tar.gz'
  source_sha256 '3ca0ff96399444078bef0185f45a8a587d0b306d1348a1b071c838d846a3c25d'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/sphinx-1.8.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/sphinx-1.8.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/sphinx-1.8.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/sphinx-1.8.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '05b209fd2f9d5d478cb83d3998ab439fb1a0fa653f7e94bdd2a533774a54d3ea',
     armv7l: '05b209fd2f9d5d478cb83d3998ab439fb1a0fa653f7e94bdd2a533774a54d3ea',
       i686: 'b29c110624a4ca74c13752b83a817094b3994c1bfeae57375b6a4f798b145cdf',
     x86_64: 'c6021656491f639e064ed18c760f68fe094946a47e46d1a52b6bb0da98ae94f7',
  })

  depends_on 'setuptools'

  def self.install
    system 'git clone https://github.com/sphinx-doc/sphinx.git build'
    Dir.chdir 'build' do
      system 'git checkout v1.8.1'
      system "pip install . --root #{CREW_DEST_DIR} --prefix #{CREW_PREFIX}"
    end
  end
end
