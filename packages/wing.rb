require 'package'

class Wing < Package
  description 'Wing Personal is a free Python IDE designed for students and hobbyists.'
  homepage 'https://wingware.com/'
  version '7.1.3.0'
  source_url 'https://wingware.com/pub/wing-personal/7.1.3.0/wing-personal-7.1.3.0-linux-x64.tar.bz2'
  source_sha256 '17d0b9152a25fac3eda9d053e6cd284a118ece478b1a87c8afcebb60f71f6864'

  binary_url ({
    x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/wing-7.1.3.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    x86_64: 'f17dedf46eecb804986894058ea5012572847823c90715fc120481f2e35b2d79',
  })

  depends_on 'python27'
  depends_on 'sommelier'

  def self.patch
    system "sed -i 's,/usr/bin/python,#{CREW_PREFIX}/bin/python,' wing-install.py"
  end

  def self.install
    abort "#{ARCH} architecture is not supported.".lightred unless ARCH == 'x86_64'
    # The install is interactive, so remember to prefix directories with #{CREW_PREFIX} when prompted.
    system './wing-install.py'
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share"
    FileUtils.mkdir_p "#{CREW_DEST_HOME}/.wingpersonal7"
    system "touch #{CREW_DEST_HOME}/.wingpersonal7/ide.log"
    FileUtils.cp "#{CREW_PREFIX}/bin/wing-personal7.1", "#{CREW_DEST_PREFIX}/bin"
    FileUtils.cp_r "#{CREW_PREFIX}/share/wing-personal7.1", "#{CREW_DEST_PREFIX}/share"
    FileUtils.ln_s "#{CREW_PREFIX}/share/wing-personal7.1/wing-personal", "#{CREW_DEST_PREFIX}/bin/wing"
  end

  def self.postinstall
    puts
    puts "Type 'wing' to get started.".lightblue
    puts
    puts "To completely remove including all preferences, execute the following:".lightblue
    puts "crew remove wing".lightblue
    puts "rm -rf ~/.wingpersonal7".lightblue
    puts
  end
end
