require 'package'

class Mono < Package
  description 'Mono is a software platform designed to allow developers to easily create cross platform applications part of the .NET Foundation.'
  homepage 'http://www.mono-project.com/'
  version '6.12.0.107'
  compatibility 'all'
  source_url 'https://download.mono-project.com/sources/mono/mono-6.12.0.107.tar.xz'
  source_sha256 '61f3cd629f8e99371c6b47c1f8d96b8ac46d9e851b5531eef20cdf9ab60d2a5f'

  depends_on 'bc'
  depends_on 'libgdiplus'
  depends_on 'python3' => :build
  depends_on 'imake' => :build

  def self.prebuild
    system 'if [ ! -f /proc/config.gz ]; then sudo modprobe configs -v; fi'
    system 'cat /proc/config.gz | gunzip | grep SYSVIPC=y || false' # Mono build hangs without this feature enabled.
  end

  def self.build
    system "env XMKMF=#{CREW_PREFIX}/bin/xmkmf \
            ./configure #{CREW_OPTIONS} \
              --disable-maintainer-mode \
              --enable-ninja \
              --with-x \
              --with-libgdiplus \
              --program-prefix='' --program-suffix='' "
    system 'make || make' # Make might fail the first time. This is a known upstream bug.
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
