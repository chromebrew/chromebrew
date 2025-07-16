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
    aarch64: '768199413bb35f650c0235ebcf3600f1f33667018d0421137a332ede0c288787',
     armv7l: '768199413bb35f650c0235ebcf3600f1f33667018d0421137a332ede0c288787',
       i686: '98218de27b0a8e91f9a22b00f783dda3c2359ee6fb9fccd891b75aece8064670',
     x86_64: '5f270e4172b2dcc4a080f8244a9d993c93a9daccaaed9809338c7f838029eb0a'
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
