require 'package'

class Monero < Package
  description 'Private, decentralized cryptocurrency that keeps your finances confidential and secure.'
  homepage 'https://www.getmonero.org/'
  version '0.17.3.0'
  license 'The Cryptonote developers,The Boolberry developers,MIT'
  compatibility 'all'
  case ARCH
  when 'aarch64', 'armv7l'
    source_url 'https://downloads.getmonero.org/cli/monero-linux-armv7-v0.17.3.0.tar.bz2'
    source_sha256 'da49d85ce2d52fc07846c58d0c58d6412f454f9d389bfa31eab9c1d49a1a13ed'
  when 'i686'
    source_url 'https://downloads.getmonero.org/cli/monero-linux-x86-v0.17.3.0.tar.bz2'
    source_sha256 '586b9967d848eb31dd66bdb6d828bd3a640098434595a5933374d129b76958eb'
  when 'x86_64'
    source_url 'https://downloads.getmonero.org/cli/monero-linux-x64-v0.17.3.0.tar.bz2'
    source_sha256 'ac18ce3d1189410a5c175984827d5d601974733303411f6142296d647f6582ce'
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/monero"
    FileUtils.mv 'monero*', "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mv 'LICENSE', "#{CREW_DEST_PREFIX}/share/monero"
  end
end
