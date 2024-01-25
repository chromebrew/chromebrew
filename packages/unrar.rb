require 'package'

class Unrar < Package
  description 'UnRAR is a powerful archive extractor.'
  homepage 'http://www.rarlab.com/'
  version '7.0.6'
  license 'unRAR'
  compatibility 'all'
  source_url 'https://www.rarlab.com/rar/unrarsrc-7.0.6.tar.gz'
  source_sha256 'd9c0d1c881603aa2fa38248634bf9c9d63a6a3bdb5fa17dc9358ebf8b61f0cd2'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9f3f6421b5570cb695f841cce31b47b7585ea351e48d43844c12466700c88a21',
     armv7l: '9f3f6421b5570cb695f841cce31b47b7585ea351e48d43844c12466700c88a21',
       i686: '71e544df5bf2ada5f716cff0d516c81c63e883eb7dac07bb1fa5c371026fb44e',
     x86_64: '911088681e176d910c5401c82b4982f43df1541e97c9d54761f318c96ae76cf7'
  })

  def self.build
    # force to compile in sequential since unrar Makefile doesn't work in parallel
    system "CPPFLAGS='-fPIC' make -j1 all"
    system "CPPFLAGS='-fPIC' make -j1 lib"
  end

  def self.install
    system 'make', "PREFIX=#{CREW_PREFIX}", "DESTDIR=#{CREW_DEST_PREFIX}", 'install'
  end
end
