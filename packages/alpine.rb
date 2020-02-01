require 'package'

class Alpine < Package
  description 'The continuation of the Alpine email client from University of Washington.'
  homepage 'http://alpine.x10host.com/alpine'
  version '2.22'
  source_url 'http://alpine.x10host.com/alpine/release/src/alpine-2.22.tar.xz'
  source_sha256 '849567c1b6f71fde3aaa1c97cf0577b12a525d9e22c0ea47797c4bf1cd2bbfdb'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/alpine-2.22-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/alpine-2.22-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/alpine-2.22-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/alpine-2.22-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '3856cd6cb2d2073b4cf022e5d2db54ed65ba2f7ab53545c4cd476d894a343d89',
     armv7l: '3856cd6cb2d2073b4cf022e5d2db54ed65ba2f7ab53545c4cd476d894a343d89',
       i686: '32701e3edcc3cab4a409d66cb9747c799b1265b46cb531e093b2472660f34f48',
     x86_64: '4277b6583b8e753da09a95ea7912d69666d45dae5a9db91b18abf1a7bbcca155',
  })

  depends_on 'hunspell_en_us'
  depends_on 'openldap'
  depends_on 'tcl'

  def self.patch
    # Fixes ./configure: line 8156: /usr/bin/file: No such file or directory
    system 'filefix'
  end

  def self.build
    system "./configure",
    "--prefix=#{CREW_PREFIX}",
    "--libdir=#{CREW_LIB_PREFIX}",
    "--with-ssl-dir=/etc/ssl",
    "--with-ssl-include-dir=#{CREW_PREFIX}/include",
    "--with-ssl-lib-dir=#{CREW_LIB_PREFIX}", "--disable-nls",
    "--with-system-pinerc=#{CREW_PREFIX}/etc/alpine.d/pine.conf",
    "--with-system-fixed-pinerc=#{CREW_PREFIX}/etc/alpine/pine.conf.fixed"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system "make", "check"
  end
end
