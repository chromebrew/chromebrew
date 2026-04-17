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
    aarch64: '42fcc6365737c1c8f7bd41f78c51b3afcc5d7e139966ea46f6fc1c2166e2df94',
     armv7l: '42fcc6365737c1c8f7bd41f78c51b3afcc5d7e139966ea46f6fc1c2166e2df94',
       i686: '762928a03769218a8138da799482e389011f72c9bf54ae4faf116a9f9b7d047d',
     x86_64: 'ac24ebb8473a17929e54ed6b8af24d030b2af63b1050939657fd846adc784f53'
  })

  depends_on 'glibc' => :library
  depends_on 'libxml2' => :library
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
