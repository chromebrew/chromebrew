require 'package'

class Dia < Package
  description 'Dia Diagram Editor is free Open Source drawing software for Windows, Mac OS X and Linux.'
  homepage 'http://dia-installer.de/'
  version '0.97.2-1'
  compatibility 'aarch64,armv7l,x86_64'
  case ARCH
  when 'aarch64', 'armv7l', 'x86_64'
    source_url 'https://github.com/GNOME/dia/archive/DIA_0_97_2.tar.gz'
    source_sha256 '13437d52f2c5cfdae7ecde8bd5ed0a53a388b0331698236d0ec63453b8a13016'
    depends_on 'optipng' => :build
    depends_on 'cairo'
    depends_on 'gtk2'
    depends_on 'libart'
    depends_on 'libpng'
    depends_on 'libwmf'
    depends_on 'six'
    depends_on 'swig1'
    depends_on 'sommelier'
  end

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/dia-0.97.2-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/dia-0.97.2-1-chromeos-armv7l.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/dia-0.97.2-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '55db6bb7d6703818578e1a8977b5020d3e83cb5fb3ac568f8d797deaf200c3b6',
     armv7l: '55db6bb7d6703818578e1a8977b5020d3e83cb5fb3ac568f8d797deaf200c3b6',
     x86_64: '6c8f42b5f5da58ebfca61c328ef621e7462b1f624c5a0d7001de7eac325ba2bc',
  })

  def self.patch
    # Fix broken images.  See http://archscientist.altervista.org/blog/how-to-solve-libpng-error-idat-invalid-distance-too-far-back/.
    system "find app/pixmaps -iname '\*.png' -exec echo {} > /tmp/pngfiles.txt \\;"
    system 'cat /tmp/pngfiles.txt | xargs -n 1 -P 3 optipng -quiet -force -fix'
    system 'rm -f /tmp/pngfiles.txt'
  end

  def self.build
    system './autogen.sh'
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-maintainer-mode',
           '--without-python',
           '--with-cairo',
           '--with-swig'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    # Fix dia_renderer_set_size: assertion 'irenderer != NULL' failed.  See https://bugs.launchpad.net/ubuntu/+source/dia/+bug/1102960/comments/11.
    system 'wget https://bugs.launchpad.net/ubuntu/+source/dia/+bug/1102960/+attachment/3552916/+files/persistence'
    abort 'Checksum mismatch :/ try again' unless Digest::SHA256.hexdigest( File.read('persistence') ) == '53cb6e49892bd60870fb31780052e46d9e47c5b19f87db1651760d10d3fe66e7'
    system "install -Dm644 persistence #{CREW_DEST_HOME}/.dia/persistence"
  end
end
