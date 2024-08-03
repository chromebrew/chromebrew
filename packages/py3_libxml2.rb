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
    aarch64: '8c23226248f7607cd21ce80117a40f3468f066e0d8748cf4183c4fff6fe5ddea',
     armv7l: '8c23226248f7607cd21ce80117a40f3468f066e0d8748cf4183c4fff6fe5ddea',
       i686: 'fef4655b6f08152a29da01e5daf78d8d39e49a44941b59452983ec45241abfb0',
     x86_64: '49e28b37dc9ce0ba6c2efbdcea1ce85b8b600db7e54fc223a85a7eb6701d137e'
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
