require 'package'

class Fribidi < Package
  description 'GNU FriBidi is an implementation of the Unicode Bidirectional Algorithm (bidi).'
  homepage 'https://www.fribidi.org/'
  version '1.0.9'
  compatibility 'all'
  source_url 'https://github.com/fribidi/fribidi/releases/download/v1.0.9/fribidi-1.0.9.tar.xz'
  source_sha256 'c5e47ea9026fb60da1944da9888b4e0a18854a0e2410bbfe7ad90a054d36e0c7'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/fribidi-1.0.9-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/fribidi-1.0.9-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/fribidi-1.0.9-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/fribidi-1.0.9-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '9726846e950c5aa4ba2587a7e2a4057ca36718e606980fcef18a47990a967e5e',
     armv7l: '9726846e950c5aa4ba2587a7e2a4057ca36718e606980fcef18a47990a967e5e',
       i686: 'a19caf91d86c53eb02398361e93ac8afdb042e661a22222d7ca63caab92fe205',
     x86_64: '17c2146657860ec4664fb7d247383c40859d3adf87fdf3c9f343e989cefcafb3',
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
