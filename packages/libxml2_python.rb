require 'package'

class Libxml2_python < Package
  description 'Libxml2 (python module) is the XML C parser and toolkit developed for the Gnome project.'
  homepage 'http://xmlsoft.org/'
  version '2.9.9'
  source_url 'ftp://xmlsoft.org/libxml2/libxml2-2.9.9.tar.gz'
  source_sha256 '94fb70890143e3c6549f265cee93ec064c80a84c42ad0f23e85ee1fd6540a871'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'python27'
  depends_on 'libxml2'

  def self.build
    Dir.chdir("python") do
      system "LDFLAGS=-L#{CREW_LIB_PREFIX} python2 setup.py build"
    end
  end

  def self.install
    Dir.chdir("python") do
      system "python2 setup.py install --root=#{CREW_DEST_DIR}"
    end
  end

end
