require 'buildsystems/autotools'

class Libffi < Autotools
  description 'The libffi library provides a portable, high level programming interface to various calling conventions.'
  homepage 'https://sourceware.org/libffi/'
  version '3.8.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/libffi/libffi.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '290d53aa49079c09de72109495bb74afa7f88de9c961c410487fbf1329c8c884',
     armv7l: '290d53aa49079c09de72109495bb74afa7f88de9c961c410487fbf1329c8c884',
       i686: '843f31a4595892c80dc51765b1f34a9d5f0686e0826d8b52d389551797b64a93',
     x86_64: '20b436c158cfb92c51e7c83421eca85d4dcf6005bc9fd616c805e63b4b06b6b6'
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
