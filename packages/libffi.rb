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
    aarch64: 'b589b48f32b37d7199792fe7a9f971dab5c122bfbd3205bea74fa985d1c6aa1d',
     armv7l: 'b589b48f32b37d7199792fe7a9f971dab5c122bfbd3205bea74fa985d1c6aa1d',
       i686: 'a2e22f40a76b66c726578b1f147f34bae2bf49b0e4377c650dc7c1127a9681b5',
     x86_64: 'ce86abb76761fc8fc946ec8f172315ba697a1a96b4f6df897224328436d8c5ab'
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
