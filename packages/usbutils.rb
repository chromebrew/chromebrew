require 'package'

class Usbutils < Package
  description 'Tools for examining usb devices'
  homepage 'http://linux-usb.sourceforge.net/'
  version '012'
  source_url 'https://www.kernel.org/pub/linux/utils/usb/usbutils/usbutils-012.tar.xz'
  source_sha256 '88634625f91840bc1993d2731cc081ee8d3b13d56069a95bdd6ac6ef0e063e46'

  binary_url ({
  })
  binary_sha256 ({
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
