require 'package'

class Py3_libxml2 < Package
  description 'Libxml2 (python module) is the XML C parser and toolkit developed for the Gnome project.'
  homepage 'http://xmlsoft.org/python.html'
  version '2.9.10'
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/libxml2/-/archive/v2.9.10/libxml2-v2.9.10.tar.bz2'
  source_sha256 '5f1cc19c849cccabb983881cf1ebf833f42db5d7b8afba7a7763a2ac3101715c'

  depends_on 'libxslt'

  def self.build
    system "env NOCONFIGURE=1 ./autogen.sh"
    system "./configure #{CREW_OPTIONS}"
    Dir.chdir("python") do
      system "LDFLAGS=-L#{CREW_LIB_PREFIX} python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
    end
  end

  def self.install
    Dir.chdir("python") do
      system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
    end
  end
end
