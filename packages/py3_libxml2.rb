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
    aarch64: '0c6ca440e6401673f4a952069de2a3d401d0463a0ee3d90d257dab923e50439e',
     armv7l: '0c6ca440e6401673f4a952069de2a3d401d0463a0ee3d90d257dab923e50439e',
       i686: 'a38b835b9d4479330231a4515b1846ea897ae82145548fa2ed720b44ad6a2d7c',
     x86_64: '701ae77cbb8cf0806bad05ca1f935cefe3a5f7a532433b68460b97440610666f'
  })

  depends_on 'glibc' # R
  depends_on 'libxml2' # R
  depends_on 'py3_setuptools' => :build
  depends_on 'python3'
  depends_on 'zlib' # R

  no_fhs

  python_build_relative_dir 'python'

  def self.prebuild
    system 'autoreconf -fiv'
    system "./configure #{CREW_CONFIGURE_OPTIONS}"
  end
end
