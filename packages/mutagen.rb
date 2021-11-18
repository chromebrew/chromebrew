require 'package'

class Mutagen < Package
  description 'Mutagen provides real-time file synchronization and flexible network forwarding, extending the reach of your existing development tools to cloud-based containers and infrastructure.'
  homepage 'https://mutagen.io/'
  version '0.12.0'
  license 'GPL-2'
  compatibility 'all'
  case ARCH
  when 'aarch64', 'armv7l'
    source_url 'https://github.com/mutagen-io/mutagen/releases/download/v0.12.0/mutagen_linux_arm_v0.12.0.tar.gz'
    source_sha256 '2705d665e7e66555b577260d32b11cca2f3a252f3f90dc27e2982f8af907a18f'
  when 'i686'
    source_url 'https://github.com/mutagen-io/mutagen/releases/download/v0.12.0/mutagen_linux_386_v0.12.0.tar.gz'
    source_sha256 'c41175729cdb5c7f7280ccb27d56b0992e26e20fb1b7cefe9a7a6d2f7f623d4a'
  when 'x86_64'
    source_url 'https://github.com/mutagen-io/mutagen/releases/download/v0.12.0/mutagen_linux_amd64_v0.12.0.tar.gz'
    source_sha256 '7a35891c0667105d43ce36b1ee406b3af21802ba5cd402cac47fcf5eff1ecad9'
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
