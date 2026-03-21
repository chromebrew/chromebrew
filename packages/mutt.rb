require 'buildsystems/autotools'

class Mutt < Autotools
  description 'Mutt is a small but very powerful text-based mail client for Unix operating systems.'
  homepage 'http://mutt.org/'
  version '2.3.1'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://gitlab.com/muttmua/mutt.git'
  git_hashtag "mutt-#{version.gsub('.', '-')}-rel"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e852121f662c37dd6202ef7ecba96361b7bacc2a7b89341326cacc21f4ca376c',
     armv7l: 'e852121f662c37dd6202ef7ecba96361b7bacc2a7b89341326cacc21f4ca376c',
       i686: '439e2fcc00a279dd2d5bf1582fe190b0a192e8c7a26978d20d8d67ae162ebe8b',
     x86_64: '2ed04ae176c92a5201987559e31e80764ab28f36a878f5dcd8bcbcb426990274'
  })

  depends_on 'gdbm' => :executable
  depends_on 'glibc' => :executable
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
