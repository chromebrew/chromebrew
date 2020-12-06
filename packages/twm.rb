require 'package'

class Twm < Package
  description 'The twm package contains a very minimal window manager.'
  homepage 'http://www.linuxfromscratch.org/blfs/view/svn/x/twm.html'
  version '1.0.11'
  compatibility 'all'
  source_url 'https://www.x.org/pub/individual/app/twm-1.0.11.tar.xz'
  source_sha256 'f4e8a842dec410e79741f25ed4dfac09df080835d0bba2e3983b5914569b68c7'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/twm-1.0.11-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/twm-1.0.11-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/twm-1.0.11-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/twm-1.0.11-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '84bc4882736d4ed174741a07c60404d47cdbad726ac7e9b7ace07012ded84d58',
     armv7l: '84bc4882736d4ed174741a07c60404d47cdbad726ac7e9b7ace07012ded84d58',
       i686: 'e8c77ddd87e509a4d801bf9383c5ecc9eaa5f8cfaf73818fc3d47f23377689bf',
     x86_64: '9108a3204e5b9eb37689aa8e97af6168cf3f4864c29d8d8e4e58ca6355de74a2',
  })

  depends_on 'xorg_server'

  def self.build
    system "./configure  #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
