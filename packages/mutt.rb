require 'buildsystems/autotools'

class Mutt < Autotools
  description 'Mutt is a small but very powerful text-based mail client for Unix operating systems.'
  homepage 'http://mutt.org/'
  version '2.4.0'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://gitlab.com/muttmua/mutt.git'
  git_hashtag "mutt-#{version.delete_suffix('.0').gsub('.', '-')}-rel"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8b9ade9e1d7a1287301304cca33b4ddfbbc6b7d852ff6a03554ec29ea530bdfe',
     armv7l: '8b9ade9e1d7a1287301304cca33b4ddfbbc6b7d852ff6a03554ec29ea530bdfe',
       i686: '09da7463788da122426bd552d0df2eac737b4b2ee57020776cc094515b44ed75',
     x86_64: '44009f5215119267bd146acc7d59ef1cad8fb35ed72e85b0aea599a5854513ac'
  })

  depends_on 'gdbm' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'libcyrussasl' => :executable
  depends_on 'libxslt'
  depends_on 'ncurses' => :executable
  depends_on 'openssl' => :executable
  depends_on 'zlib' => :executable

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
