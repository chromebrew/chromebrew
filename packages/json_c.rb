require 'buildsystems/cmake'

class Json_c < CMake
  description 'JSON-C implements a reference counting object model that allows you to easily construct JSON objects in C, output them as JSON formatted strings and parse JSON formatted strings back into the C representation of JSON objects.'
  homepage 'https://github.com/json-c/json-c'
  version '0.18-20240915-1'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/json-c/json-c.git'
  git_hashtag "json-c-#{version.split('-').tap { |a| a.pop 1 }.join('-')}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e19c19220772405804d3e2737af3962d9a87f6caa904dcd91a1f69804ed753eb',
     armv7l: 'e19c19220772405804d3e2737af3962d9a87f6caa904dcd91a1f69804ed753eb',
       i686: '50c56ec2983be8ce16abafb87e3e988aeb484e7d8b314518defb0525907df424',
     x86_64: 'c1667d019008395fb5643bc88a3fd6860318b4ff3adf6014044a22a9c1fe7ce9'
  })

  depends_on 'glibc' # R

  cmake_options '-DCMAKE_POLICY_VERSION_MINIMUM=3.5'

  cmake_install_extras do
    FileUtils.ln_s "#{CREW_LIB_PREFIX}/libjson-c.so", "#{CREW_DEST_LIB_PREFIX}/libjson-c.so.3"
    FileUtils.ln_s "#{CREW_LIB_PREFIX}/libjson-c.so", "#{CREW_DEST_LIB_PREFIX}/libjson-c.so.4"
  end
end
