require 'buildsystems/autotools'

class Flex < Autotools
  description 'Flex (The Fast Lexical Analyzer) is a fast lexical analyser generator tool for generating programs that perform pattern-matching on text.'
  homepage 'https://www.gnu.org/software/flex/'
  version '2.6.4-1'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/westes/flex/releases/download/v2.6.4/flex-2.6.4.tar.gz'
  source_sha256 'e87aae032bf07c26f85ac0ed3250998c37621d95f8bd748b31f15b33c45ee995'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a51ead6fb16d80f31592cb4057d3d6a439f98579b0ead1ab72736b1502ada313',
     armv7l: 'a51ead6fb16d80f31592cb4057d3d6a439f98579b0ead1ab72736b1502ada313',
       i686: '12f3f97a8868b5f41b8b7f4332ca3f75bb39aa49861cb90994dff7a914b28230',
     x86_64: '5506c83d69cbb5411eaefc355a05931f1955639dccec927caac5f8f6fe622f41'
  })

  depends_on 'bison' => :build
  depends_on 'glibc' # R
  depends_on 'm4' => :build

  def self.patch
    downloader 'https://gitlab.archlinux.org/archlinux/packaging/packages/flex/-/raw/main/flex-pie.patch?ref_type=heads&inline=false', '20f3cce6b0ea6ab67a902a46b89c292b959994dedcbe6ee5d187f9bba1408b0e', 'flex-pie.patch'
    system 'patch -p1 -i flex-pie.patch'
    system 'autoreconf -fiv'
  end

  configure_options '--with-pic --disable-static --enable-shared'
end
