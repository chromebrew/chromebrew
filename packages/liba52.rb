require 'package'

class Liba52 < Package
  description 'liba52 is a free library for decoding ATSC A/52 streams.'
  homepage 'http://liba52.sourceforge.net/'
  @_ver = '0.7.4'
  version "#{@_ver}-2"
  compatibility 'all'
  license 'GPL-2+'
  source_url 'https://salsa.debian.org/multimedia-team/a52dec.git'
  git_hashtag "debian/#{@_ver}-20"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '844f79a23cd1dde50dee917211786abdef130f7e952ec6b1c9c8208f8ac69abc',
     armv7l: '844f79a23cd1dde50dee917211786abdef130f7e952ec6b1c9c8208f8ac69abc',
       i686: '8fb90edfa222ac82c6b357152f5416a8e5e5d2faa9a904e0b7c531c5e8f7d04a',
     x86_64: '01c64a8b207833ee58dc4482d4d96f5dff1261071ef6573e5817ce43e76a0789'
  })

  def self.patch
    system "for i in \$(cat debian/patches/series); do patch -Np1 -i debian/patches/\${i}; done"
  end

  def self.build
    system './bootstrap'
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.check
    system 'make', 'check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
