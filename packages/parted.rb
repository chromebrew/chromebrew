require 'buildsystems/autotools'

class Parted < Autotools
  description 'Create, destroy, resize, check, copy partitions and file systems.'
  homepage 'https://www.gnu.org/software/parted/'
  version '3.7'
  license 'GPL-3'
  compatibility 'all'
  source_url "https://ftp.gnu.org/gnu/parted/parted-#{version}.tar.xz"
  source_sha256 '008de57561a4f3c25a0648e66ed11e7b30be493889b64334a6d70f2c1951ef7b'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a7315fbe718042fb5bd6baa51ff6feb5ff38356e8035f8d8957d72bc60b72136',
     armv7l: 'a7315fbe718042fb5bd6baa51ff6feb5ff38356e8035f8d8957d72bc60b72136',
       i686: 'c3ebda11ea88c528434af9617387479ff6c070fb2c7c2eac67e12aa25cba43a5',
     x86_64: '07539adee486cb85a5a29b8a59b6c4cd32c62185822ce558defc33a7ebc2e68c'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'lvm2' => :library
  depends_on 'ncurses' => :executable
  depends_on 'readline' => :executable
  depends_on 'util_linux' => :library

  def self.patch
    # The c11threads threads.h breaks builds on software that uses gnulib.
    # See: https://github.com/jtsiomb/c11threads/issues/19
    # Note that c11threads is a workaround for C11 Threads only being
    # introduced in Glibc 2.28 as per:
    # https://sourceware.org/bugzilla/show_bug.cgi?id=14092#c10
    if LIBC_VERSION.to_f < 2.28 && ENV['NESTED_CI']
      puts 'Removing the c11threads include/threads.h from the c11threads package to prevent build failures.'.orange
      FileUtils.rm_f "#{CREW_PREFIX}/include/threads.h"
    end
    # The aclocal version is hardcoded.
    aclocal_version = `aclocal --version|head -1|cut -d' ' -f4`.chomp.gsub(/\.\d+$/, '')
    system "sed -i 's,1.17,#{aclocal_version},g' aclocal.m4"
    system "sed -i 's,1.17,#{aclocal_version},g' configure"
  end
end
