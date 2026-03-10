require 'package'

class Mutagen < Package
  description 'Mutagen provides real-time file synchronization and flexible network forwarding, extending the reach of your existing development tools to cloud-based containers and infrastructure.'
  homepage 'https://mutagen.io/'
  version '0.18.1'
  license 'GPL-2'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/mutagen-io/mutagen/releases/download/v#{version}/mutagen_linux_arm_v#{version}.tar.gz",
     armv7l: "https://github.com/mutagen-io/mutagen/releases/download/v#{version}/mutagen_linux_arm_v#{version}.tar.gz",
       i686: "https://github.com/mutagen-io/mutagen/releases/download/v#{version}/mutagen_linux_386_v#{version}.tar.gz",
     x86_64: "https://github.com/mutagen-io/mutagen/releases/download/v#{version}/mutagen_linux_amd64_v#{version}.tar.gz"
  })
  source_sha256({
    aarch64: '441599fc7f8212fa009d8a829507b3879d11849dd78fcc1f3a773bfa1bc97bb9',
     armv7l: '441599fc7f8212fa009d8a829507b3879d11849dd78fcc1f3a773bfa1bc97bb9',
       i686: '58c2bdfb148da219569fb0ddb84aec2e3c121b8538f356dc78c73a989d67c4b6',
     x86_64: '7735286c778cc438418209f24d03a64f3a0151c8065ef0fe079cfaf093af6f8f'
  })

  no_compile_needed

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
    FileUtils.install 'mutagen', "#{CREW_DEST_PREFIX}/bin/mutagen", mode: 0o755
    FileUtils.install "linux_#{arch}", "#{CREW_DEST_PREFIX}/bin/mutagen-agent", mode: 0o755
  end

  def self.postinstall
    ExitMessage.add "\nType 'mutagen' to get started.\n"
  end
end
