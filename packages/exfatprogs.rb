require 'package'

class Exfatprogs < Package
  description 'exFAT filesystem userspace utilities for the Linux Kernel exfat driver.'
  homepage 'https://github.com/exfatprogs/exfatprogs'
  version '1.2.0'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/exfatprogs/exfatprogs.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/exfatprogs/1.2.0_armv7l/exfatprogs-1.2.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/exfatprogs/1.2.0_armv7l/exfatprogs-1.2.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/exfatprogs/1.2.0_i686/exfatprogs-1.2.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/exfatprogs/1.2.0_x86_64/exfatprogs-1.2.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '3549b44369753a5372ebe620309468cd0ccf2e3814aadbec75c2077f4c035841',
     armv7l: '3549b44369753a5372ebe620309468cd0ccf2e3814aadbec75c2077f4c035841',
       i686: 'ccdcf93768f7ddc060364bf9953a2e903c669866dafa08141e33a075bb660059',
     x86_64: 'fd89fc698d84aebcba7d97ca7f62d26181393bbb2878dda78d18d4773f8c3ba5'
  })

  depends_on 'glibc' # R

  def self.build
    system '[ -x configure ] || NOCONFIGURE=1 ./autogen.sh'
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
