require 'package'

class Nmap < Package
  description 'Nmap (\'Network Mapper\') is a free and open source (license) utility for network discovery and security auditing.'
  homepage 'https://nmap.org/'
  version '7.80'
  compatibility 'all'
  source_url 'https://nmap.org/dist/nmap-7.80.tar.bz2'
  source_sha256 'fcfa5a0e42099e12e4bf7a68ebe6fde05553383a682e816a7ec9256ab4773faa'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/nmap-7.80-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/nmap-7.80-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/nmap-7.80-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/nmap-7.80-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '05f6f7b8303f7249e0ce26650f13bd051d0d5665d321be0ff59f6ce51cff57fe',
     armv7l: '05f6f7b8303f7249e0ce26650f13bd051d0d5665d321be0ff59f6ce51cff57fe',
       i686: 'f40786b4937b7d3a6b6ddc67afb4a004ba577f865d9d922fa0982ebb871b1451',
     x86_64: '624e3f64733244d3f987b5dfbd72a52acef314fa481857cc1ad4f92d621d2f3a',
  })

  def self.build
    #fixup "/usr/bin/file" -> "#{CREW_PREFIX}/bin/file" in the configure scripts
    system "sed -i s#/usr/bin/file##{CREW_DEST_PREFIX}/bin/file#g libdnet-stripped/configure"
    system "./configure --with-pcap=linux --without-zenmap --prefix=#{CREW_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
