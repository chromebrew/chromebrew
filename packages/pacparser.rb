require 'package'

class Pacparser < Package
  description 'pacparser is a library to parse proxy auto-config (PAC) files.'
  homepage 'https://pacparser.manugarg.com/'
  version '1.5.3'
  license 'LGPL-3'
  compatibility 'all'
  source_url 'https://github.com/pacparser/pacparser.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0a43949a0a631c5a7d1073255248fff8cecd2bccd7ecf65c36359baf9dc42107',
     armv7l: '0a43949a0a631c5a7d1073255248fff8cecd2bccd7ecf65c36359baf9dc42107',
       i686: 'f43a673a4332e03bff977da6c13d88b2c737205559c7e6b976f01d4c53354246',
     x86_64: 'adf683f6a53738aadc02896109752f7c3b28085a6a057eaf15373b40337d8074'
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
