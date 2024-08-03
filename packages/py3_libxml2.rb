require 'package'
Package.load_package("#{__dir__}/libxml2.rb")

class Py3_libxml2 < Package
  description 'Libxml2-python provides access to libxml2 and libxslt in Python.'
  homepage 'https://gitlab.gnome.org/GNOME/libxml2/'
  version '2.13.2-py3.12'
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/libxml2.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '15c35359711c1cb7f4ea78d7637c955145e1628e78729f49e6377f3ecf121042',
     armv7l: '15c35359711c1cb7f4ea78d7637c955145e1628e78729f49e6377f3ecf121042',
       i686: 'fcb201b3f942e03466111d8240153a74791dfb05d963598710c59aa8f4a4d318',
     x86_64: 'd2a77cc3852dfd53f1e46440ad79062e82e298dea75e028e9b9e10e3b3e1cd05'
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
