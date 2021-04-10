require 'package'

class Choose < Package
  description 'make choices on the command line'
  homepage 'https://github.com/geier/choose'
  version '0.1.0-1'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/geier/choose/archive/v0.1.0.tar.gz'
  source_sha256 'd09a679920480e66bff36c76dd4d33e8ad739a53eace505d01051c114a829633'

  depends_on 'py3_urwid'
  depends_on 'py3_nuitka' => :build

  def self.build
    FileUtils.mv "choose", "choose.py"
    system "python3 -m nuitka \
            --follow-imports \
            --prefer-source-code \
            choose.py \
            -o choose"
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin/"
    FileUtils.install "choose", "#{CREW_DEST_PREFIX}/bin/choose", mode: 0755
  end
end
