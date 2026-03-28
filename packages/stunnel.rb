require 'buildsystems/autotools'

class Stunnel < Autotools
  description "Stunnel is a proxy designed to add TLS encryption functionality to existing clients and servers without any changes in the programs' code."
  homepage 'https://www.stunnel.org/index.html'
  version '5.77'
  license 'GPL-2+'
  compatibility 'all'
  source_url "https://www.stunnel.org/downloads/stunnel-#{version}.tar.gz"
  source_sha256 'ec026f4fae4e0d25b940cc7a9451d925e359e7fd59e9edad20baea66ce45f263'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1ae4abb77054bd08932698e9b21644cb47465d210d69a0ddc96c4a510cc22915',
     armv7l: '1ae4abb77054bd08932698e9b21644cb47465d210d69a0ddc96c4a510cc22915',
       i686: 'de106a125e6086200e35deccb4760614484a54f30441c3b749163d72bac3a703',
     x86_64: 'ca239963a16af6d9c4af777b6d5cc8a3e722c15e0324e8f6d68b056f7d2678ac'
  })

  depends_on 'glibc' => :library
  depends_on 'openssl' => :executable
  depends_on 'tcpwrappers' => :library

  def self.postbuild
    # Fix bash: /usr/local/bin/stunnel3: /usr/bin/perl: bad interpreter: No such file or directory
    system "sed -i 's,/usr/bin/perl,#{CREW_PREFIX}/bin/perl,' #{CREW_DEST_PREFIX}/bin/stunnel3"
  end
end
