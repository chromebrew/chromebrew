require 'package'

class Shellcheck < Package
  description 'Static analysis tool for shell scripts'
  homepage 'https://www.shellcheck.net/'
  version '0.10.0'
  license 'GPL-3.0'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/koalaman/shellcheck/releases/download/v#{version}/shellcheck-v#{version}.linux.armv6hf.tar.xz",
     armv7l: "https://github.com/koalaman/shellcheck/releases/download/v#{version}/shellcheck-v#{version}.linux.armv6hf.tar.xz",
       i686: "https://github.com/koalaman/shellcheck/releases/download/v#{version}/shellcheck-v#{version}.linux.x86_64.tar.xz",
     x86_64: "https://github.com/koalaman/shellcheck/releases/download/v#{version}/shellcheck-v#{version}.linux.x86_64.tar.xz"
  })
  source_sha256({
    aarch64: '1c89cb51e1412b580d7ba8aac240251ffb0b829788f83d2daa4a82da42d275e4',
     armv7l: '1c89cb51e1412b580d7ba8aac240251ffb0b829788f83d2daa4a82da42d275e4',
       i686: '6c881ab0698e4e6ea235245f22832860544f17ba386442fe7e9d629f8cbedf87',
     x86_64: '6c881ab0698e4e6ea235245f22832860544f17ba386442fe7e9d629f8cbedf87'
  })

  no_compile_needed

  def self.install
    FileUtils.install 'shellcheck', "#{CREW_DEST_PREFIX}/bin/shellcheck", mode: 0o755
  end
end
