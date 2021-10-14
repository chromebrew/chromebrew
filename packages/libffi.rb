require 'package'

class Libffi < Package
  description 'The libffi library provides a portable, high level programming interface to various calling conventions.'
  homepage 'https://github.com/libffi/libffi/'
  @_ver = '3.4.2'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/libffi/libffi.git'
  git_hashtag 'v' + @_ver

  def self.build
    system 'autoreconf -fiv'
    system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    # system "make check"         # DejaGNU required
  end
end
