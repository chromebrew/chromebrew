require 'buildsystems/cmake'

class Jsonc < CMake
  description 'JSON-C implements a reference counting object model that allows you to easily construct JSON objects in C, output them as JSON formatted strings and parse JSON formatted strings back into the C representation of JSON objects.'
  homepage 'https://github.com/json-c/json-c'
  version '0.17-20230812'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/json-c/json-c.git'
  git_hashtag "json-c-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7da5ea7b11964e82427322b3cfb45cef60a0c86e6725c9f2a37f39eaa839e041',
     armv7l: '7da5ea7b11964e82427322b3cfb45cef60a0c86e6725c9f2a37f39eaa839e041',
       i686: 'a372fad8f673ea8170332d60d846dacebec6ed659bb37f87c9e2112d051c0c2f',
     x86_64: '9d0e18ddb424b010c6513eae3dd437d3dc49c3fb3f0dce27377786e322847e3b'
  })

  depends_on 'glibc' # R

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
    FileUtils.ln_s "#{CREW_LIB_PREFIX}/libjson-c.so", "#{CREW_DEST_LIB_PREFIX}/libjson-c.so.3"
    FileUtils.ln_s "#{CREW_LIB_PREFIX}/libjson-c.so", "#{CREW_DEST_LIB_PREFIX}/libjson-c.so.4"
  end
end
