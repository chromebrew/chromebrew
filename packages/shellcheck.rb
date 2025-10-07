require 'package'

class Shellcheck < Package
  description 'Static analysis tool for shell scripts'
  homepage 'https://www.shellcheck.net/'
  version '0.11.0'
  license 'GPL-3.0'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/koalaman/shellcheck/releases/download/v#{version}/shellcheck-v#{version}.linux.armv6hf.tar.xz",
     armv7l: "https://github.com/koalaman/shellcheck/releases/download/v#{version}/shellcheck-v#{version}.linux.armv6hf.tar.xz",
       i686: "https://github.com/koalaman/shellcheck/releases/download/v#{version}/shellcheck-v#{version}.linux.x86_64.tar.xz",
     x86_64: "https://github.com/koalaman/shellcheck/releases/download/v#{version}/shellcheck-v#{version}.linux.x86_64.tar.xz"
  })
  source_sha256({
    aarch64: '8afc50b302d5feeac9381ea114d563f0150d061520042b254d6eb715797c8223',
     armv7l: '8afc50b302d5feeac9381ea114d563f0150d061520042b254d6eb715797c8223',
       i686: '8c3be12b05d5c177a04c29e3c78ce89ac86f1595681cab149b65b97c4e227198',
     x86_64: '8c3be12b05d5c177a04c29e3c78ce89ac86f1595681cab149b65b97c4e227198'
  })

  no_compile_needed

  def self.install
    FileUtils.install 'shellcheck', "#{CREW_DEST_PREFIX}/bin/shellcheck", mode: 0o755
  end
end
