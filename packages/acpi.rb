require 'buildsystems/autotools'

class Acpi < Autotools
  description 'Attempts to replicate the functionality of the \'old\' apm command on ACPI systems, including battery and thermal information.'
  homepage 'https://sourceforge.net/projects/acpiclient/'
  version '1.8'
  license 'GPL-2'
  compatibility 'all'
  source_url "https://downloads.sourceforge.net/project/acpiclient/acpiclient/#{version}/acpi-#{version}.tar.gz"
  source_sha256 'ed61d20400c4fd3965dde9b49ab3ac74da02f8eca1a55454f7a1ac3fa1fd5c31'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '86f608f45ef9c7d423f26f4b1a268e7b995061e1ecb613bf3fbca2d9c7bf5665',
     armv7l: '86f608f45ef9c7d423f26f4b1a268e7b995061e1ecb613bf3fbca2d9c7bf5665',
       i686: 'bbb6d7c0db9e4777aaca3b38e08affc74f16af661274b2d962ef8189a5338d2f',
     x86_64: 'db69280f951b024431221a7f28af55b9f103baa82a981619a3da01c161c2d485'
  })
end
