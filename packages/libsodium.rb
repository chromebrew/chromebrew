require 'buildsystems/autotools'

class Libsodium < Autotools
  description 'A modern, portable, easy to use crypto library'
  homepage 'https://libsodium.org'
  version '1.0.20'
  license 'ISC'
  compatibility 'all'
  source_url 'https://github.com/jedisct1/libsodium.git'
  git_hashtag "#{version}-RELEASE"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '77ef287d2f76ba67a1caf99cdc0c84b579992373e492cc2cb4df2c28130cdf6e',
     armv7l: '77ef287d2f76ba67a1caf99cdc0c84b579992373e492cc2cb4df2c28130cdf6e',
       i686: '987a5a71288c73cec1a462a03265065d588fb93cd3aed0d0e386bbb12209dd40',
     x86_64: 'f1345dbf261fc7bb8d085da9ce90b27fa3105e95171af3181e69945fc385886f'
  })

  depends_on 'glibc' # R

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    # Fix php: error while loading shared libraries: libsodium.so.23: cannot open shared object file: No such file or directory
    FileUtils.ln_s "#{CREW_LIB_PREFIX}/libsodium.so", "#{CREW_DEST_LIB_PREFIX}/libsodium.so.23"
  end

  run_tests
end
