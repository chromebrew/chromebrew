require 'package'

class Sphinx < Package
  description 'Sphinx is a tool that makes it easy to create intelligent and beautiful documentation'
  homepage 'http://www.sphinx-doc.org/en/master/'
  version '2.4.4'
  source_url 'https://github.com/sphinx-doc/sphinx/archive/v2.4.4.tar.gz'
  source_sha256 '1b011dd7e965a87e93766dc64aaee2f08f800cb32a412b5bd2582b7e5660000c'

  binary_url ({
  })
  binary_sha256 ({
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
