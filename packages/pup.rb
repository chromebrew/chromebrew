require 'package'

class Pup < Package
  description 'pup is a command line tool for processing HTML inspired by jq'
  homepage 'https://github.com/ericchiang/pup'
  version '0.4.0'
  compatibility 'all'

  case ARCH
  when 'x86_64'
    source_url "https://github.com/ericchiang/pup/releases/download/v#{self.version}/pup_v#{self.version}_linux_amd64.zip"
    source_sha256 'ec3d29e9fb375b87ac492c8b546ad6be84b0c0b49dab7ff4c6b582eac71ba01c'
  when 'aarch64', 'armv7l'
    source_url "https://github.com/ericchiang/pup/releases/download/v#{self.version}/pup_v#{self.version}_linux_arm.zip"
    source_sha256 'ebf70b3c76c02e0202c94af7ef06dcb3ecc866d1b9b84453d43fe01fa5dd5870'
  when 'i686'
    source_url "https://github.com/ericchiang/pup/releases/download/v#{self.version}/pup_v#{self.version}_linux_386.zip"
    source_sha256 'e486b32ca07552cd3aa713cbf2f9d1b6e210ddb51d34b3090c7643f465828057'
  end

  def self.install
    system "install -Dm755 pup #{CREW_DEST_PREFIX}/bin/pup"
  end
end
