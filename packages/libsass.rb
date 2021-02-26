require 'package'

class Libsass < Package
  description 'LibSass is a C/C++ port of the Sass engine'
  homepage 'https://sass-lang.com/libsass'
  version '3.6.4'
  compatibility 'all'
  source_url 'https://github.com/sass/libsass/archive/3.6.4.tar.gz'
  source_sha256 'f9484d9a6df60576e791566eab2f757a97fd414fce01dd41fc0a693ea5db2889'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libsass-3.6.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libsass-3.6.4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libsass-3.6.4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libsass-3.6.4-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '80f6e743442cc3725a889cd139c89f159f1bb834698f60c4b9e10595bcde3e8c',
     armv7l: '80f6e743442cc3725a889cd139c89f159f1bb834698f60c4b9e10595bcde3e8c',
       i686: '22f4764ace15192ce1831133b2a46486ce23b6d7628613fd1dc8ca4c5af9c367',
     x86_64: 'a8b8f0e1560da7b41ee260f603c6ff57b0c9dea5505b2956b709bba278a550ca'
  })

  def self.build
    system 'autoreconf', '-i'
    system "env CFLAGS='-pipe -flto=auto' CXXFLAGS='-pipe -flto=auto' \
      LDFLAGS='-flto=auto' \
      ./configure \
      #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
