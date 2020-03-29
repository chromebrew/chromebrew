require 'package'

class Sphinx < Package
  description 'Sphinx is a tool that makes it easy to create intelligent and beautiful documentation'
  homepage 'http://www.sphinx-doc.org/en/master/'
  version '2.4.4'
  source_url 'https://github.com/sphinx-doc/sphinx/archive/v2.4.4.tar.gz'
  source_sha256 '1b011dd7e965a87e93766dc64aaee2f08f800cb32a412b5bd2582b7e5660000c'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/sphinx-2.4.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/sphinx-2.4.4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/sphinx-2.4.4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/sphinx-2.4.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '26e8b7a5c27b2abe254db5f627fd3f303fdcd1513588c56dff945f9b8da228dc',
     armv7l: '26e8b7a5c27b2abe254db5f627fd3f303fdcd1513588c56dff945f9b8da228dc',
       i686: '62e2224234224e05655cfdd622fd5f08181143f765e11dde3cf437321bc05023',
     x86_64: '316a1e63f356c4396083b005367e89f8f2e33275820518d3c5fe5ea03471cdec',
  })

  depends_on 'setuptools'

  def self.install
    system 'git clone https://github.com/sphinx-doc/sphinx.git build'
    Dir.chdir 'build' do
      system 'git checkout v2.4.4'
      system "pip install . --root #{CREW_DEST_DIR} --prefix #{CREW_PREFIX}"
    end
  end
end
