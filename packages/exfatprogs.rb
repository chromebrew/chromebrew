require 'package'

class Exfatprogs < Package
  description 'exFAT filesystem userspace utilities for the Linux Kernel exfat driver.'
  homepage 'https://github.com/exfatprogs/exfatprogs'
  @_ver = '1.1.3'
  version @_ver
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/exfatprogs/exfatprogs.git'
  git_hashtag @_ver

  def self.build
    system 'autoreconf -fiv'
    system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
