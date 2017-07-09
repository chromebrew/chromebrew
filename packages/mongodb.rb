require 'package'

class Mongodb < Package
  description 'MongoDB is the next-generation database that lets you create applications never before possible.'
  homepage 'https://www.mongodb.com/'
  # We use 3.2 branch here since:
  #  - 3.2 branch works well with gcc-4.9.4
  #  - master 3.4 branch requires gcc-5.4.0
  version '3.2.16'
  source_url 'https://fastdl.mongodb.org/src/mongodb-src-r3.2.16.tar.gz'
  source_sha256 '7a8b1b16f3fa545af16f48aeef1f918f57d96a80e1ceb6e669cdb81fab6511d0'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/mongodb-3.2.16-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/mongodb-3.2.16-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/mongodb-3.2.16-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/mongodb-3.2.16-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '60f2e041174b4f5f8f01e740e41196e44e4e6c293cf16003e3109144cb41eec9',
     armv7l: '60f2e041174b4f5f8f01e740e41196e44e4e6c293cf16003e3109144cb41eec9',
       i686: 'd3e8fee28712b477d3cca0ad8b2dab2d2965a8fd4820e533b979f96cd3fbe766',
     x86_64: '21f87cc21d04f898dbced0f85de9382114c4087d5741d9f162552aeb00414d2f',
  })

  depends_on 'openssl' => :build
  depends_on 'libpcap' => :build
  depends_on 'python27' => :build
  depends_on 'scons' => :build
  depends_on 'go' => :build
  depends_on 'git' => :build
  case ARCH
  when 'armv7l', 'aarch64'
    depends_on 'perl' => :build         # gen-config.sh uses perl
  end

  def self.build
    # prepare mongo-tools
    system "git clone https://github.com/mongodb/mongo-tools"
    system "cd mongo-tools; ./build.sh ssl || echo '***YOU NEED TO SET UP GO ENVIRONMENT IN ORDER TO COMPILE MONGO-TOOLS***'"
    system "mkdir src/mongo-tools"
    system "cp mongo-tools/bin/* src/mongo-tools/"
    system "rm -rf mongo-tools"
  end

  def self.install
    # build mongo and install it at once
    case ARCH
    when 'x86_64'
      system "scons -j#{CREW_NPROC} install --ssl --prefix=#{CREW_DEST_DIR}#{CREW_PREFIX} --use-new-tools"
    when 'i686'
      system "scons -j#{CREW_NPROC} install --ssl --wiredtiger=off --prefix=#{CREW_DEST_DIR}#{CREW_PREFIX} --use-new-tools"
    when 'armv7l'
      # Arm 32 bit architecture is not supported officaially.
      # Please read https://groups.google.com/forum/#!msg/mongodb-dev/G-kGjZEEam0/VSVB9fYCBAAJ for details
      system "cd src/third_party/mozjs-38/; ./get_sources.sh"
      system "cd src/third_party/mozjs-38/; ./gen-config.sh arm linux"
      system "cd src/third_party/mozjs-38/; rm -rf firefix* mozilla-release"
      system "scons -j#{CREW_NPROC} install --ssl --wiredtiger=off --mmapv1=on --prefix=#{CREW_DEST_DIR}#{CREW_PREFIX} --use-new-tools"
    when 'aarch64'
      # Arm 64 bit architecture is supported, but Chrome OS aarch64 is 32 bit.
      # So, it is required to pretend it is armv7l.
      system "cd src/third_party/mozjs-38/; ./get_sources.sh"
      system "cd src/third_party/mozjs-38/; ./gen-config.sh arm linux"
      system "cd src/third_party/mozjs-38/; rm -rf firefix* mozilla-release"
      # Not sure how to pretend it under scons
      system "scons -j#{CREW_NPROC} install --ssl --wiredtiger=off --mmapv1=on --prefix=#{CREW_DEST_DIR}#{CREW_PREFIX} --use-new-tools"
    end

    # guide messages
    puts "type `mkdir #{CREW_PREFIX}/lib/mongodb` to create directory for database"
    case ARCH
    when 'x86_64'
      puts "type `mongod --dbpath=#{CREW_PREFIX}/lib/mongodb` to start server"
    when 'i686','armv7l', 'aarch64'
      puts "type `mongod --dbpath=#{CREW_PREFIX}/lib/mongodb --storageEngine=mmapv1` to start server"
    end
  end
end
