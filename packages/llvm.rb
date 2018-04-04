require 'package'

class Llvm < Package
    description 'The LLVM Project is a collection of modular and reusable compiler and toolchain technologies.'
  homepage 'https://compiler-rt.llvm.org/'
  version '6.0.0'
    source_url 'http://llvm.org/releases/6.0.0/llvm-6.0.0.src.tar.xz'
  source_sha256 '1ff53c915b4e761ef400b803f07261ade637b0c269d99569f18040f3dcee4408'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/llvm-6.0.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/llvm-6.0.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/llvm-6.0.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/llvm-6.0.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '9bfffb161e2e3c0642178175fe7ce2c18168c8ab71bce91e10ad4a15b80e3ea7',
     armv7l: '9bfffb161e2e3c0642178175fe7ce2c18168c8ab71bce91e10ad4a15b80e3ea7',
       i686: '4e3c4ee05546a808fadfbd7f388ce1f64e8daac72c1eaa7e396ed062c0c94328',
     x86_64: 'e24785612a16133605fb93fb9fd43d663b3a1e69e6cb69e5c518f23dab8321a3',
  })

  depends_on 'cmake' => :build
  
  def self.build
    system "mkdir -p builddir"
    Dir.chdir("builddir") do
      case ARCH
      when "x86_64"
        system "cmake",
               "-DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX}",
               "-DLLVM_LIBDIR_SUFFIX=64",
               "-DBUILD_SHARED_LIBS=ON",
               "-DCMAKE_BUILD_TYPE=Release",
               "-DLLVM_TARGETS_TO_BUILD=host",
               ".."
      else
        system "cmake",
               "-DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX}",
               "-DBUILD_SHARED_LIBS=ON",
               "-DCMAKE_BUILD_TYPE=Release",
               "-DLLVM_TARGETS_TO_BUILD=host",
               ".."
      end
      system "make"
    end
  end

  def self.install               
    Dir.chdir("builddir") do
      system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    end
  end
  
  
end
