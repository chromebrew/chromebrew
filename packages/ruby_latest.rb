require 'package'

class Ruby_latest < Package
  description 'Ruby is a dynamic, open source programming language with a focus on simplicity and productivity.'
  homepage 'https://www.ruby-lang.org/en/'
  version '2.4.2'
  source_url 'http://cache.ruby-lang.org/pub/ruby/ruby-2.4.2.tar.xz'
  source_sha256 '748a8980d30141bd1a4124e11745bb105b436fb1890826e0d2b9ea31af27f735'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'readline'
  depends_on 'zlibpkg'
  depends_on 'openssl'

  def self.build
    system "CC='gcc' ./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
