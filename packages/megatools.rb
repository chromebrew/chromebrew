require 'package'

class Megatools < Package
  description 'Megatools is a collection of programs for accessing Mega.nz service from a command line of your desktop or server.'
  homepage 'https://megatools.megous.com/'
  version '1.9.98'
  compatibility 'all'
  source_url 'https://megatools.megous.com/builds/megatools-1.9.98.tar.gz'
  source_sha256 '9b0521a4d27dbc417fc8e12610ac1e1da729bf6d6eb5bef927ef3670b372a16f'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/megatools-1.9.98-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/megatools-1.9.98-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/megatools-1.9.98-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/megatools-1.9.98-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '503807b962eb17c2b9fded0ae197ee4d78871a3b339f76a82dad76ac5d461275',
     armv7l: '503807b962eb17c2b9fded0ae197ee4d78871a3b339f76a82dad76ac5d461275',
       i686: '60d736bb95af651a7f78ec0f0daea2274854a9db5c548655bfc39524e77297da',
     x86_64: '39ac4b9d1aa152c12ba1b2cd162d07a8dad6b2206e6f67a6b87377b5c907ede4',
  })

  depends_on 'asciidoc'
  depends_on 'glib'

  def self.build
    system './configure'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
