require 'package'

class Metasploit < Package
  description 'The Metasploit Framework is a tool for developing and executing exploit code against a remote target machine.'
  homepage 'https://www.metasploit.com/'
  version '4.16.19'
  compatibility 'all'
  source_url 'https://github.com/rapid7/metasploit-framework/archive/4.16.19.tar.gz'
  source_sha256 'd42d950da520586cf2e3b4f0a86e895250a95e2cd6ec3aff972e3b24492bfd2a'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/metasploit-4.16.19-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/metasploit-4.16.19-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/metasploit-4.16.19-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/metasploit-4.16.19-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '048ec59ec22c011b0493fff042e159bf2a7a74ed8583ecc06713b8fe14f63235',
     armv7l: '048ec59ec22c011b0493fff042e159bf2a7a74ed8583ecc06713b8fe14f63235',
       i686: '641b577192692e7a108764eff4917eb34ca26873c9456abf2ddbd2e81586742a',
     x86_64: 'd3e70602086ffd04438aa6543318e5dc5e78995fe1eabfcfeb94fc7642372974',
  })

  depends_on 'ruby'
  depends_on 'readline'
  depends_on 'openssl'
  depends_on 'libpcap'
  depends_on 'postgres'
  depends_on 'sqlite'
  depends_on 'libxslt'
  depends_on 'libxml2'
  depends_on 'bison'

  def self.build
    system "gem install bundler --conservative"
    system "NOKOGIRI_USE_SYSTEM_LIBRARIES=1"
    system "bundle install"
  end

  def self.install
    system "mkdir -p #{CREW_DEST_PREFIX}/share/metasploit-framework/"
    system "mkdir -p #{CREW_DEST_PREFIX}/bin"
    system "cp -r * #{CREW_DEST_PREFIX}/share/metasploit-framework"
    system "ln -s #{CREW_PREFIX}/share/metasploit-framework/msfconsole #{CREW_DEST_PREFIX}/bin/msfconsole"
    system "ln -s #{CREW_PREFIX}/share/metasploit-framework/msfd #{CREW_DEST_PREFIX}/bin/msfd"
    system "ln -s #{CREW_PREFIX}/share/metasploit-framework/msfrpc #{CREW_DEST_PREFIX}/bin/msfrpc"
    system "ln -s #{CREW_PREFIX}/share/metasploit-framework/msfrpcd #{CREW_DEST_PREFIX}/bin/msfrpcd"
    system "ln -s #{CREW_PREFIX}/share/metasploit-framework/msfupdate #{CREW_DEST_PREFIX}/bin/msfupdate" # Doesn't work, but I symlinked it anyway
    system "ln -s #{CREW_PREFIX}/share/metasploit-framework/msfvenom #{CREW_DEST_PREFIX}/bin/msfvenom"
  end
end
