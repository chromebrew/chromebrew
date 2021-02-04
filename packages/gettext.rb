require 'package'

class Gettext < Package
  description 'GNU gettext utilities are a set of tools that provides a framework to help other GNU packages produce multi-lingual messages.'
  homepage 'https://www.gnu.org/software/gettext/'
  @_ver = '0.21'
  version "#{@ver}-1"
  compatibility 'all'
  source_url "https://gnu.freemirror.org/gnu/gettext/gettext-#{@_ver}.tar.lz"
  source_sha256 '435b546e3880ab767c967c0731b20629a0cb0ba620e6bac2f590f401c10ebb45'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gettext-0.21-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gettext-0.21-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gettext-0.21-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gettext-0.21-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '57ae562920cf6caefb4e6e764a171a8a78f18e5767668e42e4722cc63612cfa7',
     armv7l: '57ae562920cf6caefb4e6e764a171a8a78f18e5767668e42e4722cc63612cfa7',
       i686: '520172814ee0312877b6a0fb0d5d9f4e22473cf5bb9272facf93bf4d5597d1c0',
     x86_64: 'de490d13276f5b9a48e007b57c08c64aac21730b1091be453c1373a0e1c26c52'
  })

  depends_on 'ncurses'
  depends_on 'libxml2'
  depends_on 'icu4c'
  depends_on 'jdk8' => :build

  def self.build
    raise StandardError, 'Please remove libiconv before building.' if File.exist?("#{CREW_LIB_PREFIX}/libcharset.so")

    system "env CFLAGS='-flto=auto' CXXFLAGS='-flto=auto'  LDFLAGS='-flto=auto'\
    ./configure #{CREW_OPTIONS} \
    --disable-static \
    --enable-shared \
    --with-pic"
    system 'make'
  end

  def self.check
    # system 'make', 'check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
