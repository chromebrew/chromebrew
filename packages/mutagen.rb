require 'package'

class Mutagen < Package
  description 'Mutagen provides real-time file synchronization and flexible network forwarding, extending the reach of your existing development tools to cloud-based containers and infrastructure.'
  homepage 'https://mutagen.io/'
  version '0.11.5'
  compatibility 'all'
  case ARCH
  when 'aarch64', 'armv7l'
    source_url 'https://github.com/mutagen-io/mutagen/releases/download/v0.11.5/mutagen_linux_arm_v0.11.5.tar.gz'
    source_sha256 '35ac96d59cd958aab6b2e693da2882df17a1714b2529f9c7210deb439bb59468'
  when 'i686'
    source_url 'https://github.com/mutagen-io/mutagen/releases/download/v0.11.5/mutagen_linux_386_v0.11.5.tar.gz'
    source_sha256 'bf293258b96ca5c5a96c8e4787b101c4c287ce82a0bdf9038817385054718c61'
  when 'x86_64'
    source_url 'https://github.com/mutagen-io/mutagen/releases/download/v0.11.5/mutagen_linux_amd64_v0.11.5.tar.gz'
    source_sha256 '00112216f7d259ab94f951d5b3c644fe40a040e042811439781fcae810314575'
  end

  def self.install
    case ARCH
    when 'aarch64', 'armv7l'
      arch = 'arm'
    when 'i686'
      arch = '386'
    when 'x86_64'
      arch = 'amd64'
    end
    system "tar xvf mutagen-agents.tar.gz linux_#{arch}"
    system "install -Dm755 mutagen #{CREW_DEST_PREFIX}/bin/mutagen"
    system "install -Dm755 linux_#{arch} #{CREW_DEST_PREFIX}/bin/mutagen-agent"
  end

  def self.postinstall
    puts
    puts "Type 'mutagen' to get started.".lightblue
    puts
  end
end
