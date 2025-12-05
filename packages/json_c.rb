require 'buildsystems/cmake'

class Json_c < CMake
  description 'JSON-C implements a reference counting object model that allows you to easily construct JSON objects in C, output them as JSON formatted strings and parse JSON formatted strings back into the C representation of JSON objects.'
  homepage 'https://github.com/json-c/json-c'
  version '0.18-a1249bfd'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/json-c/json-c.git'
  git_hashtag 'a1249bfda0f6adf0363d5ab42d9ca816b3366ff2'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '43eef2f78f952ad0244cccbc275f4072c95039602fbe95e637cb72ff3e14d4dc',
     armv7l: '43eef2f78f952ad0244cccbc275f4072c95039602fbe95e637cb72ff3e14d4dc',
       i686: '588339a0482d0f81f221e1b13ac19f101f1e3487f1cf050190795994a589737b',
     x86_64: 'bb359d8041f610e47d1e9c808c03338207d310ddae7546b5b3116da391d1302a'
  })

  depends_on 'glibc' # R

  cmake_options '-DCMAKE_POLICY_VERSION_MINIMUM=3.5'

  cmake_install_extras do
    FileUtils.ln_s "#{CREW_LIB_PREFIX}/libjson-c.so", "#{CREW_DEST_LIB_PREFIX}/libjson-c.so.3"
    FileUtils.ln_s "#{CREW_LIB_PREFIX}/libjson-c.so", "#{CREW_DEST_LIB_PREFIX}/libjson-c.so.4"
  end
end
