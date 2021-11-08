require 'package'

class Monero < Package
  description 'Private, decentralized cryptocurrency that keeps your finances confidential and secure.'
  homepage 'https://www.getmonero.org/'
  version '0.17.2.3'
  license 'The Cryptonote developers,The Boolberry developers,MIT'
  compatibility 'all'
  case ARCH
  when 'aarch64', 'armv7l'
   source_url 'https://downloads.getmonero.org/cli/monero-linux-armv7-v0.17.2.3.tar.bz2'
   source_sha256 '9100704b7d98d7bffbf7f72804c0c048f5e60f1dc9f6d4830c633dda3687c419'
  when 'i686'
    source_url 'https://downloads.getmonero.org/cli/monero-linux-x86-v0.17.2.3.tar.bz2'
    source_sha256 'a93788591bd56753369a3f3171fbefb09387758c1e3a219e9265473031f0a35d'
  when 'x86_64'
    source_url 'https://downloads.getmonero.org/cli/monero-linux-x64-v0.17.2.3.tar.bz2'
    source_sha256 '8069012ad5e7b35f79e35e6ca71c2424efc54b61f6f93238b182981ba83f2311'
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/monero"
    FileUtils.mv Dir['monero*'], "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mv 'LICENSE', "#{CREW_DEST_PREFIX}/share/monero"
  end
end
