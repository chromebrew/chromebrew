require 'package'

class Libxml2_python < Package
  description 'Libxml2 (python module) is the XML C parser and toolkit developed for the Gnome project.'
  homepage 'http://xmlsoft.org/'
  version '2.9.9'
  source_url 'ftp://xmlsoft.org/libxml2/libxml2-2.9.9.tar.gz'
  source_sha256 '94fb70890143e3c6549f265cee93ec064c80a84c42ad0f23e85ee1fd6540a871'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libxml2_python-2.9.9-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libxml2_python-2.9.9-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libxml2_python-2.9.9-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libxml2_python-2.9.9-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '05b9616edf2809cea4bfaa2a0f9b21e8455871e04f9a76f08c5472e25ab655c6',
     armv7l: '05b9616edf2809cea4bfaa2a0f9b21e8455871e04f9a76f08c5472e25ab655c6',
       i686: '9676158d3071ecd96bd3fc3cb0619dd137efc39b23a8c1d0c4d38990d58223ad',
     x86_64: '54261947d04449bdeb3af3fd9c60b450fc8237defdee0076d23122786eb05934',
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
