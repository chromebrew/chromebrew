require 'package'

class Mutagen < Package
  description 'Mutagen provides real-time file synchronization and flexible network forwarding, extending the reach of your existing development tools to cloud-based containers and infrastructure.'
  homepage 'https://mutagen.io/'
  version '0.13.0'
  license 'GPL-2'
  compatibility 'all'
  case ARCH
  when 'aarch64', 'armv7l'
    source_url 'https://github.com/mutagen-io/mutagen/releases/download/v0.13.0/mutagen_linux_arm_v0.13.0.tar.gz'
    source_sha256 'be09d6cfe04ca6c9607914f7ec509608148a4209afe22d00be9b2c23b0d930d9'
  when 'i686'
    source_url 'https://github.com/mutagen-io/mutagen/releases/download/v0.13.0/mutagen_linux_386_v0.13.0.tar.gz'
    source_sha256 'a05c14dfeacbf56976983c4d513f4cd91f55e6e35fea86a4f3a44a1e2ed8808d'
  when 'x86_64'
    source_url 'https://github.com/mutagen-io/mutagen/releases/download/v0.13.0/mutagen_linux_amd64_v0.13.0.tar.gz'
    source_sha256 'bd4c009e4bbce76bf13823d8734b7ed951c1623026faedecb63f0f77aceefde1'
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
