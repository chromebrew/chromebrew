require 'package'

class Netperf < Package
  description 'Netperf is a benchmark that can be used to measure the performance of many different types of networking. It provides tests for both unidirectional throughput, and end-to-end latency.'
  homepage 'https://hewlettpackard.github.io/netperf/'
  version '2.7.0'
  compatibility 'all'
  source_url 'https://github.com/HewlettPackard/netperf/archive/netperf-2.7.0.tar.gz'
  source_sha256 '4569bafa4cca3d548eb96a486755af40bd9ceb6ab7c6abd81cc6aa4875007c4e'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/netperf-2.7.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/netperf-2.7.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/netperf-2.7.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/netperf-2.7.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '2be8d5e4d5aceb3216010f0e79b19839d92f3fd71f0dfe22d9c6335ff7a4baed',
     armv7l: '2be8d5e4d5aceb3216010f0e79b19839d92f3fd71f0dfe22d9c6335ff7a4baed',
       i686: '0dff93ad6efdf1c1f71062d499d26e718ba3aa94b72c1659fe6b286898b31c7e',
     x86_64: 'e9dc4df77a37125465ac91e858c12d0bddf365547711a8da295bd6daae056e30',
  })

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.check
    system 'make', 'check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
