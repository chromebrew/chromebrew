require 'package'

class Chicken < Package
  description 'CHICKEN is a practical and portable scheme system.'
  homepage 'https://code.call-cc.org/'
  version '6.0.0'
  license 'BSD'
  compatibility 'all'
  source_url "https://code.call-cc.org/releases/#{version}/chicken-#{version}.tar.gz"
  source_sha256 '92835552b1b687ad26737e429b5aba36510bf429f8816ec0f6d336c8cb41f443'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '497ad8e35946e23e39e4fea42dd14bad382e7a902ae59987c5cdf60520c4336d',
     armv7l: '497ad8e35946e23e39e4fea42dd14bad382e7a902ae59987c5cdf60520c4336d',
       i686: '469dc02022c66f9b3b328c2a7a1627d48099af3b5aa352f5bb9e7d3e9f2ca3cf',
     x86_64: 'f48a8b54e92b10c600961573c29aa05a4ac4d309c958cfaa37cfe5c5af9a25b3'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library

  def self.build
    system 'make', "PREFIX=#{CREW_PREFIX}", "LIBDIR=#{CREW_LIB_PREFIX}", 'PLATFORM=linux'
  end

  def self.install
    system 'make', "PREFIX=#{CREW_PREFIX}", "LIBDIR=#{CREW_LIB_PREFIX}", "DESTDIR=#{CREW_DEST_DIR}", 'PLATFORM=linux', 'install'
  end
end
