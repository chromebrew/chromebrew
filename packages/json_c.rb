require 'buildsystems/meson'

class Json_c < Meson
  description 'JSON-C implements a reference counting object model that allows you to easily construct JSON objects in C, output them as JSON formatted strings and parse JSON formatted strings back into the C representation of JSON objects.'
  homepage 'https://github.com/json-c/json-c'
  version '0.19-20260627'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/json-c/json-c.git'
  git_hashtag "json-c-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '03b86eeb687c4bf8bc06dfd483aaf30a56dc5dcfc6fa62803092e22e73a4329c',
     armv7l: '03b86eeb687c4bf8bc06dfd483aaf30a56dc5dcfc6fa62803092e22e73a4329c',
       i686: 'de0cc3e7b525e4bbf3dcbc06561b3d76788cbcab6d4977e3905bc569ec6ac932',
     x86_64: '5469ff095557137325ca317b416c28fed2ef009129c8d23551877cc4af81eb37'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'graphviz' => :build
  depends_on 'libbsd' => :library

  meson_options '-Denable_threading=true'

  meson_install_extras do
    FileUtils.ln_s "#{CREW_LIB_PREFIX}/libjson-c.so", "#{CREW_DEST_LIB_PREFIX}/libjson-c.so.3"
    FileUtils.ln_s "#{CREW_LIB_PREFIX}/libjson-c.so", "#{CREW_DEST_LIB_PREFIX}/libjson-c.so.4"
  end
end
