require 'package'

class Metasploit < Package
  description 'The Metasploit Framework is a tool for developing and executing exploit code against a remote target machine.'
  homepage 'https://www.metasploit.com/'
  version '6.0.9'
  compatibility 'all'
  source_url 'https://github.com/rapid7/metasploit-framework/archive/6.0.9.tar.gz'
  source_sha256 '69a12a089fcd130a40f3f973a53057a948a7f2b6df6a3a64613ee22aa3d53016'

  binary_url ({

  })
  binary_sha256 ({

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
