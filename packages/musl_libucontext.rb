require 'package'

class Musl_libucontext < Package
  description 'Library which provides the ucontext.h C API'
  homepage 'https://github.com/kaniini/libucontext'
  version '1.1'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/kaniini/libucontext.git'
  git_hashtag "libucontext-#{version}"
  binary_compression 'tpxz'

  binary_sha256({
    aarch64: '5b44c0cfd1bdad11b17ff782784dd0ac1f21d5cbeed72a924826b038e1ca1476',
     armv7l: '5b44c0cfd1bdad11b17ff782784dd0ac1f21d5cbeed72a924826b038e1ca1476',
       i686: 'eb76db594fce4f7f5d087276c547489a9d5b3808827d417e5f023e1c034e4f64',
     x86_64: 'ac3eb3428728c28d7daa10008d5b189f3223fc7957e5879e2a7f2cc63f5d7a07'
  })

  depends_on 'musl_native_toolchain' => :build

  is_static
  print_source_bashrc

  def self.patch
    load "#{CREW_LIB_PATH}/lib/musl.rb"
    system "sed -i 's,LIBDIR := /lib,LIBDIR := #{CREW_MUSL_PREFIX}/lib,g' Makefile"
    system "sed -i 's,INCLUDEDIR := /usr/include,INCLUDEDIR := #{CREW_MUSL_PREFIX}/include,g' Makefile"
    system "sed -i 's,PKGCONFIGDIR := /usr/lib/pkgconfig,PKGCONFIGDIR := #{CREW_MUSL_PREFIX}/lib/pkgconfig,g' Makefile"
  end

  def self.build
    case ARCH
    when 'aarch64', 'armv7l'
      @arch = 'arm'
    when 'i686'
      @arch = 'X86'
    when 'x86_64'
      @arch = 'X86_64'
    end
    system "#{MUSL_ENV_OPTIONS} make ARCH=#{@arch}"
  end

  def self.install
    system "make ARCH=#{@arch} DESTDIR=#{CREW_DEST_DIR} install"
  end
end
