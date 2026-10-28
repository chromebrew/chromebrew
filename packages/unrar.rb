require 'package'

class Unrar < Package
  description 'UnRAR is a powerful archive extractor.'
  homepage 'https://www.rarlab.com/'
  version '7.3.2'
  license 'unRAR'
  compatibility 'all'
  source_url "https://www.rarlab.com/rar/unrarsrc-#{version}.tar.gz"
  source_sha256 'f61a1160d6e2ebbda2ad353c8e82f62ab4312f97fde23c6c2c982d25e0014f99'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9af18ae71995dfb5ada72626e15f4ec889f668dceef9c351de101bb0f6972ab8',
     armv7l: '9af18ae71995dfb5ada72626e15f4ec889f668dceef9c351de101bb0f6972ab8',
       i686: 'd374b8a57f0bc32e016676c7441f3cdf86748a1a6299c79c82487b368148816f',
     x86_64: '8a780ae8fdcbfad5efb44aa798f87cff6d707ab262ced7d9776772e4b6101e3b'
  })

  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable

  def self.build
    # force to compile in sequential since unrar Makefile doesn't work in parallel
    system "CPPFLAGS='-fPIC' make -j1 all"
    system "CPPFLAGS='-fPIC' make -j1 lib"
  end

  def self.install
    system 'make', "PREFIX=#{CREW_PREFIX}", "DESTDIR=#{CREW_DEST_PREFIX}", 'install'
  end
end
