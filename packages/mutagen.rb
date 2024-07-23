require 'package'

class Mutagen < Package
  description 'Mutagen provides real-time file synchronization and flexible network forwarding, extending the reach of your existing development tools to cloud-based containers and infrastructure.'
  homepage 'https://mutagen.io/'
  version '0.17.5'
  license 'GPL-2'
  compatibility 'all'
  source_url({
    aarch64: 'https://github.com/mutagen-io/mutagen/releases/download/v0.17.5/mutagen_linux_arm_v0.17.5.tar.gz',
     armv7l: 'https://github.com/mutagen-io/mutagen/releases/download/v0.17.5/mutagen_linux_arm_v0.17.5.tar.gz',
       i686: 'https://github.com/mutagen-io/mutagen/releases/download/v0.17.5/mutagen_linux_386_v0.17.5.tar.gz',
     x86_64: 'https://github.com/mutagen-io/mutagen/releases/download/v0.17.5/mutagen_linux_amd64_v0.17.5.tar.gz'
  })
  source_sha256({
    aarch64: '96b0aac073d0ea902c1b8040ae88005dd1255bdefec01ee5a18003be7a30174c',
     armv7l: '96b0aac073d0ea902c1b8040ae88005dd1255bdefec01ee5a18003be7a30174c',
       i686: '0b98ef515688693c421e3794f9a767604b6868b6bcb6379b8bae70c651c9fd00',
     x86_64: 'cabee0af590faf822cb5542437e254406b0f037df43781c02bf6eeac267911f6'
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
    ExitMessage.add "\nType 'mutagen' to get started.\n".lightblue
  end
end
