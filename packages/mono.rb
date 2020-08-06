require 'package'

class Mono < Package
  description 'Mono is a software platform designed to allow developers to easily create cross platform applications part of the .NET Foundation.'
  homepage 'http://www.mono-project.com/'
  version '6.8.0.123-1'
  compatibility 'all'
  source_url 'https://download.mono-project.com/sources/mono/mono-6.8.0.123.tar.xz'
  source_sha256 'e2e42d36e19f083fc0d82f6c02f7db80611d69767112af353df2f279744a2ac5'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/mono-6.8.0.123-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/mono-6.8.0.123-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/mono-6.8.0.123-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/mono-6.8.0.123-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '8e62055873099e3f943dd33789274c3db2d5436ddec704c72c8cf758d24f6ee5',
     armv7l: '8e62055873099e3f943dd33789274c3db2d5436ddec704c72c8cf758d24f6ee5',
       i686: 'd0442cd9a809387cf79cb6a605018244704ccd25333fcc33f1e8440fc0c52a04',
     x86_64: '46077f0cefcfc389006e730755ec9832a7624d67b9285b27410655cd65b55083',
  })

  def self.build
    system "./configure #{CREW_OPTIONS} --disable-dependency-tracking --disable-maintainer-mode --disable-silent-rules --enable-nls=no"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    Dir.chdir "#{CREW_DEST_PREFIX}/bin" do
      system "for f in \$(ls #{CREW_BUILD}-*); do g=\$(echo \$f | sed 's,#{CREW_BUILD}-,,'); ln -sf \$f \$g; done"
      FileUtils.ln_sf "#{CREW_BUILD}-mono-sgen", 'mono'
    end
    Dir.chdir "#{CREW_DEST_MAN_PREFIX}/man1" do
      system "for f in \$(ls #{CREW_BUILD}-*); do g=\$(echo \$f | sed 's,#{CREW_BUILD}-,,'); ln -sf \$f \$g; done"
    end
    Dir.chdir "#{CREW_DEST_MAN_PREFIX}/man5" do
      system "for f in \$(ls #{CREW_BUILD}-*); do g=\$(echo \$f | sed 's,#{CREW_BUILD}-,,'); ln -sf \$f \$g; done"
    end
  end
end
