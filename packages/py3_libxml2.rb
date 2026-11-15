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
    aarch64: '02184c9964f58a2900e5444797562d9be1cd39079f34f4c838f198fd2004ec12',
     armv7l: '02184c9964f58a2900e5444797562d9be1cd39079f34f4c838f198fd2004ec12',
       i686: '685b97140b99f97166eba2697d9492e366442bf9dacf0da0fe375bd9a53b1d18',
     x86_64: 'a7366e97f8d759c6b60c7dd4f9dbec87e28b73bb3fec1e45514b988e7cf5bf26'
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
