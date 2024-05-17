require 'package'

class Unrar < Package
  description 'UnRAR is a powerful archive extractor.'
  homepage 'http://www.rarlab.com/'
  version '7.0.9'
  license 'unRAR'
  compatibility 'all'
  source_url 'https://www.rarlab.com/rar/unrarsrc-7.0.9.tar.gz'
  source_sha256 '505c13f9e4c54c01546f2e29b2fcc2d7fabc856a060b81e5cdfe6012a9198326'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f6af65b842dd3eaf120f6755ec8675dad7176125397bc20740bc5d983ed5d5d3',
     armv7l: 'f6af65b842dd3eaf120f6755ec8675dad7176125397bc20740bc5d983ed5d5d3',
       i686: 'ed4d4a78f65259128efcb55053f13af58c03604b024335a85027d19c60c2feb6',
     x86_64: '445e829e51aadc90ebddca48301c12dca0f7d23ea0bc0a2f266a376311bd90cc'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  def self.build
    # force to compile in sequential since unrar Makefile doesn't work in parallel
    system "CPPFLAGS='-fPIC' make -j1 all"
    system "CPPFLAGS='-fPIC' make -j1 lib"
  end

  def self.install
    system 'make', "PREFIX=#{CREW_PREFIX}", "DESTDIR=#{CREW_DEST_PREFIX}", 'install'
  end
end
