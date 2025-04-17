require 'package'

class Command_not_found < Package
  description 'Show suggestions for non-installed commands'
  homepage 'https://github.com/chromebrew/command-not-found-handler'
  version '0.1.1'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://github.com/chromebrew/command-not-found-handler.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7f8de55deb147596cac8c0fd518de614fb509ce0e7492e7592f13b69ce94e6a3',
     armv7l: '7f8de55deb147596cac8c0fd518de614fb509ce0e7492e7592f13b69ce94e6a3',
       i686: '775b86ef37ac0e7f541af095d939063c4dcd2512e330a88aab7846a9f6e80c47',
     x86_64: '4e1bc306c0e7995946c5f0d219a35a2e4115bee31914a242cff479a4cc5360d4'
  })

  depends_on 'glibc' # R

  print_source_bashrc

  def self.build
    system "mold -run cc #{CREW_COMMON_FLAGS} command-not-found-handler.c -o command-not-found-handler"
  end

  def self.install
    FileUtils.mkdir_p %W[#{CREW_DEST_PREFIX}/bin #{CREW_DEST_PREFIX}/etc/bash.d]
    FileUtils.install 'command-not-found-handler', "#{CREW_DEST_PREFIX}/bin/command-not-found-handler", mode: 0o755
    FileUtils.install 'command-not-found.sh', "#{CREW_DEST_PREFIX}/etc/bash.d/03-command-not-found", mode: 0o644
  end
end
