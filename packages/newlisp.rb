require 'package'

class Newlisp < Package
  description 'newLISP is a Lisp-like, general-purpose scripting language.'
  homepage 'http://www.newlisp.org/'
  version '10.7.5'
  compatibility 'all'
  source_url 'https://github.com/kosh04/newlisp/archive/10.7.5.tar.gz'
  source_sha256 'bc3272600510fe78d32a85b23e0793c16f9f9ee05605d28ca537bdc322c25dc2'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/newlisp-10.7.5-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/newlisp-10.7.5-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/newlisp-10.7.5-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/newlisp-10.7.5-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'fd2b3a812a48f420f500823b80902ab9ac74379b5b77d1ab746ff6c385b22d3a',
     armv7l: 'fd2b3a812a48f420f500823b80902ab9ac74379b5b77d1ab746ff6c385b22d3a',
       i686: '20096f6d1c00538dacfd2008476c63211fd4b1ed61bab15e73130f2fd48723b9',
     x86_64: '9fd10660d271339cac7df31b94d64c13f1a6691a412aa06478a7b933b4a02e0a',
  })

  def self.patch
    # Fix to include libffi (--enable-ffi)
    #system "sed -i 's,LINUX_CFLAGS=\",LINUX_CFLAGS=\" -I#{CREW_LIB_PREFIX}/libffi-3.2.1/include,' configure-alt"
  end

  def self.build
    system './configure-alt',
           "--prefix=#{CREW_PREFIX}",
           "--mandir=#{CREW_PREFIX}/share/man",
           '--enable-readline',
           '--enable-utf8'
    system 'make'
  end

  def self.check
    system 'make', 'check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
