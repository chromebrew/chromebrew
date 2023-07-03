require 'package'

class Monero < Package
  description 'Private, decentralized cryptocurrency that keeps your finances confidential and secure.'
  homepage 'https://www.getmonero.org/'
  version '0.18.2.2'
  license 'The Cryptonote developers,The Boolberry developers,MIT'
  compatibility 'all'
  case ARCH
  when 'aarch64', 'armv7l'
    source_url 'https://downloads.getmonero.org/cli/monero-linux-armv7-v0.18.2.2.tar.bz2'
    source_sha256 '11b70a9965e3749970531baaa6c9d636b631d8b0a0256ee23a8e519f13b4b300'
  when 'i686'
    source_url 'https://downloads.getmonero.org/cli/monero-linux-x86-v0.18.2.2.tar.bz2'
    source_sha256 'c0999191b57156fc7b4e7e64fe50ffdf16781bae0ebc12c96c41b2c60bdee79f'
  when 'x86_64'
    source_url 'https://downloads.getmonero.org/cli/monero-linux-x64-v0.18.2.2.tar.bz2'
    source_sha256 '186800de18f67cca8475ce392168aabeb5709a8f8058b0f7919d7c693786d56b'
  end

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/monero"
    FileUtils.mv Dir['monero*'], "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mv 'LICENSE', "#{CREW_DEST_PREFIX}/share/monero"
  end

  def self.postinstall
    puts "\nType 'monero-wallet-cli' to get started.\n".lightblue
  end
end
