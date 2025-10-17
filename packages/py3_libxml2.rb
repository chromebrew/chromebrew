require 'buildsystems/meson'
Package.load_package("#{__dir__}/libxml2.rb")

class Py3_libxml2 < Meson
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
     x86_64: '306e60eeebba8b24bb040362608e1479fc25f1ec7c838313280d850915d95e16'
  })

  depends_on 'glibc' # R
  depends_on 'libxml2' # R
  depends_on 'py3_setuptools' => :build
  depends_on 'python3' # R

  no_fhs

  meson_options '-Dpython=enabled'
  meson_install_extras do
    FileUtils.rm(Dir.glob("#{CREW_DEST_PREFIX}/**/*").reject { |f| f.include?(CREW_PY_VER.sub('py', 'python')) || !File.file?(f) })
    # Delete remaining empty dirs.
    Dir["#{CREW_DEST_PREFIX}**/"].reverse_each { |d| Dir.rmdir d if Dir.empty?(d) }
  end
end
