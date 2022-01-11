require 'package'

class Libdsm < Package
  description 'Defective SMb: A minimalist implementation of a client library for SMB using C.'
  homepage 'https://videolabs.github.io/libdsm/'
  @_ver = '0.3.2'
  version @_ver
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url 'https://github.com/videolabs/libdsm.git'
  git_hashtag 'v' + @_ver

  depends_on 'libtasn1'

  def self.build
    system './bootstrap'
    system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS} \
            --with-urandom=/dev/urandom"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end
