require 'package'

class Dmd < Package
  description 'D Programming Language compiler'
  homepage 'https://dlang.org/'
  version '2.102.1'
  license 'BSL-1.0'
  compatibility 'x86_64'
  source_url 'SKIP'

  binary_url({
    x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/dmd/2.102.1_x86_64/dmd-2.102.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    x86_64: '83d81ef8e0c7e0cb113c01fde0945c945f8dff57ed64c8e4aa61cf9e1f5d2cb6'
  })

  def self.build
    system "git clone -b v#{version} https://github.com/dlang/dmd.git"
    Dir.chdir 'dmd' do
      system 'make -f posix.mak AUTO_BOOTSTRAP=1'
    end
    system "git clone -b v#{version} https://github.com/dlang/phobos.git"
    Dir.chdir 'phobos' do
      system 'make -f posix.mak'
    end
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p CREW_DEST_LIB_PREFIX.to_s
    Dir.chdir 'dmd/generated/linux/release/64' do
      FileUtils.install 'dmd', "#{CREW_DEST_PREFIX}/bin/dmd", mode: 0o755
    end
    Dir.chdir 'phobos/generated/linux/release/64' do
      FileUtils.install %w[libphobos2.a libphobos2.so libphobos2.so.0.102 libphobos2.so.0.102.1], CREW_DEST_LIB_PREFIX.to_s, mode: 0o644
    end
  end
end
