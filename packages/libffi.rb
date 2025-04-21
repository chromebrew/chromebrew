require 'buildsystems/autotools'

class Libffi < Autotools
  description 'The libffi library provides a portable, high level programming interface to various calling conventions.'
  homepage 'https://sourceware.org/libffi/'
  version '3.4.8'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/libffi/libffi.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3b4652a3d47abcc3a559ea3a0cda023275aa843d3582abddb098c7d87132215e',
     armv7l: '3b4652a3d47abcc3a559ea3a0cda023275aa843d3582abddb098c7d87132215e',
       i686: '1c92fa76f7d6e00bf7b3e3c2e1d97bddae422c11951407c9db1577569ebb259b',
     x86_64: 'e2f7c3f214bfaafdfb14c6831d374fc90b37e34fc7f32a0df2463f281d572116'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  # run_tests         # DejaGNU required

  # See https://git.launchpad.net/ubuntu/+source/libffi/tree/debian/rules?h=applied/ubuntu/plucky-devel
  configure_options "--build=#{CREW_TARGET}\
    --disable-exec-static-tramp \
    --enable-pax_emutramp=experimental \
    --host=#{CREW_TARGET} \
    --without-gcc-arch"

  def self.patch
    downloader 'https://git.launchpad.net/ubuntu/+source/libffi/plain/debian/patches/no-toolexeclibdir.diff?h=applied/ubuntu/noble', '53d01b0ff395e91c4f8fa4a2c55f5efb5d61ad532310bc7aa8b72869a9cb9b14', 'no-toolexeclibdir.diff'
    system 'patch -Np1 -i no-toolexeclibdir.diff'
  end

  configure_install_extras do
    FileUtils.install "#{CREW_TARGET}/.libs/libffi_convenience.a", "#{CREW_DEST_LIB_PREFIX}/libffi_pic.a", mode: 0o644
  end
end
