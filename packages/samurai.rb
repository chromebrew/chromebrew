require 'package'

class Samurai < Package
  description 'Samurai is a ninja compatible build tool written in C.'
  homepage 'https://github.com/michaelforney/samurai/'
  @_ver = '1.2'
  version @_ver + '-1'
  license 'Apache-2.0 and MIT'
  compatibility 'all'
  source_url 'https://github.com/michaelforney/samurai.git'
  git_hashtag @_ver

  def self.patch
    system "sed -i 's:PREFIX=/usr/local:PREFIX=#{CREW_PREFIX}:' Makefile"
    system "sed -i 's:MANDIR=\$(PREFIX)/share/man:MANDIR=#{CREW_MAN_PREFIX}:g' Makefile"
  end

  def self.build
    system "make CFLAGS='#{CREW_COMMON_FLAGS}' \
                LDFLAGS='#{CREW_LDFLAGS}' \
                CC='#{CREW_TGT}-gcc'"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    # no checks
  end
end
