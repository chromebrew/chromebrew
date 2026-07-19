require 'package'

class Pacparser < Package
  description 'pacparser is a library to parse proxy auto-config (PAC) files.'
  homepage 'https://pacparser.manugarg.com/'
  version '1.5.1'
  license 'LGPL-3'
  compatibility 'all'
  source_url 'https://github.com/pacparser/pacparser.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'dba823a01d88db2af7e68015fbaadae2eb601cd1346a0a6aa387a7461f45c1b2',
     armv7l: 'dba823a01d88db2af7e68015fbaadae2eb601cd1346a0a6aa387a7461f45c1b2',
       i686: 'dd7339aa274690f26ebf100df056a2c04ddda1fc478c4c4b63f74f7745296944',
     x86_64: '86853d02df16871221d2c0f5637115fbf6dd7add392f8e289e412a7b8849d812'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library

  def self.build
    system "CFLAGS='-lpthread' make -j1 -C src"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} PREFIX=#{CREW_PREFIX} make -C src install"
    FileUtils.mv "#{CREW_DEST_PREFIX}/lib", CREW_DEST_LIB_PREFIX if ARCH.eql?('x86_64')
  end
end
