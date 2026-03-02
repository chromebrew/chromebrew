require 'buildsystems/autotools'

class Mutt < Autotools
  description 'Mutt is a small but very powerful text-based mail client for Unix operating systems.'
  homepage 'http://mutt.org/'
  version '2.3'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://gitlab.com/muttmua/mutt.git'
  git_hashtag "mutt-#{version.gsub('.', '-')}-rel"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3360227b7d62d6ce5b95dbf34023ce0bc2ecd949a360ea59854586d6cbd20d85',
     armv7l: '3360227b7d62d6ce5b95dbf34023ce0bc2ecd949a360ea59854586d6cbd20d85',
       i686: '89bf53911df6faff81804c2dc5911c94e45ea6173e88a5ac75b6feee24e9027b',
     x86_64: 'cdc654fe5b89c962d0d8990d4ee21d7824a56218d7fdc14aa167d4119cf1849a'
  })

  depends_on 'gdbm' => :executable_only
  depends_on 'glibc' => :executable_only
  depends_on 'libcyrussasl' => :executable_only
  depends_on 'libxslt'
  depends_on 'ncurses' => :executable_only
  depends_on 'openssl' => :executable_only
  depends_on 'zlib' => :executable_only

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
