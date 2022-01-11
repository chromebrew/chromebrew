require 'package'

class Libnfs < Package
  description 'client library for accessing NFS shares'
  homepage 'https://github.com/sahlberg/libnfs'
  @_ver = '4.0.0'
  version @_ver + '-1'
  license 'GPL-3, LGPL-2.1 and BSD'
  compatibility 'all'
  source_url "https://github.com/sahlberg/libnfs.git"
  git_hashtag 'libnfs-' + @_ver

  def self.build
    system 'autoreconf -fiv'
    system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS} \
            --enable-utils"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end
