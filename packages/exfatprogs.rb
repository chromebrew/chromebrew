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

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/exfatprogs/1.1.3_armv7l/exfatprogs-1.1.3-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/exfatprogs/1.1.3_armv7l/exfatprogs-1.1.3-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/exfatprogs/1.1.3_i686/exfatprogs-1.1.3-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/exfatprogs/1.1.3_x86_64/exfatprogs-1.1.3-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '109016c4ea5ea8a35820d5c3007917fcb2160b000de38bd891f88b7acbc80db1',
     armv7l: '109016c4ea5ea8a35820d5c3007917fcb2160b000de38bd891f88b7acbc80db1',
       i686: 'bdce24c712e651ccf31853737e0a70e1f70e891f3942ca44894dca46a8dce290',
     x86_64: '4669c16fd3ad52905c97452de31fb3cd2d9ecf7a713ec9f9bd2e37f9281f0767'
  })

  def self.build
    system 'autoreconf -fiv'
    system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
