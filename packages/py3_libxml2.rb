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
    aarch64: '70eb4306e4d9423a526a65ded96b09fecd02516888bacc37dedda686f69c502b',
     armv7l: '70eb4306e4d9423a526a65ded96b09fecd02516888bacc37dedda686f69c502b',
       i686: 'fe7d08b6e0a806bad7a9da897855ed2ede8eaa6cab540d0a3c29abccd9baf8fb',
     x86_64: '8bd40fc45196607b451f118a956375edddd5ada3c5e1e79a46fe924333bdf921'
  })

  depends_on 'glibc' # R
  depends_on 'libxml2' # R
  depends_on 'py3_setuptools' => :build
  depends_on 'python3' # R
  depends_on 'zlib' # R

  no_fhs

  python_build_relative_dir 'python'

  def self.prebuild
    system 'autoreconf -fiv'
    system "./configure #{CREW_CONFIGURE_OPTIONS} --with-python"
    system 'make'
  end
end
