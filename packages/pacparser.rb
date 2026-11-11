require 'package'

class Pacparser < Package
  description 'pacparser is a library to parse proxy auto-config (PAC) files.'
  homepage 'https://pacparser.manugarg.com/'
  version '1.5.4'
  license 'LGPL-3'
  compatibility 'all'
  source_url 'https://github.com/pacparser/pacparser.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2d5b105cc9e2406230405a86d3aa303d637432bb910f90278d79c0896ad1806e',
     armv7l: '2d5b105cc9e2406230405a86d3aa303d637432bb910f90278d79c0896ad1806e',
       i686: 'af33c5a319635c8d673341390901dd395ba2a3fcd8c576fdae58e7b33f14a2e0',
     x86_64: '6ef1f53d92f844cb1d8b606cb8230077bc852b56d67563320b980d5c58d52011'
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
