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
    aarch64: '0509a5084d2ef27c079b9a53bbda0539ca8b66c78bd661d3889178d896da6f31',
     armv7l: '0509a5084d2ef27c079b9a53bbda0539ca8b66c78bd661d3889178d896da6f31',
       i686: '98218de27b0a8e91f9a22b00f783dda3c2359ee6fb9fccd891b75aece8064670',
     x86_64: '04677ca7715942e79495c2ca1396d11b9f55483231faaf96e9cc56b7610642ad'
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
