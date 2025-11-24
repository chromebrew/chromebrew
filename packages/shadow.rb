require 'buildsystems/autotools'

class Shadow < Autotools
  description 'Shadow password file utilities'
  homepage 'https://github.com/shadow-maint/shadow'
  version '4.18.0'
  license 'BSD and GPL-2'
  compatibility 'all'
  source_url "https://github.com/shadow-maint/shadow/releases/download/#{version}/shadow-#{version}.tar.xz"
  source_sha256 'add4604d3bc410344433122a819ee4154b79dd8316a56298c60417e637c07608'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ce09c87fd90b9751c7f47be22d835490685f41f0fd4af484a7e06184115176e2',
     armv7l: 'ce09c87fd90b9751c7f47be22d835490685f41f0fd4af484a7e06184115176e2',
       i686: '09ea3f8487715d726dd822d921f6e1206e49e2e98ca8e5fd3d09e1933d6ce4f5',
     x86_64: '3074d0d8cbfb2d807d5e5e9993a2429ac43391a085eadbcd95a9ed12ceeb391a'
  })

  depends_on 'acl' # R
  depends_on 'attr' # R
  depends_on 'glibc' # R
  depends_on 'libbsd' => :build
  depends_on 'libeconf' # R
  depends_on 'libxcrypt' => :build
  depends_on 'linux_pam' => :build

  # ENV['CREW_LINKER_FLAGS'] = '-Wl,--undefined-version'
  # no_env_options
  no_mold

  # autotools_pre_configure_options 'LD=ld.bfd CCLD=ld.bfd CXXLD=ld.bfd'
  autotools_pre_configure_options 'env ;'
  autotools_configure_options "--bindir=#{CREW_PREFIX}/bin \
      --sbindir=#{CREW_PREFIX}/bin \
      --disable-logind \
      --enable-shared \
      --with-libpam \
      --without-selinux \
      --with-acl \
      --with-attr \
      --disable-nls \
      --enable-subordinate-ids \
      --disable-account-tools-setuid"

  autotools_install_extras do
    # Handle conflicts with coreutils.
    @conflicts = %w[login su chfn chsh groups]
    @conflicts.each do |conflict_file|
      FileUtils.mv "#{CREW_DEST_PREFIX}/bin/#{conflict_file}", "#{CREW_DEST_PREFIX}/bin/shadow_#{conflict_file}"
    end
  end
end
