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
    aarch64: '43ca7419c662f218be755aaa8bedee5e59ded5cf24c6bae1bc40cd793d26d59a',
     armv7l: '43ca7419c662f218be755aaa8bedee5e59ded5cf24c6bae1bc40cd793d26d59a',
       i686: '288abd21b98c57c7eeb0bd881db4a526957eab00b32a2b98768db569445c5948',
     x86_64: '226d9552938889e2fcdeebd590911b4eeadc8f337aca762b949f17ab61d30b5f'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
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
