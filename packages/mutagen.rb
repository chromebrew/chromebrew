require 'package'

class Mutagen < Package
  description 'Mutagen provides real-time file synchronization and flexible network forwarding, extending the reach of your existing development tools to cloud-based containers and infrastructure.'
  homepage 'https://mutagen.io/'
  version '0.13.1'
  license 'GPL-2'
  compatibility 'all'
  case ARCH
  when 'aarch64', 'armv7l'
    source_url 'https://github.com/mutagen-io/mutagen/releases/download/v0.13.1/mutagen_linux_arm_v0.13.1.tar.gz'
    source_sha256 '7947b2aa055e0884ea77e7588a1ba1d4bf943d42c92480ef90be6567c0881826'
  when 'i686'
    source_url 'https://github.com/mutagen-io/mutagen/releases/download/v0.13.1/mutagen_linux_386_v0.13.1.tar.gz'
    source_sha256 '0dbf0ea83b9fd8d7fca5aaa63f8e29a9041426464b3ad4cbe0dc3db112222d81'
  when 'x86_64'
    source_url 'https://github.com/mutagen-io/mutagen/releases/download/v0.13.1/mutagen_linux_amd64_v0.13.1.tar.gz'
    source_sha256 '943b84502f2476e3b4c44e52b93e9cd2827e24f3f9c756e2240c0344c2fd2020'
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
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.install 'mutagen', "#{CREW_DEST_PREFIX}/bin/mutagen", mode: 0o755
    FileUtils.install "linux_#{arch}", "#{CREW_DEST_PREFIX}/bin/mutagen-agent", mode: 0o755
  end

  def self.postinstall
    puts "\nType 'mutagen' to get started.\n".lightblue
  end
end
