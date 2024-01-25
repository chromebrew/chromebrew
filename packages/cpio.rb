require 'buildsystems/autotools'

class Cpio < Autotools
  description 'GNU cpio copies files into or out of a cpio or tar archive. The archive can be another file on the disk, a magnetic tape, or a pipe.'
  homepage 'https://www.gnu.org/software/cpio/'
  version '2.14'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/cpio/cpio-2.14.tar.bz2'
  source_sha256 'fcdc15d60f7267a6fc7efcd6b9db7b6c8966c4f2fbbb964c24d41336fd3f2c12'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b3bca5b31c4e1b45e2f843658464c9fcbdb8eefeec7c5f4284f2be2011b3d969',
     armv7l: 'b3bca5b31c4e1b45e2f843658464c9fcbdb8eefeec7c5f4284f2be2011b3d969',
       i686: 'ca491cfb7ce43d1121d3682da98335d26b73a64eb3fc54af638b54137d814ea7',
     x86_64: '7801234185c3afa64b2b27e1a2ebb5da842d065a9d5f57e4b5c803f529805978'
  })

  depends_on 'glibc' # R

  configure_options '--enable-mt' # magnetic tape, not manifest tool
end
