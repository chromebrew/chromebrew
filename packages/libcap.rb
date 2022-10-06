require 'package'

class Libcap < Package
  description 'Libcap implements the user-space interfaces to the POSIX 1003.1e capabilities available in Linux kernels.'
  homepage 'https://directory.fsf.org/wiki/Libcap/'
  version '2.66'
  compatibility 'all'
  license 'GPL-2 or BSD'
  source_url 'https://git.kernel.org/pub/scm/libs/libcap/libcap.git'
  git_hashtag "libcap-#{version}"

  binary_url({
    x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcap/2.65_x86_64/libcap-2.65-chromeos-x86_64.tar.xz',
   aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcap/2.66_armv7l/libcap-2.66-chromeos-armv7l.tar.xz',
    armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcap/2.66_armv7l/libcap-2.66-chromeos-armv7l.tar.xz',
      i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcap/2.66_i686/libcap-2.66-chromeos-i686.tar.xz'
  })
  binary_sha256({
    x86_64: '29070edba9fce8f5dfa9175296316e3978341065f314d10b394c2f7476da50ca',
   aarch64: 'bf9b9bbb856551554fe1ebc873ebab47cc68cc6adc9cb07225d212d7801baf72',
    armv7l: 'bf9b9bbb856551554fe1ebc873ebab47cc68cc6adc9cb07225d212d7801baf72',
      i686: '177ac781b737599778f9a11c09607369e0b3e18ccd03e7664360fcb002028191'
  })

  depends_on 'glibc' # R
  depends_on 'gperf' => :build
  depends_on 'linux_pam'
  no_zstd

  def self.patch
    # add includes option to make it work with gperf-3.1
    system 'sed -e "/gperf --/s/gperf --/gperf --includes --/" -e "/gperf --/s/cap_lookup_name(/cap_dummy(/" -i libcap/Makefile'
    # change the path to ld
    system "sed -i 's,/usr/bin/ld,#{CREW_PREFIX}/bin/ld,g' Make.Rules"
    # change prefix
    system "sed -i 's,prefix=/usr,prefix=#{CREW_PREFIX},g' Make.Rules"
    # set exec_prefix
    system "sed -i 's,^exec_prefix=,exec_prefix=\$(prefix),g' Make.Rules"
    # http://git.yoctoproject.org/cgit.cgi/poky/plain/meta/recipes-support/libcap/files/0001-ensure-the-XATTR_NAME_CAPS-is-defined-when-it-is-use.patch
    system 'sed -i "s,^\#ifdef VFS_CAP_U32,\#if defined (VFS_CAP_U32) \&\& defined (XATTR_NAME_CAPS),g" libcap/cap_file.c'
  end

  def self.build
    system "#{CREW_ENV_OPTIONS} make"
  end

  def self.install
    system 'make', 'RAISE_SETFCAP=no', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    # Tests do not work in a Docker container.
    return if File.exist?('/.dockerenv')

    system 'make', 'test'
  end
end
