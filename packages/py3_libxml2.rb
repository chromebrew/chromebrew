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
    aarch64: 'e1dd747f212b147709fd87bf56d2141bd00f05483039a41ce61d8c865f2eda2b',
     armv7l: 'e1dd747f212b147709fd87bf56d2141bd00f05483039a41ce61d8c865f2eda2b',
       i686: 'eb5b92b370510e40bdb0ed4784fb1a95f89480770d45e29fe6300d1c2162a774',
     x86_64: '4fa9051647b0281a70cdac98bc02dca0043473b05216527fab4f73c50d50f1b6'
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
