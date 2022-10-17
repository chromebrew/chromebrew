require 'package'

class Mutagen < Package
  description 'Mutagen provides real-time file synchronization and flexible network forwarding, extending the reach of your existing development tools to cloud-based containers and infrastructure.'
  homepage 'https://mutagen.io/'
  version '0.15.1'
  license 'GPL-2'
  compatibility 'all'
  source_url({
    aarch64: 'https://github.com/mutagen-io/mutagen/releases/download/v0.15.1/mutagen_linux_arm_v0.15.1.tar.gz',
     armv7l: 'https://github.com/mutagen-io/mutagen/releases/download/v0.15.1/mutagen_linux_arm_v0.15.1.tar.gz',
       i686: 'https://github.com/mutagen-io/mutagen/releases/download/v0.15.1/mutagen_linux_386_v0.15.1.tar.gz',
     x86_64: 'https://github.com/mutagen-io/mutagen/releases/download/v0.15.1/mutagen_linux_amd64_v0.15.1.tar.gz'
  })
  source_sha256({
    aarch64: '74e5dd5aba9129e41b788a4cca46b102f61bef11a22f63a3b7c7e73c85b8d8bb',
     armv7l: '74e5dd5aba9129e41b788a4cca46b102f61bef11a22f63a3b7c7e73c85b8d8bb',
       i686: 'f02be5655607541fd264d5678a7ae8e6f34c6de05b4f24c3b20bf2945c11cbc4',
     x86_64: 'e88afa1657291697245f54abab4eda84531e785bb945e2d92dfc2aab830f7120'
  })

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
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.install 'mutagen', "#{CREW_DEST_PREFIX}/bin/mutagen", mode: 0o755
    FileUtils.install "linux_#{arch}", "#{CREW_DEST_PREFIX}/bin/mutagen-agent", mode: 0o755
  end

  def self.postinstall
    puts "\nType 'mutagen' to get started.\n".lightblue
  end
end
