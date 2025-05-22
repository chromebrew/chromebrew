require 'buildsystems/autotools'

class Mutt < Autotools
  description 'Mutt is a small but very powerful text-based mail client for Unix operating systems.'
  homepage 'http://mutt.org/'
  version '2.2.14'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://gitlab.com/muttmua/mutt.git'
  git_hashtag "mutt-#{version.gsub('.', '-')}-rel"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7e2baa377337ee80a60205a89a94b52f945bcd40ac2bf27458a0012442797de7',
     armv7l: '7e2baa377337ee80a60205a89a94b52f945bcd40ac2bf27458a0012442797de7',
       i686: '861d8502be5be389b183c3ac2a55833880555c6a1ff5fd58e47b71bfc37b74c9',
     x86_64: 'd580e3c20a871e23a9701ebf5482288aded9136be0a1705319086efd73e6ce37'
  })

  depends_on 'libcyrussasl'
  depends_on 'libxslt'
  depends_on 'gdbm' # R
  depends_on 'glibc' # R
  depends_on 'ncurses' # R
  depends_on 'openssl' # R
  depends_on 'zlib' # R

  autotools_configure_options "--with-mailpath=#{CREW_PREFIX}/etc/mail \
    --with-sasl=#{CREW_LIB_PREFIX}/sasl2 \
    --with-ssl \
    --enable-imap \
    --enable-smtp \
    --enable-hcache"

  autotools_install_extras do
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/mail"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/env.d/"
    File.write "#{CREW_DEST_PREFIX}/etc/env.d/mutt", <<~MUTTEOF
      # Mutt configuration
      SASL_PATH=#{CREW_LIB_PREFIX}/sasl2
    MUTTEOF
  end

  run_tests
end
