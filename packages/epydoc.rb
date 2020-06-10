require 'package'

class Epydoc < Package
  description 'Epydoc is a tool for generating API documentation for Python modules, based on their docstrings.'
  homepage 'http://epydoc.sourceforge.net/'
  version '3.0.1'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/project/epydoc/epydoc/3.0.1/epydoc-3.0.1.tar.gz'
  source_sha256 'd4e5c8d90937d01b05170f592c1fa9b29e9ed0498dfe7f0eb2a3af61725b6ad1'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/epydoc-3.0.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/epydoc-3.0.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/epydoc-3.0.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/epydoc-3.0.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '8991ce352c0c8d49e7947ed3d99194dc3d8b3c6277c21ee47f44925b9377dccf',
     armv7l: '8991ce352c0c8d49e7947ed3d99194dc3d8b3c6277c21ee47f44925b9377dccf',
       i686: 'cff7e6d737b259381d1538acf184b7f209d857c297264fa91483c6b01033356b',
     x86_64: '5978478fb0eadb8a0a48b76b3c96bf0baa6b6c8d31ecd97c121a4cbaeb0941dd',
  })

  depends_on 'python27'

  def self.install
    system "python setup.py install --root=#{CREW_DEST_DIR} --prefix=#{CREW_PREFIX}"
  end
end
