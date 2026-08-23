require 'package'

class Pacparser < Package
  description 'pacparser is a library to parse proxy auto-config (PAC) files.'
  homepage 'https://pacparser.manugarg.com/'
  version '1.5.2'
  license 'LGPL-3'
  compatibility 'all'
  source_url 'https://github.com/pacparser/pacparser.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7c1291e3bc4fb2defe85d42222d210e4c11bd6b9ad3fdef016243fd811f9a79d',
     armv7l: '7c1291e3bc4fb2defe85d42222d210e4c11bd6b9ad3fdef016243fd811f9a79d',
       i686: 'c42044e0bf7c84e6fad15018c3d3e77ea87489d4e88900cea6ae09482aeda8b7',
     x86_64: 'b229e32c4887060f85dd945a2ac8d46da690be08eb0bc412dcd3e7622b58f67d'
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
