require 'package'

class Z < Package
  description 'jump around'
  homepage 'https://github.com/rupa/z'
  version '1.12'
  license 'WTFPL'
  compatibility 'all'
  source_url 'https://github.com/rupa/z.git'
  git_hashtag "v#{version}"

  no_compile_needed

  def self.build
    system 'make'
  end

  def self.install
    FileUtils.install 'z.sh', "#{CREW_DEST_PREFIX}/bin/z", mode: 0o755
    FileUtils.install 'z.1', "#{CREW_DEST_MAN_PREFIX}/man1/z.1", mode: 0o644
  end

  def self.postinstall
    ExitMessage.add "\nType 'man z' to get started.\n"
  end
end
