require 'package'

class Usbutils < Package
  description 'Tools for examining usb devices'
  homepage 'http://linux-usb.sourceforge.net/'
  @_ver = '013'
  version @_ver
  compatibility 'all'
  source_url "https://mirrors.kernel.org/pub/linux/utils/usb/usbutils/usbutils-#{@_ver}.tar.xz"
  source_sha256 '9e23494fcc78b7a80ee29a07dd179c95ae2f71509c35728dbbabc2d1cca41338'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/usbutils-013-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/usbutils-013-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/usbutils-013-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/usbutils-013-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '07502628efc250a37a113baaf9d24c23f524ee3f7a9a5f5693a4454f3259d4e5',
     armv7l: '07502628efc250a37a113baaf9d24c23f524ee3f7a9a5f5693a4454f3259d4e5',
       i686: 'ea0051d91206aab125e7cdd7c142123fdd0b43c06f9438dc10023060f8463ad4',
     x86_64: '09ebfe03787624a97ccf79e1e746ad3177b4ca4d991fa8ed2aa5de8227349d76'
  })

  depends_on 'libusb'

  def self.build
    system './autogen.sh'
    system "env CFLAGS='-flto=auto -ltinfo' CXXFLAGS='-flto=auto' LDFLAGS='-flto=auto' \
    ./configure #{CREW_OPTIONS}"
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
    puts 'Add a cron job with something like the following:'.lightblue
    puts '# Update usb.ids at 6pm daily.'.lightblue
    puts '0 18 * * * /usr/local/bin/crew postinstall usbutils >/dev/null 2>&1'.lightblue
  end
end
