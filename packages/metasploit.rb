require 'package'

class Metasploit < Package
  description 'The Metasploit Framework is a tool for developing and executing exploit code against a remote target machine.'
  homepage 'https://www.metasploit.com/'
  version '4.14.28'
  source_url 'https://github.com/rapid7/metasploit-framework/archive/4.14.28.tar.gz'
  source_sha256 'f2bc048542d7cbba16308b5a987718428825b5f00df7e5245543598d9d42a169'

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
    system "mkdir -p #{CREW_DEST_DIR}/usr/local/share/metasploit-framework/"
    system "mkdir -p #{CREW_DEST_DIR}/usr/local/bin"
    system "cp -r * #{CREW_DEST_DIR}/usr/local/share/metasploit-framework"
    system "ln -s /usr/local/share/metasploit-framework/msfconsole #{CREW_DEST_DIR}/usr/local/bin/msfconsole"
    system "ln -s /usr/local/share/metasploit-framework/msfd #{CREW_DEST_DIR}/usr/local/bin/msfd"
    system "ln -s /usr/local/share/metasploit-framework/msfrpc #{CREW_DEST_DIR}/usr/local/bin/msfrpc"
    system "ln -s /usr/local/share/metasploit-framework/msfrpcd #{CREW_DEST_DIR}/usr/local/bin/msfrpcd"
    system "ln -s /usr/local/share/metasploit-framework/msfupdate #{CREW_DEST_DIR}/usr/local/bin/msfupdate" # Doesn't work, but I symlinked it anyway
    system "ln -s /usr/local/share/metasploit-framework/msfvenom #{CREW_DEST_DIR}/usr/local/bin/msfvenom"
  end
end
