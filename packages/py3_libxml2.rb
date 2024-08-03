require 'package'
Package.load_package("#{__dir__}/libxml2.rb")

class Py3_libxml2 < Package
  description 'Libxml2-python provides access to libxml2 and libxslt in Python.'
  homepage 'https://gitlab.gnome.org/GNOME/libxml2/'
  version Libxml2.version
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/libxml2.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3fc4a5d2cbd677523bcfc481277547344f8d17074b540782dc2b7dedf240cad8',
     armv7l: '3fc4a5d2cbd677523bcfc481277547344f8d17074b540782dc2b7dedf240cad8',
       i686: 'ecf7103a0b3df76ade67ad7cc612a2e0a458546ec2c9fdb827f54180fd74166d',
     x86_64: 'b428aafd46c329ae5073343c766c10624fdbc8139ad969b3fb6bf42d7e7cb39f'
  })

  depends_on 'glibc' # R
  depends_on 'libxml2' # R
  depends_on 'libxslt' => :build
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
