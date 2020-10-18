require 'package'

class Sphinx < Package
  description 'Sphinx is a tool that makes it easy to create intelligent and beautiful documentation'
  homepage 'http://www.sphinx-doc.org/en/master/'
  version '3.2.1'
  compatibility 'all'
  source_url 'https://github.com/sphinx-doc/sphinx/archive/v3.2.1.tar.gz'
  source_sha256 '8816c90665b192b36c4482fb59819c276bae37ed275948fb2ab2ba873aa29d8a'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/sphinx-3.2.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/sphinx-3.2.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/sphinx-3.2.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/sphinx-3.2.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'b41731dc932880a677e23ae5d6d1fcb3a2b7bc0baecb6fe39c28d849789f98e9',
     armv7l: 'b41731dc932880a677e23ae5d6d1fcb3a2b7bc0baecb6fe39c28d849789f98e9',
       i686: 'de048c2762faff28134c1103097cdb9df02ecd2b078c256917f5b4169f5e5e15',
     x86_64: '54effef8d4e749a5d88150867bc4f171d30bbe1c97d600364bd19a260129ef70',
  })

  depends_on 'setuptools'

  def self.install
    system 'git clone https://github.com/sphinx-doc/sphinx.git build'
    Dir.chdir 'build' do
      system "git checkout v#{version}"
      system "pip install . --root #{CREW_DEST_DIR} --prefix #{CREW_PREFIX}"
    end
  end
end
