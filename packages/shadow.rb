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
    aarch64: 'c2bbcfb3398aba4ca42c0f7947d4398f717f4a7ec397cb7884ca9fb993689811',
     armv7l: 'c2bbcfb3398aba4ca42c0f7947d4398f717f4a7ec397cb7884ca9fb993689811',
       i686: 'a5a6b286bd2bff3f63bf3beb89c4d59e45a1470e471b002b4506616f92f09c1d',
     x86_64: 'f1f6ea17a3b13d6cb3f4cc4e1c2a60c82cb72f7706ca306d97738432780a8e36'
  })

  depends_on 'acl' # R
  depends_on 'attr' # R
  depends_on 'glibc' # R
  depends_on 'libbsd' # R
  depends_on 'libeconf' # R
  depends_on 'libmd' # R
  depends_on 'libxcrypt' # R
  depends_on 'linux_pam' # R

  autotools_configure_options "--bindir=#{CREW_PREFIX}/bin \
      --sbindir=#{CREW_PREFIX}/bin \
      --disable-logind \
      --disable-static \
      --enable-shared \
      --with-libpam \
      --without-selinux \
      --with-acl \
      --with-attr \
      --disable-nls \
      --enable-subordinate-ids \
      --disable-account-tools-setuid"

  autotools_install_extras do
    # Handle conflicts.
    @conflicts = %w[login su chfn chsh groups newgrp]
    @conflicts.each do |conflict_file|
      next unless File.file?("#{CREW_DEST_PREFIX}/bin/#{conflict_file}")

      FileUtils.mv "#{CREW_DEST_PREFIX}/bin/#{conflict_file}", "#{CREW_DEST_PREFIX}/bin/shadow_#{conflict_file}"
    end
  end
end
