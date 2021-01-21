require 'package'

class Bison < Package
  description 'Bison is a general-purpose parser generator that converts an annotated context-free grammar into a deterministic LR or generalized LR (GLR) parser employing LALR(1) parser tables.'
  homepage 'https://www.gnu.org/software/bison/'
  @_ver = '3.7.4'
  version @_ver
  compatibility 'all'
  source_url "https://ftpmirror.gnu.org/gnu/bison/bison-#{@_ver}.tar.xz"
  source_sha256 'a3b5813f48a11e540ef26f46e4d288c0c25c7907d9879ae50e430ec49f63c010'
  
  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/bison-3.7.4-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/bison-3.7.4-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/bison-3.7.4-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/bison-3.7.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: 'ba8edbb5a88d16aedbd7c37dc247bd4a4fec5390063dc6220b1275a0bdcfb44c',
      armv7l: 'ba8edbb5a88d16aedbd7c37dc247bd4a4fec5390063dc6220b1275a0bdcfb44c',
        i686: '5e3db2010be0f04fefe4d4db3c265e4c5c96e7d9b36748fbd221fb71c4405ff5',
      x86_64: '9ae17d6c8ae82bbf4ff2d6e2cdca52f91c21a8498b972f1012629697e6d8ee5d',
  })

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make check'
  end
end
