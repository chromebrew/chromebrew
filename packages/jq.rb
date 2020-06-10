require 'package'

class Jq < Package
  description 'jq is a lightweight and flexible command-line JSON processor.'
  homepage 'https://stedolan.github.io/jq/'
  version '1.6'
  compatibility 'all'
  source_url 'https://github.com/stedolan/jq/releases/download/jq-1.6/jq-1.6.tar.gz'
  source_sha256 '5de8c8e29aaa3fb9cc6b47bb27299f271354ebb72514e3accadc7d38b5bbaa72'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/jq-1.6-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/jq-1.6-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/jq-1.6-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/jq-1.6-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'c230cb2046a0c1b40fe531a3480ee028cbe4db89cd7631eab48b3e4a38fac679',
     armv7l: 'c230cb2046a0c1b40fe531a3480ee028cbe4db89cd7631eab48b3e4a38fac679',
       i686: '135d38a61e055595485694711f8f47ab614d260b910ec73acd963333f1fe655e',
     x86_64: 'c4c04bfd6860fe7b7072e253ee4a4a1d6e37895cf859bc7caebb8df44a164327',
  })

  depends_on 'oniguruma'

  def self.build
    system "./configure",
      "--prefix=#{CREW_PREFIX}",
      '--disable-maintainer-mode', # disable make rules and dependencies not useful
      '--disable-docs'             # there's no support for manpages
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
