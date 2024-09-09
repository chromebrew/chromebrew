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
    aarch64: '3e1e15cefeae56e1900f403e451df0aecf830ff5b5a87ab14bd7728567aae7da',
     armv7l: '3e1e15cefeae56e1900f403e451df0aecf830ff5b5a87ab14bd7728567aae7da',
       i686: '2c00954c38ec288fe6fb7d892f85f21af2d418584cd4b37bd1f2a7283f30d7d5',
     x86_64: '3f19e088f7e3bc2bb4c354ec4d6c1896aa55d728b18508d5d0de0517c66acbca'
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
end
