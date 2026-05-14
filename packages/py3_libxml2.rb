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
    aarch64: '432cbdc5821d7f6e283724b8d959ecc56c7eecd7b79b2cc2d535621401024d3e',
     armv7l: '432cbdc5821d7f6e283724b8d959ecc56c7eecd7b79b2cc2d535621401024d3e',
       i686: '69cce40d2a8b75501304354a6d94fb8933158ce2391df3b43e1a5b96d7b4ee11',
     x86_64: '79ad45501c150c0713014453a0abb707afd4646922ad4410b8f627ad42d5d1c2'
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
