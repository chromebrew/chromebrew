require 'package'

class Usbutils < Package
  description 'Tools for examining usb devices'
  homepage 'http://linux-usb.sourceforge.net/'
  version '013'
  license 'GPL-2'
  compatibility 'all'
  source_url "https://mirrors.kernel.org/pub/linux/utils/usb/usbutils/usbutils-#{version}.tar.xz"
  source_sha256 '9e23494fcc78b7a80ee29a07dd179c95ae2f71509c35728dbbabc2d1cca41338'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: '031de655991e234e4978f63306510504229fa7b84f8f98959a1afcf054db0e1f',
     armv7l: '031de655991e234e4978f63306510504229fa7b84f8f98959a1afcf054db0e1f',
       i686: 'e86afc7fc87f4740645765229229e27a38b8a5179e0aa779e07822e1cd6e16c1',
     x86_64: 'dd7055b6ed55339a9774b104af3166da897a0415c9b206f48a853f62a9212c3f'
  })

  depends_on 'libusb'

  def self.build
    system 'NOCONFIGURE=1 ./autogen.sh'
    system "env #{CREW_ENV_OPTIONS} \
    ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/hwdata"
    FileUtils.touch "#{CREW_DEST_PREFIX}/share/hwdata/usb.ids"
  end

  def self.postinstall
    FileUtils.mkdir_p "#{CREW_PREFIX}/share/hwdata/"
    system "curl -#LO http://www.linux-usb.org/usb.ids -o #{CREW_PREFIX}/share/hwdata/usb.ids"
    puts "It's recommended that you setup a cron job to update this file regularly.".lightblue
    puts 'You can install a cron package by executing `crew install cronie`'.lightblue
    puts
    puts 'Add a cron job with something like the following:'.lightblue
    puts '# Update usb.ids at 6pm daily.'.lightblue
    puts "0 18 * * * #{CREW_PREFIX}/bin/crew postinstall usbutils >/dev/null 2>&1".lightblue
  end
end
