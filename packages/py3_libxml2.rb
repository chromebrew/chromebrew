require 'package'
Package.load_package("#{__dir__}/libxml2.rb")

class Py3_libxml2 < Package
  description 'Libxml2-python provides access to libxml2 and libxslt in Python.'
  homepage 'https://gitlab.gnome.org/GNOME/libxml2/'
  version Libxml2.version
  license 'MIT'
  compatibility 'all'
  source_url Libxml2.source_url
  git_hashtag Libxml2.git_hashtag
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bff8fae7283d0749d059f3921f7e8b6651f3da3e102c02abfecbee93435e5cc9',
     armv7l: 'bff8fae7283d0749d059f3921f7e8b6651f3da3e102c02abfecbee93435e5cc9',
       i686: 'f92d0961f38537cbf5233b5f08c25d28b3425ba306398e76e2eae0bc0171f600',
     x86_64: 'f03253815093dba410b70186d2a877ecd465db3ff426b12a02e1b5cff9ffeac2'
  })

  depends_on 'glibc' # R
  depends_on 'libxml2' # R
  depends_on 'py3_setuptools' => :build
  depends_on 'python3' # R
  depends_on 'zlib' # R

  def self.build
    system 'autoreconf -fiv'
    system "./configure #{CREW_OPTIONS}"
    Dir.chdir('python') do
      system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
    end
  end

  def self.install
    Dir.chdir('python') do
      system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS_NO_SVEM}"
    end
  end

  no_source_build
end
