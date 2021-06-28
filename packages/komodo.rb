require 'package'

class Komodo < Package
  description 'Komodo IDE is a great editor if you\'re looking for something powerful, yet simple.'
  homepage 'https://www.activestate.com/products/komodo-ide/'
  version '12.0.1'
  license 'ActiveState® Platform EULA'
  compatibility 'x86_64'
  source_url 'https://downloads.activestate.com/Komodo/releases/12.0.1/Komodo-Edit-12.0.1-18441-linux-x86_64.tar.gz'
  source_sha256 'b51783eb1cb8ce60b26e506ee00cd54ff31b61830622c5e5a8c77405e9c54e48'

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
