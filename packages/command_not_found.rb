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
    aarch64: 'e3cacd7f1b300ef05dffd49998d438849c008c9aaf54d72305b0a1a7e5569333',
     armv7l: 'e3cacd7f1b300ef05dffd49998d438849c008c9aaf54d72305b0a1a7e5569333',
       i686: '8fdc2eb291297b6143b9fb6557ac249303cff6bee8da938a26829099f338492f',
     x86_64: 'c231721811f8d82f61e7515dfef7ea42e3e990d7c5a31a1c85e4e53de5d12582'
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
