require 'buildsystems/python'
Package.load_package("#{__dir__}/libxml2.rb")

class Py3_libxml2 < Python
  description 'Libxml2-python provides access to libxml2 and libxslt in Python.'
  homepage 'https://gitlab.gnome.org/GNOME/libxml2/'
  version "#{Libxml2.version}-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url Libxml2.source_url
  git_hashtag Libxml2.git_hashtag
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a7836b787c81589f64d05846064e2d4ab273f16c4d8f84170c2261764c9e8888',
     armv7l: 'a7836b787c81589f64d05846064e2d4ab273f16c4d8f84170c2261764c9e8888',
       i686: '6c77c43611eaf3aa000c7fb0121ca144ed9116c4bc3ca9d9eda9017a26196aa5',
     x86_64: '87d409eb9a7408413dab36cd25d507216b844d08f0f1c440584dc447d1dacaeb'
  })

  depends_on 'glibc' # R
  depends_on 'libxml2' # R
  depends_on 'python3'
  depends_on 'py3_setuptools' => :build
  depends_on 'zlib' # R

  no_fhs

  python_build_relative_dir 'python'

  def self.prebuild
    system 'autoreconf -fiv'
    system "./configure #{CREW_CONFIGURE_OPTIONS}"
  end
end
