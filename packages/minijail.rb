# Adapted from Arch Linux minijail PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=minijail

require 'package'

class Minijail < Package
  description 'Tool to run a process in jailed environment'
  homepage 'https://google.github.io/minijail/'
  version '81e4b0e2'
  license 'custom:chromiumos'
  compatibility 'all'
  source_url 'https://android.googlesource.com/platform/external/minijail.git'
  git_hashtag '81e4b0e245f6fef9a82800d3f182e73127bfa2fe'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/minijail/81e4b0e2_armv7l/minijail-81e4b0e2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/minijail/81e4b0e2_armv7l/minijail-81e4b0e2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/minijail/81e4b0e2_i686/minijail-81e4b0e2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/minijail/81e4b0e2_x86_64/minijail-81e4b0e2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '4abb6b16d341150f99c59d35c2eea53e16295f7011db633f3dfe6a09a5ae7584',
     armv7l: '4abb6b16d341150f99c59d35c2eea53e16295f7011db633f3dfe6a09a5ae7584',
       i686: '5090b7a0bc486e585bfeefe2491948a44fcccd06b4193a1e9a10de075b566bc7',
     x86_64: '9d4bedd9892f1a24d8c9ca4e2cb98fb41d9d0c5e7efff39f0a66816aa4ac5d8f'
  })

  depends_on 'libcap'

  def self.build
    system 'make'
    @minijailversion = `grep -o "version=.*" setup.py | sed 's/,//' | sed "s/'//g" | sed "s/version=//"`.chomp
    @minijail_pc = <<~MINIJAIL_PC_EOF
      prefix=#{CREW_PREFIX}
      libdir=#{CREW_LIB_PREFIX}
      includedir=\${prefix}/include

      Name: libminijail
      Description: Minijail shared library
      URL: https://google.github.io/minijail/
      Version: #{@minijail_version}
      Libs: -L\${libdir} -lminijail
      Cflags: -I\${includedir}
    MINIJAIL_PC_EOF
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_LIB_PREFIX}/pkgconfig/"
    File.write("#{CREW_DEST_LIB_PREFIX}/pkgconfig/libminijail.pc", @minijail_pc)
    system "install -m755 -D libminijail.so #{CREW_DEST_LIB_PREFIX}/libminijail.so"
    system "install -m755 -D libminijailpreload.so #{CREW_DEST_LIB_PREFIX}/libminijailpreload.so"
    system "install -m644 -D libminijail.h #{CREW_DEST_PREFIX}/include/libminijail.h"
    system "install -m644 -D minijail0.1 #{CREW_DEST_MAN_PREFIX}/man1/minijail0.1"
    system "install -m644 -D minijail0.5 #{CREW_DEST_MAN_PREFIX}/man5/minijail0.5"
    system "install -m644 -D NOTICE #{CREW_DEST_PREFIX}/share/licenses/minijail/NOTICE"
  end
end
