require 'package'

class Libfmt < Package
  description 'A modern formatting library'
  homepage 'https://fmt.dev'
  version '7.1.3'
  compatibility 'all'
  source_url 'https://github.com/fmtlib/fmt/releases/download/7.1.3/fmt-7.1.3.zip'
  source_sha256 '5d98c504d0205f912e22449ecdea776b78ce0bb096927334f80781e720084c9f'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libfmt-7.1.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libfmt-7.1.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libfmt-7.1.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libfmt-7.1.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '26bb8f4333716d1ccce3a479b040e326bdb833483098064d20ef28a53d5068b1',
     armv7l: '26bb8f4333716d1ccce3a479b040e326bdb833483098064d20ef28a53d5068b1',
       i686: 'c395953aa8d320e73529488802c7ce418e0902d279102b55722bb6831ae827b7',
     x86_64: 'cf283994f84edf3b0e7e299ee01fb748f1f8e366f2f30444908cbd2100fa2951',
  })

  def self.build
    Dir.mkdir "builddir"
    Dir.chdir "builddir" do
      system "cmake #{CREW_CMAKE_OPTIONS} \
              -DBUILD_SHARED_LIBS=TRUE \
              .."
      system "make"
    end
  end

  def self.install
    Dir.chdir "builddir" do
      system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    end
  end

  def self.check
    Dir.chdir "builddir" do
      system "make", "test"
    end
  end
end
