require 'buildsystems/cmake'

class Json_c < CMake
  description 'JSON-C implements a reference counting object model that allows you to easily construct JSON objects in C, output them as JSON formatted strings and parse JSON formatted strings back into the C representation of JSON objects.'
  homepage 'https://github.com/json-c/json-c'
  version '0.18-d1018cf'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/json-c/json-c.git'
  git_hashtag 'd1018cf6ba662a4003a0ce526b53def94da7f04b'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f14c0115baee999fd056107d474db37ef639b025d5554c7258710769d2b67aa4',
     armv7l: 'f14c0115baee999fd056107d474db37ef639b025d5554c7258710769d2b67aa4',
       i686: '9f8804415a3dfc2bcb0943e97d2eb71f60a9502526ee42579269a6fcee6be83f',
     x86_64: '4984e1d5d1f7436165cd7cb7f2c9ceea2b7263609512896e9b2643521632ced4'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'graphviz' => :build
  depends_on 'libbsd' => :library

  def self.patch
    system "sed -i 's,*child,*child = NULL,' json_object.c"
  end

  cmake_options '-DCMAKE_POLICY_VERSION_MINIMUM=3.5'

  cmake_install_extras do
    FileUtils.ln_s "#{CREW_LIB_PREFIX}/libjson-c.so", "#{CREW_DEST_LIB_PREFIX}/libjson-c.so.3"
    FileUtils.ln_s "#{CREW_LIB_PREFIX}/libjson-c.so", "#{CREW_DEST_LIB_PREFIX}/libjson-c.so.4"
  end
end
