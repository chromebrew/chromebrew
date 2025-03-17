require 'package'

class Qortal < Package
  description 'Data storage, communications, web hosting, decentralized trading, complete infrastructure for the future blockchain based Internet'
  homepage 'https://qortal.org/'
  version '4.7.0'
  license 'GPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://github.com/Qortal/qortal/releases/download/v#{version}/qortal.zip"
  source_sha256 '0ae8bec807b635e7f7a541e13b18cd9158fb564213adc20744a6443711833d04'

  depends_on 'libx11'
  depends_on 'libxext'
  depends_on 'libxrender'
  depends_on 'libxtst'
  depends_on 'openjdk11'
  depends_on 'unzip'

  no_compile_needed

  def self.build
    File.write 'qortal.sh', <<~EOF
      #!/bin/bash
      cd #{CREW_PREFIX}/share/qortal
      ./start.sh
    EOF
  end

  def self.install
    FileUtils.install 'qortal.sh', "#{CREW_DEST_PREFIX}/bin/qortalstart", mode: 0o755
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/qortal"
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/qortal"
    FileUtils.chmod 0o755, "#{CREW_DEST_PREFIX}/share/qortal/stop.sh"
    FileUtils.ln_s "#{CREW_PREFIX}/share/qortal/stop.sh", "#{CREW_DEST_PREFIX}/bin/qortalstop"
  end

  def self.postinstall
    ExitMessage.add <<~EOM

      Type 'qortalstart' to get started.

      Type 'qortalstop' to stop.
    EOM
  end

  def self.postremove
    Package.agree_to_remove("#{CREW_PREFIX}/share/qortal")
  end
end
