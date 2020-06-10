require 'package'

class Libunbound < Package
  description 'Unbound is a validating, recursive, and caching DNS resolver.'
  homepage 'https://nlnetlabs.nl/projects/unbound/about/'
  version '1.9.4'
  compatibility 'all'
  source_url 'https://nlnetlabs.nl/downloads/unbound/unbound-1.9.4.tar.gz'
  source_sha256 '3d3e25fb224025f0e732c7970e5676f53fd1764c16d6a01be073a13e42954bb0'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libunbound-1.9.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libunbound-1.9.4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libunbound-1.9.4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libunbound-1.9.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'd8951bc3aea52562d64b899ec99e8e12ed4a53b186b2631557ff182da14724f0',
     armv7l: 'd8951bc3aea52562d64b899ec99e8e12ed4a53b186b2631557ff182da14724f0',
       i686: '2fc4b02d55f38c63ae4a4070774b50ebe17a724a9ba3232321a1f82f135210ea',
     x86_64: '47007cc2efc1962ea0e6b5eb03c2e768faa95af16f92e7e7de52cb2638c211cd',
  })

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--enable-shared',
           '--disable-static',
           '--with-pic'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'test'
  end
end
