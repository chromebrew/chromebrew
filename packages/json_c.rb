require 'buildsystems/cmake'

class Json_c < CMake
  description 'JSON-C implements a reference counting object model that allows you to easily construct JSON objects in C, output them as JSON formatted strings and parse JSON formatted strings back into the C representation of JSON objects.'
  homepage 'https://github.com/json-c/json-c'
  version '0.18-20240915'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/json-c/json-c.git'
  git_hashtag "json-c-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '217e11520160be237177a0d65343458def697d26e087dd877b545d0a63e2f779',
     armv7l: '217e11520160be237177a0d65343458def697d26e087dd877b545d0a63e2f779',
       i686: '9ba118efb99aee704fbfca41b87d221d876c1edf359d2e1384ce3501b01f24af',
     x86_64: '7c0dd0ae3eb8e18649fa38cf77ca31cc51fc554faaca4025b90a5e208ed714db'
  })

  depends_on 'glibc' # R

  cmake_install_extras do
    FileUtils.ln_s "#{CREW_LIB_PREFIX}/libjson-c.so", "#{CREW_DEST_LIB_PREFIX}/libjson-c.so.3"
    FileUtils.ln_s "#{CREW_LIB_PREFIX}/libjson-c.so", "#{CREW_DEST_LIB_PREFIX}/libjson-c.so.4"
  end
end
