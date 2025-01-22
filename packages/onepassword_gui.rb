require 'package'

class Onepassword_gui < Package
  description '1Password GUI brings 1Password to your desktop.'
  homepage 'https://1password.com/'
  version '8.10.58'
  license 'Apache-2.0, BSD, GPL-2, LGPL, MIT, Mozilla Public License, MS-PL'
  compatibility 'x86_64'
  source_url 'https://downloads.1password.com/linux/tar/stable/x86_64/1password-latest.tar.gz'
  source_sha256 '2739c5db11baeb3f052b00bb5e0dcf7bf2cbc31c393ea6c705eb2c9b1ce9c910'

  depends_on 'at_spi2_core'
  depends_on 'gtk3'
  depends_on 'polkit'

  no_compile_needed
  no_shrink

  def self.build
    ENV['POLICY_OWNERS'] = 'chronos'
    system 'eval "cat <<EOF
$(cat ./com.1password.1Password.policy.tpl)
EOF" > ./com.1password.1Password.policy'
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/icons"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/1password"
    FileUtils.install 'com.1password.1Password.policy', "#{CREW_DEST_PREFIX}/share/polkit-1/actions/com.1password.1Password.policy", mode: 0o644
    FileUtils.install 'resources/custom_allowed_browsers', "#{CREW_DEST_PREFIX}/share/doc/1password/examples/custom_allowed_browsers", mode: 0o644
    FileUtils.install 'resources/1password.desktop', "#{CREW_DEST_PREFIX}/share/applications/1password.desktop", mode: 0o644
    FileUtils.cp_r Dir['resources/icons/*'], "#{CREW_DEST_PREFIX}/share/icons/"
    FileUtils.cp_r Dir['*'], "#{CREW_DEST_PREFIX}/share/1password/"
    FileUtils.ln_s "#{CREW_PREFIX}/share/1password/1password", "#{CREW_DEST_PREFIX}/bin/1password"
  end

  def self.postinstall
    ExitMessage.add "\nType '1password' to get started.\n"
  end
end
