require 'package'

class Pcre2 < Package
  description 'The PCRE2 package contains a new generation of the Perl Compatible Regular Expression libraries.'
  homepage 'http://pcre.org/'
  version '10.34'
  compatibility 'all'
  source_url 'https://ftp.pcre.org/pub/pcre/pcre2-10.34.tar.gz'
  source_sha256 'da6aba7ba2509e918e41f4f744a59fa41a2425c59a298a232e7fe85691e00379'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/pcre2-10.34-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/pcre2-10.34-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/pcre2-10.34-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/pcre2-10.34-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'e1f117b420f4f72645cd643756a01ee712b56ce3b6367f2ec801e300e1d6e4cf',
     armv7l: 'e1f117b420f4f72645cd643756a01ee712b56ce3b6367f2ec801e300e1d6e4cf',
       i686: 'dafff4b147f8b3f0bffb6411fd7996bd8654823cd0a0789bc5edec723a20cb06',
     x86_64: '4325b2825b0c425a5914c750d9837d8ad10d830156e1dc49e11f156664e9b51f',
  })

  depends_on 'libtool' => :build

  def self.build
    system "./configure \
           --prefix=#{CREW_PREFIX} \
           --libdir=#{CREW_LIB_PREFIX} \
           --enable-pcre2-16 \
           --enable-pcre2-32 \
           --enable-unicode \
           --enable-pcre2-16 \
           --enable-pcre2-32 \
           --enable-pcre2test-libreadline \
           --enable-jit \
           --disable-static"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

end
