require 'package'

class Pcre < Package
  description 'The PCRE library is a set of functions that implement regular expression pattern matching using the same syntax and semantics as Perl 5.'
  homepage 'http://pcre.org/'
  @_ver = '8.44'
  version "#{@_ver}-1"
  compatibility 'all'
  source_url "https://ftp.pcre.org/pub/pcre/pcre-#{@_ver}.tar.bz2"
  source_sha256 '19108658b23b3ec5058edc9f66ac545ea19f9537234be1ec62b714c84399366d'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/pcre-8.44-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/pcre-8.44-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/pcre-8.44-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/pcre-8.44-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '6d54befc6735b9d85928c14d1f03519d25514aed4c1a1f3d12114d3585f535f3',
     armv7l: '6d54befc6735b9d85928c14d1f03519d25514aed4c1a1f3d12114d3585f535f3',
       i686: '092fe524f7e00bc4e19b6a5cf01e1677f9d7900c8e105adcd086cd9670c7c558',
     x86_64: '4c62ce6b8ae532c7b0885973b50363034c2a84b281baa5542149226a38016cbe'
  })

  def self.build
    system "env CFLAGS='-flto=auto' CXXFLAGS='-flto=auto' \
      LDFLAGS='-flto=auto' \
      ./configure #{CREW_OPTIONS} \
      --enable-shared \
      --with-pic \
      --enable-unicode-properties \
      --enable-pcre16 \
      --enable-pcre32 \
      --enable-jit \
      --enable-pcretest-libreadline"
    system 'make'
  end

  def self.check
    # `make check` fails because of an issue with locale.
    # All but one test passes.
    # system 'make', 'check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
