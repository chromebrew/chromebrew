require 'package'

class Minerd < Package
  description 'CPU miner for Litecoin and Bitcoin'
  homepage 'https://github.com/pooler/cpuminer'
  version '2.5.0'
  source_url 'https://github.com/pooler/cpuminer/releases/download/v2.5.0/pooler-cpuminer-2.5.0.tar.gz'
  source_sha256 'ea16761a952b8f0fbba22fd16d48bb5e20abc48a10af99a00c70c332b3cb54f5'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'curl'
  depends_on 'jansson'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    system "gzip -9 #{CREW_DEST_PREFIX}/share/man/man1/minerd.1"
  end
end
