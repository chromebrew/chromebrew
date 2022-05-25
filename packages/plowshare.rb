require 'package'

class Plowshare < Package
  description 'Command-line tool and engine for managing sharing websites'
  homepage 'https://github.com/mcrapet/plowshare'
  version '2.1.7-1'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://github.com/mcrapet/plowshare/archive/v2.1.7.tar.gz'
  source_sha256 'c17d0cc1b3323f72b2c1a5b183a9fcef04e8bfc53c9679a4e1523642310d22ad'
  binary_compression 'tar.xz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/plowshare/2.1.7-1_armv7l/plowshare-2.1.7-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/plowshare/2.1.7-1_armv7l/plowshare-2.1.7-1-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/plowshare/2.1.7-1_i686/plowshare-2.1.7-1-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/plowshare/2.1.7-1_x86_64/plowshare-2.1.7-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '0ea3edec905fbdd53d7b94ae485878905008c9945f5861eda3724f0804d52d5b',
     armv7l: '0ea3edec905fbdd53d7b94ae485878905008c9945f5861eda3724f0804d52d5b',
       i686: '40c24122a6a953e2da2f4b23593a3f141fc8591bcf09c9292fcefe8bbde5c703',
     x86_64: '7febe5e161d02172925313b232c9f9615459395a296856e93df3d9ed36defad8'
  })

  depends_on 'recode'

  def self.install
    system 'make', "PREFIX=#{CREW_PREFIX}", "DESTDIR=#{CREW_DEST_DIR}", 'install'

    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/bash.d/"
    @plowshareenv = <<~PLOWSHAREEOF
      # plowshare bash completion
      source #{CREW_PREFIX}/share/bash-completion/completions/plowdown
    PLOWSHAREEOF
    File.write("#{CREW_DEST_PREFIX}/etc/bash.d/plowshare", @plowshareenv)
  end
end
