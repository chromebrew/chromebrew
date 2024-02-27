require 'buildsystems/autotools'

class Libsodium < Autotools
  description 'A modern, portable, easy to use crypto library'
  homepage 'https://libsodium.org'
  @_ver = '1.0.19'
  version "#{@_ver}-1"
  license 'ISC'
  compatibility 'all'
  source_url 'https://github.com/jedisct1/libsodium.git'
  git_hashtag @_ver
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4efd9fd525873faa4280e5792c04a21b5264c2ae19bc9c92d5d2be367062ca0a',
     armv7l: '4efd9fd525873faa4280e5792c04a21b5264c2ae19bc9c92d5d2be367062ca0a',
       i686: '97189cfbf743e03fcc9884be9d4f69b701e21e70e6880dbabb9f562a7f75902c',
     x86_64: 'bc886a2dc037f82ad23635df4e782abdfdc3b998f8b517144d64ff9a612d224a'
  })

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    # Fix php: error while loading shared libraries: libsodium.so.23: cannot open shared object file: No such file or directory
    FileUtils.ln_s "#{CREW_LIB_PREFIX}/libsodium.so", "#{CREW_DEST_LIB_PREFIX}/libsodium.so.23"
  end

  run_tests
end
