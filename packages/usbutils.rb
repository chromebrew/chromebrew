require 'package'

class Usbutils < Package
  description 'Tools for examining usb devices'
  homepage 'http://linux-usb.sourceforge.net/'
  @_ver = '013-1'
  version @_ver
  license 'GPL-2'
  compatibility 'all'
  source_url "https://mirrors.kernel.org/pub/linux/utils/usb/usbutils/usbutils-#{@_ver}.tar.xz"
  source_sha256 '9e23494fcc78b7a80ee29a07dd179c95ae2f71509c35728dbbabc2d1cca41338'

  depends_on 'libusb'

  def self.build
    system './autogen.sh'
    system "env CFLAGS='-flto=auto -ltinfow' CXXFLAGS='-flto=auto' LDFLAGS='-flto=auto' \
    ./configure #{CREW_OPTIONS}"
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.postinstall
    FileUtils.mkdir_p "#{CREW_PREFIX}/share/hwdata/" unless Dir.exist? "#{CREW_PREFIX}/share/hwdata/"
    system "curl -#LO http://www.linux-usb.org/usb.ids -O #{CREW_PREFIX}/share/hwdata/usb.ids"
    puts "It's recommended that you setup a cron job to update this file regularly.".lightblue
    puts 'You can install a cron package by executing `crew install cronie`'.lightblue
    puts
    puts 'Add a cron job with something like the following:'.lightblue
    puts '# Update usb.ids at 6pm daily.'.lightblue
    puts "0 18 * * * #{CREW_PREFIX}/bin/crew postinstall usbutils >/dev/null 2>&1".lightblue
  end
end
