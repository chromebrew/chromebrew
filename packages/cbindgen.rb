require 'package'

class Cbindgen < Package
  description 'Generates C bindings from Rust code.'
  homepage 'https://github.com/eqrion/cbindgen/'
  @_ver = '0.20.0'
  version @_ver
  license 'MPL-2'
  compatibility 'all'
  source_url 'https://github.com/eqrion/cbindgen.git'
  git_hashtag "v#{@_ver}"

  depends_on 'rust' => :build

  def self.build
    system 'cargo build --release -v'
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin/"
    FileUtils.cp 'target/release/cbindgen', "#{CREW_DEST_PREFIX}/bin/cbindgen"
  end
end
