require 'buildsystems/cmake'

class Json_c < CMake
  description 'JSON-C implements a reference counting object model that allows you to easily construct JSON objects in C, output them as JSON formatted strings and parse JSON formatted strings back into the C representation of JSON objects.'
  homepage 'https://github.com/json-c/json-c'
  version '0.18-52ddfb3'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/json-c/json-c.git'
  git_hashtag '52ddfb35f1cc7e337edb6b1939a043140b42cf5a'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '08cb11fa918d844204dfc59cfcfb65687accf4173effcd9f090b1fe345d2b64f',
     armv7l: '08cb11fa918d844204dfc59cfcfb65687accf4173effcd9f090b1fe345d2b64f',
       i686: '49ce08435fdd4740bd55c15dec10eb1d09dd23a91d53d98da96493a42ca56fe9',
     x86_64: '2792cbebb1ed47b8a4dd7e642ef6d86d3d3f60b49e6e409756926e065f5ff66d'
  })

  depends_on 'glibc' => :library
  depends_on 'libbsd' => :library

  cmake_options '-DCMAKE_POLICY_VERSION_MINIMUM=3.5'

  cmake_install_extras do
    FileUtils.ln_s "#{CREW_LIB_PREFIX}/libjson-c.so", "#{CREW_DEST_LIB_PREFIX}/libjson-c.so.3"
    FileUtils.ln_s "#{CREW_LIB_PREFIX}/libjson-c.so", "#{CREW_DEST_LIB_PREFIX}/libjson-c.so.4"
  end
end
