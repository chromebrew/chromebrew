require 'package'

class Mutagen < Package
  description 'Mutagen provides real-time file synchronization and flexible network forwarding, extending the reach of your existing development tools to cloud-based containers and infrastructure.'
  homepage 'https://mutagen.io/'
  version '0.17.2'
  license 'GPL-2'
  compatibility 'all'
  source_url({
    aarch64: 'https://github.com/mutagen-io/mutagen/releases/download/v0.17.2/mutagen_linux_arm_v0.17.2.tar.gz',
     armv7l: 'https://github.com/mutagen-io/mutagen/releases/download/v0.17.2/mutagen_linux_arm_v0.17.2.tar.gz',
       i686: 'https://github.com/mutagen-io/mutagen/releases/download/v0.17.2/mutagen_linux_386_v0.17.2.tar.gz',
     x86_64: 'https://github.com/mutagen-io/mutagen/releases/download/v0.17.2/mutagen_linux_amd64_v0.17.2.tar.gz'
  })
  source_sha256({
    aarch64: 'fc6475d5c0a275491a7a5228d03b41b7fb2a46dc054395c4b8003af9bd49e3a1',
     armv7l: 'fc6475d5c0a275491a7a5228d03b41b7fb2a46dc054395c4b8003af9bd49e3a1',
       i686: 'e9657d23a2b1ea7cb753fdbbb5c82063efceec1619bd516f4014018aa1e96bd6',
     x86_64: '85d967462ade994d37fc8d4906579d33b6fbb1744bab4a7cceb0c12424fb0f1d'
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
    FileUtils.install 'mutagen', "#{CREW_DEST_PREFIX}/bin/mutagen", mode: 0o755
    FileUtils.install "linux_#{arch}", "#{CREW_DEST_PREFIX}/bin/mutagen-agent", mode: 0o755
  end

  def self.postinstall
    puts "\nType 'mutagen' to get started.\n".lightblue
  end
end
