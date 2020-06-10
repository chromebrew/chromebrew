require 'package'

class Mlocate < Package
  description 'mlocate is a locate/updatedb implementation.'
  homepage 'https://pagure.io/mlocate'
  version '0.26-1'
  compatibility 'all'
  source_url 'https://releases.pagure.org/mlocate/mlocate-0.26.tar.xz'
  source_sha256 '3063df79fe198fb9618e180c54baf3105b33d88fe602ff2d8570aaf944f1263e'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/mlocate-0.26-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/mlocate-0.26-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/mlocate-0.26-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/mlocate-0.26-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '69e02f44a498cd38a8f4bc2e3410f934506426d670664c402a09bfb34d51418c',
     armv7l: '69e02f44a498cd38a8f4bc2e3410f934506426d670664c402a09bfb34d51418c',
       i686: '74acf4453947b3570f68c43e485cb8e9f2da688e4a50336d593bbba1b6ebd2ee',
     x86_64: 'f943fe00ad4666f5a9c7bf12d710cd8f2e136a33ad94568863b92dd45526d7eb',
  })

  def self.build
    system "mkdir -p #{CREW_PREFIX}/db/mlocate"
    system "sed -i 's,\$(localstatedir)/,#{CREW_PREFIX}/db/,g' Makefile.*"
    system "sed -i \"s/groupname = mlocate/groupname = #{USER}/g\" Makefile.*"
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
