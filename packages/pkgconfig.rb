require 'package'

class Pkgconfig < Package
  description 'pkg-config is a helper tool used when compiling applications and libraries.'
  homepage 'https://www.freedesktop.org/wiki/Software/pkg-config/'
  version '0.29.2'
  source_url 'http://pkgconfig.freedesktop.org/releases/pkg-config-0.29.2.tar.gz'
  source_sha256 '6fc69c01688c9458a57eb9a1664c9aba372ccda420a02bf4429fe610e7e7d591'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/pkgconfig-0.29.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/pkgconfig-0.29.2-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/pkgconfig-0.29.2-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/pkgconfig-0.29.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'b07f5bc401a82f0c91a15cf8918fa3ba19233fa4d5098117220bdb27f60b0ddb',
     armv7l: 'b07f5bc401a82f0c91a15cf8918fa3ba19233fa4d5098117220bdb27f60b0ddb',
       i686: '32b54dd0baa0518164fc44021244415b7657673e8a704f0bdd137e3a403c2285',
     x86_64: '0002d91658f4c0789de2831b716fc4025ffa661c3de68d7308d72bddc553d426',
  })

  # It is not possible to write buildessential here since it causes dependency loop.
  #   depends_on 'buildessential'
  # Write dependency to gcc make linuxheaders instead.
  depends_on 'gcc'
  depends_on 'linuxheaders'
  depends_on 'make'

  def self.build
      # check lib64 on any architectures since it is not a problem to not exist lib64 directory.
      system "./configure", "--with-internal-glib", "--with-pc-path=/usr/local/lib/pkgconfig:/usr/local/lib64/pkgconfig:/usr/local/share/pkgconfig"
      system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system "make", "check"
  end
end
