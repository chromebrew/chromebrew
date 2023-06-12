require 'package'

class Xxd_standalone < Package
  description 'Hexdump utility from vim'
  homepage 'http://www.vim.org'
  version '9.0.1145'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/vim/vim.git'
  git_hashtag "v#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xxd_standalone/9.0.1145_armv7l/xxd_standalone-9.0.1145-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xxd_standalone/9.0.1145_armv7l/xxd_standalone-9.0.1145-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xxd_standalone/9.0.1145_i686/xxd_standalone-9.0.1145-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xxd_standalone/9.0.1145_x86_64/xxd_standalone-9.0.1145-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '6f0371fe309b6acf9075ffe3d5c39565d265aafd2aae6915aa8e7d34e2497833',
     armv7l: '6f0371fe309b6acf9075ffe3d5c39565d265aafd2aae6915aa8e7d34e2497833',
       i686: 'c18efdaca3fdc3c670a044e105968d34c214347763500fd329a0fa610c09f2da',
     x86_64: 'b6b4db1208ebb85772a18f08aea51a5644cebb8e62473b3008c29e8bd61c153a'
  })

  depends_on 'glibc' # R

  def self.build
    Dir.chdir 'src/xxd' do
      system 'make xxd'
    end
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin/"
    FileUtils.mkdir_p "#{CREW_DEST_MAN_PREFIX}/man1/"
    Dir.chdir 'src/xxd' do
      FileUtils.install 'xxd', "#{CREW_DEST_PREFIX}/bin/xxd", mode: 0o755
    end
    Dir.chdir 'runtime/doc' do
      FileUtils.install 'xxd.1', "#{CREW_DEST_MAN_PREFIX}/man1/xxd.1", mode: 0o644
    end
  end
end
