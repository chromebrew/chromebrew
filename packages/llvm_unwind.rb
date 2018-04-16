require 'package'

class Llvm_unwind < Package
  description 'Part of the LLVM project.'
  homepage 'https://github.com/llvm-mirror/libunwind'
  version '6.0.0'
  source_url 'https://releases.llvm.org/6.0.0/libunwind-6.0.0.src.tar.xz'
  source_sha256 '256c4ed971191bde42208386c8d39e5143fa4afd098e03bd2c140c878c63f1d6'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/llvm_unwind-6.0.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/llvm_unwind-6.0.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/llvm_unwind-6.0.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/llvm_unwind-6.0.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '3fa7a4015549fffef05586673ce27fdff912b82e559df299c4edc007bcc59b6b',
     armv7l: '3fa7a4015549fffef05586673ce27fdff912b82e559df299c4edc007bcc59b6b',
       i686: '0966f9d500bc0330f486f97e4203def62ce9f76cf3cff6b53eefb4d1b265fd2c',
     x86_64: '8f11eec662c83e7baaeb613e13ebfd1e62e54c5e3bb5cc81319ae3d2b5cd310e',
  })

  depends_on 'llvm'

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
               ".."
      else
        system "cmake",
               "-DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX}",
               "-DBUILD_SHARED_LIBS=ON",
               "-DCMAKE_BUILD_TYPE=Release",
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
