require 'package'

class Socat < Package
  description 'SOcket CAT is a multipurpose relay \'netcat++\' (extended design, new implementation).'
  homepage 'http://www.dest-unreach.org/socat/'
  version '1.7.4.4'
  license 'GPL-2'
  compatibility 'all'
  source_url 'http://www.dest-unreach.org/socat/download/socat-1.7.4.4.tar.gz'
  source_sha256 '0f8f4b9d5c60b8c53d17b60d79ababc4a0f51b3bb6d2bd3ae8a6a4b9d68f195e'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '76d9e400d0574e6200cee7c4c9743b2a78f1e64d3f59a2ca7beb41a697a9e49d',
     armv7l: '76d9e400d0574e6200cee7c4c9743b2a78f1e64d3f59a2ca7beb41a697a9e49d',
       i686: '315b412cafa133fed17c0fff71ad16813eea35f4ce29f59489d7378e5d8f72c9',
     x86_64: '44b495a05a294d69bca119e9d4efc9c5e81de85baa5f3c87f431701cbafd55b2'
  })

  depends_on 'readline'
  depends_on 'openssl'
  depends_on 'glibc' # R

  def self.build
    system './configure'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
