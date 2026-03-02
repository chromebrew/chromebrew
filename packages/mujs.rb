require 'package'

class Mujs < Package
  description 'An embeddable Javascript interpreter in C'
  homepage 'https://mujs.com/'
  version '1.3.8'
  license 'ISC'
  compatibility 'all'
  source_url 'https://codeberg.org/ccxvii/mujs.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c34a1c25bba90c9ea8cc29b3ae7f4037413f7b1934ebb0d5ee4b8600eaf23f1a',
     armv7l: 'c34a1c25bba90c9ea8cc29b3ae7f4037413f7b1934ebb0d5ee4b8600eaf23f1a',
       i686: 'a0801f7e0efcb31feeb42c32f4b91eac99c207a03bb7c005deeb8ab25b25d460',
     x86_64: 'dee2285e3ddfac2c845fde3be2c9e540255a299c3a1e518b5f282d73b04b256e'
  })

  depends_on 'glibc' # R
  depends_on 'readline' => :executable_only

  def self.build
    system 'make', 'release'
  end

  def self.install
    system 'make', "prefix=#{CREW_PREFIX}", "libdir=#{CREW_LIB_PREFIX}", "DESTDIR=#{CREW_DEST_DIR}", 'install-shared'
  end
end
