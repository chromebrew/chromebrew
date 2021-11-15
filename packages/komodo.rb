require 'package'

class Komodo < Package
  description 'Komodo IDE is a great editor if you\'re looking for something powerful, yet simple.'
  homepage 'https://www.activestate.com/products/komodo-ide/'
  version '12.0.1-91869'
  license 'ActiveState® Platform EULA'
  compatibility 'x86_64'
  source_url 'https://downloads.activestate.com/Komodo/releases/12.0.1/Komodo-IDE-12.0.1-91869-linux-x86_64.tar.gz'
  source_sha256 '5c2735e9a323ffe290425e5066dd6f72f11e5d58d732411e6648a685725e055a'

  depends_on 'gtk2'
  depends_on 'sommelier'

  def self.build
    system "sed -i 's,\$dname/INSTALLDIR/lib/python/bin/python,#{CREW_PREFIX}/bin/python2,' install.sh"
    system "sed -i 's,INSTALLDIR,#{CREW_DEST_PREFIX},' install.sh"
    system "sed -i '74d' install.sh"
  end

  def self.install
    system "./install.sh -I #{CREW_DEST_PREFIX}"
  end

  def self.remove
    print "Would you like to remove the config directories? [y/N] "
    response = STDIN.getc
    config_dirs = ["#{HOME}/.komodoide", "#{HOME}/.activestate"]
    config_dirs.each { |config_dir|
      if Dir.exists? config_dir
        case response
        when "y", "Y"
          FileUtils.rm_rf config_dir
          puts "#{config_dir} removed.".lightred
        else
          puts "#{config_dir} saved.".lightgreen
        end
      end
    }
  end
end
