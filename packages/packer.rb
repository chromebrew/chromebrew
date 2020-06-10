ENV['CREW_NOT_STRIP'] = 'true'

require 'package'

class Packer < Package
  description 'Packer is an open source tool for creating identical machine images for multiple platforms from a single source configuration.'
  homepage 'https://www.packer.io/'
  version '1.4.4'
  compatibility 'all'

  case ARCH
  when 'aarch64'
    source_url 'https://releases.hashicorp.com/packer/1.4.4/packer_1.4.4_linux_arm64.zip'
    source_sha256 'c6930cf5afdeb99df3ed5c9eeeef89fbcb3a1a71a9e17ebba16c873405ab72cd'
  when 'armv7l'
    source_url 'https://releases.hashicorp.com/packer/1.4.4/packer_1.4.4_linux_arm.zip'
    source_sha256 '0cac826f983172aa836da65f76aa535fe7eacdece0510832ccfe3b51cb8dfe47'
  when 'i686'
    source_url 'https://releases.hashicorp.com/packer/1.4.4/packer_1.4.4_linux_386.zip'
    source_sha256 'a1a3773305453c81c48a5f5c0d2df91d64a44c29063e3d5dccd6be77fef3bcea'
  when 'x86_64'
    source_url 'https://releases.hashicorp.com/packer/1.4.4/packer_1.4.4_linux_amd64.zip'
    source_sha256 'b4dc37877a0fd00fc72ebda98977c2133be9ba6b26bcdd13b1b14a369e508948'
  end

  def self.install
    system "install -Dm755 packer #{CREW_DEST_PREFIX}/bin/packer"
  end
end

ENV['CREW_NOT_STRIP'] = ''
