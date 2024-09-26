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
    aarch64: '0833c7822fbc2bc026bc219921ad375496da51d1f9387a4a770634d0ae80c91b',
     armv7l: '0833c7822fbc2bc026bc219921ad375496da51d1f9387a4a770634d0ae80c91b',
       i686: 'f62d6717a8ea63a53872efc8097720c974f48206182d1c4e2d48fec6a9523ad5',
     x86_64: '5c6f02cc962cb28f66d2cfa34b8f8da524d36e550c0b8e8497ed9646a0f2aa25'
  })

  depends_on 'glibc' # R
  depends_on 'libxml2' # R
  depends_on 'py3_setuptools' => :build
  depends_on 'python3' # R
  depends_on 'zlib' # R

  def self.build
    system 'autoreconf -fiv'
    system "./configure #{CREW_CONFIGURE_OPTIONS}"
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
