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
    aarch64: '0aead6c12bd67808524230208ff15d4bc42d7ed1ea9be3afcda04d472c60f1d1',
     armv7l: '0aead6c12bd67808524230208ff15d4bc42d7ed1ea9be3afcda04d472c60f1d1',
       i686: 'b7ff7c3e46bb451ea65c2040266c899baa6f3ac20dbcb7534a60f5515b76c90b',
     x86_64: 'c0b85473858287fc4cf473fd0afea705607d3355ff7acceec42a7e38628462c2'
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
