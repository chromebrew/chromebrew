require 'package'

class Libudev_stub < Package
  description 'A libudev stub and proxy library for WSL'
  homepage 'https://github.com/therealkenc/libudev-stub'
  version '0.9.0'
  compatibility 'all'
  source_url 'https://github.com/therealkenc/libudev-stub/archive/v0.9.0.tar.gz'
  source_sha256 '4bc4479b8297bfd6449f245e09106600af1b3af657dd1472d9fd4c920b673660'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libudev_stub-0.9.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libudev_stub-0.9.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libudev_stub-0.9.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libudev_stub-0.9.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '2eb86743b502cab926280f0e37a19417f96eaad925d9e533cf1c5a01212796b4',
     armv7l: '2eb86743b502cab926280f0e37a19417f96eaad925d9e533cf1c5a01212796b4',
       i686: '5d32f73bc45239941a6db33e1764735260fdebb7cb56bde812436625769d2aa6',
     x86_64: 'df1199025c15f1701e21355fe647270f0c8d7f3cd7a6c0b1683dc0bb96b786a0',
  })

  depends_on 'eudev'
  depends_on 'ninja' => :build

  def self.build
    Dir.chdir "#{CREW_PREFIX}/bin" do
      system "ln -sf #{CREW_PREFIX}/bin/g++-7.3 g++-6"
    end
    system './scripts/build-all.sh'
    Dir.chdir 'build/out/lib' do
      system 'ln -sf libudev-stub.so.1.6.4 libudev.so.1'
    end
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    Dir.chdir "#{CREW_DEST_PREFIX}/bin" do
      system "ln -sf #{CREW_PREFIX}/bin/g++-7.3 g++-6"
    end
    FileUtils.mkdir_p "#{CREW_DEST_LIB_PREFIX}"
    system "cp -r build/out/lib/* #{CREW_DEST_LIB_PREFIX}"
    system "install -Dm755 build/out/bin/libudev_test #{CREW_DEST_PREFIX}/bin/libudev_test"
  end
end
