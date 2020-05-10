require 'package'

class Usbutils < Package
  description 'Tools for examining usb devices'
  homepage 'http://linux-usb.sourceforge.net/'
  version '012'
  compatibility 'all'
  source_url 'https://www.kernel.org/pub/linux/utils/usb/usbutils/usbutils-012.tar.xz'
  source_sha256 '88634625f91840bc1993d2731cc081ee8d3b13d56069a95bdd6ac6ef0e063e46'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/usbutils-012-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/usbutils-012-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/usbutils-012-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/usbutils-012-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '84309375b4d635563a2bdc47e55c5a95841d18a937fcb3af646b51f5e1af5b53',
     armv7l: '84309375b4d635563a2bdc47e55c5a95841d18a937fcb3af646b51f5e1af5b53',
       i686: 'a174fbc8d94512af2591505a790226ec4230ea2236afe06f1ed119a33982b7c9',
     x86_64: '483f60e4d8dd5f44a2fabe7840e560c1d5eb67ae4eddca08f209dc8b30b9d4bc',
  })

  depends_on 'libusb'

  def self.build
    system './autogen.sh'
    system "./configure \
      --prefix=#{CREW_PREFIX} \
      --libdir=#{CREW_LIB_PREFIX}"
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.postinstall
    FileUtils.mkdir_p "#{CREW_PREFIX}/share/hwdata/" unless Dir.exist? "#{CREW_PREFIX}/share/hwdata/"
    system "wget http://www.linux-usb.org/usb.ids -O #{CREW_PREFIX}/share/hwdata/usb.ids"
    puts "It's recommended that you setup a cron job to update this file regularly.".lightblue
    puts 'You can install a cron package by executing `crew install cronie`'.lightblue
    puts
    puts 'Add a cron job with something like the following:' .lightblue
    puts '# Update usb.ids at 6pm daily.'.lightblue
    puts '0 18 * * * /usr/local/bin/crew postinstall usbutils >/dev/null 2>&1'.lightblue
  end
end
