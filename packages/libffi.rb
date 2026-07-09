require 'buildsystems/autotools'

class Libffi < Autotools
  description 'The libffi library provides a portable, high level programming interface to various calling conventions.'
  homepage 'https://sourceware.org/libffi/'
  version '3.7.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/libffi/libffi.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd463ee58e6a0dc7d9aa2db7ad849685f6315b03d8a6b6b8566786bd558efa2e2',
     armv7l: 'd463ee58e6a0dc7d9aa2db7ad849685f6315b03d8a6b6b8566786bd558efa2e2',
       i686: 'd99613923965bff817eedda2e224b50cbf48fefd3ecdd9a485174a616dbe3c84',
     x86_64: '1307ea1deb5c2585facfef32d5d785c58b43051ff9bd58abcaeaaef62dd13273'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library

  # run_tests         # DejaGNU required

  # See https://git.launchpad.net/ubuntu/+source/libffi/tree/debian/rules?h=applied/ubuntu/plucky-devel
  autotools_configure_options "--build=#{CREW_TARGET}\
    --disable-builddir \
    --disable-docs \
    --disable-exec-static-tramp \
    --enable-shared \
    --enable-pax_emutramp=experimental \
    --host=#{CREW_TARGET} \
    --without-gcc-arch"

  def self.patch
    downloader 'https://git.launchpad.net/ubuntu/+source/libffi/plain/debian/patches/no-toolexeclibdir.diff?h=applied/ubuntu/noble', '53d01b0ff395e91c4f8fa4a2c55f5efb5d61ad532310bc7aa8b72869a9cb9b14', 'no-toolexeclibdir.diff'
    system 'patch -Np1 -i no-toolexeclibdir.diff'
  end

  autotools_install_extras do
    FileUtils.install '.libs/libffi_convenience.a', "#{CREW_DEST_LIB_PREFIX}/libffi_pic.a", mode: 0o644
  end
end
