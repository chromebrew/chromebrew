require 'package'

class Fpc < Package
  description 'Free Pascal is a 32, 64 and 16 bit professional Pascal compiler.'
  homepage 'https://www.freepascal.org/'
  version '3.2.3'
  license 'GPL-2 and LGPL-2.1-with-linking-exception'
  compatibility 'all'
  source_url 'https://gitlab.com/freepascal.org/fpc/source.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '59e1525374c44782be0bc0cdaa41620b0f6317403640e9530e4524be7ba25817',
     armv7l: '59e1525374c44782be0bc0cdaa41620b0f6317403640e9530e4524be7ba25817',
       i686: 'dd54485d5db294e4cd713debc7e09b3f00150b46574dfd7bf16b21e781428729',
     x86_64: '90ba51e07916559f4cfbdc41ce3f57bd8498f5b35138b8822ea7338d7cd9d256'
  })

  print_source_bashrc

  def self.build
    # https://gitlab.com/freepascal.org/fpc/source/-/issues/40841
    # fpc isn't fooled by our docker emulation, and thus disables reading from the config because it thinks we're cross-compiling.
    # See https://gitlab.com/freepascal.org/fpc/source/-/commit/898a4debcab843b2f6f5c29b795a517485582dfb
    # Because we don't read from the config, we don't get the correct library paths.
    # The correct thing to do here would be to find the fault in our docker setup that reveals we're running under emulation, and fix it.
    # In the meantime, though, just pass the correct library path manually.
    # Chromebrew messes things up if we don't pass this in one string, adding single quotes around OPT which break things.
    system "make OVERRIDEVERSIONCHECK=1 OPT='#{"-Fl#{CREW_LIB_PREFIX}" unless ARCH.eql?('x86_64')} -k-L#{CREW_LIB_PREFIX}' all"
  end

  def self.install
    system 'make', "PREFIX=#{CREW_DEST_PREFIX}", 'install'
    compiler = { aarch64: 'ppcarm', armv7l: 'ppcarm', i686: 'ppc386', x86_64: 'ppcx64' }
    FileUtils.ln_sf "#{CREW_PREFIX}/lib/fpc/#{version}/#{compiler[ARCH.to_sym]}", "#{CREW_DEST_PREFIX}/bin/#{compiler[ARCH.to_sym]}"
    # Set up the default fpc config file.
    system "#{CREW_DEST_PREFIX}/lib/fpc/#{version}/samplecfg #{CREW_DEST_PREFIX}/lib/fpc/#{version} #{CREW_DEST_PREFIX}/etc"
    system "sed -i '/# searchpath for libraries/a\-Fl#{CREW_LIB_PREFIX}' #{CREW_DEST_PREFIX}/etc/fpc.cfg"
    File.write 'fpcenv', <<~FPC_ENV_EOF
      # Set PPC_CONFIG_PATH so that fpc finds fpc.cfg
      export PPC_CONFIG_PATH=#{CREW_PREFIX}/etc
    FPC_ENV_EOF
    FileUtils.install 'fpcenv', "#{CREW_DEST_PREFIX}/etc/env.d/fpc", mode: 0o644
  end

  def self.postinstall
    ExitMessage.add "Type 'fp' to start.".lightblue
  end
end
